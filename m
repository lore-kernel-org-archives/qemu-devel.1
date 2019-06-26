Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6EEC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 13:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539E7204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 13:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539E7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg8AF-0002F7-A8
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 09:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hg894-0001SF-Hp
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 09:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hg892-0002d0-Ov
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 09:39:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48898)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hg88z-00027b-CQ; Wed, 26 Jun 2019 09:39:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8137830BBE97;
 Wed, 26 Jun 2019 13:38:58 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2573D60BE5;
 Wed, 26 Jun 2019 13:38:52 +0000 (UTC)
Date: Wed, 26 Jun 2019 15:38:50 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190626133850.kxhco6gofohhbgn2@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-7-drjones@redhat.com>
 <b93f37cf-0159-39f5-bc25-f951c41a907c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93f37cf-0159-39f5-bc25-f951c41a907c@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 26 Jun 2019 13:38:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/14] target/arm: Allow SVE to be
 disabled via a CPU property
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
 qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 12:00:54PM +0200, Auger Eric wrote:
> Hi Drew,
> 
> On 6/21/19 6:34 PM, Andrew Jones wrote:
> > Since 97a28b0eeac14 ("target/arm: Allow VFP and Neon to be disabled via
> > a CPU property") we can disable the 'max' cpu model's VFP and neon
> > features, but there's no way to disable SVE. Add the 'sve=on|off'
> > property to give it that flexibility. We also rename
> > cpu_max_get/set_sve_vq to cpu_max_get/set_sve_max_vq in order for them
> > to follow the typical *_get/set_<property-name> pattern.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  target/arm/cpu.c         | 10 +++++-
> >  target/arm/cpu64.c       | 72 ++++++++++++++++++++++++++++++++++------
> >  target/arm/helper.c      |  8 +++--
> >  target/arm/monitor.c     |  2 +-
> >  tests/arm-cpu-features.c |  1 +
> >  5 files changed, 78 insertions(+), 15 deletions(-)
> > 
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 858f668d226e..f08e178fc84b 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -198,7 +198,7 @@ static void arm_cpu_reset(CPUState *s)
> >          env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
> >          env->cp15.cptr_el[3] |= CPTR_EZ;
> >          /* with maximum vector length */
> > -        env->vfp.zcr_el[1] = cpu->sve_max_vq - 1;
> > +        env->vfp.zcr_el[1] = cpu->sve_max_vq ? cpu->sve_max_vq - 1 : 0;
> >          env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
> >          env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
> >          /*
> > @@ -1129,6 +1129,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
> >          cpu->isar.mvfr0 = u;
> >      }
> >  
> > +    if (!cpu->sve_max_vq) {
> > +        uint64_t t;
> > +
> > +        t = cpu->isar.id_aa64pfr0;
> > +        t = FIELD_DP64(t, ID_AA64PFR0, SVE, 0);
> > +        cpu->isar.id_aa64pfr0 = t;
> > +    }
> > +
> >      if (arm_feature(env, ARM_FEATURE_M) && !cpu->has_dsp) {
> >          uint32_t u;
> >  
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 946994838d8a..02ada65f240c 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -257,27 +257,75 @@ static void aarch64_a72_initfn(Object *obj)
> >      define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
> >  }
> >  
> > -static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
> > -                               void *opaque, Error **errp)
> > +static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
> > +                                   void *opaque, Error **errp)
> >  {
> >      ARMCPU *cpu = ARM_CPU(obj);
> >      visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
> >  }
> >  
> > -static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
> > -                               void *opaque, Error **errp)
> > +static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
> > +                                   void *opaque, Error **errp)
> >  {
> >      ARMCPU *cpu = ARM_CPU(obj);
> >      Error *err = NULL;
> > +    uint32_t value;
> >  
> > -    visit_type_uint32(v, name, &cpu->sve_max_vq, &err);
> > +    visit_type_uint32(v, name, &value, &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> >  
> > -    if (!err && (cpu->sve_max_vq == 0 || cpu->sve_max_vq > ARM_MAX_VQ)) {
> > -        error_setg(&err, "unsupported SVE vector length");
> > -        error_append_hint(&err, "Valid sve-max-vq in range [1-%d]\n",
> > +    if (!cpu->sve_max_vq) {
> > +        error_setg(errp, "cannot set sve-max-vq");
> > +        error_append_hint(errp, "SVE has been disabled with sve=off\n");
> > +        return;
> > +    }
> > +
> > +    cpu->sve_max_vq = value;
> > +
> > +    if (cpu->sve_max_vq == 0 || cpu->sve_max_vq > ARM_MAX_VQ) {
> > +        error_setg(errp, "unsupported SVE vector length");
> > +        error_append_hint(errp, "Valid sve-max-vq in range [1-%d]\n",
> >                            ARM_MAX_VQ);
> >      }
> > -    error_propagate(errp, err);
> > +}
> > +
> > +static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
> > +                            void *opaque, Error **errp)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +    bool value = !!cpu->sve_max_vq;
> > +
> > +    visit_type_bool(v, name, &value, errp);
> > +}
> > +
> > +static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
> > +                            void *opaque, Error **errp)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +    Error *err = NULL;
> > +    bool value;
> > +
> > +    visit_type_bool(v, name, &value, &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +
> > +    if (value) {
> > +        /*
> > +         * We handle the -cpu <cpu>,sve=off,sve=on case by reinitializing,
> > +         * but otherwise we don't do anything as an sve=on could come after
> > +         * a sve-max-vq setting.
> > +         */
> > +        if (!cpu->sve_max_vq) {
> > +            cpu->sve_max_vq = ARM_MAX_VQ;> +        }
> > +    } else {
> > +        cpu->sve_max_vq = 0;
> > +    }
> >  }
> >  
> >  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
> > @@ -373,8 +421,10 @@ static void aarch64_max_initfn(Object *obj)
> >  #endif
> >  
> >          cpu->sve_max_vq = ARM_MAX_VQ;
> > -        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
> > -                            cpu_max_set_sve_vq, NULL, NULL, &error_fatal);
> > +        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
> > +                            cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
> > +        object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> > +                            cpu_arm_set_sve, NULL, NULL, &error_fatal);
> Wouldn't it be possible to allow 0 as a valid value for sve-max-vq and
> interpret this as sve=off?

