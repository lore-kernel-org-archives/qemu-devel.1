Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47808C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143BE21655
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143BE21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHNNm-0003x0-5N
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 03:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iHNLy-0002dV-LW
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iHNLx-0000FI-1E
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:22:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iHNLp-0000BR-QY; Mon, 07 Oct 2019 03:22:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0F2D018C4272;
 Mon,  7 Oct 2019 07:22:36 +0000 (UTC)
Received: from [10.36.116.56] (ovpn-116-56.ams2.redhat.com [10.36.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8E565D6D0;
 Mon,  7 Oct 2019 07:22:29 +0000 (UTC)
Subject: Re: [PATCH v5 5/9] target/arm/kvm64: Add kvm_arch_get/put_sve
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-6-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e2a87b8d-d156-c2cb-98e6-64c55a4404cd@redhat.com>
Date: Mon, 7 Oct 2019 09:22:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191001125845.8793-6-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Mon, 07 Oct 2019 07:22:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 10/1/19 2:58 PM, Andrew Jones wrote:
> These are the SVE equivalents to kvm_arch_get/put_fpsimd. Note, the
> swabbing is different than it is for fpsmid because the vector format
> is a little-endian stream of words.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
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
>      }
>  
> -    reg.addr = (uintptr_t)(&fpr);
> -    fpr = vfp_get_fpcr(env);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
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
> +    }
> +
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
>      }
> -    vfp_set_fpsr(env, fpr);
>  
> -    reg.addr = (uintptr_t)(&fpr);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> +    for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
> +        r = &env->vfp.pregs[n].p[0];
> +        reg.addr = (uintptr_t)r;
> +        reg.id = KVM_REG_ARM64_SVE_PREG(n, 0);
> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +        if (ret) {
> +            return ret;
> +        }
> +        sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
> +    }
> +
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
> 

