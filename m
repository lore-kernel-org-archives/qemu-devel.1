Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C97ECDE20
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 07:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4BA20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 07:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4BA20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8JjM-00036o-Kp
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 03:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1i8JiG-0002Bk-Ah
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 03:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1i8JiF-00038e-7q
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 03:40:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1i8JiC-00036x-Q5; Thu, 12 Sep 2019 03:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 99BC8300BE7F;
 Thu, 12 Sep 2019 07:40:15 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF0375D704;
 Thu, 12 Sep 2019 07:40:11 +0000 (UTC)
Date: Thu, 12 Sep 2019 09:40:09 +0200
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190912074009.gkqirjdyvitxwnxw@kamzik.brq.redhat.com>
References: <20190911155125.11932-1-eric.auger@redhat.com>
 <20190911155125.11932-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911155125.11932-4-eric.auger@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 12 Sep 2019 07:40:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v2 3/3] virt: Check
 KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for smp_cpus > 256
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
Cc: peter.maydell@linaro.org, maz@kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, yuzenghui@huawei.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 05:51:25PM +0200, Eric Auger wrote:
> Host kernel within [4.18, 5.3] report an erroneous KVM_MAX_VCPUS=512
> for ARM. The actual capability to instantiate more than 256 vcpus
> was fixed in 5.4 with the upgrade of the KVM_IRQ_LINE ABI to support
> vcpu id encoded on 12 bits instead of 8 and a redistributor consuming
> a single KVM IO device instead of 2.
> 
> So let's check this capability when attempting to use more than 256
> vcpus.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt.c        |  4 ++++
>  target/arm/kvm.c     | 21 +++++++++++++++++++++
>  target/arm/kvm_arm.h | 15 +++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0d1629ccb3..465e3140f7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1575,6 +1575,10 @@ static void machvirt_init(MachineState *machine)
>          virt_max_cpus = GIC_NCPU;
>      }
>  
> +    if (kvm_arm_irq_line_layout_mismatch(MACHINE(vms), max_cpus)) {
> +        exit(1);
> +    }
> +
>      if (max_cpus > virt_max_cpus) {
>          error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
>                       "supported by machine 'mach-virt' (%d)",
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 6cdfa2204f..b601e2f35a 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -171,6 +171,27 @@ bool kvm_arm_pmu_supported(CPUState *cpu)
>      return kvm_check_extension(s, KVM_CAP_ARM_PMU_V3);
>  }
>  
> +bool kvm_arm_irq_line_layout_mismatch(MachineState *ms, int vcpus)
> +{
> +    KVMState *s;
> +    bool ret;
> +
> +    if (!kvm_enabled()) {
> +        return false;
> +    }
> +
> +    s = KVM_STATE(ms->accelerator);
> +
> +    ret = vcpus > 256 &&
> +          !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2);
> +
> +    if (ret) {
> +        error_report("Using more than 256 vcpus requires a host kernel "
> +                     "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
> +    }
> +    return ret;
> +}
> +
>  int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
>  {
>      KVMState *s = KVM_STATE(ms->accelerator);
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index b4e19457a0..d893d950d8 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -233,6 +233,16 @@ bool kvm_arm_pmu_supported(CPUState *cs);
>   */
>  int kvm_arm_get_max_vm_ipa_size(MachineState *ms);
>  
> +/**
> + * kvm_arm_irq_line_layout_mismatch - Returns whether the number of vcpus
> + * exceeds the limit imposed by the legacy KVM_IRQ_LINE ARM layout
> + * (without the vcpu2_index field).
> + *
> + * @ms: Machine state handle
> + * @vcpus: number of vcpus
> + */
> +bool kvm_arm_irq_line_layout_mismatch(MachineState *ms, int vcpus);
> +
>  /**
>   * kvm_arm_sync_mpstate_to_kvm
>   * @cpu: ARMCPU
> @@ -281,6 +291,11 @@ static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
>      return -ENOENT;
>  }
>  
> +static inline bool kvm_arm_irq_line_layout_mismatch(MachineState *ms, int vcpus)
> +{
> +    return false;
> +}
> +
>  static inline int kvm_arm_vgic_probe(void)
>  {
>      return 0;
> -- 
> 2.20.1
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

