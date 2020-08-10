Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7157AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 03:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C0E204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 03:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0fvskZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C0E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4y6y-0002ts-7I
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 23:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k4y6F-0002M8-R0
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 23:03:47 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:39166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k4y6C-0005nf-RN
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 23:03:47 -0400
Received: by mail-io1-xd42.google.com with SMTP id z6so7448336iow.6
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2020 20:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=irpLHooQhudsr3cZ1+6XxT+4wN2uJIN635QV+tB1xLA=;
 b=Q0fvskZGXLJTbJf2c/UMJAmSv32ojvxxqjcPXC39nZepn1wrzfGa+g34o4KxBRi/P7
 m9VIZrKUtDQecfU4M/Txu9FmvPOltTZmSKZ6UHtGDaaG3JyoSyzNMw0fE50qSjsgfz/T
 kj4cmpvmPiCAF0b5vV5RYE7wOFhrsaKRMoppFJCxasTxp47vUp08x1qPIjcp3RRZKYv3
 t5fA3+0NCuRrpZEbYauiTEuq6mzCgE7wzN0+5wC9TSE5c0oukG8bC9+wH88pga0KWReh
 9i+sFV80YZQ2CjIGHj4HtK08n4ftYJ+f8alZjh6qTDoors+Ypnc8uiasPxBlQXSWyU7T
 K84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=irpLHooQhudsr3cZ1+6XxT+4wN2uJIN635QV+tB1xLA=;
 b=dBOidD4SS6dFG3dQrxZ+tZzpSU6cA0ywVki6jZBkQbhkidqhhLvJZGij66a0yy1wMQ
 k35ipTLYhsaUNoymGAGIuJWSKHKInUTuMrY5KzC+oz7O9d2IhR1LvLGlt8V6597gvx6+
 05TiJNZn3AEYE/RBSYa1dA5COjwDu7MlmhNSYvwco9UzjWBTrHOeuOkIIT3qsWf0KxYe
 DxigbISArh+5Xq+w+0IV47fhLi06vziV9Y6AB+ESf9y+bRAIJiUQs2ERW0oG5VFS8iWB
 Akvo+FXyrBPttC6TESYUm2pMAWboBf+hkW3Zz1RpSkgW7nrUidku2e+os+hrPjeoO64X
 fKRg==
X-Gm-Message-State: AOAM5304Mu/FZZsRvmwve/f/YECljQc1fqDeM5XPMLnT4i05zcWEqEt0
 Dzpyi7oP5yfomXTzMkrtzTxgF1eeAwTy0j4qCdMG
X-Google-Smtp-Source: ABdhPJzBTN9dZIY5QREDiFemblwVrk/L6Linq6t3k13Ee70lqq8heXtatxdoeZFjpFnH0yu/bJQZoo9G1FnJ3blb9g0=
X-Received: by 2002:a5d:8b4f:: with SMTP id c15mr15492688iot.146.1597028623370; 
 Sun, 09 Aug 2020 20:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <c4ab709b684bf6505a9721163564d2223d06c49d.1596768588.git.haibo.xu@linaro.org>
 <5fd62d43-0cdb-d69f-c11c-4a0122b28396@amsat.org>
In-Reply-To: <5fd62d43-0cdb-d69f-c11c-4a0122b28396@amsat.org>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Mon, 10 Aug 2020 11:03:32 +0800
Message-ID: <CAJc+Z1ECoqwzexiGABs4oBk_DdZcA3_r6u7fQP-ZnZnuKaK7Rw@mail.gmail.com>
Subject: Re: [PATCH 3/7] target/arm/cpu: spe: Add an option to turn on/off
 vSPE support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, drjones@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 at 16:28, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Hi Haibo,
>
> On 8/7/20 10:10 AM, Haibo Xu wrote:
> > Adds a spe=3D[on/off] option to enable/disable vSPE support in
> > guest vCPU. Note this option is only available for "-cpu host"
> > with KVM mode, and default value is on.
> >
> > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> > ---
> >  target/arm/cpu.c | 28 ++++++++++++++++++++++++++++
> >  target/arm/cpu.h |  3 +++
> >  2 files changed, 31 insertions(+)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 111579554f..40768b4d19 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1122,6 +1122,29 @@ static void arm_set_pmu(Object *obj, bool value,=
 Error **errp)
> >      cpu->has_pmu =3D value;
> >  }
> >
> > +static bool arm_get_spe(Object *obj, Error **errp)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(obj);
> > +
> > +    return cpu->has_spe;
> > +}
> > +
> > +static void arm_set_spe(Object *obj, bool value, Error **errp)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(obj);
> > +
> > +    if (value) {
> > +        if (kvm_enabled() && !kvm_arm_spe_supported()) {
> > +            error_setg(errp, "'spe' feature not supported by KVM on th=
is host");
> > +            return;
> > +        }
> > +        set_feature(&cpu->env, ARM_FEATURE_SPE);
> > +    } else {
> > +        unset_feature(&cpu->env, ARM_FEATURE_SPE);
> > +    }
> > +    cpu->has_spe =3D value;
> > +}
> > +
> >  unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
> >  {
> >      /*
> > @@ -1195,6 +1218,11 @@ void arm_cpu_post_init(Object *obj)
> >          object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu)=
;
> >      }
> >
> > +    if (arm_feature(&cpu->env, ARM_FEATURE_SPE)) {
> > +        cpu->has_spe =3D true;
>
> Being a profiling feature, are you sure you want it to be ON by default?
>
> I'd expect the opposite, either being turned on via command line at
> startup or by a management layer at runtime, when someone is ready
> to record the perf events and analyze them.
>

I'm not sure whether it's proper to follow the 'pmu' setting here
which has it on  by default.
To be honest, I also prefer to turn it off by default(Please refer to
the comments in the cover letter).

> > +        object_property_add_bool(obj, "spe", arm_get_spe, arm_set_spe)=
;
> > +    }
> > +
> >      /*
> >       * Allow user to turn off VFP and Neon support, but only for TCG -=
-
> >       * KVM does not currently allow us to lie to the guest about its
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 9e8ed423ea..fe0ac14386 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -822,6 +822,8 @@ struct ARMCPU {
> >      bool has_el3;
> >      /* CPU has PMU (Performance Monitor Unit) */
> >      bool has_pmu;
> > +    /* CPU has SPE (Statistical Profiling Extension) */
> > +    bool has_spe;
> >      /* CPU has VFP */
> >      bool has_vfp;
> >      /* CPU has Neon */
> > @@ -1959,6 +1961,7 @@ enum arm_features {
> >      ARM_FEATURE_VBAR, /* has cp15 VBAR */
> >      ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
> >      ARM_FEATURE_M_MAIN, /* M profile Main Extension */
> > +    ARM_FEATURE_SPE, /* has SPE support */
> >  };
> >
> >  static inline int arm_feature(CPUARMState *env, int feature)
> >
>

