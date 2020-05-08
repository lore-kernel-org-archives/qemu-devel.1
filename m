Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A503BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC2C20870
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7nc9dUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC2C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0bN-0005hC-Lg
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 06:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX0aO-0004rB-2g
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:50:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX0aN-0003JK-1T
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:50:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id 50so789137wrc.11
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=na4PxtxYBtTgNIyJrJVZOQfkqaOH+MD6SpKh/IbaOOY=;
 b=Z7nc9dUhR+2Lor8t1HZfAy4TQYymAvZSCiBn0Ox7KKvkPi6dzD056wMC2FcNHBF8ks
 OAFqOTcQnj7quLWA7+Hax5AqDDXjcHh1Hdp/bYyF3yXHYiXw1WBqo/NLJx4kPb0NhnUZ
 ELJrpRSmowesx+Fc6f2TJc6qBTIC5Hkl6GJyEbkGNYLcNKDHBTgpLfQu7JOgu2D9ocGR
 sXaekMiXCv+YPyxvML82fWyzj3uBlA6IoPVieEx0NBYlkbRsjGrU81iI0q9bgC9Z4OB2
 GascgWJTJBYItZDYI+L4YelrC/IVI9mU6vPdpgQLwRJfScBREvuhxJxkvQTRZocu3iRy
 7uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=na4PxtxYBtTgNIyJrJVZOQfkqaOH+MD6SpKh/IbaOOY=;
 b=X8ZW5oCaWkq9cbJCn//wJa+I1/wEFyuEKFk/esBen9RGxLQC2IVKnVZoZaWcvkZ1+e
 s4o25nPosYmMBT1nkZgp0kHV3VU6rdPGqb+DnEBxWeGzpO9owyWmjTkLxu3bdy8VbGfx
 vdFrhJtVAwqC4wuMN2fVaJFR4mu3HOWQivFlNYrxc4iQnvfb5vrhMVQ0L9ccDIaypzgp
 U6MF6ofz+UYj0HWktiWzK2YF27tA9tqHqHMEX+SWN3UhyLbP7PaY592Dj3IFamt/tEGU
 F/ZBP6iRNRI+485qJ8YiBtprahwe9k4S390mRVNd7vkgGeRIDlKh23KPcs5WlJX93CZc
 IxPw==
X-Gm-Message-State: AGi0PubHkRGLqAQ4nkr7Kf+7XQ5cNQnhpwnh6AJgUAgqBKOH5+Y0vIbr
 C47Qi9Wri2yGhBf12h5+0PNSo2S9KpyJtsNE5PI=
X-Google-Smtp-Source: APiQypLps5e89dryAJ1QstWGUCC3pDIOliobPu6WMtlfpmaqxoS1yp2kh2z3aXIKNNmT+rqhwwgHq4EwpWC53c73bAM=
X-Received: by 2002:adf:a2d7:: with SMTP id t23mr2248151wra.402.1588935029568; 
 Fri, 08 May 2020 03:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-7-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-7-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 12:49:14 +0200
