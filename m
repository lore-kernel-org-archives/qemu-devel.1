Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3C3C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0845520645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0845520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtRV-0004nL-Aq
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hgtF9-0006BV-G2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hgtF5-0002Wf-8y
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:56:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hgtEk-0001pl-QO; Fri, 28 Jun 2019 11:56:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 94C3E30C1CC0;
 Fri, 28 Jun 2019 15:55:56 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2D0D1001B12;
 Fri, 28 Jun 2019 15:55:51 +0000 (UTC)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-14-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b0646e59-2647-2b53-c4f7-3db5e09e8791@redhat.com>
Date: Fri, 28 Jun 2019 17:55:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-14-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 28 Jun 2019 15:56:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 13/14] target/arm/cpu64: max cpu:
 Support sve properties with KVM
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

On 6/21/19 6:34 PM, Andrew Jones wrote:
> Extend the SVE vq map initialization and validation with KVM's
> supported vector lengths when KVM is enabled. In order to determine
> and select supported lengths we add two new KVM functions for getting
> and setting the KVM_REG_ARM64_SVE_VLS pseudo-register.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.h         |   3 +-
>  target/arm/cpu64.c       | 171 +++++++++++++++++++++++++++------------
>  target/arm/kvm64.c       | 117 +++++++++++++++++++++++++--
>  target/arm/kvm_arm.h     |  19 +++++
>  target/arm/monitor.c     |   2 +-
>  tests/arm-cpu-features.c |  86 +++++++++++++++++---
>  6 files changed, 331 insertions(+), 67 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index cbb155cf72a5..8a1c6c66a462 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -926,7 +926,8 @@ struct ARMCPU {
>       * (bit-number + 1) * 16 bytes, i.e. each bit number + 1 is the vector
>       * length in quadwords. We need a map size twice the maximum
>       * quadword length though because we use two bits for each vector
> -     * length in order to track three states: uninitialized, off, and on.
> +     * length in order to track four states: uninitialized, uninitialized
> +     * but supported by KVM, off, and on.
>       */
>      DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ * 2);
>  };
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 2e595ad53137..6e92aa54b9c8 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -261,10 +261,11 @@ static void aarch64_a72_initfn(Object *obj)
>   * While we eventually use cpu->sve_vq_map as a typical bitmap, where each vq
>   * has only two states (off/on), until we've finalized the map at realize time
>   * we use an extra bit, at the vq - 1 + ARM_MAX_VQ bit number, to also allow
> - * tracking of the uninitialized state. The arm_vq_state typedef and following
> - * functions allow us to more easily work with the bitmap. Also, while the map
> - * is still initializing, sve-max-vq has an additional three states, bringing
> - * the number of its states to five, which are the following:
> + * tracking of the uninitialized state and the uninitialized but supported by
> + * KVM state. The arm_vq_state typedef and following functions allow us to more
> + * easily work with the bitmap. Also, while the map is still initializing,
> + * sve-max-vq has an additional three states, bringing the number of its states
> + * to five, which are the following:
>   *
>   * sve-max-vq:
>   *   0:    SVE is disabled. The default value for a vq in the map is 'OFF'.
> @@ -296,6 +297,11 @@ typedef enum arm_vq_state {
>      ARM_VQ_OFF,
>      ARM_VQ_ON,
>      ARM_VQ_UNINITIALIZED,
> +    ARM_VQ_UNINITIALIZED_KVM_SUPPORTED
> +    /*
> +     * More states cannot be added without adding bits to sve_vq_map
> +     * and modifying its supporting functions.
> +     */
>  } arm_vq_state;
>  
>  static arm_vq_state arm_cpu_vq_map_get(ARMCPU *cpu, int vq)
> @@ -324,6 +330,23 @@ static void arm_cpu_vq_map_init(ARMCPU *cpu)
>  {
>      bitmap_zero(cpu->sve_vq_map, ARM_MAX_VQ * 2);
>      bitmap_set(cpu->sve_vq_map, ARM_MAX_VQ, ARM_MAX_VQ);
> +
> +    if (kvm_enabled()) {
> +        DECLARE_BITMAP(kvm_supported, ARM_MAX_VQ);
> +        uint32_t kvm_max_vq;
> +
> +        bitmap_zero(kvm_supported, ARM_MAX_VQ);
> +
> +        kvm_arm_sve_get_vls(CPU(cpu), kvm_supported, ARM_MAX_VQ, &kvm_max_vq);
> +
> +        if (kvm_max_vq > ARM_MAX_VQ) {
> +            warn_report("KVM supports vector lengths larger than "
> +                        "QEMU can enable");
> +        }
> +
> +        bitmap_or(cpu->sve_vq_map, cpu->sve_vq_map,
> +                  kvm_supported, ARM_MAX_VQ);
So you store the KVM supported state in the 1st half of the bitmap
(ON/OFF)? That's confusing actually. And the second half of the bitmap
still is used to encode whether the state is UNITIALIZED? As Richard
suggested would be clearer with separate bitmaps including for the KVM
supported state.
> +    }
>  }
>  
>  static bool arm_cpu_vq_map_is_finalized(ARMCPU *cpu)
> @@ -371,12 +394,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>          return;
>      }
>  
> -    /* sve-max-vq and sve<vl-bits> properties not yet implemented for KVM */
> -    if (kvm_enabled()) {
> -        return;
> -    }
> -
> -    if (cpu->sve_max_vq == ARM_SVE_INIT) {
> +    if (!kvm_enabled() && cpu->sve_max_vq == ARM_SVE_INIT) {
>          object_property_set_uint(OBJECT(cpu), ARM_MAX_VQ, "sve-max-vq", &err);
>          if (err) {
>              error_propagate(errp, err);
> @@ -431,6 +449,11 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> +    if (kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
> +        error_setg(errp, "'sve' feature not supported by KVM on this host");
> +        return;
> +    }
> +
>      /*
>       * It gets complicated trying to support both sve-max-vq and
>       * sve<vl-bits> properties together, so we mostly don't. We
> @@ -460,6 +483,12 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
>              sprintf(name, "sve%d", vq * 128);
>              object_property_set_bool(obj, true, name, &err);
>              if (err) {
> +                if (kvm_enabled()) {
> +                    error_append_hint(&err, "It is not possible to use "
> +                                      "sve-max-vq with this KVM host. Try "
> +                                      "using only sve<vl-bits> "
> +                                      "properties.\n");
If I understand correctly, the problem is that setting sve-max-vq to a
given value implies all <= required lengths need to be supported and at
least one isn't. In that case the object_property_set_bool will produce
a "cannot enable %s", with a hint "This KVM host does not support
                the vector length %d-bits". So here you may simply say
sve-max-vq cannot be used as one of the requuired 128b length inferior
or equal to sve-max-vq is not supported by the host.


> +                }
>                  error_propagate(errp, err);
>                  return;
>              }
> @@ -484,6 +513,12 @@ static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
>          value = true;
>      } else if (vq_state == ARM_VQ_OFF) {
>          value = false;
> +    } else if (kvm_enabled() && vq_state == ARM_VQ_UNINITIALIZED) {
> +        /*
> +         * When KVM is enabled, anything not supported by the host must have
> +         * 'OFF' for the default.
> +         */
> +        value = false;
>      } else {
>          /*
>           * vq is uninitialized. We pick a default here based on the
> @@ -539,6 +574,11 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> +    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
> +        error_setg(errp, "'sve' feature not supported by KVM on this host");
> +        return;
> +    }
> +
>      if (arm_sve_have_max_vq(cpu)) {
>          max_vq = cpu->sve_max_vq;
>      } else {
> @@ -569,6 +609,8 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
>          }
>      }
>  
> +    vq_state = arm_cpu_vq_map_get(cpu, vq);
> +
>      if (arm_sve_have_max_vq(cpu) && value && vq > cpu->sve_max_vq) {
>          error_setg(errp, "cannot enable %s", name);
>          error_append_hint(errp, "vq=%d (%d bits) is larger than the "
> @@ -580,19 +622,31 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
>          error_append_hint(errp, "The maximum vector length must be "
>                            "enabled, sve-max-vq=%d (%d bits)\n",
>                            cpu->sve_max_vq, cpu->sve_max_vq * 128);
> -    } else if (arm_sve_have_max_vq(cpu) && !value && vq < cpu->sve_max_vq &&
> -               is_power_of_2(vq)) {
> +    } else if (!kvm_enabled() && arm_sve_have_max_vq(cpu) && !value &&
> +               vq < cpu->sve_max_vq && is_power_of_2(vq)) {
>          error_setg(errp, "cannot disable %s", name);
>          error_append_hint(errp, "vq=%d (%d bits) is required as it is a "
>                            "power-of-2 length smaller than the maximum, "
>                            "sve-max-vq=%d (%d bits)\n", vq, vq * 128,
>                            cpu->sve_max_vq, cpu->sve_max_vq * 128);
> -    } else if (!value && vq < max_vq && is_power_of_2(vq)) {
> +    } else if (!kvm_enabled() && !value && vq < max_vq && is_power_of_2(vq)) {
>          error_setg(errp, "cannot disable %s", name);
>          error_append_hint(errp, "Vector length %d-bits is required as it "
>                            "is a power-of-2 length smaller than another "
>                            "enabled vector length. Disable all larger vector "
>                            "lengths first.\n", vq * 128);
> +    } else if (kvm_enabled() && value && vq_state == ARM_VQ_UNINITIALIZED) {
> +        error_setg(errp, "cannot enable %s", name);
> +        error_append_hint(errp, "This KVM host does not support "
> +                          "the vector length %d-bits.\n", vq * 128);
> +    } else if (kvm_enabled() && !value && vq < max_vq &&
> +               (vq_state == ARM_VQ_ON ||
> +                vq_state == ARM_VQ_UNINITIALIZED_KVM_SUPPORTED)) {
> +        error_setg(errp, "cannot disable %s", name);
> +        error_append_hint(errp, "Vector length %d-bits is a KVM supported "
> +                          "length smaller than another enabled vector "
> +                          "length. Disable all larger vector lengths "
> +                          "first.\n", vq * 128);
all those checks may be more readable if segment into kvm / !kvm, value
/ !value
>      } else {
>          if (value) {
>              bool fail = false;
> @@ -602,31 +656,53 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
>               * Enabling a vector length automatically enables all
>               * uninitialized power-of-2 lengths smaller than it, as
>               * per the architecture.
> +             *
> +             * For KVM we have to automatically enable all supported,
> +             * uninitialized lengths smaller than this length, even
> +             * when it's not a power-of-2.
>               */
>              for (s = 1; s < vq; ++s) {
> -                if (is_power_of_2(s)) {
> -                    vq_state = arm_cpu_vq_map_get(cpu, s);
> -                    if (vq_state == ARM_VQ_UNINITIALIZED) {
> -                        arm_cpu_vq_map_set(cpu, s, ARM_VQ_ON);
> -                    } else if (vq_state == ARM_VQ_OFF) {
> -                        fail = true;
> -                        break;
> -                    }
> +                vq_state = arm_cpu_vq_map_get(cpu, s);
> +                if (!kvm_enabled() && is_power_of_2(s) &&
> +                    vq_state == ARM_VQ_UNINITIALIZED) {
> +                    arm_cpu_vq_map_set(cpu, s, ARM_VQ_ON);
> +                } else if (vq_state == ARM_VQ_UNINITIALIZED_KVM_SUPPORTED) {
> +                    assert(kvm_enabled());
> +                    arm_cpu_vq_map_set(cpu, s, ARM_VQ_ON);
> +                } else if ((kvm_enabled() || is_power_of_2(s)) &&
> +                           vq_state == ARM_VQ_OFF) {
> +                    fail = true;
> +                    break;
>                  }
>              }
>  
> -            if (fail) {
> +            if (!kvm_enabled() && fail) {
>                  error_setg(errp, "cannot enable %s", name);
>                  error_append_hint(errp, "Vector length %d-bits is disabled "
>                                    "and is a power-of-2 length smaller than "
>                                    "%s. All power-of-2 vector lengths smaller "
>                                    "than the maximum length are required.\n",
>                                    s * 128, name);
> +
> +            } else if (fail) {
> +                error_setg(errp, "cannot enable %s", name);
> +                error_append_hint(errp, "Vector length %d-bits is disabled "
> +                                  "and the KVM host requires all supported "
> +                                  "vector lengths smaller than %s to also be "
> +                                  "enabled.\n", s * 128, name);
>              } else {
>                  arm_cpu_vq_map_set(cpu, vq, ARM_VQ_ON);
>              }
>          } else {
> -            arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
> +            /*
> +             * For KVM if the vq wasn't supported then we leave it in
> +             * the ARM_VQ_UNINITIALIZED state in order to keep that
> +             * unsupported information. It'll be set to OFF later when
> +             * we finalize the map.
> +             */
> +            if (!kvm_enabled() || vq_state != ARM_VQ_UNINITIALIZED) {
> +                arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
> +            }
>          }
>      }
>  }
> @@ -689,11 +765,6 @@ static void aarch64_max_initfn(Object *obj)
>  
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> -        /*
> -         * KVM doesn't yet support the sve-max-vq property, but
> -         * setting cpu->sve_max_vq is also used to turn SVE on.
> -         */
> -        cpu->sve_max_vq = ARM_SVE_INIT;
>      } else {
>          uint64_t t;
>          uint32_t u;
> @@ -774,32 +845,32 @@ static void aarch64_max_initfn(Object *obj)
>          cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
>          cpu->dcz_blocksize = 7; /*  512 bytes */
>  #endif
> -
> -        /*
> -         * sve_max_vq is initially unspecified, but must be initialized to a
> -         * non-zero value (ARM_SVE_INIT) to indicate that this cpu type has
> -         * SVE. It will be finalized in arm_cpu_realizefn().
> -         */
> -        cpu->sve_max_vq = ARM_SVE_INIT;
> -        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
> -                            cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
> -
> -        /*
> -         * sve_vq_map uses a special state while setting properties, so
> -         * we initialize it here with its init function and finalize it
> -         * in arm_cpu_realizefn().
> -         */
> -        arm_cpu_vq_map_init(cpu);
> -        for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> -            char name[8];
> -            sprintf(name, "sve%d", vq * 128);
> -            object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
> -                                cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
> -        }
>      }
>  
>      object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
>                          cpu_arm_set_sve, NULL, NULL, &error_fatal);
> +
> +    /*
> +     * sve_max_vq is initially unspecified, but must be initialized to a
> +     * non-zero value (ARM_SVE_INIT) to indicate that this cpu type has
> +     * SVE. It will be finalized in arm_cpu_realizefn().
> +     */
> +    cpu->sve_max_vq = ARM_SVE_INIT;
> +    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
> +                        cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
> +
> +    /*
> +     * sve_vq_map uses a special state while setting properties, so
> +     * we initialize it here with its init function and finalize it
> +     * in arm_cpu_realizefn().
> +     */
> +    arm_cpu_vq_map_init(cpu);
> +    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> +        char name[8];
> +        sprintf(name, "sve%d", vq * 128);
> +        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
> +                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
> +    }
>  }
>  
>  struct ARMCPUInfo {
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 2821135a4d0e..5b0707e1192b 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -617,6 +617,110 @@ bool kvm_arm_sve_supported(CPUState *cpu)
>      return ret > 0;
>  }
>  
> +QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
> +
> +void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map,
> +                         uint32_t qemu_max_vq, uint32_t *kvm_max_vq)
you could have kvm_max_vq as a returned value?
> +{
> +    static uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
> +    static uint32_t host_max_vq = -1;
> +    uint32_t vq;
> +    int i, j;
> +
> +    bitmap_clear(map, 0, qemu_max_vq);
> +    *kvm_max_vq = 0;
> +
> +    /*
> +     * KVM ensures all host CPUs support the same set of vector lengths.
> +     * So we only need to create a scratch VCPU once and then cache the
> +     * results.
> +     */
> +    if (host_max_vq == -1) {
always true?
> +        int fdarray[3], ret = -1;
> +
> +        if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, NULL)) {
> +            error_report("failed to create scratch vcpu");
> +            abort();
> +        }
> +
> +        if (ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE) > 0) {
suggestion:

has_sve = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE);
kvm_arm_destroy_scratch_host_vcpu(fdarray);
if (!has_sve) {
    return;
}

