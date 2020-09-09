Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABE7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77192215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QL+NyviU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77192215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvbk-0007Um-C4
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFvaL-00058M-NQ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:36:10 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:34932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFvaJ-0006hg-Gk
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:36:09 -0400
Received: by mail-il1-x142.google.com with SMTP id l4so1571793ilq.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8lmo7B52MqzvZ9+E1/DhpswZ0QiEmoM8ELNnZhLo2Xk=;
 b=QL+NyviULWLnjj7hTQXkWtx4jgQ+JOes4JcUbtPq/brotTsvswesOXE2G2jQaD5OjA
 r6b2jK0/sTz1e6kO1umILifpoxteaaGVrfJbBmRhYtvnUzdS6GFu8vL7hFnsZ2L68A0Q
 ecQlXc3MlLbv07V3I5xpghTJ6MJ6Pk/TTsbkzq2WYsxufLCWz8gnotuI4z+HakQ7SKay
 iFH1rBtg+PWO120xyNzeD4HJ+RZE7PcRNk2k9iUfqtbGyCiS8T64jj3+qzWkq6f+ZdEJ
 msvrRUcqJT1coZUAxsPap6c9LcsPQrcPouUHVVldIhWAv9e3sO7KhD+qwHkafFl/LK9J
 N4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8lmo7B52MqzvZ9+E1/DhpswZ0QiEmoM8ELNnZhLo2Xk=;
 b=M3FQyxOVDuCR4DZ8lF15lZHEViMazD913aRd5vsx54R2402e2dRumftp4GW1nfgidH
 FAxmZKTKVyRptKm3CWBNYZqNBWjVOjiK+j3LYLOxuIy1U1X5yget13ke0sJhzwdb1HWZ
 uqA7c8hTIi7cVXClhjBoWS1/neQVj7XZQ/jG7DVThOOewxitZsOG6X0G7/3VBvdrcfiB
 UacsluHGqsOK/BK0ry/6aXzkNVIJ5Eef73F0lNaqvXd50NozLjrVmanbZ+e1KSwYJirk
 MWcQAYNg9eirEZhwcj7qjXmxZB4JtVf1Rvu23lEk4ak9KPrWLGLd+vL74yMaDr/vzD/P
 ca8w==
X-Gm-Message-State: AOAM530HppE/B7SKNj6hkM5/gK2soYq0T7/pWogDXMinNsyHJC0IsBkN
 EQSLNZTZYPcP5tnA/6th5KY1xEW/BHqg87KvzE9s
X-Google-Smtp-Source: ABdhPJxJkhz45iKwJ4R/kqIKtVA8PqMAaX0hcUiHD30vUZo18nkJH4Gx/Xv7GJzGMSEUOemA8Gj9JEUNgaMrlQxw8QU=
X-Received: by 2002:a05:6e02:dd3:: with SMTP id
 l19mr2813667ilj.233.1599640565561; 
 Wed, 09 Sep 2020 01:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <26b4ace9ea3c5b43d14802d6fc5ceea90befbcc8.1599549462.git.haibo.xu@linaro.org>
 <20200908113253.b6owlcu62hypp6aw@kamzik.brq.redhat.com>
In-Reply-To: <20200908113253.b6owlcu62hypp6aw@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Wed, 9 Sep 2020 16:35:54 +0800
Message-ID: <CAJc+Z1Fh6AkQ=b4C=SFHRE9R2gRmMM-qpL7qpkGoOZX1mF98wA@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] target/arm/cpu: spe: Enable spe to work with
 host cpu
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=haibo.xu@linaro.org; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: philmd@redhat.com, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 19:33, Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Sep 08, 2020 at 08:13:28AM +0000, Haibo Xu wrote:
> > Turn on the spe cpu property by default if host cpu
> > support it, i.e. we can now do '-cpu max|host' to add
> > the vSPE, and '-cpu max|host,spe=off' to remove it.
> >
> > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> > ---
> >  target/arm/cpu.c   |  3 +++
> >  target/arm/cpu.h   |  2 ++
> >  target/arm/cpu64.c |  7 ++++++-
> >  target/arm/kvm64.c | 12 ++++++++++++
> >  4 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 786cc6134c..58f12d6eb5 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -2271,6 +2271,9 @@ static void arm_host_initfn(Object *obj)
> >      kvm_arm_set_cpu_features_from_host(cpu);
> >      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> >          aarch64_add_sve_properties(obj);
> > +
> > +        cpu->has_spe = ON_OFF_AUTO_AUTO;
> > +        aarch64_add_spe_properties(obj);
>
> Why not put the assignment of has_spe into aarch64_add_spe_properties()?
>

