Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A592C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 07:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB35204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 07:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB35204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgky8-00026N-9h
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 03:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44649)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hgkxZ-0001Yz-Gx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hgkxX-0005TV-Rv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hgkxS-0005Ks-Ph; Fri, 28 Jun 2019 03:06:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6277483F3C;
 Fri, 28 Jun 2019 07:05:48 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE5DD5C644;
 Fri, 28 Jun 2019 07:05:40 +0000 (UTC)
Date: Fri, 28 Jun 2019 09:05:38 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190628070538.c33axnciv3ml3vec@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-15-drjones@redhat.com>
 <3b5fd5ff-2ea3-243a-0472-141a844d5f2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b5fd5ff-2ea3-243a-0472-141a844d5f2b@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 07:05:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 14/14] target/arm/kvm: host cpu: Add
 support for sve<vl-bits> properties
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

On Thu, Jun 27, 2019 at 07:15:13PM +0200, Auger Eric wrote:
> Hi Drew,
> On 6/21/19 6:34 PM, Andrew Jones wrote:
> > Allow cpu 'host' to enable SVE when it's available, unless the
> > user chooses to disable it with the added 'sve=off' cpu property.
> > Also give the user the ability to select vector lengths with the
> > sve<vl-bits> properties. We don't adopt 'max' cpu's other sve
> > property, sve-max-vq, because that property is difficult to
> > use with KVM. That property assumes all vector lengths in the
> > range from 1 up to and including the specified maximum length are
> > supported, but there may be optional lengths not supported by the
> > host in that range. With KVM one must be more specific when
> > enabling vector lengths.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  target/arm/cpu.c         |  1 +
> >  target/arm/cpu.h         |  2 ++
> >  target/arm/cpu64.c       | 47 ++++++++++++++++++++++++++--------------
> >  tests/arm-cpu-features.c | 21 +++++++++---------
> >  4 files changed, 45 insertions(+), 26 deletions(-)
> > 
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index e060a0d9df0e..9d05291cb5f6 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -2407,6 +2407,7 @@ static void arm_host_initfn(Object *obj)
> >      ARMCPU *cpu = ARM_CPU(obj);
> >  
> >      kvm_arm_set_cpu_features_from_host(cpu);
> > +    aarch64_add_sve_properties(obj);
> >      arm_cpu_post_init(obj);
> >  }
> >  
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 8a1c6c66a462..52a6b219b74a 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -974,11 +974,13 @@ int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> >  void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
> >  void aarch64_sve_change_el(CPUARMState *env, int old_el,
> >                             int new_el, bool el0_a64);
> > +void aarch64_add_sve_properties(Object *obj);
> >  #else
> >  static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
> >  static inline void aarch64_sve_change_el(CPUARMState *env, int o,
> >                                           int n, bool a)
> >  { }
> > +static inline void aarch64_add_sve_properties(Object *obj) { }
> >  #endif
> >  
> >  target_ulong do_arm_semihosting(CPUARMState *env);
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 6e92aa54b9c8..89396a7729ec 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -753,6 +753,36 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
> >      }
> >  }
> >  
> > +void aarch64_add_sve_properties(Object *obj)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +    uint32_t vq;
> > +
> > +    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> > +                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
> > +
> > +    /*
> > +     * sve_max_vq is initially unspecified, but must be initialized to a
> > +     * non-zero value (ARM_SVE_INIT) to indicate that this cpu type has
> > +     * SVE. It will be finalized in arm_cpu_realizefn().
> > +     */
> this comment is duplicated in aarch64_max_initfn().
> Also sve_max_vq may
> be already initialized to SVE_INIT so what do you mean by unspecified?

Unspecified means it's not set to a valid maximum VQ.

> > +    assert(!cpu->sve_max_vq || cpu->sve_max_vq == ARM_SVE_INIT);> +    cpu->sve_max_vq = ARM_SVE_INIT;
> maybe you could move this assignment in arm_cpu_vq_map_init().

I guess so. And then I guess I could just drop the comment, as
the new location would make it clear what we're doing.

