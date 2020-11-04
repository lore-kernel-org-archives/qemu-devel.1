Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358322224E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J83kgK/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358322224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaCxH-0005jo-WD
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1kaCwQ-0005Ko-Js
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:10:46 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1kaCwN-00048F-KD
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:10:46 -0500
Received: by mail-pf1-x443.google.com with SMTP id 133so16532505pfx.11
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 23:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8GTOaJmRrUbbHWdRwqirS1I2A/lZj1gBOu+lltttV0o=;
 b=J83kgK/w2+e2NM8Jd5cqW3/fdFUaX/kRHVJl9F8efOMp9yUqG1mUxu8UXERaPlqecO
 11i6iMu84FienpM+SjwLdLng1O5eMJznrp6x3D04wXDMK/xuNRJf2wiyLkfv3BTYdXt0
 3TPbAhehBWh0NjYc3jzxj3w3lyAlZW4mF5S7/1d7NQ7Xh19obDI8eV9jhl3kViGl7ZvX
 D8M+2awoCKkKobw1Wc4vEtiW8JQqcdAtFu4N3vAnSxrY8W33fbVKSiYm3t+zsDtlCpLG
 tEcPpkIQnC7fAUEhRw4P+0yBPEMQZmmld1TS4GQyAJJg2rFgIi0Pzzj0B3mqlFyo9s47
 j76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8GTOaJmRrUbbHWdRwqirS1I2A/lZj1gBOu+lltttV0o=;
 b=MU5S3gHHcGKEjt57WuvkNCMnaOeEeEiu3hUR4V1TTjroWhI1uhTJWABDxVeFZbdPEv
 IgqIj9amwETg6n9iD6Lb6bosYE0/0+fcNmAdTXkrxpFqinjtfpgfRTf1soXOi3mXEdrK
 Zotn8v086Ekdft8hRE/HySJqeRSqeVnvWuALx14O1Jt6tY6Nc1T6mwtFiQuD1GX4Ux5X
 h8Z22qsj49cCz9WKi4G5fgPguG4kR3fpkITex8strT8ovS++a2chHUcm21t8bUFWkxAI
 m1GC41eY7HC9BdYG/SR4Zg178bR4Aq3Af+SjWyo8M9Sx4p+jBuN0MPYMpj5Pt7qk/83F
 aNdQ==
X-Gm-Message-State: AOAM532sgj0UDUWo5ERSjuPeyCPxy1JblwjVCOgbBSGGIEtsUxNl447e
 ZROZRdVO2KyLvSJc8pfJQj0=
X-Google-Smtp-Source: ABdhPJx0uUgBXou+4N7F6jk6S066MDX9mjRUleYXX1SgljB/bBIeLg6CwP5tsrkhU3trRrS9TyQ6ig==
X-Received: by 2002:a62:8f8b:0:b029:164:9e98:c0e with SMTP id
 n133-20020a628f8b0000b02901649e980c0emr28795028pfd.80.1604473841126; 
 Tue, 03 Nov 2020 23:10:41 -0800 (PST)
Received: from localhost (g133.220-213-56.ppp.wakwak.ne.jp. [220.213.56.133])
 by smtp.gmail.com with ESMTPSA id
 15sm1229595pfj.179.2020.11.03.23.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 23:10:40 -0800 (PST)
Date: Wed, 4 Nov 2020 16:10:33 +0900
From: Stafford Horne <shorne@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/openrisc: Remove dead code attempting to check
 "is timer disabled"
Message-ID: <20201104071033.GB3294551@lianli.shorne-pla.net>
References: <20201103114654.18540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103114654.18540-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=shorne@gmail.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 11:46:54AM +0000, Peter Maydell wrote:
> In the mtspr helper we attempt to check for "is the timer disabled"
> with "if (env->ttmr & TIMER_NONE)".  This is wrong because TIMER_NONE
> is zero and the condition is always false (Coverity complains about
> the dead code.)
> 
> The correct check would be to test whether the TTMR_M field in the
> register is equal to TIMER_NONE instead.  However, the
> cpu_openrisc_timer_update() function checks whether the timer is
> enabled (it looks at cpu->env.is_counting, which is set to 0 via
> cpu_openrisc_count_stop() when the TTMR_M field is set to
> TIMER_NONE), so there's no need to check for "timer disabled" in the
> target/openrisc code.  Instead, simply remove the dead code.

Thanks for the patch!

I think the check is needed, but it's coded wrong.  The ttmr bits 31,30
are the timer mode.  If they are equal to zero (TIMER_NONE) then it means
the timer is disabled and we can skip the timer update.

The code should be something like ((env->ttmr >> 30) == TIMER_NONE). But I
haven't tested it.

I may not have time to look at this, in the next few days so if you want to just
remove the code I am fine with that.  It seems to be working fine as is anyway.

Also, we almost always have timers running in my workloads so the optimization
doesn't do much.

-Stafford

> Fixes: Coverity CID 1005812
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/openrisc/sys_helper.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index d9fe6c59489..41390d046f6 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -176,9 +176,6 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>  
>      case TO_SPR(10, 1): /* TTCR */
>          cpu_openrisc_count_set(cpu, rb);
> -        if (env->ttmr & TIMER_NONE) {
> -            return;
> -        }
>          cpu_openrisc_timer_update(cpu);
>          break;
>  #endif
> -- 
> 2.20.1
> 

