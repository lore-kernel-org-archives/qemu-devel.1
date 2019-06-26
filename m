Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B879FC48BD8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 13:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BC0214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 13:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BC0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg7ly-0000U5-NW
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 09:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36153)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hg7iA-0007fH-Fm
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 09:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hg7i0-0000nu-Ep
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 09:11:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hg7ht-0000ch-IF; Wed, 26 Jun 2019 09:11:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1203C04B2F6;
 Wed, 26 Jun 2019 13:11:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3102C60A97;
 Wed, 26 Jun 2019 13:11:11 +0000 (UTC)
Date: Wed, 26 Jun 2019 15:11:08 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190626131108.lyqunrmepqmjlzxw@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-3-drjones@redhat.com>
 <7ba318d0-1701-39de-acee-d1a51385977d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ba318d0-1701-39de-acee-d1a51385977d@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 26 Jun 2019 13:11:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 02/14] target/arm/cpu: Ensure we can use
 the pmu with kvm
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

On Wed, Jun 26, 2019 at 11:49:03AM +0200, Richard Henderson wrote:
> On 6/21/19 6:34 PM, Andrew Jones wrote:
> > We first convert the pmu property from a static property to one with
> > its own accessors. Then we use the set accessor to check if the PMU is
> > supported when using KVM. Indeed a 32-bit KVM host does not support
> > the PMU, so this check will catch an attempt to use it at property-set
> > time.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  target/arm/cpu.c     | 30 +++++++++++++++++++++++++-----
> >  target/arm/kvm.c     |  9 +++++++++
> >  target/arm/kvm_arm.h | 13 +++++++++++++
> >  3 files changed, 47 insertions(+), 5 deletions(-)
> > 
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 376db154f008..858f668d226e 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -759,10 +759,6 @@ static Property arm_cpu_has_el3_property =
> >  static Property arm_cpu_cfgend_property =
> >              DEFINE_PROP_BOOL("cfgend", ARMCPU, cfgend, false);
> >  
> > -/* use property name "pmu" to match other archs and virt tools */
> > -static Property arm_cpu_has_pmu_property =
> > -            DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
> > -
> >  static Property arm_cpu_has_vfp_property =
> >              DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
> >  
> > @@ -785,6 +781,29 @@ static Property arm_cpu_pmsav7_dregion_property =
> >                                             pmsav7_dregion,
> >                                             qdev_prop_uint32, uint32_t);
> >  
> > +static bool arm_get_pmu(Object *obj, Error **errp)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +
> > +    return cpu->has_pmu;
> > +}
> > +
> > +static void arm_set_pmu(Object *obj, bool value, Error **errp)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +
> > +    if (value) {
> > +        if (kvm_enabled() && !kvm_arm_pmu_supported(CPU(cpu))) {
> > +            error_setg(errp, "'pmu' feature not supported by KVM on this host");
> > +            return;
> > +        }
> > +        set_feature(&cpu->env, ARM_FEATURE_PMU);
> > +    } else {
> > +        unset_feature(&cpu->env, ARM_FEATURE_PMU);
> > +    }
> > +    cpu->has_pmu = value;
> > +}
> > +
> >  static void arm_get_init_svtor(Object *obj, Visitor *v, const char *name,
> >                                 void *opaque, Error **errp)
> >  {
> > @@ -859,7 +878,8 @@ void arm_cpu_post_init(Object *obj)
> >      }
> >  
> >      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
> > -        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_pmu_property,
> > +        cpu->has_pmu = true;
> > +        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu,
> >                                   &error_abort);
> 
> This doesn't look right.
> 
> The static property is only enabled here if the cpu is known to support the
> PMU, and thus the only useful setting is -cpu foo,pmu=off.  Which means that
> the extra checking that you do in the dynamic property is unused.

It's used when attempting to do '-cpu foo,pmu=on' on a cpu model that
would support the PMU on TCG, and thus has the property, but won't work
when KVM is in use. I'll admit I didn't test this, because I don't have
32-bit KVM hosts available, but I'm pretty sure it should work as
expected:

 -accel tcg -cpu foo                <-- on by default
 -accel tcg -cpu foo,pmu=off        <-- off
 -accel tcg -cpu foo,pmu=on         <-- nop

 -accel kvm -cpu foo                <-- on by default if kvm+foo supports
                                        the pmu, otherwise off
 -accel kvm -cpu foo,pmu=off        <-- off
 -accel kvm -cpu foo,pmu=on         <-- nop if kvm+foo supports the pmu,
                                        otherwise error message

With the error message, which will only occur with 32-bit kvm hosts, since
64-bit kvm hosts have all supported the pmu for quite some time, being the
only new thing.

> 
> It seems like you need to be checking for the PMU earlier, e.g. in
> kvm_arm_get_host_cpu_features.

We need to push all the checks into property accessors if we want the
QMP command to work for them.

Thanks,
drew

