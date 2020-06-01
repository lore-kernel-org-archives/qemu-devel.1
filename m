Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48CAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C894206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8IgVR1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C894206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfgP0-0000DW-TI
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 05:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfgO4-00082w-IR
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:05:40 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:32933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfgO2-00023z-M2
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:05:40 -0400
Received: by mail-ej1-x642.google.com with SMTP id n24so8534104ejd.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 02:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2BInjEraFup28WzKeGP7jF+fAB+mDxB0TmcZorruRZA=;
 b=n8IgVR1Rrv7A7DL1/SpWclhtx6uUsernrdBxoJVrizLWZMvbFH5PyxD0De+6KrfQSJ
 ONs3Cnt6Qdjq7u0uJqeJi0tMADidWRh9U+A2KvBJHnJQ3Am9sfSMulRLRmo3bkZca5wB
 35Sf5lrdkZVHTb5teKqesSpf3yF7WjvH9ZHNRdvcm/oeLWooxWBoOxCavyjcfGiQ5ZSL
 ivXpWdndWjklsDuskcrgUFYWBXzcP9XGh3wol8MWMqm6nkqP37PK8ILSYh2h3eT3VPxe
 ODQca6XfyiuleAuTIo6w5//oPcKdObK7/tXZZj0zspJ5f8Vb0ZKewGksEqnEpA+p550h
 Y0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2BInjEraFup28WzKeGP7jF+fAB+mDxB0TmcZorruRZA=;
 b=SKKmrhhBrRQis/pQKlq0aNkjOF4Ud3uE1Z5sAFXr/u63/EH1dU+IyaFfCQ0q8hF4gQ
 zKqWcwa615dL1LnOh8InzqrTNMZ/oaoVS5fvbZkCuEBcTByPIdGrlhWbe6YVIK99GQq+
 xdZDBEhs0IUDqn34wXQQI/pohoHouiNbPAq5rOHq4TRAp4yYv5dlyv/Ga3oM8dTqlAtc
 r0Sk4p2JNKPrEb0tQHWc4jCNetVNNeaQtejlxBEFHMI0mM8sCi/H6pA6Qcg5feok+I+4
 lK/D6LGz1XMtiJSeb60vMFzfkSbcfTZ/RnFy5+EtDGhH4fbpf8zHm9957rUx98gVsTOe
 bE2A==
X-Gm-Message-State: AOAM530QalXLVNAJ2bRlhs2V8xoYRdaMiUu/D3qZqxILNpL0213ecsJn
 9Z5uv9PH2BMrICNLeqZiSEgLYHEKNvfddU7Sbqo=
X-Google-Smtp-Source: ABdhPJyZtL2l4ODGfZH76BBAsi+VOOMdpBo/ZeVyeaAq18CSjELKfLk/b4eqqBVof1UWkJrCGpGzWQqWbS+Ll9y1OOU=
X-Received: by 2002:a17:906:e47:: with SMTP id
 q7mr5194393eji.279.1591002337023; 
 Mon, 01 Jun 2020 02:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <1588501221-1205-6-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588501221-1205-6-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jun 2020 11:05:26 +0200
Message-ID: <CAL1e-=gxfh6NjS+pG9bynm7ByE3r+Lv=3jgdXRO_KcXBYqUv_A@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 5/7] target/mips: Add more CP0 register for
 save/restore
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 3, 2020 at 12:28 PM Huacai Chen <zltjiangshi@gmail.com> wrote:
>
> Add more CP0 register for save/restore, including: EBase, XContext,
> PageGrain, PWBase, PWSize, PWField, PWCtl, Config*, KScratch1~KScratch6.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Applied to MIPS queue.

Many thanks!
Aleksandar

