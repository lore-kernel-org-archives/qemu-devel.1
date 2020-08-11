Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D87C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 03:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F404A2065D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 03:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABSia0dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F404A2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5KmF-0006UY-5E
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 23:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k5Klc-0005xn-8w
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 23:16:00 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:34925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k5KlY-0004oi-C4
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 23:15:59 -0400
Received: by mail-io1-xd44.google.com with SMTP id s189so11209011iod.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 20:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NTK9y2WF6s6GOtcvPJH1+1SKcribkFootE2GPoMEh6s=;
 b=ABSia0dP5u6HOV6wB8e+yW1zK8Jna1L3MPh/LOxSpWADkOJAHSPSOSepvDSPk2Rt/w
 VfYRQpsuQLSZp0sM7tMUd+g1BjV3JrLy8EJfHu0jm4maHtXHmcMrCzVkGEBNVwqFgKLz
 BdPbdU3WbYtOuEDA2XMnkxJC7MYi58gs4ZtTIIU7nC2kVP3oj//VQ1WXR+3jane79gBO
 6a/Ke6A5+yR/YtqDuA6Htb30gDd/bLQ3ewCUZwNQA9MHqQqJbSq2DrNp0uGCJrygZjuv
 SNxUbBC/zReDidOBzLJR5xLU8p/MRaGYUPUt0k1hXr1No5BzZxfF1jkfau7O21tTDcO7
 BvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NTK9y2WF6s6GOtcvPJH1+1SKcribkFootE2GPoMEh6s=;
 b=KPMYalTRD51IDc2tTlC+fza8T/B9z7HmkjsedpH0naBSF4RornxhJKBq9tHy/WYhlf
 tnmE7VfGysqp19+iotI6ZfUtNDaddEOfAxTu5zv23BblZc90pwKlcH+7RhwMGqHsG8O0
 qmDuiK3x+sIJeqw6c1Hrd8rTCji8ZrIec65TgeCnTWPA1TBAj1TxJ6w2TqDdVPoM4Dlo
 4BeBT99QdULunvZGfV9ludM9fijiPwQ4Ny7GBTgGiIJnzq028cxeZ74zsjUd0K1dzIeL
 P67e1cjTlPH83cWNJXQoaArlK1VL3NCgorhLTvu1fFHBwebVDGtTBzm8pSV8dhss7c+B
 nYyQ==
X-Gm-Message-State: AOAM530Z3bhzWnRiacLpeXSbB0V80Fzg5K3KZ9eG9Z5mR0IBiSwFbbYt
 J/txwh2M8/WcxZAgrucbb4Ol45T7cao1SMG+6ES3
X-Google-Smtp-Source: ABdhPJzj6xoYdcP6/HjzehFbxLwwY0eTj3UI+IUSaq8Ja6kw/8gs1OQNNzb7KUbs3EYqXhc8NJCACyBoIcgEHrd8cXg=
X-Received: by 2002:a02:838e:: with SMTP id z14mr24562907jag.84.1597115754078; 
 Mon, 10 Aug 2020 20:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <bf909c1f4904a22be0804cae9fd6f38ba4862563.1596768588.git.haibo.xu@linaro.org>
 <20200810111640.ykejphmuyirncjwv@kamzik.brq.redhat.com>
In-Reply-To: <20200810111640.ykejphmuyirncjwv@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Tue, 11 Aug 2020 11:15:42 +0800
Message-ID: <CAJc+Z1F_vFdJuy2kZnj0gZSOd_8-=rSfWFHjQSPU5XEKQ2KZkg@mail.gmail.com>
Subject: Re: [PATCH 7/7] target/arm/cpu: spe: Enable spe to work with host cpu
To: Andrew Jones <drjones@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000307ca805ac917d6c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000307ca805ac917d6c
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Aug 2020 at 19:16, Andrew Jones <drjones@redhat.com> wrote:
>
> On Fri, Aug 07, 2020 at 08:10:37AM +0000, Haibo Xu wrote:
> > Turn on the spe cpu property by default when working with host
> > cpu type in KVM mode, i.e. we can now do '-cpu host' to add the
> > vSPE, and '-cpu host,spe=off' to remove it.
>
> -cpu max with KVM should also enable it by default
>

Ok, will fix it!