Yes, it could be. Will fix it in v3.

> >      }
> >      arm_cpu_post_init(obj);
> >  }
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 395a1e5df8..5a3ea876c8 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -1040,6 +1040,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
> >  void aarch64_sve_change_el(CPUARMState *env, int old_el,
> >                             int new_el, bool el0_a64);
> >  void aarch64_add_sve_properties(Object *obj);
> > +void aarch64_add_spe_properties(Object *obj);
> >
> >  /*
> >   * SVE registers are encoded in KVM's memory in an endianness-invariant format.
> > @@ -1071,6 +1072,7 @@ static inline void aarch64_sve_change_el(CPUARMState *env, int o,
> >                                           int n, bool a)
> >  { }
> >  static inline void aarch64_add_sve_properties(Object *obj) { }
> > +static inline void aarch64_add_spe_properties(Object *obj) { }
> >  #endif
> >
> >  #if !defined(CONFIG_TCG)
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 4997c4a3c0..d38c55e2ca 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -621,6 +621,11 @@ static void arm_spe_set(Object *obj, bool value, Error **errp)
> >      ARM_CPU(obj)->has_spe = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> >  }
> >
> > +void aarch64_add_spe_properties(Object *obj)
> > +{
> > +    object_property_add_bool(obj, "spe", arm_spe_get, arm_spe_set);
> > +}
> > +
> >  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
> >   * otherwise, a CPU with as many features enabled as our emulation supports.
> >   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> > @@ -772,7 +777,7 @@ static void aarch64_max_initfn(Object *obj)
> >                          cpu_max_set_sve_max_vq, NULL, NULL);
> >
> >      cpu->has_spe = ON_OFF_AUTO_AUTO;
> > -    object_property_add_bool(obj, "spe", arm_spe_get, arm_spe_set);
> > +    aarch64_add_spe_properties(obj);
>
> If TCG doesn't support this cpu feature then this should be in the
> kvm_enabled() part of this function.
>
>

Will fix it in v3.

> >  }
> >
> >  static const ARMCPUInfo aarch64_cpus[] = {
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index 5a2032fc9e..3f0a09c05b 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -515,6 +515,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> >       */
> >      int fdarray[3];
> >      bool sve_supported;
> > +    bool spe_supported;
> >      uint64_t features = 0;
> >      uint64_t t;
> >      int err;
> > @@ -655,6 +656,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> >      }
> >
> >      sve_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE) > 0;
> > +    spe_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION,
> > +                                      KVM_CAP_ARM_SPE_V1) > 0;
> >
> >      kvm_arm_destroy_scratch_host_vcpu(fdarray);
> >
> > @@ -668,6 +671,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> >          t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
> >          ahcf->isar.id_aa64pfr0 = t;
> >      }
> > +    if (!spe_supported) {
> > +        t = ahcf->isar.id_aa64dfr0;
> > +        t = FIELD_DP64(t, ID_AA64DFR0, PMSVER, 0);
> > +        ahcf->isar.id_aa64dfr0 = t;
> > +    }
> >
>
> If this works then there's a bug with the KVM implementation. get-one-reg
> shouldn't expose SPE unless userspace has enabled it, which we're not
> doing on the scratch vcpu. That's why we set, not clear, the ID bits for
> SVE.
>
>

You are right. I have printed the returned field, and it's 0.
Thanks for pointing this out, I will fix it in v3.

Regards,
Haibo

> >      /*
> >       * We can assume any KVM supporting CPU is at least a v8
> > @@ -830,6 +838,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >          assert(kvm_arm_sve_supported());
> >          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
> >      }
> > +    if (cpu_isar_feature(aa64_spe, cpu)) {
> > +        assert(kvm_arm_spe_supported());
> > +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SPE_V1;
> > +    }
> >
> >      /* Do KVM_ARM_VCPU_INIT ioctl */
> >      ret = kvm_arm_vcpu_init(cs);
> > --
> > 2.17.1
> >
>
> Thanks,
> drew
>

