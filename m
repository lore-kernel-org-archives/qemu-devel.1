Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC6DC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F576208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F576208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfhtR-0004Ta-Or
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 05:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46254)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hfhrF-0002iK-1I
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hfhrD-0005Xv-Nk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:35:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49243)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hfhrA-0005Rb-TE; Tue, 25 Jun 2019 05:35:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B2F35F72C;
 Tue, 25 Jun 2019 09:35:16 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEB435C22F;
 Tue, 25 Jun 2019 09:35:13 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-2-drjones@redhat.com>
Message-ID: <1ed69063-eaae-2c02-1fe1-2650492496d4@redhat.com>
Date: Tue, 25 Jun 2019 11:35:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-2-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 25 Jun 2019 09:35:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 01/14] target/arm/cpu64: Ensure kvm
 really supports aarch64=off
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
> If -cpu <cpu>,aarch64=off is used then KVM must also be used, and it
> and the host must support running the vcpu in 32-bit mode. Also, if
> -cpu <cpu>,aarch64=on is used, then it doesn't matter if kvm is
> enabled or not.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>


> ---
>  target/arm/cpu64.c   | 12 ++++++------
>  target/arm/kvm64.c   | 11 +++++++++++
>  target/arm/kvm_arm.h | 14 ++++++++++++++
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 1901997a0645..946994838d8a 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -407,13 +407,13 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
>       * restriction allows us to avoid fixing up functionality that assumes a
>       * uniform execution state like do_interrupt.
>       */> -    if (!kvm_enabled()) {
> -        error_setg(errp, "'aarch64' feature cannot be disabled "
> -                         "unless KVM is enabled");
> -        return;
> -    }
> -
>      if (value == false) {
> +        if (!kvm_enabled() || !kvm_arm_aarch32_supported(CPU(cpu))) {
> +            error_setg(errp, "'aarch64' feature cannot be disabled "
> +                             "unless KVM is enabled and 32-bit EL1 "
> +                             "is supported");
> +            return;
> +        }
>          unset_feature(&cpu->env, ARM_FEATURE_AARCH64);
>      } else {
>          set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 22d19c9aec6f..45ccda589903 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -24,7 +24,9 @@
>  #include "exec/gdbstub.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/kvm_int.h"
>  #include "kvm_arm.h"
> +#include "hw/boards.h"
>  #include "internals.h"
>  
>  static bool have_guest_debug;
> @@ -593,6 +595,15 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      return true;
>  }
>  
> +bool kvm_arm_aarch32_supported(CPUState *cpu)
> +{
> +    KVMState *s = KVM_STATE(current_machine->accelerator);
> +    int ret;
> +
> +    ret = kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
> +    return ret > 0;
nit: return kvm_check_extension() should be sufficient
> +}
> +
>  #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
>  
>  int kvm_arch_init_vcpu(CPUState *cs)
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 2a07333c615f..812125f805a1 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -207,6 +207,15 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
>   */
>  void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>  
> +/**
> + * kvm_arm_aarch32_supported:
> + * @cs: CPUState
use kernel-doc comment style?
> + *
> + * Returns true if the KVM VCPU can enable AArch32 mode and false
> + * otherwise.
> + */
> +bool kvm_arm_aarch32_supported(CPUState *cs);
> +
>  /**
>   * kvm_arm_get_max_vm_ipa_size - Returns the number of bits in the
>   * IPA address space supported by KVM
> @@ -247,6 +256,11 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>      cpu->host_cpu_probe_failed = true;
>  }
>  
> +static inline bool kvm_arm_aarch32_supported(CPUState *cs)
> +{
> +    return false;
> +}
> +
>  static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
>  {
>      return -ENOENT;
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