No, because it wouldn't be a very nice interface considering all other cpu
features are enabled/disabled with booleans, all the sve<vl-bits>
properties are in vl-bits rather than vq's - so it'd be nicer to just
forget about sve-max-vq altogether, and indeed it wouldn't work for cpu
'host', because that cpu type doesn't have the sve-max-vq property at all.

> >      }
> >  }
> >  
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index edba94004e0b..f500ccb6d31b 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -5314,9 +5314,13 @@ uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
> >  static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >                        uint64_t value)
> >  {
> > +    ARMCPU *cpu = env_archcpu(env);
> >      int cur_el = arm_current_el(env);
> > -    int old_len = sve_zcr_len_for_el(env, cur_el);
> > -    int new_len;
> > +    int old_len, new_len;
> > +
> > +    assert(cpu->sve_max_vq);
> > +
> > +    old_len = sve_zcr_len_for_el(env, cur_el);
> The comment
>     /*
>      * Because we arrived here, we know both FP and SVE are enabled;
>      * otherwise we would have trapped access to the ZCR_ELn register.
>      */
> gives the impression we are sure SVE is enabled. So is it mandated to
> test sve_max_vq? Otherwise adapt the comment?

Nope, it's not mandatory, that was just some extra paranoia I can remove
now.

Thanks,
drew

> 
> Thanks
> 
> Eric
> >  
> >      /* Bits other than [3:0] are RAZ/WI.  */
> >      QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
> > diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> > index 19e3120eef95..157c487a1551 100644
> > --- a/target/arm/monitor.c
> > +++ b/target/arm/monitor.c
> > @@ -90,7 +90,7 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
> >  }
> >  
> >  static const char *cpu_model_advertised_features[] = {
> > -    "aarch64", "pmu",
> > +    "aarch64", "pmu", "sve",
> >      NULL
> >  };
> >  
> > diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> > index 31b1c15bb979..509e458e9c2f 100644
> > --- a/tests/arm-cpu-features.c
> > +++ b/tests/arm-cpu-features.c
> > @@ -158,6 +158,7 @@ static void test_query_cpu_model_expansion(const void *data)
> >  
> >      if (g_str_equal(qtest_get_arch(), "aarch64")) {
> >          assert_has_feature(qts, "max", "aarch64");
> > +        assert_has_feature(qts, "max", "sve");
> >          assert_has_feature(qts, "cortex-a57", "pmu");
> >          assert_has_feature(qts, "cortex-a57", "aarch64");
> >  
> > 
> 

