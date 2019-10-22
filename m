Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2045CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C510214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZ+DJ5kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C510214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwUx-00037m-Ok
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 11:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iMwL4-00024W-Es
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iMwL2-0000xI-Bh
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:44:50 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iMwL1-0000wI-2k
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:44:48 -0400
Received: by mail-il1-x144.google.com with SMTP id i12so5354313ils.6
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nGKvUdAZepYPnQXNUUyRDAWv88QdMwl4dDgOOd130Do=;
 b=tZ+DJ5kpq5egWH/asfjzvqjx0ls/YDDpyvu95OSVmtbkNbEIyMecRA5k3lj5EQDppT
 HcuVLRlenUAHFGpm5F73hzkZX4ryr6a/xTiY47uXyLWgbSBZpEyoT6jCgcIRDMNBKX/M
 hPyV4kF225Mi+SYH2cz0OZzxfjtQENIPzlfc3OogGxJGNLWqH8g4euIyNijhTzLHyAFj
 MkuqnMKo2+apaI42RO3TwJtGlF3s3iV0LtzOtBfzWhc5uvCxX6XJZs2z4klkCvjnrlXn
 RUWWhT2UW8vt8L9stb9gAjl7lXWNf2vvix4nUX6JmeqAhDtOVEMd8NarpIOvIZTgbv0c
 dnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nGKvUdAZepYPnQXNUUyRDAWv88QdMwl4dDgOOd130Do=;
 b=N0KiFAHO/r+OgG7IBFQLdFrkR81vktHZkNOxzWvU0ppu4VCIL5VWL7zi3xlmBNJIrb
 cVpM23rVaZ4pFHVUv3Ujk+NzCezILP3iuSunzhsBVfRMkola2bKe+MWO1xyaiJo1G5L/
 HxSZsydUR+Y3gCKLYavoQ082QfVbVbpMrONCX3VWFkIR6+KR8tJEBhNRbHqTux0nguk5
 AS7XkdRLLjX+kEG1V6W3r3hlBOjX9lKWzpEv6umMvyMyo6+ojDEQFvZOEXaTKQZRiNJO
 t7KqlMACTAS3Gxb71O/HcGDeGPoLAunRhY5q36N+cXmxFyOyyIWbRe/gT/bos4jHMt8C
 MYVA==
X-Gm-Message-State: APjAAAWOYacttxc/A11TpqTNy01nhIGsj8byTrl1SmWZDKQhBSHmm6ZI
 TtDO3xw6u/KdQtolHRqQEHND1cN7+wy3qE66IKJjJw==
X-Google-Smtp-Source: APXvYqxS3/i8CN/AhZ9frvKNGZEjqepHf2PpZC/0lLtvi+Z4bEr2S97LxQGKKcWh4txg7rXUI1hUTehvismAs9bvPq8=
X-Received: by 2002:a92:360b:: with SMTP id d11mr32079069ila.143.1571759086376; 
 Tue, 22 Oct 2019 08:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085408.24360-1-drjones@redhat.com>
 <20191016085408.24360-7-drjones@redhat.com>
In-Reply-To: <20191016085408.24360-7-drjones@redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 22 Oct 2019 16:44:35 +0100
Message-ID: <CADSWDztTRjEaj2QNpHmDO1ON=ZW6uU3qXfZ6kECx88q0su-6hw@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] target/arm/kvm64: max cpu: Enable SVE when
 available
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew

On Wed, 16 Oct 2019 at 10:03, Andrew Jones <drjones@redhat.com> wrote:
>
> Enable SVE in the KVM guest when the 'max' cpu type is configured
> and KVM supports it. KVM SVE requires use of the new finalize
> vcpu ioctl, so we add that now too. For starters SVE can only be
> turned on or off, getting all vector lengths the host CPU supports
> when on. We'll add the other SVE CPU properties in later patches.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Beata Michalska <beata.michalska@linaro.org>

Thanks,

