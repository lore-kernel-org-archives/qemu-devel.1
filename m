Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2003EC4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE0D20656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wx8DZSfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE0D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6zgd-0007On-AY
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6zfi-0006Up-UH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6zfh-0004Wm-PN
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:36:30 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6zfh-0004UY-HY
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:36:29 -0500
Received: by mail-pl1-x644.google.com with SMTP id g6so1499673plt.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XGxBi06S5twoQRPY3oVf8T/EbZFE6lieZGOKgkJPxs0=;
 b=Wx8DZSfuUI5EjLOlSbiFPvrD52GfYflKhIwm7j5vn0fyRmzXEqzUNzDWA0PkvqXG++
 uAK3lUF7ZaF9iTIyMRc2J7vOqDIZ5sF+1k58VOReNfutHLi2c7aOE10BDsI7Ixjh2BBe
 zkZrMBanPvMCN4j+M3FtsufdcsYK66CPw60kTwho2Bgkg3MFuXcz+O6Km2DEQUyNk1GL
 N8hgK4xoGONbEgohAavdRCT3LTHX9Dsq6+TXF31Nnl2cmyr22DT2RJjIml9QGprgo7Ok
 oE4T6HGd6kKL6gpXmmGnC4+s927CLg4c6mHJvoDOpUf/Dtq/AuTs9n5bs6X7CujwayWX
 ArGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XGxBi06S5twoQRPY3oVf8T/EbZFE6lieZGOKgkJPxs0=;
 b=MuPfGH2wnZYg3ms7KLsYEOr3KToxI+MTFPbTWycTv+QIYiSodJS0g5LUzKopCGSAj5
 PCu9mAWFDq1KChRwSxgkB/Qm+eH/stJCvEwb9WsgYs4bSSDmc/XOIbIzba6c8A8UAUWu
 4OGxnK5lbSyD03oTNM+3NGtvxnUCrId8nVs8lhQMIFqAxCMwrUaAGr57x3YwGPFS+hlP
 Gxlok4HACDZHqTau8X4bBH0csu6PCaCUJ1dhqteogkguK0wWq85K8wvfDfQX7pVtfVyB
 gMyWyJfObDjwP5zj2baFw/HlZTuYkJMqEap17c0iC6Qk+twEF2hLrP7A2FxypCUseTqb
 wdqA==
X-Gm-Message-State: APjAAAUH7OfG5N8ihEPEqD8mZDta7VC/rG7/hT058UttzlPxNfnPWAml
 McP6+uY1DFW+O29MRemL1D7glw==
X-Google-Smtp-Source: APXvYqzioFTGSliesVsb31cQs30ZB86onewShqJTg+5NwnP3dr5YnwVYFjgG8KTWi9GAomA/tGpgJA==
X-Received: by 2002:a17:90a:7f93:: with SMTP id
 m19mr5953784pjl.92.1582734986819; 
 Wed, 26 Feb 2020 08:36:26 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 s124sm4051236pfc.57.2020.02.26.08.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 08:36:25 -0800 (PST)
Subject: Re: [PATCH] accel/tcg: remove link between guest ram and TCG cache
 size
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200226152710.31751-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bac7a5a4-c4c4-5102-4fe8-097ab15af29f@linaro.org>
Date: Wed, 26 Feb 2020 08:36:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226152710.31751-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: f4bug@amsat.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 7:27 AM, Alex Bennée wrote:
> Basing the TB cache size on the ram_size was always a little heuristic
> and was broken by a1b18df9a4 which caused ram_size not to be fully
> realised at the time we initialise the TCG translation cache.
> 
> At the same time the default code generation size seems mainly set to
> deal with the fact we use a static code buffer for CONFIG_USER to
> avoid mmap allocation problems on constrained systems. So we:
> 
>   - only use a static code buffer on 32 bit systems
>   - up the default buffer size for bigger systems
>   - ignore the ram_size and just go with the default
>   - document the fact tb-size is ignored for 32 bit linux-user
> 
> The could potentially slow down softmmu emulation on 32 bit systems
> with lots (3gb?) of spare memory. Those users can still manually up
> the tb-size via the command line if they do in fact exist.
> 
> Fixes: a1b18df9a4
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
...
> -#if defined(CONFIG_USER_ONLY)
> -/* Currently it is not recommended to allocate big chunks of data in
> -   user mode. It will change when a dedicated libc will be used.  */
> -/* ??? 64-bit hosts ought to have no problem mmaping data outside the
> -   region in which the guest needs to run.  Revisit this.  */
> +#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS == 32
> +/*
> + * For user mode on smaller 32 bit systems we may run into trouble
> + * allocating big chunks of data in the right place. On these systems
> + * we utilise a static code generation buffer directly in the binary.
> + */
>  #define USE_STATIC_CODE_GEN_BUFFER
>  #endif
>  
> @@ -927,7 +928,11 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
>  # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
>  #endif
>  
> +#if TCG_TARGET_REG_BITS == 32
>  #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32u * 1024 * 1024)
> +#else
> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (2ul * 1024 * 1024 * 1024)
> +#endif

As Igor notes, there is no -tb-size X or -accel tcg,tb-size=Y option for
linux-user.  Therefore I'd prefer this patch merely fix the default for softmmu
and not change linux-user at all.

I agree it is somewhat silly to use the static code gen buffer on a 64-bit
host, but let's leave that to a separate patch.


r~

