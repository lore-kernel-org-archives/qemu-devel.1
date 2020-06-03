Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74B2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8BA20659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPQqXiFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8BA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgN8c-0000vG-TC
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 02:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgN7f-00007l-G8
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 02:43:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgN7e-0000ma-Hc
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 02:43:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id x6so1004661wrm.13
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cXlxmiVWVVH9wxRrHYbj8hfaoBI6Fen5UD/9euxmmoc=;
 b=nPQqXiFGsljr7Qr+RsFXAVut03wSdKJnSIDsW7QfOJ4JCbowgQwQDRwlGhqqdECqh8
 KihgPYRfoxxiqQ62LsF1F5Ez+Vd1tCOWuipVedIxfMekQ3lbv1bozjJbk6zNquoAOQGj
 iz22Gmo2lf6OpcuEbZsRG9CYwYlpvaSyQgrRCMTMLh13Wm4jnOiDhQ0ZbsX/3yob4ygi
 yWuS0fHHdWRvYWegzZVFt/YM1kpy0okX3Jd4wzCx41zIK/j9VoW3GbgD8p1wtvSWGVlS
 e/l6nLjkfvOlQLdcnws5a+TqI4w0FuRpYyJADUNVZ7Cn20OBfu47h9oTvmNyZ4jYXbG8
 Cqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cXlxmiVWVVH9wxRrHYbj8hfaoBI6Fen5UD/9euxmmoc=;
 b=AhVauLLfPppWPaDEr+hFEOfZOWMJ6wEuJzKLV+yfWboi/g3j7VXOHdqu1r3Dnkx53H
 k4gGXuug1f6HSrI76d/WZJBIVFr6iv9HmfugL3kbBufxqnSXRkcWxsjtZY0vXxOgc967
 U2RTOtkC9HpwkE6PsmWvgmOj8mV8Vv7TB4byYh/1tJb0g36oDpmV4Fvs01iMb9YOQby1
 jpSdrHYkXtxN+PLXS1dWh8cvMx/eAHs43j0sKYUN3F252DOr3tRkSqY87M3HDsTfID64
 xjTj5kg+V5nkpcV0bHDbcpvyagqWYshSsl+/2NaeVqFMzk2TmqlLyqGocxh67dsW9wTb
 yqMA==
X-Gm-Message-State: AOAM533T6r/I886mW1l1DZ5lC7eqPOyWzLvbI/JmjXKuzIVz8kS8nxJG
 6csCwfoYFavVqHIRkkw2N2s=
X-Google-Smtp-Source: ABdhPJxntra5CiBbQUjrOyXXFcEwDlEm8vI34jjMH5LYSwbnVJiUPSlbEyU3Tn981dLEGiNOIqeTZw==
X-Received: by 2002:adf:f8cc:: with SMTP id f12mr28917089wrq.418.1591166613070; 
 Tue, 02 Jun 2020 23:43:33 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u130sm1543505wmg.32.2020.06.02.23.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 23:43:31 -0700 (PDT)
Subject: Re: [PATCH] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
To: agrecascino123@gmail.com, qemu-devel@nongnu.org
References: <20200603052308.11744-1-agrecascino123@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2a0fa3cb-9527-ae8b-e89b-2af08e2f54f4@amsat.org>
Date: Wed, 3 Jun 2020 08:43:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603052308.11744-1-agrecascino123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Catherine A. Frederick" <chocola@animebitch.es>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Catherine,

On 6/3/20 7:23 AM, agrecascino123@gmail.com wrote:
> From: "Catherine A. Frederick" <chocola@animebitch.es>
> 
> Signed-off-by: "Catherine A. Frederick" <chocola@animebitch.es>
> ---
>  tcg/ppc/tcg-target.inc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index ee1f9227c1..a5450a5e67 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -790,21 +790,25 @@ static inline void tcg_out_ext32u(TCGContext *s, TCGReg dst, TCGReg src)
>  
>  static inline void tcg_out_shli32(TCGContext *s, TCGReg dst, TCGReg src, int c)
>  {
> +    c = ((unsigned)c > 32) ? 32 : c;
>      tcg_out_rlw(s, RLWINM, dst, src, c, 0, 31 - c);
>  }
>  
>  static inline void tcg_out_shli64(TCGContext *s, TCGReg dst, TCGReg src, int c)
>  {
> +    c = ((unsigned)c > 64) ? 64 : c;
>      tcg_out_rld(s, RLDICR, dst, src, c, 63 - c);
>  }
>  
>  static inline void tcg_out_shri32(TCGContext *s, TCGReg dst, TCGReg src, int c)
>  {
> +    c = ((unsigned)c > 32) ? 32 : c;
>      tcg_out_rlw(s, RLWINM, dst, src, 32 - c, c, 31);
>  }
>  
>  static inline void tcg_out_shri64(TCGContext *s, TCGReg dst, TCGReg src, int c)
>  {
> +    c = ((unsigned)c > 64) ? 64 : c;
>      tcg_out_rld(s, RLDICL, dst, src, 64 - c, c);
>  }

I agree there is a bug, but I am not sure we should silently cap the
value this way. I'd rather see the caller provide a value in range, and
maybe the callee use 'tcg_debug_assert(c <= RANGE);' to catch future new
caller added missing the range check.