Message-ID: <CAHiYmc5o93GwReZ2YhqF_SF9A5Pg-px9aMj7PZDi9weoygOdTA@mail.gmail.com>
Subject: Re: [PATCH V3 06/14] KVM: MIPS: Introduce and use cpu_guest_has_ldpte
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm@vger.kernel.org,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:11 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> Loongson-3 has lddir/ldpte instructions and their related CP0 registers
> are the same as HTW. So we introduce a cpu_guest_has_ldpte flag and use
> it to indicate whether we need to save/restore HTW related CP0 registers
> (PWBase, PWSize, PWField and PWCtl).
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/cpu-features.h |  3 +++
>  arch/mips/kernel/cpu-probe.c         |  1 +
>  arch/mips/kvm/vz.c                   | 26 +++++++++++++-------------
>  3 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm=
/cpu-features.h
> index 400b123..e127495 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -659,6 +659,9 @@
>  #ifndef cpu_guest_has_htw
>  #define cpu_guest_has_htw      (cpu_data[0].guest.options & MIPS_CPU_HTW=
)
>  #endif
> +#ifndef cpu_guest_has_ldpte
> +#define cpu_guest_has_ldpte    (cpu_data[0].guest.options & MIPS_CPU_LDP=
TE)
> +#endif
>  #ifndef cpu_guest_has_mvh
>  #define cpu_guest_has_mvh      (cpu_data[0].guest.options & MIPS_CPU_MVH=
)
>  #endif
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index ca2e6f1..be1b556 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -2004,6 +2004,7 @@ static inline void cpu_probe_loongson(struct cpuinf=
o_mips *c, unsigned int cpu)
>                  * register, we correct it here.
>                  */
>                 c->options |=3D MIPS_CPU_FTLB | MIPS_CPU_TLBINV | MIPS_CP=
U_LDPTE;
> +               c->guest.options |=3D MIPS_CPU_LDPTE;
>                 c->writecombine =3D _CACHE_UNCACHED_ACCELERATED;
>                 c->ases |=3D (MIPS_ASE_LOONGSON_MMI | MIPS_ASE_LOONGSON_C=
AM |
>                         MIPS_ASE_LOONGSON_EXT | MIPS_ASE_LOONGSON_EXT2);
> diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
> index 17932ab..422cd06 100644
> --- a/arch/mips/kvm/vz.c
> +++ b/arch/mips/kvm/vz.c
> @@ -1706,7 +1706,7 @@ static unsigned long kvm_vz_num_regs(struct kvm_vcp=
u *vcpu)
>                 ret +=3D ARRAY_SIZE(kvm_vz_get_one_regs_contextconfig);
>         if (cpu_guest_has_segments)
>                 ret +=3D ARRAY_SIZE(kvm_vz_get_one_regs_segments);
> -       if (cpu_guest_has_htw)
> +       if (cpu_guest_has_htw || cpu_guest_has_ldpte)
>                 ret +=3D ARRAY_SIZE(kvm_vz_get_one_regs_htw);
>         if (cpu_guest_has_maar && !cpu_guest_has_dyn_maar)
>                 ret +=3D 1 + ARRAY_SIZE(vcpu->arch.maar);
> @@ -1755,7 +1755,7 @@ static int kvm_vz_copy_reg_indices(struct kvm_vcpu =
*vcpu, u64 __user *indices)
>                         return -EFAULT;
>                 indices +=3D ARRAY_SIZE(kvm_vz_get_one_regs_segments);
>         }
> -       if (cpu_guest_has_htw) {
> +       if (cpu_guest_has_htw || cpu_guest_has_ldpte) {
>                 if (copy_to_user(indices, kvm_vz_get_one_regs_htw,
>                                  sizeof(kvm_vz_get_one_regs_htw)))
>                         return -EFAULT;
> @@ -1878,17 +1878,17 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vc=
pu,
>                 *v =3D read_gc0_segctl2();
>                 break;
>         case KVM_REG_MIPS_CP0_PWBASE:
> -               if (!cpu_guest_has_htw)
> +               if (!cpu_guest_has_htw && !cpu_guest_has_ldpte)
>                         return -EINVAL;
>                 *v =3D read_gc0_pwbase();
>                 break;
>         case KVM_REG_MIPS_CP0_PWFIELD:
> -               if (!cpu_guest_has_htw)
> +               if (!cpu_guest_has_htw && !cpu_guest_has_ldpte)
>                         return -EINVAL;
>                 *v =3D read_gc0_pwfield();
>                 break;
>         case KVM_REG_MIPS_CP0_PWSIZE:
> -               if (!cpu_guest_has_htw)
> +               if (!cpu_guest_has_htw && !cpu_guest_has_ldpte)
>                         return -EINVAL;
>                 *v =3D read_gc0_pwsize();
>                 break;
> @@ -1896,7 +1896,7 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu=
,
>                 *v =3D (long)read_gc0_wired();
>                 break;
>         case KVM_REG_MIPS_CP0_PWCTL:
> -               if (!cpu_guest_has_htw)
> +               if (!cpu_guest_has_htw && !cpu_guest_has_ldpte)
>                         return -EINVAL;
>                 *v =3D read_gc0_pwctl();
>                 break;
> @@ -2101,17 +2101,17 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vc=
pu,
>                 write_gc0_segctl2(v);
>                 break;
>         case KVM_REG_MIPS_CP0_PWBASE:
> -               if (!cpu_guest_has_htw)
> +               if (!cpu_guest_has_htw && !cpu_guest_has_ldpte)
>                         return -EINVAL;
>                 write_gc0_pwbase(v);
>                 break;
>         case KVM_REG_MIPS_CP0_PWFIELD:
> -               if (!cpu_guest_has_htw)
> +               if (!cpu_guest_has_htw && !cpu_guest_has_ldpte)
>                         return -EINVAL;
>                 write_gc0_pwfield(v);
>                 break;
>         case KVM_REG_MIPS_CP0_PWSIZE:
> -               if (!cpu_guest_has_htw)
> +               if (!cpu_guest_has_htw && !cpu_guest_has_ldpte)
>                         return -EINVAL;
>                 write_gc0_pwsize(v);
>                 break;
> @@ -2119,7 +2119,7 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu=
,
>                 change_gc0_wired(MIPSR6_WIRED_WIRED, v);
>                 break;
>         case KVM_REG_MIPS_CP0_PWCTL:
> -               if (!cpu_guest_has_htw)
> +               if (!cpu_guest_has_htw && !cpu_guest_has_ldpte)
>                         return -EINVAL;
>                 write_gc0_pwctl(v);
>                 break;
> @@ -2580,7 +2580,7 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, =
int cpu)
>         }
>
>         /* restore HTW registers */
> -       if (cpu_guest_has_htw) {
> +       if (cpu_guest_has_htw || cpu_guest_has_ldpte) {
>                 kvm_restore_gc0_pwbase(cop0);
>                 kvm_restore_gc0_pwfield(cop0);
>                 kvm_restore_gc0_pwsize(cop0);
> @@ -2685,8 +2685,8 @@ static int kvm_vz_vcpu_put(struct kvm_vcpu *vcpu, i=
nt cpu)
>         }
>
>         /* save HTW registers if enabled in guest */
> -       if (cpu_guest_has_htw &&
> -           kvm_read_sw_gc0_config3(cop0) & MIPS_CONF3_PW) {
> +       if (cpu_guest_has_ldpte || (cpu_guest_has_htw &&
> +           kvm_read_sw_gc0_config3(cop0) & MIPS_CONF3_PW)) {
>                 kvm_save_gc0_pwbase(cop0);
>                 kvm_save_gc0_pwfield(cop0);
>                 kvm_save_gc0_pwsize(cop0);
> --
> 2.7.0
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

