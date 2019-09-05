Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A51C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B04206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfnbscCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B04206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tiQ-00017u-HA
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5tgk-000870-4i
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5tgi-00014W-SR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:28:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5tgi-00014C-Ko
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:28:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id y8so3277379wrn.10
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IFWLeqnoSi0SCHpRKO1OqQNUxbmXKoklHhsd/J9FOLk=;
 b=FfnbscCfUL54+B2NjogenAqlvJcnZmgT9Aya5c6OtJKw3GOGjsp3t4ufCwxRtAGxGi
 GqPmNRd1oqSJkpRBUdGzcJ15jNzSlH3sMdtImYvOfjMaK2p/ucrzvvZxGGwfB05DZLXV
 /CaojOkEuweKTPTYINPsR71GkxHdsahCQzFYj8nmjQ+cnfQXQOGHeU3s3p+g42Bhz92L
 /5PfCkC136YN23xX4F8G0G1EvamcnyVgn9fqcpqZTYZLMg6i5Aljbty7nrADyKg9A14f
 oVFE9uGApRKBQVHnsj8JOKMCuVbYbbtbB4DjY/2elownBhadLXtxHlp3PA+s+7zSVDQ/
 Qcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IFWLeqnoSi0SCHpRKO1OqQNUxbmXKoklHhsd/J9FOLk=;
 b=brUFJYOWlb1iUE7iq0apfctpYBeam8Ls1YJDi27CBrwqMuOd+W5qQBciA1pvNCoGav
 xH+lFVkBcRTaO8pRv3PFbv1EFKRSLR6djmq613qb/tOVOpM8q3cEtT1JJpU2KZkhlwvD
 IYv9tOtUVi/EXlWLjdVzahkYdzVGIO2Q1uIG4mLqGi41LIUm6sqWOSZuwecfD5xTjt6J
 moe+2AR8ALp7822UXA5S+FM1BZMEy3F+Ba9/qQU1tgnL6cx0Tnnqbxz3Fpmov8B8FFoc
 Vq4i6vDMSZrgvVUaoSwTMTTFq3NUK41YntZM57y1aFQLFsysLb/3SSfxEk2+rtSH6W69
 mTCw==
X-Gm-Message-State: APjAAAWRFsUONf4NWpTVXOQmTonQsV3vzLAtQhLl6k9EylAr0Dc5c0uN
 v/nrJn6O4i8R8VgxnT46fmkH4Q==
X-Google-Smtp-Source: APXvYqywRM+lq9+0Go0DtVny/5MCahTV2keu2jeStS9SAQ/YZ18WixX4pQNZ61ZMiDZZT7Q2IiN+rQ==
X-Received: by 2002:a5d:66d0:: with SMTP id k16mr3105032wrw.333.1567697323213; 
 Thu, 05 Sep 2019 08:28:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s22sm2482499wmc.7.2019.09.05.08.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 08:28:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E17CC1FF87;
 Thu,  5 Sep 2019 16:28:41 +0100 (BST)
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <20190820210720.18976-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190820210720.18976-3-richard.henderson@linaro.org>
Date: Thu, 05 Sep 2019 16:28:41 +0100
Message-ID: <875zm692za.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 02/17] target/arm: Split out
 rebuild_hflags_a64
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Create a function to compute the values of the TBFLAG_A64 bits
> that will be cached.  For now, the env->hflags variable is not
> used, and the results are fed back to cpu_get_tb_cpu_state.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 131 +++++++++++++++++++++++---------------------
>  1 file changed, 69 insertions(+), 62 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f2c6419369..02cb43cf58 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11032,6 +11032,71 @@ static uint32_t rebuild_hflags_common(CPUARMStat=
e *env, int fp_el,
>      return flags;
>  }
>
> +static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
> +                                   ARMMMUIdx mmu_idx)
> +{
<snip>
> +
> +    if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
> +        /* Note that SCTLR_EL[23].BT =3D=3D SCTLR_BT1.  */
> +        if (sctlr & (el =3D=3D 0 ? SCTLR_BT0 : SCTLR_BT1)) {
> +            flags =3D FIELD_DP32(flags, TBFLAG_A64, BT, 1);
> +        }
> +    }
> +
> +    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
> +}
> +
>  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {
> @@ -11041,67 +11106,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>      uint32_t flags =3D 0;
>
>      if (is_a64(env)) {
<snip>
> -
> -        if (cpu_isar_feature(aa64_bti, cpu)) {
> -            /* Note that SCTLR_EL[23].BT =3D=3D SCTLR_BT1.  */
> -            if (sctlr & (current_el =3D=3D 0 ? SCTLR_BT0 : SCTLR_BT1)) {
> -                flags =3D FIELD_DP32(flags, TBFLAG_A64, BT, 1);
> -            }
> +        flags =3D rebuild_hflags_a64(env, current_el, fp_el, mmu_idx);
> +        if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
>              flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);

It seems off to only hoist part of the BTI flag check into the helper,
was it just missed or is there a reason? If so it could probably do with
an additional comment.

>          }
>      } else {
> @@ -11121,9 +11128,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>              flags =3D FIELD_DP32(flags, TBFLAG_A32,
>                                 XSCALE_CPAR, env->cp15.c15_cpar);
>          }
> -    }
>
> -    flags =3D rebuild_hflags_common(env, fp_el, mmu_idx, flags);
> +        flags =3D rebuild_hflags_common(env, fp_el, mmu_idx, flags);
> +    }
>
>      /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
>       * states defined in the ARM ARM for software singlestep:


--
Alex Benn=C3=A9e

