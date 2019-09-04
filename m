Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB13C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0388621670
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0388621670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5QlJ-0008Jh-VE
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 04:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1i5Qj6-00078O-It
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1i5Qj0-0005zv-Ng
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:33:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1i5Qir-0005w7-48; Wed, 04 Sep 2019 04:33:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B96FD3002A2F;
 Wed,  4 Sep 2019 08:32:59 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6459660606;
 Wed,  4 Sep 2019 08:32:55 +0000 (UTC)
Date: Wed, 4 Sep 2019 10:32:52 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190904083252.7pmmjvbynik7dk33@kamzik.brq.redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190810013112.28732-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810013112.28732-1-richard.henderson@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 04 Sep 2019 08:32:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] HACK: Centralize sve property checks
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 09, 2019 at 06:31:12PM -0700, Richard Henderson wrote:
> As promised, an experiment in unifying the checks.
> 
> I believe that I've tested for all of the same conditions, modulo the
> timing at which they are emitted.  As before, only one error is reported,
> so if multiple errors exist you can't rely on which error is seen.
> 
> I think there's value in splitting the sve_map_vq bitmap such that the
> initialized state can be easily manipulated with bitmap functions.
> 
> The diffstat is promising.  Lemme know what you think.

Hi Richard,

Thanks for this!

I'm back after a long context switch away from this work. There is indeed
a nice number of lines reduced. I applied this (with a couple minor fixups
for kvm code) and lightly tested it (primarily with tcg, other than the
sve-not-supported-with-this-kvm path). It works for me. I wouldn't say
this approach is less complex, but with the LOC reduction, then I'm happy
to get started on integrating it into the v4 series. How would you suggest
I apply credit for it? I can give you authorship for any patches that
mainly contain your code. Or I can keep authorship and add mentions of
your contributions in the commit messages. Just let me know your
preference.

I also have a couple comments below on the patch.