BR
Beata
> ---
>  target/arm/cpu64.c       | 17 ++++++++++++++---
>  target/arm/kvm.c         |  5 +++++
>  target/arm/kvm64.c       | 20 +++++++++++++++++++-
>  target/arm/kvm_arm.h     | 27 +++++++++++++++++++++++++++
>  tests/arm-cpu-features.c |  1 +
>  5 files changed, 66 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 34b0ba2cf6f7..a771a28daa56 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -493,6 +493,11 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>
> +    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
> +        error_setg(errp, "'sve' feature not supported by KVM on this host");
> +        return;
> +    }
> +
>      t = cpu->isar.id_aa64pfr0;
>      t = FIELD_DP64(t, ID_AA64PFR0, SVE, value);
>      cpu->isar.id_aa64pfr0 = t;
> @@ -507,11 +512,16 @@ static void aarch64_max_initfn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>      uint32_t vq;
> +    uint64_t t;
>
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> +        if (kvm_arm_sve_supported(CPU(cpu))) {
> +            t = cpu->isar.id_aa64pfr0;
> +            t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
> +            cpu->isar.id_aa64pfr0 = t;
> +        }
>      } else {
> -        uint64_t t;
>          uint32_t u;
>          aarch64_a57_initfn(obj);
>
> @@ -612,8 +622,6 @@ static void aarch64_max_initfn(Object *obj)
>
>          object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
>                              cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
> -        object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> -                            cpu_arm_set_sve, NULL, NULL, &error_fatal);
>
>          for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
>              char name[8];
> @@ -622,6 +630,9 @@ static void aarch64_max_initfn(Object *obj)
>                                  cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
>          }
>      }
> +
> +    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> +                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
>  }
>
>  struct ARMCPUInfo {
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b473c63edb1c..f07332bbda30 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -51,6 +51,11 @@ int kvm_arm_vcpu_init(CPUState *cs)
>      return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_INIT, &init);
>  }
>
> +int kvm_arm_vcpu_finalize(CPUState *cs, int feature)
> +{
> +    return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_FINALIZE, &feature);
> +}
> +
>  void kvm_arm_init_serror_injection(CPUState *cs)
>  {
>      cap_has_inject_serror_esr = kvm_check_extension(cs->kvm_state,
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 4c0b11d105a4..850da1b5e6aa 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -602,6 +602,13 @@ bool kvm_arm_aarch32_supported(CPUState *cpu)
>      return kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
>  }
>
> +bool kvm_arm_sve_supported(CPUState *cpu)
> +{
> +    KVMState *s = KVM_STATE(current_machine->accelerator);
> +
> +    return kvm_check_extension(s, KVM_CAP_ARM_SVE);
> +}
> +
>  #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
>
>  int kvm_arch_init_vcpu(CPUState *cs)
> @@ -630,13 +637,17 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
>      }
>      if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
> -            cpu->has_pmu = false;
> +        cpu->has_pmu = false;
>      }
>      if (cpu->has_pmu) {
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>      } else {
>          unset_feature(&env->features, ARM_FEATURE_PMU);
>      }
> +    if (cpu_isar_feature(aa64_sve, cpu)) {
> +        assert(kvm_arm_sve_supported(cs));
> +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
> +    }
>
>      /* Do KVM_ARM_VCPU_INIT ioctl */
>      ret = kvm_arm_vcpu_init(cs);
> @@ -644,6 +655,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
>
> +    if (cpu_isar_feature(aa64_sve, cpu)) {
> +        ret = kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
>      /*
>       * When KVM is in use, PSCI is emulated in-kernel and not by qemu.
>       * Currently KVM has its own idea about MPIDR assignment, so we
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index b4e19457a094..7c12f1501a8b 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -27,6 +27,20 @@
>   */
>  int kvm_arm_vcpu_init(CPUState *cs);
>
> +/**
> + * kvm_arm_vcpu_finalize
> + * @cs: CPUState
> + * @feature: int
> + *
> + * Finalizes the configuration of the specified VCPU feature by
> + * invoking the KVM_ARM_VCPU_FINALIZE ioctl. Features requiring
> + * this are documented in the "KVM_ARM_VCPU_FINALIZE" section of
> + * KVM's API documentation.
> + *
> + * Returns: 0 if success else < 0 error code
> + */
> +int kvm_arm_vcpu_finalize(CPUState *cs, int feature);
> +
>  /**
>   * kvm_arm_register_device:
>   * @mr: memory region for this device
> @@ -225,6 +239,14 @@ bool kvm_arm_aarch32_supported(CPUState *cs);
>   */
>  bool kvm_arm_pmu_supported(CPUState *cs);
>
> +/**
> + * bool kvm_arm_sve_supported:
> + * @cs: CPUState
> + *
> + * Returns true if the KVM VCPU can enable SVE and false otherwise.
> + */
> +bool kvm_arm_sve_supported(CPUState *cs);
> +
>  /**
>   * kvm_arm_get_max_vm_ipa_size - Returns the number of bits in the
>   * IPA address space supported by KVM
> @@ -276,6 +298,11 @@ static inline bool kvm_arm_pmu_supported(CPUState *cs)
>      return false;
>  }
>
> +static inline bool kvm_arm_sve_supported(CPUState *cs)
> +{
> +    return false;
> +}
> +
>  static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
>  {
>      return -ENOENT;
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> index 0190148260dc..3c8ed85b5adb 100644
> --- a/tests/arm-cpu-features.c
> +++ b/tests/arm-cpu-features.c
> @@ -391,6 +391,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>
>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
>          assert_has_feature(qts, "host", "aarch64");
> +        assert_has_feature(qts, "max", "sve");
>
>          assert_error(qts, "cortex-a15",
>              "We cannot guarantee the CPU type 'cortex-a15' works "
> --
> 2.21.0
>
>

