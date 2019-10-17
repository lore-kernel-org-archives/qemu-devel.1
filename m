Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62E5ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8453620820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyrYFVG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8453620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9hp-0001M6-Ko
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1iL8sP-0006BD-8G
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1iL8sL-0004Nc-MO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:43:49 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:36644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1iL8sL-0004NJ-5N; Thu, 17 Oct 2019 12:43:45 -0400
Received: by mail-qt1-x844.google.com with SMTP id o12so4557478qtf.3;
 Thu, 17 Oct 2019 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=f9WdxtYPXe3N6CGzF+mqfEtRreH6S0emXJdS3OnAjJ8=;
 b=IyrYFVG9CerazNG4ah4dCWnzyMUhQftCN5CdqQK+xDvLZfS3VagJMHA9zu6tT95n7a
 ngC62Ma/BO+qVQLegcOYObKvSIf0rl3C1HD+II9ZN4o4z4WfUr/cVRVyrL5apTrH75eD
 rCeD0RoZHP19mVyQ/ltAwtrkqoJPRcgQGoWKsVNGHx3JeOiMctSTocE0Dj+ekiXzwAH4
 Lt/Cj1JqoLRrq7XXwLOLHjT0Bf+Gr9XDQOqarsWrZ6Xk7eLIKAlfC5lKWi4PZqv9+60Q
 EVv4omgcRtszNb3KAR5KuqWjAvLY3gMpfp898RElKcxgmLB+JEBB/s6AB1W+JjiVUTO1
 /VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=f9WdxtYPXe3N6CGzF+mqfEtRreH6S0emXJdS3OnAjJ8=;
 b=ldW+M10PSVCe+u6Ke/VzCkgh/IG2UV3Mh4rKbfLPdgBfE7h7u9PabADF/aaQlGIhe5
 RIwxlUoLi27oa3XqukXt2jrqqMJoxUMzSy56mFu6ijZsHHWXNjSSlmBIOTTiyTIlyWaU
 Av7Xn5L8nwSWo6lemnUMAMFNeLJBfmRtQC5dcUW28kyf+uQRfDecepB1HupbUUJxeTgY
 gk1tBFEsIzxZw+EFiQKaoizGyXbDtDv1ChLyWGn8/woww0aFvnc2/vrqDuYJTC/aSW+X
 JWCs91C7p4PbCXRkoYZPHuiRh6XoPuCtaxca2jj5zQc/bzO4Nl6p8/gbi61XyInjvK5d
 UE6Q==
X-Gm-Message-State: APjAAAVV5Jjw7wHlIcgh72lO7pvpKjZ93CEw0XkA3rMIONJZrPMGV+Wl
 DovjoN6wVvD9QHjUz4T4wQ==
X-Google-Smtp-Source: APXvYqxrmDMtN6WdBhKTB7oLzU0N6JOY5GZKNS3gysKhXBmdzIzCehlM+mpu/Z3r5/r/wUU19GjD6A==
X-Received: by 2002:aed:3641:: with SMTP id e59mr4936888qtb.115.1571330624576; 
 Thu, 17 Oct 2019 09:43:44 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id c23sm547148qte.66.2019.10.17.09.43.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Oct 2019 09:43:44 -0700 (PDT)
Date: Thu, 17 Oct 2019 12:43:41 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v6 5/9] target/arm/kvm64: Add kvm_arch_get/put_sve
Message-ID: <20191017164340.izip2kbax7gaoa76@gabell>
References: <20191016085408.24360-1-drjones@redhat.com>
 <20191016085408.24360-6-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016085408.24360-6-drjones@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 10:54:04AM +0200, Andrew Jones wrote:
> These are the SVE equivalents to kvm_arch_get/put_fpsimd. Note, the
> swabbing is different than it is for fpsmid because the vector format
> is a little-endian stream of words.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

This patch works well on aarch64 with SVE machine, thanks!
Please feel free to add:

    Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

- Masa