> 
> 
> r~
> 
> ---
>  target/arm/cpu.h     |  16 +-
>  target/arm/cpu.c     |  12 +-
>  target/arm/cpu64.c   | 502 ++++++++++++++-----------------------------
>  target/arm/monitor.c |   7 +
>  4 files changed, 190 insertions(+), 347 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 7993085bea..924476480b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -184,11 +184,11 @@ typedef struct {
>  
>  #ifdef TARGET_AARCH64
>  # define ARM_MAX_VQ    16
> -void arm_cpu_sve_finalize(ARMCPU *cpu);
> +void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
>  uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq);
>  #else
>  # define ARM_MAX_VQ    1
> -static inline void arm_cpu_sve_finalize(ARMCPU *cpu) { }
> +static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
>  static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
>  { return 0; }
>  #endif
> @@ -924,12 +924,14 @@ struct ARMCPU {
>      /*
>       * In sve_vq_map each set bit is a supported vector length of
>       * (bit-number + 1) * 16 bytes, i.e. each bit number + 1 is the vector
> -     * length in quadwords. We need a map size twice the maximum
> -     * quadword length though because we use two bits for each vector
> -     * length in order to track four states: uninitialized, uninitialized
> -     * but supported by KVM, off, and on.
> +     * length in quadwords.
> +     *
> +     * While processing properties during initialization, corresponding
> +     * sve_vq_init bits are set for bits in sve_vq_map that have been
> +     * set by properties.
>       */
> -    DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ * 2);
> +    DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
> +    DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
>  };
>  
>  void arm_cpu_post_init(Object *obj);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 604f5c3651..a113c30def 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1255,8 +1255,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    if (cpu_isar_feature(aa64_sve, cpu)) {
> -        arm_cpu_sve_finalize(cpu);
> +    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> +        arm_cpu_sve_finalize(cpu, &local_err);
> +        if (local_err != NULL) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>      }
>  
>      if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> @@ -2656,7 +2660,9 @@ static void arm_host_initfn(Object *obj)
>      ARMCPU *cpu = ARM_CPU(obj);
>  
>      kvm_arm_set_cpu_features_from_host(cpu);
> -    aarch64_add_sve_properties(obj);
> +    if (arm_feature(env, ARM_FEATURE_AARCH64)) {

&cpu->env

> +        aarch64_add_sve_properties(obj);
> +    }
>      arm_cpu_post_init(obj);
>  }
>  
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 0313eec88a..7c7e54ad78 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -257,165 +257,168 @@ static void aarch64_a72_initfn(Object *obj)
>      define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
>  }
>  
> -/*
> - * While we eventually use cpu->sve_vq_map as a typical bitmap, where each vq
> - * has only two states (off/on), until we've finalized the map at realize time
> - * we use an extra bit, at the vq - 1 + ARM_MAX_VQ bit number, to also allow
> - * tracking of the uninitialized state and the uninitialized but supported by
> - * KVM state. The arm_vq_state typedef and following functions allow us to more
> - * easily work with the bitmap.
> - */
> -typedef enum arm_vq_state {
> -    ARM_VQ_OFF,
> -    ARM_VQ_ON,
> -    ARM_VQ_UNINITIALIZED,
> -    ARM_VQ_UNINITIALIZED_KVM_SUPPORTED
> -    /*
> -     * More states cannot be added without adding bits to sve_vq_map
> -     * and modifying its supporting functions.
> -     */
> -} arm_vq_state;
> -
> -static arm_vq_state arm_cpu_vq_map_get(ARMCPU *cpu, uint32_t vq)
> +void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>  {
> -    assert(vq <= ARM_MAX_VQ);
> -
> -    return test_bit(vq - 1, cpu->sve_vq_map) |
> -           test_bit(vq - 1 + ARM_MAX_VQ, cpu->sve_vq_map) << 1;
> -}
> -
> -static void arm_cpu_vq_map_set(ARMCPU *cpu, uint32_t vq, arm_vq_state state)
> -{
> -    assert(vq <= ARM_MAX_VQ);
> -    assert(state == ARM_VQ_OFF || state == ARM_VQ_ON);
> -
> -    clear_bit(vq - 1 + ARM_MAX_VQ, cpu->sve_vq_map);
> -
> -    if (state == ARM_VQ_ON) {
> -        set_bit(vq - 1, cpu->sve_vq_map);
> -    } else {
> -        clear_bit(vq - 1, cpu->sve_vq_map);
> -    }
> -}
> -
> -static bool arm_cpu_vq_kvm_supported(ARMCPU *cpu, uint32_t vq)
> -{
> -    return arm_cpu_vq_map_get(cpu, vq) != ARM_VQ_UNINITIALIZED;
> -}
> -
> -static bool arm_cpu_vq_uninitialized(ARMCPU *cpu, uint32_t vq)
> -{
> -    arm_vq_state vq_state = arm_cpu_vq_map_get(cpu, vq);
> -
> -    if (kvm_enabled()) {
> -        return vq_state == ARM_VQ_UNINITIALIZED_KVM_SUPPORTED;
> -    }
> -
> -    return vq_state == ARM_VQ_UNINITIALIZED;
> -}
> -
> -/*
> - * Uninitialized vector lengths need a default value to use in case we need
> - * to query their value prior to map finalization. Additionally map finalizing
> - * itself needs to determine what value to assign uninitialized vector lengths.
> - * The default is determined as follows:
> - *
> - *  * When no vector lengths have been explicitly enabled, i.e. either no
> - *    input has been provided by the user at all, or vector lengths have
> - *    only been disabled, then all uninitialized vector lengths default 'ON'.
> - *
> - *  * When one or more vector lengths have been enabled, then all uninitialized
> - *    vector lengths default 'OFF'. Note, when checking for enabled vector
> - *    lengths we do not discriminate between user-enabled vector lengths and
> - *    auto-enabled vector lengths (which were auto-enabled in order to satisfy
> - *    the user-enabled vector lengths). This implies the default can never
> - *    transition back to 'ON', even if the user-enabled and auto-enabled vector
> - *    lengths that initially transitioned it to 'OFF' are later disabled, as at
> - *    least one vector length must remain enabled unless the SVE feature is
> - *    completely disabled. If SVE is completely disabled then all vector
> - *    lengths are effectively 'OFF'.
> - */
> -static bool arm_cpu_vq_map_get_default(ARMCPU *cpu)
> -{
> -    uint32_t vq;
> -
> -    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> -        if (arm_cpu_vq_map_get(cpu, vq) == ARM_VQ_ON) {
> -            return false;
> -        }
> -    }
> -
> -    return true;
> -}
> -
> -/*
> - * We need to be able to track the number of enabled (or will-be enabled)
> - * vector lengths in order to ensure we never drop to zero. If the default
> - * is 'ON', then we count enabled and uninitialized vector lengths. Otherwise,
> - * if the default is 'OFF', then we only count enabled vector lengths.
> - */
> -static int arm_cpu_num_vqs_available(ARMCPU *cpu)
> -{
> -    uint32_t vq;
> -    bool defval;
> -    int num = 0;
> -
> -    defval = arm_cpu_vq_map_get_default(cpu);
> -
> -    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> -        if (arm_cpu_vq_map_get(cpu, vq) == ARM_VQ_ON) {
> -            ++num;
> -        } else if (defval && arm_cpu_vq_uninitialized(cpu, vq)) {
> -            ++num;
> -        }
> -    }
> -
> -    return num;
> -}
> -
> -static void arm_cpu_vq_map_init(ARMCPU *cpu)
> -{
> -    /* Set all vq's to 0b10 (ARM_VQ_UNINITIALIZED) */
> -    bitmap_clear(cpu->sve_vq_map, 0, ARM_MAX_VQ);
> -    bitmap_set(cpu->sve_vq_map, ARM_MAX_VQ, ARM_MAX_VQ);
> -
> -    if (kvm_enabled()) {
> -        /*
> -         * As the upper bits of the ARM_VQ_UNINITIALIZED_KVM_SUPPORTED (0b11)
> -         * states have already been set with the bitmap_set() above, we only
> -         * need to OR in the lower bits.
> -         */
> -        DECLARE_BITMAP(kvm_supported, ARM_MAX_VQ);
> +    DECLARE_BITMAP(kvm_supported, ARM_MAX_VQ);
> +    DECLARE_BITMAP(test, ARM_MAX_VQ);
> +    uint32_t vq, max_vq = 0;
>  
> +    /* Collect the set of VQ supported by KVM. */
> +    if (kvm_enabled() && kvm_arm_sve_supported(CPU(cpu))) {
>          kvm_arm_sve_get_vls(CPU(cpu), kvm_supported);
> -        bitmap_or(cpu->sve_vq_map, cpu->sve_vq_map, kvm_supported, ARM_MAX_VQ);
> +    } else {
> +        bitmap_zero(kvm_supported, ARM_MAX_VQ);
>      }
> -}
>  
> -void arm_cpu_sve_finalize(ARMCPU *cpu)
> -{
> -    bool defval = arm_cpu_vq_map_get_default(cpu);
> -    uint32_t vq, max_vq;
> +    /*
> +     * Process explicit sve<N> properties.
> +     * From the properties, sve_vq_map<N> implies sve_vq_init<N>.
> +     * Check first for any sve<N> enabled.
> +     */
> +    if (!bitmap_empty(cpu->sve_vq_map, ARM_MAX_VQ)) {
> +        max_vq = find_last_bit(cpu->sve_vq_map, ARM_MAX_VQ) + 1;
>  
> -    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> -        if (kvm_enabled() && !arm_cpu_vq_kvm_supported(cpu, vq)) {
> -            arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
> -        } else if (arm_cpu_vq_uninitialized(cpu, vq)) {
> -            if (defval) {
> -                arm_cpu_vq_map_set(cpu, vq, ARM_VQ_ON);
> -            } else {
> -                arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
> +        if (cpu->sve_max_vq && max_vq > cpu->sve_max_vq) {
> +            error_setg(errp, "cannot enable sve%d", max_vq * 128);
> +            error_append_hint(errp, "sve%d is larger than the maximum vector "
> +                              "length, sve-max-vq=%d (%d bits)\n",
> +                              max_vq * 128, cpu->sve_max_vq,
> +                              cpu->sve_max_vq * 128);
> +            return;
> +        }
> +
> +        /* Propagate enabled bits down through required powers-of-two. */
> +        for (vq = pow2floor(max_vq); vq >= 1; vq >>= 1) {
> +            if (!test_bit(vq - 1, cpu->sve_vq_init)) {
> +                set_bit(vq - 1, cpu->sve_vq_map);
> +                set_bit(vq - 1, cpu->sve_vq_init);
>              }
>          }

While the architecture requires this, so all hardware should also
require it / depend on it, I would only do this propagation in the
non-KVM path. When KVM is enabled I prefer giving KVM full authority
over what vector lengths may be enabled. The reasoning is for the
unlikely case of KVM possibly trying to workaround some hardware
errata involving power-of-2 vector lengths.

> +
> +        /*
> +         * For KVM we have to automatically enable all supported unitialized
> +         * lengths, even when the smaller lengths are not all powers-of-two.
> +         */
> +        if (kvm_enabled()) {
> +            if (!kvm_arm_sve_supported(CPU(cpu))) {
> +                error_setg(errp, "cannot enable sve%d", max_vq);

max_vq * 128

> +                error_append_hint(errp, "SVE not supported by "
> +                                  "KVM on this host\n");
> +                return;
> +            }
> +            bitmap_andnot(test, kvm_supported, cpu->sve_vq_init, max_vq);
> +            bitmap_or(cpu->sve_vq_map, cpu->sve_vq_map, test, max_vq);
> +            bitmap_or(cpu->sve_vq_init, cpu->sve_vq_init, test, max_vq);
> +        }
> +    } else if (cpu->sve_max_vq == 0) {
> +        /*
> +         * No explicit bits enabled, and no implicit bits from sve-max-vq.
> +         */
> +        if (!cpu_isar_feature(aa64_sve, cpu)) {
> +            /* SVE is disabled and so are all vector lengths.  Good. */
> +            return;
> +        }
> +
> +        /* Disabling a power-of-two disables all larger lengths. */
> +        if (test_bit(0, cpu->sve_vq_init)) {
> +            error_setg(errp, "cannot disable sve128");
> +            error_append_hint(errp, "Disabling sve128 results in all vector "
> +                              "lengths being disabled.\n");
> +            error_append_hint(errp, "With SVE enabled, at least one vector "
> +                                  "length must be enabled.\n");
> +
> +            return;
> +        }
> +        for (vq = 2; vq <= ARM_MAX_VQ; vq <<= 1) {
> +            if (test_bit(vq - 1, cpu->sve_vq_init)) {
> +                break;
> +            }
> +        }
> +        max_vq = (vq <= ARM_MAX_VQ ? vq - 1 : ARM_MAX_VQ);
> +
> +        /* Enable all supported bits other than those explicit disabled. */
> +        if (kvm_enabled()) {
> +            bitmap_andnot(cpu->sve_vq_map, kvm_supported,
> +                          cpu->sve_vq_init, max_vq);
> +        } else {
> +            bitmap_complement(cpu->sve_vq_map, cpu->sve_vq_init, max_vq);
> +        }
> +        bitmap_set(cpu->sve_vq_init, 0, max_vq);
> +        max_vq = find_last_bit(cpu->sve_vq_map, max_vq) + 1;
>      }
>  
> -    max_vq = arm_cpu_vq_map_next_smaller(cpu, ARM_MAX_VQ + 1);
> +    /*
> +     * Process the sve-max-vq property.
> +     * Note that we know from the above that no bit above
> +     * sve-max-vq is currently set.
> +     */
> +    if (cpu->sve_max_vq != 0) {
> +        max_vq = cpu->sve_max_vq;
>  
> -    if (!cpu->sve_max_vq) {
> -        cpu->sve_max_vq = max_vq;
> +        if (!test_bit(max_vq - 1, cpu->sve_vq_map) &&
> +            test_bit(max_vq - 1, cpu->sve_vq_init)) {
> +            error_setg(errp, "cannot disable sve%d", max_vq * 128);
> +            error_append_hint(errp, "The maximum vector length must be "
> +                              "enabled, sve-max-vq=%d (%d bits)\n",
> +                              max_vq, max_vq * 128);
> +            return;
> +        }
> +
> +        /* Set all bits not explicitly set within sve-max-vq.  */
> +        bitmap_complement(test, cpu->sve_vq_init, max_vq);
> +        bitmap_or(cpu->sve_vq_map, cpu->sve_vq_map, test, max_vq);
>      }
>  
> -    assert(max_vq && cpu->sve_max_vq == max_vq);
> +    /*
> +     * At this point we will have found max_vq.  All bits implied from
> +     * other properties are set or clear in cpu->sve_vq_map.
> +     * All bits implied from other sve<N> are set in cpu->sve_vq_init.
> +     * If sve_vq_map<N> & !sve_vq_init<N>, then the bit must have come
> +     * sve-max-vq.
> +     */
> +    assert(max_vq != 0);
> +
> +    /* Ensure all required powers-of-two are enabled. */
> +    for (vq = pow2floor(max_vq); vq >= 1; vq >>= 1) {
> +        if (!test_bit(vq - 1, cpu->sve_vq_map)) {
> +            error_setg(errp, "cannot disable sve%d", vq * 128);
> +            error_append_hint(errp, "sve%d is required as it "
> +                              "is a power-of-2 length smaller than "
> +                              "the maximum, sve%d\n",
> +                              vq * 128, max_vq * 128);
> +            return;
> +        }
> +    }
> +
> +    /* Ensure the set of lengths matches what KVM supports. */
> +    if (kvm_enabled()) {
> +        bitmap_xor(test, cpu->sve_vq_map, kvm_supported, max_vq);
> +        if (!bitmap_empty(test, max_vq)) {
> +            vq = find_last_bit(test, max_vq);
> +            if (!test_bit(vq - 1, cpu->sve_vq_map)) {
> +                error_setg(errp, "cannot disable sve%d", vq * 128);
> +                error_append_hint(errp, "The KVM host requires all "
> +                                  "supported vector lengths smaller "
> +                                  "than %d bits to also be enabled.\n",
> +                                  max_vq * 128);
> +            } else if (test_bit(vq - 1, cpu->sve_vq_init)) {
> +                error_setg(errp, "cannot enable sve%d", vq * 128);
> +                error_append_hint(errp, "This KVM host does not support "
> +                                  "the vector length %d-bits.\n", vq * 128);
> +            } else {
> +                error_setg(errp, "cannot set sve-max-vq=%d", cpu->sve_max_vq);
> +                error_append_hint(errp, "This KVM host does not support "
> +                                  "the vector length %d-bits.\n", vq * 128);
> +                error_append_hint(errp, "It may not be possible to use "
> +                                  "sve-max-vq with this KVM host. Try "
> +                                  "using only sve<vl-bits> properties.\n");
> +            }
> +            return;
> +        }
> +    }
> +
> +    /* From now on sve_max_vq is the actual maximum supported length. */
> +    cpu->sve_max_vq = max_vq;
>  }
>  
>  uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
> @@ -427,6 +430,7 @@ uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
>       * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
>       * function always returns the next smaller than the input.
>       */
> +    assert(vq > 1);
>      assert(vq <= ARM_MAX_VQ + 1);
>  
>      bitnum = find_last_bit(cpu->sve_vq_map, vq - 1);
> @@ -437,7 +441,15 @@ static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
>                                     void *opaque, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> -    visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
> +    uint32_t value;
> +
> +    /* All vector lengths are disabled when SVE is off. */
> +    if (!cpu_isar_feature(aa64_sve, cpu)) {
> +        value = 0;
> +    } else {
> +        value = cpu->sve_max_vq;
> +    }
> +    visit_type_uint32(v, name, &value, errp);
>  }
>  
>  static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
> @@ -445,7 +457,6 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>      Error *err = NULL;
> -    uint32_t vq;
>  
>      visit_type_uint32(v, name, &cpu->sve_max_vq, &err);
>      if (err) {
> @@ -465,27 +476,6 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
>                            ARM_MAX_VQ);
>          return;
>      }
> -
> -    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> -        if (vq <= cpu->sve_max_vq) {
> -            char tmp[8];
> -
> -            sprintf(tmp, "sve%d", vq * 128);
> -            object_property_set_bool(obj, true, tmp, &err);
> -            if (err) {
> -                if (kvm_enabled()) {
> -                    error_append_hint(&err, "It is not possible to use "
> -                                      "sve-max-vq with this KVM host. Try "
> -                                      "using only sve<vl-bits> "
> -                                      "properties.\n");
> -                }
> -                error_propagate(errp, err);
> -                return;
> -            }
> -        } else if (arm_cpu_vq_map_get(cpu, vq) == ARM_VQ_ON) {
> -            arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
> -        }
> -    }
>  }
>  
>  static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
> @@ -493,24 +483,14 @@ static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>      uint32_t vq = atoi(&name[3]) / 128;
> -    arm_vq_state vq_state = arm_cpu_vq_map_get(cpu, vq);
>      bool value;
>  
> +    /* All vector lengths are disabled when SVE is off. */
>      if (!cpu_isar_feature(aa64_sve, cpu)) {
> -        /* All vector lengths are disabled when SVE is off. */
>          value = false;
> -    } else if (vq_state == ARM_VQ_ON) {
> -        value = true;
> -    } else if (vq_state == ARM_VQ_OFF) {
> -        value = false;
> -    } else if (kvm_enabled() && !arm_cpu_vq_kvm_supported(cpu, vq)) {
> -        value = false;
> -    } else if (arm_cpu_vq_map_get_default(cpu)) {
> -        value = true;
>      } else {
> -        value = false;
> +        value = test_bit(vq - 1, cpu->sve_vq_map);
>      }
> -
>      visit_type_bool(v, name, &value, errp);
>  }
>  
> @@ -519,7 +499,6 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>      uint32_t vq = atoi(&name[3]) / 128;
> -    uint32_t max_vq = 0;
>      Error *err = NULL;
>      bool value;
>  
> @@ -529,146 +508,12 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
> -        error_setg(errp, "cannot enable %s", name);
> -        error_append_hint(errp, "SVE not supported by KVM on this host\n");
> -        return;
> -    }
> -
> -    /*
> -     * We need to know the maximum vector length, which may just currently
> -     * be the maximum length, in order to validate the enabling/disabling
> -     * of this vector length.
> -     */
> -    if (!cpu->sve_max_vq) {
> -        for (max_vq = ARM_MAX_VQ; max_vq >= 1; --max_vq) {
> -            if (arm_cpu_vq_map_get(cpu, max_vq) == ARM_VQ_ON) {
> -                break;
> -            }
> -        }
> -    }
> -
> -    if (cpu->sve_max_vq && value && vq > cpu->sve_max_vq) {
> -        error_setg(errp, "cannot enable %s", name);
> -        error_append_hint(errp, "vq=%d (%d bits) is larger than the "
> -                          "maximum vector length, sve-max-vq=%d "
> -                          "(%d bits)\n", vq, vq * 128,
> -                          cpu->sve_max_vq, cpu->sve_max_vq * 128);
> -    } else if (cpu->sve_max_vq && !value && vq == cpu->sve_max_vq) {
> -        error_setg(errp, "cannot disable %s", name);
> -        error_append_hint(errp, "The maximum vector length must be "
> -                          "enabled, sve-max-vq=%d (%d bits)\n",
> -                          cpu->sve_max_vq, cpu->sve_max_vq * 128);
> -    } else if (!kvm_enabled() && cpu->sve_max_vq && !value &&
> -               vq < cpu->sve_max_vq && is_power_of_2(vq)) {
> -        error_setg(errp, "cannot disable %s", name);
> -        error_append_hint(errp, "vq=%d (%d bits) is required as it is a "
> -                          "power-of-2 length smaller than the maximum, "
> -                          "sve-max-vq=%d (%d bits)\n", vq, vq * 128,
> -                          cpu->sve_max_vq, cpu->sve_max_vq * 128);
> -    } else if (!kvm_enabled() && max_vq && !value && vq < max_vq &&
> -               is_power_of_2(vq)) {
> -        error_setg(errp, "cannot disable %s", name);
> -        error_append_hint(errp, "Vector length %d-bits is required as it "
> -                          "is a power-of-2 length smaller than another "
> -                          "enabled vector length. Disable all larger vector "
> -                          "lengths first.\n", vq * 128);
> -    } else if (kvm_enabled() && !value && vq < max_vq &&
> -                arm_cpu_vq_kvm_supported(cpu, vq)) {
> -        error_setg(errp, "cannot disable %s", name);
> -        error_append_hint(errp, "Vector length %d-bits is a KVM supported "
> -                          "length smaller than another enabled vector "
> -                          "length. Disable all larger vector lengths "
> -                          "first.\n", vq * 128);
> -    } else if (kvm_enabled() && value && !arm_cpu_vq_kvm_supported(cpu, vq)) {
> -        error_setg(errp, "cannot enable %s", name);
> -        error_append_hint(errp, "This KVM host does not support "
> -                          "the vector length %d-bits.\n", vq * 128);
> +    if (value) {
> +        set_bit(vq - 1, cpu->sve_vq_map);
>      } else {
> -        uint32_t s;
> -
> -        if (value) {
> -            bool fail = false;
> -
> -            /*
> -             * Enabling a vector length automatically enables all
> -             * uninitialized power-of-2 lengths smaller than it, as
> -             * per the architecture.
> -             *
> -             * For KVM we have to automatically enable all supported,
> -             * uninitialized lengths smaller than this length, even
> -             * when the smaller lengths are not power-of-2's.
> -             */
> -            for (s = 1; s < vq; ++s) {
> -                if (kvm_enabled() || is_power_of_2(s)) {
> -                    if (arm_cpu_vq_uninitialized(cpu, s)) {
> -                        arm_cpu_vq_map_set(cpu, s, ARM_VQ_ON);
> -                    } else if (arm_cpu_vq_map_get(cpu, s) == ARM_VQ_OFF) {
> -                        fail = true;
> -                        break;
> -                    }
> -                }
> -            }
> -
> -            if (!kvm_enabled() && fail) {
> -                error_setg(errp, "cannot enable %s", name);
> -                error_append_hint(errp, "Vector length %d-bits is disabled "
> -                                  "and is a power-of-2 length smaller than "
> -                                  "%s. All power-of-2 vector lengths smaller "
> -                                  "than the maximum length are required.\n",
> -                                  s * 128, name);
> -
> -            } else if (fail) {
> -                error_setg(errp, "cannot enable %s", name);
> -                error_append_hint(errp, "Vector length %d-bits is disabled "
> -                                  "and the KVM host requires all supported "
> -                                  "vector lengths smaller than %s to also be "
> -                                  "enabled.\n", s * 128, name);
> -            } else {
> -                arm_cpu_vq_map_set(cpu, vq, ARM_VQ_ON);
> -            }
> -        } else {
> -            /*
> -             * When disabling vector lengths with KVM enabled if the vq wasn't
> -             * supported then we leave it in the ARM_VQ_UNINITIALIZED state in
> -             * order to keep that unsupported information. It'll be set to OFF
> -             * later when we finalize the map.
> -             *
> -             * We would have errored-out already if we were attempting to
> -             * disable a power-of-2 vector length less than another enabled
> -             * vector length, but there may be uninitialized vector lengths
> -             * larger than a power-of-2 vector length that we're disabling.
> -             * We disable all of those lengths now too, as they can no longer
> -             * be enabled. Additionally, for KVM, we have to automatically
> -             * disable all supported, uninitialized lengths larger than this
> -             * length, even when this length is not a power-of-2.
> -             */
> -            if (kvm_enabled() || is_power_of_2(vq)) {
> -                for (s = vq + 1; s <= ARM_MAX_VQ; ++s) {
> -                    if (!kvm_enabled() || arm_cpu_vq_kvm_supported(cpu, vq)) {
> -                        arm_cpu_vq_map_set(cpu, s, ARM_VQ_OFF);
> -                    }
> -                }
> -            }
> -
> -            if (!kvm_enabled() || arm_cpu_vq_kvm_supported(cpu, vq)) {
> -                arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
> -            }
> -
> -            /*
> -             * We just disabled one or more vector lengths. We need to make
> -             * sure we didn't disable them all when SVE is enabled.
> -             */
> -            if (cpu_isar_feature(aa64_sve, cpu) &&
> -                !arm_cpu_num_vqs_available(cpu)) {
> -                error_setg(errp, "cannot disable %s", name);
> -                error_append_hint(errp, "Disabling %s results in all vector "
> -                                  "lengths being disabled.\n", name);
> -                error_append_hint(errp, "With SVE enabled, at least one vector "
> -                                  "length must be enabled.\n");
> -            }
> -        }
> +        clear_bit(vq - 1, cpu->sve_vq_map);
>      }
> +    set_bit(vq - 1, cpu->sve_vq_init);
>  }
>  
>  static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
> @@ -702,32 +547,15 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
>      t = cpu->isar.id_aa64pfr0;
>      t = FIELD_DP64(t, ID_AA64PFR0, SVE, value);
>      cpu->isar.id_aa64pfr0 = t;
> -
> -    /*
> -     * When SVE is enabled ensure that we have at least one vector
> -     * length available.
> -     */
> -    if (cpu_isar_feature(aa64_sve, cpu) && !arm_cpu_num_vqs_available(cpu)) {
> -        error_setg(errp, "cannot enable SVE");
> -        error_append_hint(errp, "All possible SVE vector lengths have "
> -                          "been disabled.\n");
> -    }
>  }
>  
>  void aarch64_add_sve_properties(Object *obj)
>  {
> -    ARMCPU *cpu = ARM_CPU(obj);
>      uint32_t vq;
>  
>      object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
>                          cpu_arm_set_sve, NULL, NULL, &error_fatal);
>  
> -    /*
> -     * sve_vq_map uses a special state while setting properties, so
> -     * we initialize it here with its init function and finalize it
> -     * in arm_cpu_realizefn().
> -     */
> -    arm_cpu_vq_map_init(cpu);
>      for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
>          char name[8];
>          sprintf(name, "sve%d", vq * 128);
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index e2d559c230..433cbe9b53 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -195,6 +195,9 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>          if (!err) {
>              visit_check_struct(visitor, &err);
>          }
> +        if (!err) {
> +            arm_cpu_sve_finalize(ARM_CPU(obj), &err);
> +        }
>          visit_end_struct(visitor, NULL);
>          visit_free(visitor);
>          if (err) {
> @@ -202,6 +205,10 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>              error_propagate(errp, err);
>              return NULL;
>          }
> +    } else {
> +        Error *err = NULL;
> +        arm_cpu_sve_finalize(ARM_CPU(obj), &err);
> +        assert(err == NULL);
>      }

Should we already introduce a function that will collect all
finalizers together now, rather than sprinkling around 
arm_cpu_sve_finalize() calls? Something like

void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
{
  arm_cpu_sve_finalize(cpu, errp);
}

Of course we can introduce it when/if we add other finalizers
later, but I guess the vfp-neon finalizer should be coming
soon anyway.

>  
>      expansion_info = g_new0(CpuModelExpansionInfo, 1);
> -- 
> 2.17.1
> 
> 

Thanks,
drew

