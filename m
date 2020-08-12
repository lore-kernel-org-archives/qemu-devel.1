Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 00:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E712078B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 00:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKM7hYto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E712078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5f3s-0003xu-Ig
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 20:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k5f2r-0003NS-Jc
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 20:55:09 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:40372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k5f2p-0008SD-JA
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 20:55:09 -0400
Received: by mail-il1-x143.google.com with SMTP id x1so224471ilp.7
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 17:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VIafFEqltHqYeExmIqavmOEAKE93CyLo9JE7LXb68b8=;
 b=pKM7hYtoWKySVPTMbgZOjJqZizpWcV148EDy+j5jPd6DgADkVbH++3M+iBVmo8F4PN
 Aqv6tDMYdMAMSnaBaNloSE6EQCmwxyuCtiP0JYnlsLsg3yXiQ+NnXDWdU/VXK+Yh4dSQ
 4acVhPx8ch4vKiwzjZGxTxeuUa3u2hX0VWihhITmWco+NljAmgKG3Coz8hBac4gM0jUA
 D3cD8vTQQe7wos6HIJB2yDaAOUt8CamVVCF00WzpbybRShr8Z2c0vcQNkMtXGhtqqqqe
 Xqd6XDVk9cqx3gM9kaNQw1ceeoC6vbQoHLa7VMwbb2RD07VcIGE89G3yN3HntZea1kJ/
 gV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VIafFEqltHqYeExmIqavmOEAKE93CyLo9JE7LXb68b8=;
 b=trkHByBlfR71Di5/i2PyIE5h7yoGFWANU6rbr3Mz9/vOxMQLJnHQbv38H67PWUUgMm
 AyFRylaEa4AIghJ4i6l64ZlyF78smMjdvroxgL3G2L+TKUh/YB90sG0gTc/OD4e/X1E5
 XCOsquf9b4qw/oBvwuRJtr8v8+tbgibqxQtSy9ePhN9IIDiATos5GI8/BxA4ynJa/eCu
 m2AVF5neAviqrZuRGqbdj5JaAUu54nH0X4FzXIvFcNknK7SfzNKA7xdDDvZBBChyTs2Z
 xQPbSmp2JDarrX5fg+NZ5ZbgY+3j3O7BY47CzsUaPbaWj3AtXKSTIxTcdWtyCXc63Hmt
 A8zw==
X-Gm-Message-State: AOAM532/UJ56O/HjRURwLqZzcIqNRTX6awa3VLJy2JyuMyAzNUaTlekU
 Ps6MjetR5kmqFzpH0t4UF8tlQZydhCXRFs9t5wXT
X-Google-Smtp-Source: ABdhPJxWEhFDts+Zy8y9kPBA7SP2BLZp1oTxNTSrPwXCzza4DaujgryavNEKPFMOA9KwlIMEz8KUULONOED+eTngqRE=
X-Received: by 2002:a92:d841:: with SMTP id h1mr26847646ilq.233.1597193705332; 
 Tue, 11 Aug 2020 17:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <bf909c1f4904a22be0804cae9fd6f38ba4862563.1596768588.git.haibo.xu@linaro.org>
 <20200810111640.ykejphmuyirncjwv@kamzik.brq.redhat.com>
 <CAJc+Z1F_vFdJuy2kZnj0gZSOd_8-=rSfWFHjQSPU5XEKQ2KZkg@mail.gmail.com>
 <20200811164954.s2sdjzpqpdh2orks@kamzik.brq.redhat.com>
In-Reply-To: <20200811164954.s2sdjzpqpdh2orks@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Wed, 12 Aug 2020 08:54:53 +0800
Message-ID: <CAJc+Z1FNbS_U31ZSgGj5yOd1z5sA=SFLHYVhNGe05+nC4qBkKQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] target/arm/cpu: spe: Enable spe to work with host cpu
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=haibo.xu@linaro.org; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Aug 2020 at 00:50, Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Aug 11, 2020 at 11:15:42AM +0800, Haibo Xu wrote:
> > > > +    if (!cpu->has_spe || !kvm_enabled()) {
> > > > +        unset_feature(env, ARM_FEATURE_SPE);
> > > > +    }
> > >
> > > I don't think this should be necessary.
> > >
> >
> > Yes, I have tried to remove this check, and the vSPE can still work
> > correctly.
> > But I don't know whether there are some corner cases that trigger an error.
> > The similar logic is added in commit 929e754d5a to enable vPMU support.
>
> I think the PMU logic needs a cleanup, rather than to be imitated.
>
> >
> > > > +
> > > >      if (!arm_feature(env, ARM_FEATURE_EL2)) {
> > > >          /* Disable the hypervisor feature bits in the processor feature
> > > >           * registers if we don't have EL2. These are id_pfr1[15:12] and
> > > > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > > > index be045ccc5f..4ea58afc1d 100644
> > > > --- a/target/arm/kvm64.c
> > > > +++ b/target/arm/kvm64.c
> > > > @@ -679,6 +679,7 @@ bool
> > kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> > > >      features |= 1ULL << ARM_FEATURE_AARCH64;
> > > >      features |= 1ULL << ARM_FEATURE_PMU;
> > > >      features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
> > > > +    features |= 1ULL << ARM_FEATURE_SPE;
> > >
> > > No, SPE is not a feature we assume is present in v8.0 CPUs.
> > >
> >
> > Yes, SPE is an optional feature for v8.2. How about changing to the
> > following logic:
> >
> > spe_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SPE_V1)
> > > 0;
> > if (spe_supported) {
> >     features |= 1ULL << ARM_FEATURE_SPE;
> > }
>
> Yes, except you need to drop the ARM_FEATURE_SPE define and use the ID
> register bit instead like "sve_supported" does.
>
> >
> > > >
> > > >      ahcf->features = features;
> > > >
> > > > @@ -826,6 +827,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > > >      } else {
> > > >          env->features &= ~(1ULL << ARM_FEATURE_PMU);
> > > >      }
> > > > +    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_SPE_V1)) {
> > > > +        cpu->has_spe = false;
> > > > +    }
> > > > +    if (cpu->has_spe) {
> > > > +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SPE_V1;
> > > > +    } else {
> > > > +        env->features &= ~(1ULL << ARM_FEATURE_SPE);
> > > > +    }
> > >
> > > The PMU code above this isn't a good pattern to copy. The SVE code below
> > > is better. SVE uses an ID bit and doesn't do the redundant KVM cap check.
> > > It'd be nice to cleanup the PMU code (with a separate patch) and then add
> > > SPE in a better way.
> > >
> >
> > I noticed that Peter had sent out a mail
> > <https://www.mail-archive.com/qemu-devel@nongnu.org/msg727640.html> to talk
> > about the feature-identification strategy.
> > So shall we adapt it to the vPMU and vSPE feature?
>
> At least SPE. You'll have to double check that it makes sense to do for
> PMU. But, if so, then it should be done with a separate series.
>

Ok, will adapt the SPE support to this new feature-identification
strategy first, and
investigate whether it makes sense to do so for PMU later.

Thank you very much for helping review the patch series!

> Thanks,
> drew
>