> ---
>  target/arm/kvm64.c | 183 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 155 insertions(+), 28 deletions(-)
> 
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 28f6db57d5ee..4c0b11d105a4 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -671,11 +671,12 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>  bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
>  {
>      /* Return true if the regidx is a register we should synchronize
> -     * via the cpreg_tuples array (ie is not a core reg we sync by
> -     * hand in kvm_arch_get/put_registers())
> +     * via the cpreg_tuples array (ie is not a core or sve reg that
> +     * we sync by hand in kvm_arch_get/put_registers())
>       */
>      switch (regidx & KVM_REG_ARM_COPROC_MASK) {
>      case KVM_REG_ARM_CORE:
> +    case KVM_REG_ARM64_SVE:
>          return false;
>      default:
>          return true;
> @@ -721,10 +722,8 @@ int kvm_arm_cpreg_level(uint64_t regidx)
>  
>  static int kvm_arch_put_fpsimd(CPUState *cs)
>  {
> -    ARMCPU *cpu = ARM_CPU(cs);
> -    CPUARMState *env = &cpu->env;
> +    CPUARMState *env = &ARM_CPU(cs)->env;
>      struct kvm_one_reg reg;
> -    uint32_t fpr;
>      int i, ret;
>  
>      for (i = 0; i < 32; i++) {
> @@ -742,17 +741,73 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
>          }
>      }
>  
> -    reg.addr = (uintptr_t)(&fpr);
> -    fpr = vfp_get_fpsr(env);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> -    if (ret) {
> -        return ret;
> +    return 0;
> +}
> +
> +/*
> + * SVE registers are encoded in KVM's memory in an endianness-invariant format.
> + * The byte at offset i from the start of the in-memory representation contains
> + * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means the
> + * lowest offsets are stored in the lowest memory addresses, then that nearly
> + * matches QEMU's representation, which is to use an array of host-endian
> + * uint64_t's, where the lower offsets are at the lower indices. To complete
> + * the translation we just need to byte swap the uint64_t's on big-endian hosts.
> + */
> +static uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
> +{
> +#ifdef HOST_WORDS_BIGENDIAN
> +    int i;
> +
> +    for (i = 0; i < nr; ++i) {
> +        dst[i] = bswap64(src[i]);
> +    }
> +
> +    return dst;
> +#else
> +    return src;
> +#endif
> +}
> +
> +/*
> + * KVM SVE registers come in slices where ZREGs have a slice size of 2048 bits
> + * and PREGS and the FFR have a slice size of 256 bits. However we simply hard
> + * code the slice index to zero for now as it's unlikely we'll need more than
> + * one slice for quite some time.
> + */
> +static int kvm_arch_put_sve(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +    uint64_t tmp[ARM_MAX_VQ * 2];
> +    uint64_t *r;
> +    struct kvm_one_reg reg;
> +    int n, ret;
> +
> +    for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
> +        r = sve_bswap64(tmp, &env->vfp.zregs[n].d[0], cpu->sve_max_vq * 2);
> +        reg.addr = (uintptr_t)r;
> +        reg.id = KVM_REG_ARM64_SVE_ZREG(n, 0);
> +        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
> +        r = sve_bswap64(tmp, r = &env->vfp.pregs[n].p[0],
> +                        DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
> +        reg.addr = (uintptr_t)r;
> +        reg.id = KVM_REG_ARM64_SVE_PREG(n, 0);
> +        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +        if (ret) {
> +            return ret;
> +        }
>      }
>  
> -    reg.addr = (uintptr_t)(&fpr);
> -    fpr = vfp_get_fpcr(env);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> +    r = sve_bswap64(tmp, &env->vfp.pregs[FFR_PRED_NUM].p[0],
> +                    DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
> +    reg.addr = (uintptr_t)r;
> +    reg.id = KVM_REG_ARM64_SVE_FFR(0);
>      ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>      if (ret) {
>          return ret;
> @@ -765,6 +820,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>  {
>      struct kvm_one_reg reg;
>      uint64_t val;
> +    uint32_t fpr;
>      int i, ret;
>      unsigned int el;
>  
> @@ -855,7 +911,27 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          }
>      }
>  
> -    ret = kvm_arch_put_fpsimd(cs);
> +    if (cpu_isar_feature(aa64_sve, cpu)) {
> +        ret = kvm_arch_put_sve(cs);
> +    } else {
> +        ret = kvm_arch_put_fpsimd(cs);
> +    }
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    reg.addr = (uintptr_t)(&fpr);
> +    fpr = vfp_get_fpsr(env);
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    reg.addr = (uintptr_t)(&fpr);
> +    fpr = vfp_get_fpcr(env);
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>      if (ret) {
>          return ret;
>      }
> @@ -878,10 +954,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>  
>  static int kvm_arch_get_fpsimd(CPUState *cs)
>  {
> -    ARMCPU *cpu = ARM_CPU(cs);
> -    CPUARMState *env = &cpu->env;
> +    CPUARMState *env = &ARM_CPU(cs)->env;
>      struct kvm_one_reg reg;
> -    uint32_t fpr;
>      int i, ret;
>  
>      for (i = 0; i < 32; i++) {
> @@ -899,21 +973,53 @@ static int kvm_arch_get_fpsimd(CPUState *cs)
>          }
>      }
>  
> -    reg.addr = (uintptr_t)(&fpr);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> -    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> -    if (ret) {
> -        return ret;
> +    return 0;
> +}
> +
> +/*
> + * KVM SVE registers come in slices where ZREGs have a slice size of 2048 bits
> + * and PREGS and the FFR have a slice size of 256 bits. However we simply hard
> + * code the slice index to zero for now as it's unlikely we'll need more than
> + * one slice for quite some time.
> + */
> +static int kvm_arch_get_sve(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +    struct kvm_one_reg reg;
> +    uint64_t *r;
> +    int n, ret;
> +
> +    for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
> +        r = &env->vfp.zregs[n].d[0];
> +        reg.addr = (uintptr_t)r;
> +        reg.id = KVM_REG_ARM64_SVE_ZREG(n, 0);
> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +        if (ret) {
> +            return ret;
> +        }
> +        sve_bswap64(r, r, cpu->sve_max_vq * 2);
> +    }
> +
> +    for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
> +        r = &env->vfp.pregs[n].p[0];
> +        reg.addr = (uintptr_t)r;
> +        reg.id = KVM_REG_ARM64_SVE_PREG(n, 0);
> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +        if (ret) {
> +            return ret;
> +        }
> +        sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
>      }
> -    vfp_set_fpsr(env, fpr);
>  
> -    reg.addr = (uintptr_t)(&fpr);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> +    r = &env->vfp.pregs[FFR_PRED_NUM].p[0];
> +    reg.addr = (uintptr_t)r;
> +    reg.id = KVM_REG_ARM64_SVE_FFR(0);
>      ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret) {
>          return ret;
>      }
> -    vfp_set_fpcr(env, fpr);
> +    sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
>  
>      return 0;
>  }
> @@ -923,6 +1029,7 @@ int kvm_arch_get_registers(CPUState *cs)
>      struct kvm_one_reg reg;
>      uint64_t val;
>      unsigned int el;
> +    uint32_t fpr;
>      int i, ret;
>  
>      ARMCPU *cpu = ARM_CPU(cs);
> @@ -1012,10 +1119,30 @@ int kvm_arch_get_registers(CPUState *cs)
>          env->spsr = env->banked_spsr[i];
>      }
>  
> -    ret = kvm_arch_get_fpsimd(cs);
> +    if (cpu_isar_feature(aa64_sve, cpu)) {
> +        ret = kvm_arch_get_sve(cs);
> +    } else {
> +        ret = kvm_arch_get_fpsimd(cs);
> +    }
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    reg.addr = (uintptr_t)(&fpr);
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    vfp_set_fpsr(env, fpr);
> +
> +    reg.addr = (uintptr_t)(&fpr);
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret) {
>          return ret;
>      }
> +    vfp_set_fpcr(env, fpr);
>  
>      ret = kvm_get_vcpu_events(cpu);
>      if (ret) {
> -- 
> 2.21.0
> 
> 