/* host supports SVE */
../..
> +            struct kvm_vcpu_init init = {
> +                .target = -1,
> +                .features[0] = (1 << KVM_ARM_VCPU_SVE),
> +            };
> +            struct kvm_one_reg reg = {
> +                .id = KVM_REG_ARM64_SVE_VLS,
> +                .addr = (uint64_t)&vls[0],
> +            };
> +
> +            kvm_arm_destroy_scratch_host_vcpu(fdarray);
> +
> +            if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, &init)) {
> +                error_report("failed to create scratch vcpu");
> +                abort();
> +            }
> +
> +            ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);
> +            if (ret) {
> +                error_report("failed to get KVM_REG_ARM64_SVE_VLS: %s",
> +                             strerror(errno));
> +                abort();
> +            }
> +        }
> +
> +        kvm_arm_destroy_scratch_host_vcpu(fdarray);
> +
> +        if (ret) {
> +            /* The host doesn't support SVE. */
> +            return;
> +        }
> +    }
> +
> +    for (i = KVM_ARM64_SVE_VLS_WORDS - 1; i >= 0; --i) {
> +        if (!vls[i]) {
> +            continue;
> +        }
> +        if (host_max_vq == -1) {
> +            host_max_vq = 64 - clz64(vls[i]) + i * 64;
> +        }
> +        for (j = 1; j <= 64; ++j) {
> +            vq = j + i * 64;
> +            if (vq > qemu_max_vq) {
> +                break;
> +            }
> +            if (vls[i] & (1UL << (j - 1))) {
> +                set_bit(vq - 1, map);
> +            }
> +        }
> +    }
> +
> +    *kvm_max_vq = host_max_vq;
> +}
> +
> +static int kvm_arm_sve_set_vls(CPUState *cs)
> +{
> +    uint64_t vls[KVM_ARM64_SVE_VLS_WORDS] = {0};
> +    struct kvm_one_reg reg = {
> +        .id = KVM_REG_ARM64_SVE_VLS,
> +        .addr = (uint64_t)&vls[0],
> +    };
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    uint32_t vq;
> +    int i, j;
> +
> +    assert(cpu->sve_max_vq <= KVM_ARM64_SVE_VQ_MAX);
> +
> +    for (vq = 1; vq <= cpu->sve_max_vq; ++vq) {
> +        if (test_bit(vq - 1, cpu->sve_vq_map)) {
> +            i = (vq - 1) / 64;
> +            j = (vq - 1) % 64;
> +            vls[i] |= 1UL << j;
> +        }
> +    }
> +
> +    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +}
> +
>  #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
>  
>  int kvm_arch_init_vcpu(CPUState *cs)
> @@ -628,7 +732,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>      if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE ||
>          !object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU)) {
> -        fprintf(stderr, "KVM is not supported for this guest CPU type\n");
> +        error_report("KVM is not supported for this guest CPU type");
>          return -EINVAL;
>      }
>  
> @@ -653,11 +757,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          unset_feature(&env->features, ARM_FEATURE_PMU);
>      }
>      if (cpu->sve_max_vq) {
> -        if (!kvm_arm_sve_supported(cs)) {
> -            cpu->sve_max_vq = 0;
> -        } else {
> -            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
> -        }
> +        assert(kvm_arm_sve_supported(cs));
> +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
>      }
>  
>      /* Do KVM_ARM_VCPU_INIT ioctl */
> @@ -667,6 +768,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      }
>  
>      if (cpu->sve_max_vq) {
> +        ret = kvm_arm_sve_set_vls(cs);
> +        if (ret) {
> +            return ret;
> +        }
>          ret = kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
>          if (ret) {
>              return ret;
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 2367f8ab78ed..d5eb341e906d 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -212,6 +212,22 @@ typedef struct ARMHostCPUFeatures {
>   */
>  bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
>  
> +/**
> + * kvm_arm_sve_get_vls:
kernel-doc comment?
> + * @cs: CPUState
> + * @map: bitmap to fill in
> + * @qemu_max_vq: the maximum vector length QEMU supports in quadwords
> + *               (size of the bitmap to fill in)
> + * @kvm_max_vq: the maximum vector length KVM supports in quadwords
> + *
> + * Get all the SVE vector lengths supported by the KVM host, setting
> + * the bits corresponding to their length in quadwords minus one
> + * (vq - 1) in @map up to @qemu_max_vq. Also assign @kvm_max_vq to the
> + * maximum vector length the KVM host supports.
> + */
> +void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map,
> +                         uint32_t qemu_max_vq, uint32_t *kvm_max_vq);
> +
>  /**
>   * kvm_arm_set_cpu_features_from_host:
>   * @cpu: ARMCPU to set the features for
> @@ -314,6 +330,9 @@ static inline int kvm_arm_vgic_probe(void)
>  static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
>  static inline void kvm_arm_pmu_init(CPUState *cs) {}
>  
> +static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map,
> +                                       uint32_t qemu_max_vq,
> +                                       uint32_t *kvm_max_vq) {}
>  #endif
>  
>  static inline const char *gic_class_name(void)
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index 1e213906fd8f..284818fb4a51 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -100,7 +100,7 @@ QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
>   *
>   * The sve<vl-bits> features need to be in reverse order in order to
>   * enable/disable the largest vector lengths first, ensuring all
> - * power-of-2 vector lengths smaller can also be enabled/disabled.
> + * smaller required vector lengths can also be enabled/disabled.
>   */
>  static const char *cpu_model_advertised_features[] = {
>      "aarch64", "pmu", "sve",
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> index 67ad5f2b78d5..349bd0dca6d1 100644
> --- a/tests/arm-cpu-features.c
> +++ b/tests/arm-cpu-features.c
> @@ -324,23 +324,35 @@ static void sve_tests_sve_max_vq_8(const void *data)
>      qtest_quit(qts);
>  }
>  
> -static void sve_tests_sve_off(const void *data)
> +static void sve_tests_off(QTestState *qts, const char *cpu_type)
>  {
> -    QTestState *qts;
> -
> -    qts = qtest_init(MACHINE "-cpu max,sve=off");
> -
>      /*
>       * SVE is off, so the map should be empty.
>       */
> -    assert_sve_vls(qts, "max", 0, NULL);
> +    assert_sve_vls(qts, cpu_type, 0, NULL);
>  
>      /*
>       * We can't turn anything on, but off is OK.
>       */
> -    assert_error(qts, "max", "cannot enable sve128", "{ 'sve128': true }");
> -    assert_sve_vls(qts, "max", 0, "{ 'sve128': false }");
> +    assert_error(qts, cpu_type, "cannot enable sve128", "{ 'sve128': true }");
> +    assert_sve_vls(qts, cpu_type, 0, "{ 'sve128': false }");
> +}
>  
> +static void sve_tests_sve_off(const void *data)
> +{
> +    QTestState *qts;
> +
> +    qts = qtest_init(MACHINE "-cpu max,sve=off");
> +    sve_tests_off(qts, "max");
> +    qtest_quit(qts);
> +}
> +
> +static void sve_tests_sve_off_kvm(const void *data)
> +{
> +    QTestState *qts;
> +
> +    qts = qtest_init(MACHINE "-accel kvm -cpu max,sve=off");
> +    sve_tests_off(qts, "max");
>      qtest_quit(qts);
>  }
>  
> @@ -392,12 +404,66 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>      assert_has_feature(qts, "host", "pmu");
>  
>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
> +        bool kvm_supports_sve;
> +        uint32_t max_vq, vq;
> +        uint64_t vls;
> +        char name[8];
> +        QDict *resp;
> +        char *error;
> +
>          assert_has_feature(qts, "host", "aarch64");
> -        assert_has_feature(qts, "max", "sve");
>  
>          assert_error(qts, "cortex-a15",
>              "The CPU definition 'cortex-a15' cannot "
>              "be used with KVM on this host", NULL);
> +
> +        assert_has_feature(qts, "max", "sve");
> +        resp = do_query_no_props(qts, "max");
> +        g_assert(resp);
> +        kvm_supports_sve = qdict_get_bool(resp_get_props(resp), "sve");
> +        qobject_unref(resp);
> +
> +        if (kvm_supports_sve) {
> +            resp = do_query_no_props(qts, "max");
> +            resp_get_sve_vls(resp, &vls, &max_vq);
> +            g_assert(max_vq != 0);
> +            qobject_unref(resp);
> +
> +            /* Enabling a supported length is of course fine. */
> +            sprintf(name, "sve%d", max_vq * 128);
> +            assert_sve_vls(qts, "max", vls, "{ %s: true }", name);
> +
> +            /* Also disabling the largest lengths is fine. */
> +            assert_sve_vls(qts, "max", (vls & ~BIT(max_vq - 1)),
> +                           "{ %s: false }", name);
> +
> +            for (vq = 1; vq <= max_vq; ++vq) {
> +                if (!(vls & BIT(vq - 1))) {
> +                    /* vq is unsupported */
> +                    break;
> +                }
> +            }
> +            if (vq <= SVE_MAX_VQ) {
> +                sprintf(name, "sve%d", vq * 128);
> +                error = g_strdup_printf("cannot enable %s", name);
> +                assert_error(qts, "max", error, "{ %s: true }", name);
> +                g_free(error);
> +            }
> +
> +            if (max_vq > 1) {
> +                /* The next smaller, supported vq is required */
> +                vq = 64 - __builtin_clzll(vls & ~BIT(max_vq - 1));
> +                sprintf(name, "sve%d", vq * 128);
> +                error = g_strdup_printf("cannot disable %s", name);
> +                assert_error(qts, "max", error, "{ %s: false }", name);
> +                g_free(error);
> +            }
> +        } else {
> +            resp = do_query_no_props(qts, "max");
> +            resp_get_sve_vls(resp, &vls, &max_vq);
> +            g_assert(max_vq == 0);
> +            qobject_unref(resp);
> +        }
>      } else {
>          assert_error(qts, "host",
>                       "'pmu' feature not supported by KVM on this host",
> @@ -434,6 +500,8 @@ int main(int argc, char **argv)
>      if (kvm_available) {
>          qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
>                              NULL, test_query_cpu_model_expansion_kvm);
> +        qtest_add_data_func("/arm/kvm/query-cpu-model-expansion/sve-off",
> +                            NULL, sve_tests_sve_off_kvm);
>      }
>  
>      return g_test_run();
> 

Thanks

Eric