> >
> > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> > ---
> >  target/arm/cpu.c   | 4 ++++
> >  target/arm/kvm64.c | 9 +++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 67ab0089fd..42fa99953c 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1719,6 +1719,10 @@ static void arm_cpu_realizefn(DeviceState *dev,
Error **errp)
> >          cpu->pmceid1 = 0;
> >      }
> >
> > +    if (!cpu->has_spe || !kvm_enabled()) {
> > +        unset_feature(env, ARM_FEATURE_SPE);
> > +    }
>
> I don't think this should be necessary.
>

Yes, I have tried to remove this check, and the vSPE can still work
correctly.
But I don't know whether there are some corner cases that trigger an error.
The similar logic is added in commit 929e754d5a to enable vPMU support.

> > +
> >      if (!arm_feature(env, ARM_FEATURE_EL2)) {
> >          /* Disable the hypervisor feature bits in the processor feature
> >           * registers if we don't have EL2. These are id_pfr1[15:12] and
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index be045ccc5f..4ea58afc1d 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -679,6 +679,7 @@ bool
kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> >      features |= 1ULL << ARM_FEATURE_AARCH64;
> >      features |= 1ULL << ARM_FEATURE_PMU;
> >      features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
> > +    features |= 1ULL << ARM_FEATURE_SPE;
>
> No, SPE is not a feature we assume is present in v8.0 CPUs.
>

Yes, SPE is an optional feature for v8.2. How about changing to the
following logic:

spe_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SPE_V1)
> 0;
if (spe_supported) {
    features |= 1ULL << ARM_FEATURE_SPE;
}

> >
> >      ahcf->features = features;
> >
> > @@ -826,6 +827,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >      } else {
> >          env->features &= ~(1ULL << ARM_FEATURE_PMU);
> >      }
> > +    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_SPE_V1)) {
> > +        cpu->has_spe = false;
> > +    }
> > +    if (cpu->has_spe) {
> > +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SPE_V1;
> > +    } else {
> > +        env->features &= ~(1ULL << ARM_FEATURE_SPE);
> > +    }
>
> The PMU code above this isn't a good pattern to copy. The SVE code below
> is better. SVE uses an ID bit and doesn't do the redundant KVM cap check.
> It'd be nice to cleanup the PMU code (with a separate patch) and then add
> SPE in a better way.
>

I noticed that Peter had sent out a mail
<https://www.mail-archive.com/qemu-devel@nongnu.org/msg727640.html> to talk
about the feature-identification strategy.
So shall we adapt it to the vPMU and vSPE feature?

> >      if (cpu_isar_feature(aa64_sve, cpu)) {
> >          assert(kvm_arm_sve_supported());
> >          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
> > --
> > 2.17.1
> >
>
> Thanks,
> drew
>

--000000000000307ca805ac917d6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Mon, 10 Aug 2020 at 19:16, Andrew Jones &lt;<a href=3D"=
mailto:drjones@redhat.com">drjones@redhat.com</a>&gt; wrote:<br>&gt;<br>&gt=
; On Fri, Aug 07, 2020 at 08:10:37AM +0000, Haibo Xu wrote:<br>&gt; &gt; Tu=
rn on the spe cpu property by default when working with host<br>&gt; &gt; c=
pu type in KVM mode, i.e. we can now do &#39;-cpu host&#39; to add the<br>&=
gt; &gt; vSPE, and &#39;-cpu host,spe=3Doff&#39; to remove it.<br>&gt;<br>&=
gt; -cpu max with KVM should also enable it by default<br>&gt;<br><br>Ok, w=
ill fix it!<br><br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Haibo Xu &lt;<a hr=
ef=3D"mailto:haibo.xu@linaro.org">haibo.xu@linaro.org</a>&gt;<br>&gt; &gt; =
---<br>&gt; &gt; =C2=A0target/arm/cpu.c =C2=A0 | 4 ++++<br>&gt; &gt; =C2=A0=
target/arm/kvm64.c | 9 +++++++++<br>&gt; &gt; =C2=A02 files changed, 13 ins=
ertions(+)<br>&gt; &gt;<br>&gt; &gt; diff --git a/target/arm/cpu.c b/target=
/arm/cpu.c<br>&gt; &gt; index 67ab0089fd..42fa99953c 100644<br>&gt; &gt; --=
- a/target/arm/cpu.c<br>&gt; &gt; +++ b/target/arm/cpu.c<br>&gt; &gt; @@ -1=
719,6 +1719,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **e=
rrp)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;pmceid1 =3D 0;<=
br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0} =C2=A0<br>&gt; &gt;<br>&gt; &gt; + =C2=
=A0 =C2=A0if (!cpu-&gt;has_spe || !kvm_enabled()) {<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0unset_feature(env, ARM_FEATURE_SPE);<br>&gt; &gt; + =C2=
=A0 =C2=A0}<br>&gt;<br>&gt; I don&#39;t think this should be necessary.<br>=
&gt;<br><br>Yes, I have tried to remove this check, and the vSPE can still =
work correctly.<br>But I don&#39;t know whether there are some corner cases=
 that trigger an error.<br>The similar logic is added in commit 929e754d5a =
to enable vPMU support.<br><br>&gt; &gt; +<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0if (!arm_feature(env, ARM_FEATURE_EL2)) {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* Disable the hypervisor feature bits in the processor fe=
ature<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * registers if we don=
&#39;t have EL2. These are id_pfr1[15:12] and<br>&gt; &gt; diff --git a/tar=
get/arm/kvm64.c b/target/arm/kvm64.c<br>&gt; &gt; index be045ccc5f..4ea58af=
c1d 100644<br>&gt; &gt; --- a/target/arm/kvm64.c<br>&gt; &gt; +++ b/target/=
arm/kvm64.c<br>&gt; &gt; @@ -679,6 +679,7 @@ bool kvm_arm_get_host_cpu_feat=
ures(ARMHostCPUFeatures *ahcf)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0features |=
=3D 1ULL &lt;&lt; ARM_FEATURE_AARCH64;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0fea=
tures |=3D 1ULL &lt;&lt; ARM_FEATURE_PMU;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0=
features |=3D 1ULL &lt;&lt; ARM_FEATURE_GENERIC_TIMER;<br>&gt; &gt; + =C2=
=A0 =C2=A0features |=3D 1ULL &lt;&lt; ARM_FEATURE_SPE;<br>&gt;<br>&gt; No, =
SPE is not a feature we assume is present in v8.0 CPUs.<br>&gt;<br><br>Yes,=
 SPE is an optional feature for v8.2. How about changing to the following l=
ogic:<br><br>spe_supported =3D ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_C=
AP_ARM_SPE_V1) &gt; 0;<br>if (spe_supported) {<br>=C2=A0 =C2=A0 features |=
=3D 1ULL &lt;&lt; ARM_FEATURE_SPE;<br>}<br><br>&gt; &gt;<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0ahcf-&gt;features =3D features;<br>&gt; &gt;<br>&gt; &gt; =
@@ -826,6 +827,14 @@ int kvm_arch_init_vcpu(CPUState *cs)<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0} else {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0en=
v-&gt;features &amp;=3D ~(1ULL &lt;&lt; ARM_FEATURE_PMU);<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0}<br>&gt; &gt; + =C2=A0 =C2=A0if (!kvm_check_extension(cs-=
&gt;kvm_state, KVM_CAP_ARM_SPE_V1)) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0cpu-&gt;has_spe =3D false;<br>&gt; &gt; + =C2=A0 =C2=A0}<br>&gt; &gt;=
 + =C2=A0 =C2=A0if (cpu-&gt;has_spe) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0cpu-&gt;kvm_init_features[0] |=3D 1 &lt;&lt; KVM_ARM_VCPU_SPE_V1;<br>=
&gt; &gt; + =C2=A0 =C2=A0} else {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0env-&gt;features &amp;=3D ~(1ULL &lt;&lt; ARM_FEATURE_SPE);<br>&gt; &gt;=
 + =C2=A0 =C2=A0}<br>&gt;<br>&gt; The PMU code above this isn&#39;t a good =
pattern to copy. The SVE code below<br>&gt; is better. SVE uses an ID bit a=
nd doesn&#39;t do the redundant KVM cap check.<br>&gt; It&#39;d be nice to =
cleanup the PMU code (with a separate patch) and then add<br>&gt; SPE in a =
better way.<br>&gt;<br><br>I noticed that Peter had sent out a <a href=3D"h=
ttps://www.mail-archive.com/qemu-devel@nongnu.org/msg727640.html">mail</a> =
to talk about the feature-identification strategy.<div>So shall we adapt it=
 to the vPMU and vSPE feature?<br><br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0if (cpu=
_isar_feature(aa64_sve, cpu)) {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0assert(kvm_arm_sve_supported());<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cpu-&gt;kvm_init_features[0] |=3D 1 &lt;&lt; KVM_ARM_VCPU_SVE;=
<br>&gt; &gt; --<br>&gt; &gt; 2.17.1<br>&gt; &gt;<br>&gt;<br>&gt; Thanks,<b=
r>&gt; drew<br>&gt;</div></div>

--000000000000307ca805ac917d6c--

