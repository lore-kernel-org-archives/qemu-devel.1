Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77691C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468B122BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLxTn14K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468B122BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqg9o-0002Hc-4g
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55382)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqg9U-0001CF-ON
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqg9T-0006y3-Jd
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:59:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqg9T-0006xp-Bv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:59:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id v15so45504556wml.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vviHuFgZIF2oIfYIuMDPQOGc2lJS7ohf7xF0vfeOv/A=;
 b=NLxTn14KD8PSoCW96+qs6rGZ5ziT4BOS5W8QX4s79GYOPkXiuWmPooBiUSXUBcH9O/
 CoMEbn1G+gxGnw7yoKbA1lBqbsAHIBAEQ6e+efsi+e4ivbltmAKWTDvj+V/Eod+aR0tF
 20j17HIUVWruQTcBU3zuTn/LwyfL5HQFPA0OdyIjiBIbwk7JbTZm5u8KfNebPVC7CWLm
 M8sVNJJ8ZqGAMIx9LyGMksy8k4S/f0J+Q0qSPaJRPzURzjxzx9zZbWSsS9H7HV/FbTm2
 NxVDfnp9AGyLYxiRVPS9R32twys9IlP/F0IKO6DTkuT0LowDDYWx+y8ee5XiTtbWxM7Q
 gZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vviHuFgZIF2oIfYIuMDPQOGc2lJS7ohf7xF0vfeOv/A=;
 b=J6R19I81242VsOxGSDDf/9pclngXAGmWTYc42w9nDlbGXIpUXMj+H1lSh9paIRkXsq
 SifjMMbUMghOD1h/56wCzh6etu4uge4PNFfPWXcHLJdn6qyC/EXGJDHajUGm3rj4Emqf
 3etoCqq5FTV/nzNqQ03xVDn0dkIfH0wm3mVdiGpgwIhaCx6Qf42nJmETCGTbhDmI0EIP
 qGGtHpVI4aBzreU/I35+7Kmxw3MS0MVjXCC1UUfsWtHS3l8vxpmGjtuzJww7mlZfmxK6
 zKyOlnlZvFsDxyysPcn82QXInknBTLxy981hycQ47Mb7UziKMx6FNoAk2tLRp7+EcRBV
 NXiw==
X-Gm-Message-State: APjAAAXLL372VoQZZsQ+7Z4O/KDL3K+uFqIW4h8WM9mG1sePrzCLqFJK
 oL97UCQRORjVpa46J5x93PjsZw==
X-Google-Smtp-Source: APXvYqyFpGryubnBaAFaTUUZaD9MS/GnlNhEdE/aOH5f6ZZRcHyeHJbj7xA6oCOqbWctnHqIGLa5qg==
X-Received: by 2002:a05:600c:212:: with SMTP id
 18mr30775024wmi.88.1564070370078; 
 Thu, 25 Jul 2019 08:59:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u6sm51618813wml.9.2019.07.25.08.59.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:59:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E8FF1FF87;
 Thu, 25 Jul 2019 16:59:29 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-17-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-17-richard.henderson@linaro.org>
Date: Thu, 25 Jul 2019 16:59:29 +0100
Message-ID: <87v9vqyuji.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.2 16/24] target/arm: Add
 regime_has_2_ranges
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

Can you elucidate what we mean by having 2 ranges?


> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h     | 16 ++++++++++++++++
>  target/arm/helper.c        | 22 +++++-----------------
>  target/arm/translate-a64.c |  3 +--
>  3 files changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 047cbfd1d7..f653e0e7f5 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -824,6 +824,22 @@ static inline void arm_call_el_change_hook(ARMCPU *c=
pu)
>      }
>  }
>
> +/* Return true if this address translation regime has two ranges.  */
> +static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_Stage1_E0:
> +    case ARMMMUIdx_Stage1_E1:
> +    case ARMMMUIdx_EL10_0:
> +    case ARMMMUIdx_EL10_1:
> +    case ARMMMUIdx_EL20_0:
> +    case ARMMMUIdx_EL20_2:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>  /* Return true if this address translation regime is secure */
>  static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 240a6ed168..2d5658f9e3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8999,15 +8999,8 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx =
mmu_idx, bool is_aa64,
>      }
>
>      if (is_aa64) {
> -        switch (regime_el(env, mmu_idx)) {
> -        case 1:
> -            if (!is_user) {
> -                xn =3D pxn || (user_rw & PAGE_WRITE);
> -            }
> -            break;
> -        case 2:
> -        case 3:
> -            break;
> +        if (regime_has_2_ranges(mmu_idx) && !is_user) {
> +            xn =3D pxn || (user_rw & PAGE_WRITE);
>          }
>      } else if (arm_feature(env, ARM_FEATURE_V7)) {
>          switch (regime_el(env, mmu_idx)) {
> @@ -9541,7 +9534,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState=
 *env, uint64_t va,
>                                          ARMMMUIdx mmu_idx)
>  {
>      uint64_t tcr =3D regime_tcr(env, mmu_idx)->raw_tcr;
> -    uint32_t el =3D regime_el(env, mmu_idx);
>      bool tbi, tbid, epd, hpd, using16k, using64k;
>      int select, tsz;
>
> @@ -9551,7 +9543,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState=
 *env, uint64_t va,
>       */
>      select =3D extract64(va, 55, 1);
>
> -    if (el > 1) {
> +    if (!regime_has_2_ranges(mmu_idx)) {
>          tsz =3D extract32(tcr, 0, 6);
>          using64k =3D extract32(tcr, 14, 1);
>          using16k =3D extract32(tcr, 15, 1);
> @@ -9707,10 +9699,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, t=
arget_ulong address,
>          param =3D aa64_va_parameters(env, address, mmu_idx,
>                                     access_type !=3D MMU_INST_FETCH);
>          level =3D 0;
> -        /* If we are in 64-bit EL2 or EL3 then there is no TTBR1, so mar=
k it
> -         * invalid.
> -         */
> -        ttbr1_valid =3D (el < 2);
> +        ttbr1_valid =3D regime_has_2_ranges(mmu_idx);
>          addrsize =3D 64 - 8 * param.tbi;
>          inputsize =3D 64 - param.tsz;
>      } else {
> @@ -11361,8 +11350,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>              ARMVAParameters p0 =3D aa64_va_parameters_both(env, 0, stage=
1);
>              int tbii, tbid;
>
> -            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> -            if (regime_el(env, stage1) < 2) {
> +            if (regime_has_2_ranges(mmu_idx)) {
>                  ARMVAParameters p1 =3D aa64_va_parameters_both(env, -1, =
stage1);
>                  tbid =3D (p1.tbi << 1) | p0.tbi;
>                  tbii =3D tbid & ~((p1.tbid << 1) | p0.tbid);
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index a9e65fe347..5679349310 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -176,8 +176,7 @@ static void gen_top_byte_ignore(DisasContext *s, TCGv=
_i64 dst,
>      if (tbi =3D=3D 0) {
>          /* Load unmodified address */
>          tcg_gen_mov_i64(dst, src);
> -    } else if (s->current_el >=3D 2) {
> -        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> +    } else if (!regime_has_2_ranges(s->mmu_idx)) {
>          /* Force tag byte to all zero */
>          tcg_gen_extract_i64(dst, src, 0, 56);
>      } else {


--
Alex Benn=C3=A9e