>  target/mips/kvm.c     | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/mips/machine.c |   6 +-
>  2 files changed, 216 insertions(+), 2 deletions(-)
>
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index de3e26e..96cfa10 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -245,10 +245,16 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level)
>      (KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U64 | (8 * (_R) + (_S)))
>
>  #define KVM_REG_MIPS_CP0_INDEX          MIPS_CP0_32(0, 0)
> +#define KVM_REG_MIPS_CP0_RANDOM         MIPS_CP0_32(1, 0)
>  #define KVM_REG_MIPS_CP0_CONTEXT        MIPS_CP0_64(4, 0)
>  #define KVM_REG_MIPS_CP0_USERLOCAL      MIPS_CP0_64(4, 2)
>  #define KVM_REG_MIPS_CP0_PAGEMASK       MIPS_CP0_32(5, 0)
> +#define KVM_REG_MIPS_CP0_PAGEGRAIN      MIPS_CP0_32(5, 1)
> +#define KVM_REG_MIPS_CP0_PWBASE         MIPS_CP0_64(5, 5)
> +#define KVM_REG_MIPS_CP0_PWFIELD        MIPS_CP0_64(5, 6)
> +#define KVM_REG_MIPS_CP0_PWSIZE         MIPS_CP0_64(5, 7)
>  #define KVM_REG_MIPS_CP0_WIRED          MIPS_CP0_32(6, 0)
> +#define KVM_REG_MIPS_CP0_PWCTL          MIPS_CP0_32(6, 6)
>  #define KVM_REG_MIPS_CP0_HWRENA         MIPS_CP0_32(7, 0)
>  #define KVM_REG_MIPS_CP0_BADVADDR       MIPS_CP0_64(8, 0)
>  #define KVM_REG_MIPS_CP0_COUNT          MIPS_CP0_32(9, 0)
> @@ -258,13 +264,22 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level)
>  #define KVM_REG_MIPS_CP0_CAUSE          MIPS_CP0_32(13, 0)
>  #define KVM_REG_MIPS_CP0_EPC            MIPS_CP0_64(14, 0)
>  #define KVM_REG_MIPS_CP0_PRID           MIPS_CP0_32(15, 0)
> +#define KVM_REG_MIPS_CP0_EBASE          MIPS_CP0_64(15, 1)
>  #define KVM_REG_MIPS_CP0_CONFIG         MIPS_CP0_32(16, 0)
>  #define KVM_REG_MIPS_CP0_CONFIG1        MIPS_CP0_32(16, 1)
>  #define KVM_REG_MIPS_CP0_CONFIG2        MIPS_CP0_32(16, 2)
>  #define KVM_REG_MIPS_CP0_CONFIG3        MIPS_CP0_32(16, 3)
>  #define KVM_REG_MIPS_CP0_CONFIG4        MIPS_CP0_32(16, 4)
>  #define KVM_REG_MIPS_CP0_CONFIG5        MIPS_CP0_32(16, 5)
> +#define KVM_REG_MIPS_CP0_CONFIG6        MIPS_CP0_32(16, 6)
> +#define KVM_REG_MIPS_CP0_XCONTEXT       MIPS_CP0_64(20, 0)
>  #define KVM_REG_MIPS_CP0_ERROREPC       MIPS_CP0_64(30, 0)
> +#define KVM_REG_MIPS_CP0_KSCRATCH1      MIPS_CP0_64(31, 2)
> +#define KVM_REG_MIPS_CP0_KSCRATCH2      MIPS_CP0_64(31, 3)
> +#define KVM_REG_MIPS_CP0_KSCRATCH3      MIPS_CP0_64(31, 4)
> +#define KVM_REG_MIPS_CP0_KSCRATCH4      MIPS_CP0_64(31, 5)
> +#define KVM_REG_MIPS_CP0_KSCRATCH5      MIPS_CP0_64(31, 6)
> +#define KVM_REG_MIPS_CP0_KSCRATCH6      MIPS_CP0_64(31, 7)
>
>  static inline int kvm_mips_put_one_reg(CPUState *cs, uint64_t reg_id,
>                                         int32_t *addr)
> @@ -394,6 +409,29 @@ static inline int kvm_mips_get_one_ureg64(CPUState *cs, uint64_t reg_id,
>                                           (1U << CP0C5_UFE) | \
>                                           (1U << CP0C5_FRE) | \
>                                           (1U << CP0C5_UFR))
> +#define KVM_REG_MIPS_CP0_CONFIG6_MASK   ((1U << CP0C6_BPPASS) | \
> +                                         (0x3fU << CP0C6_KPOS) | \
> +                                         (1U << CP0C6_KE) | \
> +                                         (1U << CP0C6_VTLBONLY) | \
> +                                         (1U << CP0C6_LASX) | \
> +                                         (1U << CP0C6_SSEN) | \
> +                                         (1U << CP0C6_DISDRTIME) | \
> +                                         (1U << CP0C6_PIXNUEN) | \
> +                                         (1U << CP0C6_SCRAND) | \
> +                                         (1U << CP0C6_LLEXCEN) | \
> +                                         (1U << CP0C6_DISVC) | \
> +                                         (1U << CP0C6_VCLRU) | \
> +                                         (1U << CP0C6_DCLRU) | \
> +                                         (1U << CP0C6_PIXUEN) | \
> +                                         (1U << CP0C6_DISBLKLYEN) | \
> +                                         (1U << CP0C6_UMEMUALEN) | \
> +                                         (1U << CP0C6_SFBEN) | \
> +                                         (1U << CP0C6_FLTINT) | \
> +                                         (1U << CP0C6_VLTINT) | \
> +                                         (1U << CP0C6_DISBTB) | \
> +                                         (3U << CP0C6_STPREFCTL) | \
> +                                         (1U << CP0C6_INSTPREF) | \
> +                                         (1U << CP0C6_DATAPREF))
>
>  static inline int kvm_mips_change_one_reg(CPUState *cs, uint64_t reg_id,
>                                            int32_t *addr, int32_t mask)
> @@ -729,6 +767,11 @@ static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
>          DPRINTF("%s: Failed to put CP0_INDEX (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_RANDOM, &env->CP0_Random);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_RANDOM (%d)\n", __func__, err);
> +        ret = err;
> +    }
>      err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_CONTEXT,
>                                   &env->CP0_Context);
>      if (err < 0) {
> @@ -747,11 +790,40 @@ static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
>          DPRINTF("%s: Failed to put CP0_PAGEMASK (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_PAGEGRAIN,
> +                               &env->CP0_PageGrain);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_PAGEGRAIN (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_PWBASE,
> +                               &env->CP0_PWBase);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_PWBASE (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_PWFIELD,
> +                               &env->CP0_PWField);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_PWField (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_PWSIZE,
> +                               &env->CP0_PWSize);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_PWSIZE (%d)\n", __func__, err);
> +        ret = err;
> +    }
>      err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_WIRED, &env->CP0_Wired);
>      if (err < 0) {
>          DPRINTF("%s: Failed to put CP0_WIRED (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_PWCTL, &env->CP0_PWCtl);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_PWCTL (%d)\n", __func__, err);
> +        ret = err;
> +    }
>      err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_HWRENA, &env->CP0_HWREna);
>      if (err < 0) {
>          DPRINTF("%s: Failed to put CP0_HWRENA (%d)\n", __func__, err);
> @@ -799,6 +871,11 @@ static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
>          DPRINTF("%s: Failed to put CP0_PRID (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_EBASE, &env->CP0_EBase);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_EBASE (%d)\n", __func__, err);
> +        ret = err;
> +    }
>      err = kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG,
>                                    &env->CP0_Config0,
>                                    KVM_REG_MIPS_CP0_CONFIG_MASK);
> @@ -841,12 +918,61 @@ static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
>          DPRINTF("%s: Failed to change CP0_CONFIG5 (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG6,
> +                                  &env->CP0_Config6,
> +                                  KVM_REG_MIPS_CP0_CONFIG6_MASK);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to change CP0_CONFIG6 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_XCONTEXT,
> +                                 &env->CP0_XContext);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_XCONTEXT (%d)\n", __func__, err);
> +        ret = err;
> +    }
>      err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_ERROREPC,
>                                   &env->CP0_ErrorEPC);
>      if (err < 0) {
>          DPRINTF("%s: Failed to put CP0_ERROREPC (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH1,
> +                                 &env->CP0_KScratch[0]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH1 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH2,
> +                                 &env->CP0_KScratch[1]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH2 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH3,
> +                                 &env->CP0_KScratch[2]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH3 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH4,
> +                                 &env->CP0_KScratch[3]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH4 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH5,
> +                                 &env->CP0_KScratch[4]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH5 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH6,
> +                                 &env->CP0_KScratch[5]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH6 (%d)\n", __func__, err);
> +        ret = err;
> +    }
>
>      return ret;
>  }
> @@ -862,6 +988,11 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
>          DPRINTF("%s: Failed to get CP0_INDEX (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_RANDOM, &env->CP0_Random);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_RANDOM (%d)\n", __func__, err);
> +        ret = err;
> +    }
>      err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_CONTEXT,
>                                   &env->CP0_Context);
>      if (err < 0) {
> @@ -880,11 +1011,40 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
>          DPRINTF("%s: Failed to get CP0_PAGEMASK (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_PAGEGRAIN,
> +                               &env->CP0_PageGrain);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_PAGEGRAIN (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_PWBASE,
> +                               &env->CP0_PWBase);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_PWBASE (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_PWFIELD,
> +                               &env->CP0_PWField);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_PWFIELD (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_PWSIZE,
> +                               &env->CP0_PWSize);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_PWSIZE (%d)\n", __func__, err);
> +        ret = err;
> +    }
>      err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_WIRED, &env->CP0_Wired);
>      if (err < 0) {
>          DPRINTF("%s: Failed to get CP0_WIRED (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_PWCTL, &env->CP0_PWCtl);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_PWCtl (%d)\n", __func__, err);
> +        ret = err;
> +    }
>      err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_HWRENA, &env->CP0_HWREna);
>      if (err < 0) {
>          DPRINTF("%s: Failed to get CP0_HWRENA (%d)\n", __func__, err);
> @@ -932,6 +1092,11 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
>          DPRINTF("%s: Failed to get CP0_PRID (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_EBASE, &env->CP0_EBase);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_EBASE (%d)\n", __func__, err);
> +        ret = err;
> +    }
>      err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG, &env->CP0_Config0);
>      if (err < 0) {
>          DPRINTF("%s: Failed to get CP0_CONFIG (%d)\n", __func__, err);
> @@ -962,12 +1127,59 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
>          DPRINTF("%s: Failed to get CP0_CONFIG5 (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG6, &env->CP0_Config6);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_CONFIG6 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_XCONTEXT,
> +                                 &env->CP0_XContext);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_XCONTEXT (%d)\n", __func__, err);
> +        ret = err;
> +    }
>      err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_ERROREPC,
>                                   &env->CP0_ErrorEPC);
>      if (err < 0) {
>          DPRINTF("%s: Failed to get CP0_ERROREPC (%d)\n", __func__, err);
>          ret = err;
>      }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH1,
> +                                 &env->CP0_KScratch[0]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH1 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH2,
> +                                 &env->CP0_KScratch[1]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH2 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH3,
> +                                 &env->CP0_KScratch[2]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH3 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH4,
> +                                 &env->CP0_KScratch[3]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH4 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH5,
> +                                 &env->CP0_KScratch[4]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH5 (%d)\n", __func__, err);
> +        ret = err;
> +    }
> +    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH6,
> +                                 &env->CP0_KScratch[5]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH6 (%d)\n", __func__, err);
> +        ret = err;
> +    }
>
>      return ret;
>  }
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index 8d5b18b..5b23e3e 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb = {
>
>  const VMStateDescription vmstate_mips_cpu = {
>      .name = "cpu",
> -    .version_id = 19,
> -    .minimum_version_id = 19,
> +    .version_id = 20,
> +    .minimum_version_id = 20,
>      .post_load = cpu_post_load,
>      .fields = (VMStateField[]) {
>          /* Active TC */
> @@ -289,6 +289,8 @@ const VMStateDescription vmstate_mips_cpu = {
>          VMSTATE_INT32(env.CP0_Config1, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Config2, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Config3, MIPSCPU),
> +        VMSTATE_INT32(env.CP0_Config4, MIPSCPU),
> +        VMSTATE_INT32(env.CP0_Config5, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Config6, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Config7, MIPSCPU),
>          VMSTATE_UINT64(env.CP0_LLAddr, MIPSCPU),
> --
> 2.7.0
>
>

