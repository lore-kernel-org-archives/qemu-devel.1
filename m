Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A8C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBB9206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBB9206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39441 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYTkH-00056v-Be
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 07:06:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hYTjV-0004ec-0e
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hYTjT-0004qc-I6
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:05:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hYTjK-0004Pj-3b; Wed, 05 Jun 2019 07:05:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B098D7EBD3;
	Wed,  5 Jun 2019 11:04:53 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DBAD75D705;
	Wed,  5 Jun 2019 11:04:46 +0000 (UTC)
Date: Wed, 5 Jun 2019 13:04:44 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190605110444.234xp4roedpn2i5f@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-7-drjones@redhat.com>
	<53832876-c973-7176-1c84-897a489f3656@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53832876-c973-7176-1c84-897a489f3656@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 05 Jun 2019 11:05:03 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, abologna@redhat.com, qemu-arm@nongnu.org,
	alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 11:09:56AM +0200, Auger Eric wrote:
> Hi Drew,
> 
> On 5/12/19 10:36 AM, Andrew Jones wrote:
> > Enable SVE in the KVM guest when the 'max' cpu type is configured
> > and KVM supports it. KVM SVE requires use of the new finalize
> > vcpu ioctl, so we add that now too.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  target/arm/cpu64.c   |  1 +
> >  target/arm/kvm.c     |  5 +++++
> >  target/arm/kvm64.c   | 16 +++++++++++++++-
> >  target/arm/kvm_arm.h | 12 ++++++++++++
> >  4 files changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 228906f26786..6c19ef6837d5 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -292,6 +292,7 @@ static void aarch64_max_initfn(Object *obj)
> >  
> >      if (kvm_enabled()) {
> >          kvm_arm_set_cpu_features_from_host(cpu);
> > +        cpu->sve_max_vq = ARM_MAX_VQ;
> same line in the !kvm_enabled path. Maybe you can set the sve_max_vq
> field in a subsequent patch and just introduce the finalize and
> capability checking in that patch?

This gets changed in a subsequent patch, so factoring now would
be wasted code motion. I'm not sure the finalize function is worth
its own patch, so I'm inclined to leave this as is.

> >      } else {
> >          uint64_t t;
> >          uint32_t u;
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 599563461264..c51db4229d0f 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -50,6 +50,11 @@ int kvm_arm_vcpu_init(CPUState *cs)
> >      return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_INIT, &init);
> >  }
> >  
> > +int kvm_arm_vcpu_finalize(CPUState *cs, int feature)
> > +{
> > +    return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_FINALIZE, &feature);
> > +}
> > +
> >  void kvm_arm_init_serror_injection(CPUState *cs)
> >  {
> >      cap_has_inject_serror_esr = kvm_check_extension(cs->kvm_state,
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index 86362f4cd7d0..c2d92df75353 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -622,13 +622,20 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
> >      }
> >      if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
> > -            cpu->has_pmu = false;
> > +        cpu->has_pmu = false;
> nit: maybe document this unrelated indent fix in the commit msg?

It's pretty obvious without extra commentary, IMHO.

> >      }
> >      if (cpu->has_pmu) {
> >          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
> >      } else {
> >          unset_feature(&env->features, ARM_FEATURE_PMU);
> >      }
> > +    if (cpu->sve_max_vq) {
> > +        if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_SVE)) {
> > +            cpu->sve_max_vq = 0;
> > +        } else {
> > +            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
> > +        }
> > +    }
> >  
> >      /* Do KVM_ARM_VCPU_INIT ioctl */
> >      ret = kvm_arm_vcpu_init(cs);
> > @@ -636,6 +643,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >          return ret;
> >      }
> >  
> > +    if (cpu->sve_max_vq) {
> > +        ret = kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +    }
> > +
> >      /*
> >       * When KVM is in use, PSCI is emulated in-kernel and not by qemu.
> >       * Currently KVM has its own idea about MPIDR assignment, so we
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index 2a07333c615f..c488ec3ab410 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -27,6 +27,18 @@
> >   */
> >  int kvm_arm_vcpu_init(CPUState *cs);
> >  
> > +/**
> > + * kvm_arm_vcpu_finalize
> > + * @cs: CPUState
> > + * @feature: int
> feature bitmap or bit?

Neither. I can improve this by stating these integers must be one
of the set defined in the "KVM_ARM_VCPU_FINALIZE" section of
kernel doc Documentation/virtual/kvm/api.txt though.

> > + *
> > + * Finalizes the configuration of the specified VCPU feature
> > + * by invoking the KVM_ARM_VCPU_FINALIZE ioctl.
> > + *
> > + * Returns: 0 if success else < 0 error code
> > + */
> > +int kvm_arm_vcpu_finalize(CPUState *cs, int feature);
> > +
> >  /**
> >   * kvm_arm_register_device:
> >   * @mr: memory region for this device
> > 
> 

Thanks,
drew

