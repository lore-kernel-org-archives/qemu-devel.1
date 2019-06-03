Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2698EC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25952793B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="infPsifv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25952793B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXp95-0005bF-70
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:45:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXp8B-000590-EJ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXp8A-0007N7-6u
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:44:15 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXp89-0007JS-VT
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:44:14 -0400
Received: by mail-oi1-x243.google.com with SMTP id b21so9229729oic.8
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=qD9qoZ6js/eg3w9SoNliCFhVHtwCLIPLM72tU7Dfj8E=;
	b=infPsifv0h529ZWlSYwPmEk9IqT94XL5lu6BL3Oj/gvbwsNiS+y46jN66mfNAiy2P0
	KJ9wfBRWdl2DVbhRA7xGpgPXsLiktJGVBdMBVCMvwIi467HEKuClK3BvmJ8xnX+8B8SX
	lQTxFaDejwMlpLKosuHnjpIbPbyZZ2yCcL/AfAXuTZBUvOiSvX9RYHaU8TYhmbno9pzG
	iAuI2glwb4zXD9CAKw+4rMzI8C1vXmzPZL9wiXncHvYhSR5pi6K5V7MJlx27w+IUiJE4
	XUChr6qGZoyTBvKgwe/cs5Fk1ASIQ2zWII7uifXEReYIwfJ52pUgWH3OO3taVXXhJYH6
	4rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qD9qoZ6js/eg3w9SoNliCFhVHtwCLIPLM72tU7Dfj8E=;
	b=HfxM+nGzK/7VU6x+ZqxU3QgZdh0hHdJq9Iy8Ac4dtEbWtiIX1h0aOPRkNAJG82xOow
	yh5xltbjYELNlhk1xymq2vdv0t+2IRll5NQclg7X4lOQ/WEOpurIMKPodsJ6o3Mg6qPy
	DO9E3p+/qelR9Y+vkQi3+9xh8kEn2rJLMSnPXAb1AaiZF10hDgFoLFoGWkTrElpDZVqL
	Pu3ufJ2KeMr78wCOhuDR96JPEbzVxtmeWvnrnmomUQmiiGmg3P4mfxPmQNWLuhXr/Lob
	nKVBAIN0I5Z+3GZ1JKwhQL/ql6ih/dP2geD6Ok5S7DWDATjdkFHz+u7YiIMF14x+Lm05
	xpbg==
X-Gm-Message-State: APjAAAWzuJcT/+Mktjh3MWuwy6sFQZlOOhoUMZDmC8AQqHJJJ4/tpo+W
	j8mR/TOA8HgdMC/FxN25FOoVRQ==
X-Google-Smtp-Source: APXvYqwdpg2IuXM+BrRujdpzts1IXkH0jsntypux0PviDVE//3428BtvomeNkdyWcSRP4TV68a2arg==
X-Received: by 2002:aca:4b58:: with SMTP id y85mr934132oia.117.1559576652190; 
	Mon, 03 Jun 2019 08:44:12 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id y4sm3984710otg.19.2019.06.03.08.44.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 08:44:11 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-4-mrolnik@gmail.com>
	<402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
	<CAK4993iXV9oRr_VfabJHg4fCYEppW49i_PE9R0X_TBqk7TDkrQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9e2acbbe-7ede-c45d-5e9f-bb269aa25fcc@linaro.org>
Date: Mon, 3 Jun 2019 10:44:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK4993iXV9oRr_VfabJHg4fCYEppW49i_PE9R0X_TBqk7TDkrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH RFC v20 3/8] target/avr: Add mechanism to
 check for active debugger connection
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/19 4:12 PM, Michael Rolnik wrote:
> Hi Richard.
> 
> If I implement it this way
> 
> ```
>  static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
>  {
>      if (avr_feature(ctx->env, AVR_FEATURE_BREAK) == false) {
>          gen_helper_unsupported(cpu_env);
>      } else {
>          tcg_gen_movi_tl(cpu_pc, ctx->inst[0].npc);
>          gen_helper_debug(cpu_env);
>      }
> 
>      ctx->bstate = BS_EXCP;
> 
>      return true;
>  }
> ```
> 
> qemu (without -s -S flags) crashes when debugger is not connected

I was not suggesting using the internal qemu EXCP_DEBUG, but another AVR
specific exception, much the same way as every other cpu has a cpu-specific
debug exception.

Or perhaps always do nothing.  Why is gdb insertting BREAK in the first place?
 It should be using the "hardware breakpoint" support that qemu advertises as
part of the gdbstub protocol, and that you support here:

> +        if (unlikely(cpu_breakpoint_test(cs, OFFSET_CODE + cpc * 2, BP_ANY))
> +                 || cpu_breakpoint_test(cs, OFFSET_DATA + cpc * 2, BP_ANY)) {
> +            tcg_gen_movi_i32(cpu_pc, cpc);
> +            gen_helper_debug(cpu_env);
> +            ctx.bstate = BS_EXCP;
> +            goto done_generating;
> +        }



r~