> 
> > +
> > +    /*
> > +     * sve_vq_map uses a special state while setting properties, so
> > +     * we initialize it here with its init function and finalize it
> > +     * in arm_cpu_realizefn().
> > +     */
> > +    arm_cpu_vq_map_init(cpu);
> > +    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> > +        char name[8];
> > +        sprintf(name, "sve%d", vq * 128);
> > +        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
> > +                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);> +    }
> > +}
> > +
> >  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
> >   * otherwise, a CPU with as many features enabled as our emulation supports.
> >   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> > @@ -761,7 +791,6 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
> >  static void aarch64_max_initfn(Object *obj)
> >  {
> >      ARMCPU *cpu = ARM_CPU(obj);
> > -    uint32_t vq;
> >  
> >      if (kvm_enabled()) {
> >          kvm_arm_set_cpu_features_from_host(cpu);
> > @@ -847,9 +876,6 @@ static void aarch64_max_initfn(Object *obj)
> >  #endif
> >      }
> >  
> > -    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> > -                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
> > -
> >      /*
> >       * sve_max_vq is initially unspecified, but must be initialized to a
> >       * non-zero value (ARM_SVE_INIT) to indicate that this cpu type has
> > @@ -859,18 +885,7 @@ static void aarch64_max_initfn(Object *obj)
> >      object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
> >                          cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
> >  
> > -    /*
> > -     * sve_vq_map uses a special state while setting properties, so
> > -     * we initialize it here with its init function and finalize it
> > -     * in arm_cpu_realizefn().
> > -     */
> > -    arm_cpu_vq_map_init(cpu);
> > -    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> > -        char name[8];
> > -        sprintf(name, "sve%d", vq * 128);
> > -        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
> > -                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
> > -    }
> > +    aarch64_add_sve_properties(obj);
> >  }
> >  
> >  struct ARMCPUInfo {
> > diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> > index 349bd0dca6d1..dfe83f104b27 100644
> > --- a/tests/arm-cpu-features.c
> > +++ b/tests/arm-cpu-features.c
> > @@ -351,8 +351,8 @@ static void sve_tests_sve_off_kvm(const void *data)
> >  {
> >      QTestState *qts;
> >  
> > -    qts = qtest_init(MACHINE "-accel kvm -cpu max,sve=off");
> > -    sve_tests_off(qts, "max");
> > +    qts = qtest_init(MACHINE "-accel kvm -cpu host,sve=off");
> > +    sve_tests_off(qts, "host");
> >      qtest_quit(qts);
> >  }
> >  
> > @@ -417,24 +417,24 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
> >              "The CPU definition 'cortex-a15' cannot "
> >              "be used with KVM on this host", NULL);
> >  
> > -        assert_has_feature(qts, "max", "sve");
> > -        resp = do_query_no_props(qts, "max");
> > +        assert_has_feature(qts, "host", "sve");
> > +        resp = do_query_no_props(qts, "host");
> >          g_assert(resp);
> >          kvm_supports_sve = qdict_get_bool(resp_get_props(resp), "sve");
> >          qobject_unref(resp);
> >  
> >          if (kvm_supports_sve) {
> > -            resp = do_query_no_props(qts, "max");
> > +            resp = do_query_no_props(qts, "host");
> >              resp_get_sve_vls(resp, &vls, &max_vq);
> >              g_assert(max_vq != 0);
> >              qobject_unref(resp);
> >  
> >              /* Enabling a supported length is of course fine. */
> >              sprintf(name, "sve%d", max_vq * 128);
> > -            assert_sve_vls(qts, "max", vls, "{ %s: true }", name);
> > +            assert_sve_vls(qts, "host", vls, "{ %s: true }", name);
> >  
> >              /* Also disabling the largest lengths is fine. */
> > -            assert_sve_vls(qts, "max", (vls & ~BIT(max_vq - 1)),
> > +            assert_sve_vls(qts, "host", (vls & ~BIT(max_vq - 1)),
> >                             "{ %s: false }", name);
> >  
> >              for (vq = 1; vq <= max_vq; ++vq) {
> > @@ -446,7 +446,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
> >              if (vq <= SVE_MAX_VQ) {
> >                  sprintf(name, "sve%d", vq * 128);
> >                  error = g_strdup_printf("cannot enable %s", name);
> > -                assert_error(qts, "max", error, "{ %s: true }", name);
> > +                assert_error(qts, "host", error, "{ %s: true }", name);
> >                  g_free(error);
> >              }
> >  
> > @@ -455,16 +455,17 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
> >                  vq = 64 - __builtin_clzll(vls & ~BIT(max_vq - 1));
> >                  sprintf(name, "sve%d", vq * 128);
> >                  error = g_strdup_printf("cannot disable %s", name);
> > -                assert_error(qts, "max", error, "{ %s: false }", name);
> > +                assert_error(qts, "host", error, "{ %s: false }", name);
> >                  g_free(error);
> >              }
> >          } else {
> > -            resp = do_query_no_props(qts, "max");
> > +            resp = do_query_no_props(qts, "host");
> >              resp_get_sve_vls(resp, &vls, &max_vq);
> >              g_assert(max_vq == 0);
> >              qobject_unref(resp);
> >          }
> >      } else {
> > +        assert_has_not_feature(qts, "host", "sve");
> >          assert_error(qts, "host",
> >                       "'pmu' feature not supported by KVM on this host",
> >                       "{ 'pmu': true }");
> > 
> Thanks
> 
> Eric
> 

