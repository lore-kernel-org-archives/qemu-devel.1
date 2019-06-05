Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0134FC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE25F2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE25F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37922 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYRxI-0004xY-1R
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 05:11:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hYRwO-0004fk-0M
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hYRwG-0008Ix-7o
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hYRw6-0006uU-Pg; Wed, 05 Jun 2019 05:10:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B254330C0DE3;
	Wed,  5 Jun 2019 09:10:04 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 503CC1001E63;
	Wed,  5 Jun 2019 09:09:57 +0000 (UTC)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-7-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <53832876-c973-7176-1c84-897a489f3656@redhat.com>
Date: Wed, 5 Jun 2019 11:09:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190512083624.8916-7-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 05 Jun 2019 09:10:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 06/13] target/arm/kvm: max cpu: Enable SVE
 when available
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
	abologna@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 5/12/19 10:36 AM, Andrew Jones wrote:
> Enable SVE in the KVM guest when the 'max' cpu type is configured
> and KVM supports it. KVM SVE requires use of the new finalize
> vcpu ioctl, so we add that now too.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu64.c   |  1 +
>  target/arm/kvm.c     |  5 +++++
>  target/arm/kvm64.c   | 16 +++++++++++++++-
>  target/arm/kvm_arm.h | 12 ++++++++++++
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 228906f26786..6c19ef6837d5 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -292,6 +292,7 @@ static void aarch64_max_initfn(Object *obj)
>  
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> +        cpu->sve_max_vq = ARM_MAX_VQ;
same line in the !kvm_enabled path. Maybe you can set the sve_max_vq
field in a subsequent patch and just introduce the finalize and
capability checking in that patch?
>      } else {
>          uint64_t t;
>          uint32_t u;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 599563461264..c51db4229d0f 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -50,6 +50,11 @@ int kvm_arm_vcpu_init(CPUState *cs)
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
> index 86362f4cd7d0..c2d92df75353 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -622,13 +622,20 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
>      }
>      if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
> -            cpu->has_pmu = false;
> +        cpu->has_pmu = false;
nit: maybe document this unrelated indent fix in the commit msg?
>      }
>      if (cpu->has_pmu) {
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>      } else {
>          unset_feature(&env->features, ARM_FEATURE_PMU);
>      }
> +    if (cpu->sve_max_vq) {
> +        if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_SVE)) {
> +            cpu->sve_max_vq = 0;
> +        } else {
> +            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
> +        }
> +    }
>  
>      /* Do KVM_ARM_VCPU_INIT ioctl */
>      ret = kvm_arm_vcpu_init(cs);
> @@ -636,6 +643,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
>  
> +    if (cpu->sve_max_vq) {
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
> index 2a07333c615f..c488ec3ab410 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -27,6 +27,18 @@
>   */
>  int kvm_arm_vcpu_init(CPUState *cs);
>  
> +/**
> + * kvm_arm_vcpu_finalize
> + * @cs: CPUState
> + * @feature: int
feature bitmap or bit?
> + *
> + * Finalizes the configuration of the specified VCPU feature
> + * by invoking the KVM_ARM_VCPU_FINALIZE ioctl.
> + *
> + * Returns: 0 if success else < 0 error code
> + */
> +int kvm_arm_vcpu_finalize(CPUState *cs, int feature);
> +
>  /**
>   * kvm_arm_register_device:
>   * @mr: memory region for this device
> 

