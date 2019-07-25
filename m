Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD03C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2780921901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xaQ4UYIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2780921901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqePp-00066x-9d
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58283)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqePf-0005em-8e
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqePe-0005YL-1C
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:08:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqePd-0005Vg-QY
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:08:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id f9so50907290wre.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fdON3riPBaP6kngTdwpBKLAeePGqC08Kz2KbBcaqzlo=;
 b=xaQ4UYIL4H21BUw7s/9sriwpS4Q5tmP5AvQC5ti/hV9B4FFFH7tiLU0iwcQ9alUGaN
 jF5Jc9Zbyd3vKHOKit1jD7W7ZVe6aR7hRnwJXaCR9dAowc7303qah3Ckude2IuWflMin
 ZngvT3XH6ItagW95h+BueK+GcXCNL98Uvhd1KALLVkOKyBDGtB6SLSkcO9uSAN0kR9uR
 U+otS1tjxm677ERMJLutOeNMnlqL+JLCMhujf5pFwDwxt4zgsK2fX5z9zmWb0h/X2Aiz
 /6axBQRSSNLB51YdeGTXen3gzxvQkINRjrIMLPFR6jifWLAcAtjg4g3ynA1vq5vaPJBB
 kCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fdON3riPBaP6kngTdwpBKLAeePGqC08Kz2KbBcaqzlo=;
 b=GTswhKAwfv8Z374sxltthfpV7HKSuWCJpDz31+bq03sQzFcdRJOVhuBi8m3s3U+RzD
 7FDk9tsFXRSZs5I7ZdmH4g3Xm9j7Fl/3GHiwSwaY/jdk+bR0JtIISmwsV7zZzI/jJC/m
 geIUF9Mg5UmU8iYv2i8bKtYYdnRRLNtu3dBAOqybqOPR2QYZOgz9g08/knNgXZ9ip6HO
 45Wp9hmaeca+AE4wwnZBLBPnE6D1OFEUsb6ymBbIxXQOk5aCvHPyftwJEKi2jYemW0Ut
 NalZIi1Cj5rIL/kz0iY3lcGA0/5tGhdeGMrxm1Jc2VGT4TVnuPwljZa/CvI6z6ZtRSeU
 ilCw==
X-Gm-Message-State: APjAAAU32U0XeHA5gD/YJvMZKFIRERQIjP/DkrIw98So8/9musOhf29q
 6YEVGj8pz6RZ1ywU0HDr1VXY0g==
X-Google-Smtp-Source: APXvYqwPR+dDHsMDsaLkvE8fmCsA++Xumz6bWuEaUqBZnAibU/jtT4A15BLRa6CzD0g+9azEGjoh3A==
X-Received: by 2002:adf:c613:: with SMTP id n19mr38445010wrg.109.1564063684360; 
 Thu, 25 Jul 2019 07:08:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o24sm55704287wmh.2.2019.07.25.07.08.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 07:08:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 729101FF87;
 Thu, 25 Jul 2019 15:08:03 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-15-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-15-richard.henderson@linaro.org>
Date: Thu, 25 Jul 2019 15:08:03 +0100
Message-ID: <87y30myzp8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH for-4.2 14/24] target/arm: Simplify
 tlb_force_broadcast alternatives
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Rather than call to a separate function and re-compute any
> parameters for the flush, simply use the correct flush
> function directly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 52 +++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7adbf51479..2b95fc763f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -626,56 +626,54 @@ static void tlbiall_write(CPUARMState *env, const A=
RMCPRegInfo *ri,
>                            uint64_t value)
>  {
>      /* Invalidate all (TLBIALL) */
> -    ARMCPU *cpu =3D env_archcpu(env);
> +    CPUState *cs =3D env_cpu(env);
>
>      if (tlb_force_broadcast(env)) {
> -        tlbiall_is_write(env, NULL, value);
> -        return;
> +        tlb_flush_all_cpus_synced(cs);
> +    } else {
> +        tlb_flush(cs);
>      }
> -
> -    tlb_flush(CPU(cpu));
>  }
>
>  static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                            uint64_t value)
>  {
>      /* Invalidate single TLB entry by MVA and ASID (TLBIMVA) */
> -    ARMCPU *cpu =3D env_archcpu(env);
> +    CPUState *cs =3D env_cpu(env);
>
> +    value &=3D TARGET_PAGE_MASK;

I'm fairly sure this is superfluous (we certainly mask pages in the
cputlb code, don't know if we do at the translation end).

>      if (tlb_force_broadcast(env)) {
> -        tlbimva_is_write(env, NULL, value);
> -        return;
> +        tlb_flush_page_all_cpus_synced(cs, value);
> +    } else {
> +        tlb_flush_page(cs, value);
>      }
> -
> -    tlb_flush_page(CPU(cpu), value & TARGET_PAGE_MASK);
>  }
>
>  static void tlbiasid_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                             uint64_t value)
>  {
>      /* Invalidate by ASID (TLBIASID) */
> -    ARMCPU *cpu =3D env_archcpu(env);
> +    CPUState *cs =3D env_cpu(env);
>
>      if (tlb_force_broadcast(env)) {
> -        tlbiasid_is_write(env, NULL, value);
> -        return;
> +        tlb_flush_all_cpus_synced(cs);
> +    } else {
> +        tlb_flush(cs);
>      }
> -
> -    tlb_flush(CPU(cpu));
>  }
>
>  static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                             uint64_t value)
>  {
>      /* Invalidate single entry by MVA, all ASIDs (TLBIMVAA) */
> -    ARMCPU *cpu =3D env_archcpu(env);
> +    CPUState *cs =3D env_cpu(env);
>
> +    value &=3D TARGET_PAGE_MASK;
>      if (tlb_force_broadcast(env)) {
> -        tlbimvaa_is_write(env, NULL, value);
> -        return;
> +        tlb_flush_page_all_cpus_synced(cs, value);
> +    } else {
> +        tlb_flush_page(cs, value);
>      }
> -
> -    tlb_flush_page(CPU(cpu), value & TARGET_PAGE_MASK);
>  }
>
>  static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3926,11 +3924,10 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *=
env, const ARMCPRegInfo *ri,
>      int mask =3D vae1_tlbmask(env);
>
>      if (tlb_force_broadcast(env)) {
> -        tlbi_aa64_vmalle1is_write(env, NULL, value);
> -        return;
> +        tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
> +    } else {
> +        tlb_flush_by_mmuidx(cs, mask);
>      }
> -
> -    tlb_flush_by_mmuidx(cs, mask);
>  }
>
>  static int vmalle1_tlbmask(CPUARMState *env)
> @@ -4052,11 +4049,10 @@ static void tlbi_aa64_vae1_write(CPUARMState *env=
, const ARMCPRegInfo *ri,
>      uint64_t pageaddr =3D sextract64(value << 12, 0, 56);
>
>      if (tlb_force_broadcast(env)) {
> -        tlbi_aa64_vae1is_write(env, NULL, value);
> -        return;
> +        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
> +    } else {
> +        tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
>      }
> -
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
>  }
>
>  static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo =
*ri,

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

