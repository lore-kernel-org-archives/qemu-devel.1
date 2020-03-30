Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42FCC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C59E206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrLcJzsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C59E206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIqRF-0004Ma-LL
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1jIqQF-0003G2-QF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1jIqQE-0007i2-Ns
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:09:31 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1jIqQC-0007P2-Am; Mon, 30 Mar 2020 05:09:28 -0400
Received: by mail-pj1-x1044.google.com with SMTP id o12so7058908pjs.2;
 Mon, 30 Mar 2020 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=o90aux+gJuYZZ35aBpKAauPQDQOQmxZUCFQGlqjLIsc=;
 b=QrLcJzsw1dwKUcw3n2EIP8FAS5disqHLjkybsna47wFVst4lQ9Qx/j2DNFn9Rx2CuX
 NlPiX0RtPCie7oP4ZSQngoC6duOW7MtDm7aIBscxKV+ZDdW1tXnC5+JnWertMIkICY94
 BfwCLLpf7RNuZoXLbREzmdOhFljI5xTGhgfTVS/R5cWVUfyktqtzqlDjQUt1dhxmmyMi
 BrTrnXiRvrbexSXtUyC2YytjJyqq6rchuQo2HZo/87gvPuueL+OUweeyoct1MuQiVER7
 dz6C6PNE6cSZBftzbAfNdI63kiQNfz3/qcUKBSWqc8J/Pxj5mBxfoL3aBw2MiSFYKoRq
 X2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o90aux+gJuYZZ35aBpKAauPQDQOQmxZUCFQGlqjLIsc=;
 b=FCedm1/q5qtyKF1IwKaeK2KI+3iFg4lId1UlIus2CQtNewmg9tVhH0KW60bjqixlpa
 E+JMEpX5cXfdTzNMbZM4lA0/BgkcTCUvrJK13BHpVIWFNfC5In6SoOurzZmkVgIe11KV
 D+okeoaDhDigxTpl40a9QlGaMSdjAeEsZpRglXjyu1M6+k603avLswVKy9P5FdvmUyIW
 i+Zg7CxmIl01+VYVQbINjBmPSfNUs1GyUutWDUdUpK6iCQxwk2ZfVy0HNVEgOw/XGzGk
 qevhhniA0Bvi8grJsI5gbovkWxQOnxuODSW2ws6PirZotMkelkrQFdkFSwKay8ZBkYJS
 p9XA==
X-Gm-Message-State: ANhLgQ0LkHNxzDG6ojtKfWXAKE27l7+NEY61+mjeEz/4vXx1SfsPs1lp
 9Z2UgfyxFWVoMTGN0VUY2Xc=
X-Google-Smtp-Source: ADFU+vsDvZ7YdcNFMVD8nSBMoO6AFiQSYjXgtntv+ibAVAHHvnbYSf4cpu6of2ETu1jITeOQHe8EzQ==
X-Received: by 2002:a17:90a:8e84:: with SMTP id
 f4mr14347349pjo.72.1585559363826; 
 Mon, 30 Mar 2020 02:09:23 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id x11sm3791086pfp.204.2020.03.30.02.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 02:09:23 -0700 (PDT)
Date: Mon, 30 Mar 2020 17:09:17 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] target/arm: fix incorrect current EL bug in aarch32
 exception emulation
Message-ID: <20200330090917.kovajpwnb3mxbtc7@mail.google.com>
References: <20200328140232.17278-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328140232.17278-1-changbin.du@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Peter,
Could you take this fix as high priority? This bug has made qemu-system-arm
broken.

On Sat, Mar 28, 2020 at 10:02:32PM +0800, Changbin Du wrote:
> The arm_current_el() should be invoked after mode switching. Otherwise, we
> get a wrong current EL value, since current EL is also determined by
> current mode.
> 
> Fixes: 4a2696c0d4 ("target/arm: Set PAN bit as required on exception entry")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  target/arm/helper.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b7b6887241..163c91a1cc 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9172,7 +9172,6 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
>  
>      /* Change the CPU state so as to actually take the exception. */
>      switch_mode(env, new_mode);
> -    new_el = arm_current_el(env);
>  
>      /*
>       * For exceptions taken to AArch32 we must clear the SS bit in both
> @@ -9184,6 +9183,10 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
>      env->condexec_bits = 0;
>      /* Switch to the new mode, and to the correct instruction set.  */
>      env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
> +
> +    /* This must be after mode switching. */
> +    new_el = arm_current_el(env);
> +
>      /* Set new mode endianness */
>      env->uncached_cpsr &= ~CPSR_E;
>      if (env->cp15.sctlr_el[new_el] & SCTLR_EE) {
> -- 
> 2.25.1
> 

-- 
Cheers,
Changbin Du

