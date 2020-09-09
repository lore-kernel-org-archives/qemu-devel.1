Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0640AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464E42177B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCpP6Zi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464E42177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFq1s-0005M4-Br
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 22:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFq12-0004mu-Ax
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 22:39:20 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:41433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFq0z-0001oz-FI
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 22:39:20 -0400
Received: by mail-io1-xd44.google.com with SMTP id z13so1572926iom.8
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vc9NDn+cSIFMYl+W2YtSQC4BTkz6DvX8O9OUNytIVLE=;
 b=rCpP6Zi2QNofp/MAlJKwFS/2AwnS6HHnkROT3bs1tT4aJZVqhXCUPnv7ufnzSoZhsZ
 tV8w6UzlyV4IhuqErUUMl+mjq9qWFQ6UwyansedGF6w0fj6aVu/aJF6Ev9kzKFpQZ2E1
 D8pjOD7AuIUjuM5JfgeqpzopsM2r1Zvb9X9AoNF88hH39H2u74Snl0XKliUjFwWCeyXG
 KBPKYgtsyUa77Ve8eOceDYE2h598VUmzfOAwfBW8UxNOW2GVDDH/Pfx9OYDOjMKYDCxu
 qZp5pOm4OoBMsvVA1BQ9YNVhGVeN1ipl8UcqkEHDj9CHsZ5rtWt+jhdQJy5oeBa5p0WL
 3frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vc9NDn+cSIFMYl+W2YtSQC4BTkz6DvX8O9OUNytIVLE=;
 b=evjNwOHOnJd9WHuQqyGEobU21LMhvnCgozvQdbhEjtXRAeqAGEHQEU2q403M0B9gqW
 SvxLP0MzkO18ziZjo7oR4Lntkg1VYijL90RsO5G+rfYv+Ve1rW2h+HJ4M6K7alaDt1OR
 Fly/g7hOxMlO/o3EVHleokEMTwTwTDgxVgEYtLpqrZEtMsnHs9pvOLrIZUS+IYSx+ifV
 1xcpZcn/ynPH+kWMJ0ZGpQEj0Qv+lxNTA5dH+02XuEHRW8xAJgQS9PhLyGYWHOwTrMxJ
 r6as3nkzZ029W0eSS0cXtucnp6IqCf9zOgElwvSXT+wQdpELnMrjb0HdPU2M+qLc2e93
 5pLA==
X-Gm-Message-State: AOAM533nb56JSaXecRf5fbrBmzJqbm/rmL0x9vY5ynR4Q5MozFEjFj9+
 UE5D9esLmg70ITx2TJj/rQvjIXn1wg0eaFbKm1Qy
X-Google-Smtp-Source: ABdhPJxgIYqVbiZ1qdziWBgbOuTB18Hwri8bijhKVqF2u8v8/Fi71ZeREuxkhmcin1sKXYwsz/zU04bMVOfYDfgTamY=
X-Received: by 2002:a6b:6309:: with SMTP id p9mr1710300iog.78.1599619155960;
 Tue, 08 Sep 2020 19:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <45eecae26272efc7a09837573cd5278296b58dc5.1599549462.git.haibo.xu@linaro.org>
 <20200908105631.etggiu56l65ohlyq@kamzik.brq.redhat.com>
In-Reply-To: <20200908105631.etggiu56l65ohlyq@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Wed, 9 Sep 2020 10:39:05 +0800
Message-ID: <CAJc+Z1G9F2BrtuOs5Lw5-ibBZLjWEXDzudsQur13YSqAr0=XVA@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] target/arm/kvm: spe: Unify device attr operation
 helper
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd44.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 18:56, Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Sep 08, 2020 at 08:13:23AM +0000, Haibo Xu wrote:
> > From: Andrew Jones <drjones@redhat.com>
> >
> > Rename kvm_arm_pmu_set_attr() to kvm_arm_set_device_attr(),
> > So both the vPMU and vSPE device can share the same API.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
>
> Looks like a faithful port of what I posted as a hunk of another patch, so
> I'll accept the authorship. Please also add you s-b though.
>
> Thanks,
> drew
>

Ok, will fix it in v3.

Thanks,
Haibo

> > ---
> >  target/arm/kvm64.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index ef1e960285..8ffd31ffdf 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -397,19 +397,20 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
> >      return NULL;
> >  }
> >
> > -static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
> > +static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
> > +                                    const char *name)
> >  {
> >      int err;
> >
> >      err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
> >      if (err != 0) {
> > -        error_report("PMU: KVM_HAS_DEVICE_ATTR: %s", strerror(-err));
> > +        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
> >          return false;
> >      }
> >
> >      err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
> >      if (err != 0) {
> > -        error_report("PMU: KVM_SET_DEVICE_ATTR: %s", strerror(-err));
> > +        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
> >          return false;
> >      }
> >
> > @@ -426,7 +427,7 @@ void kvm_arm_pmu_init(CPUState *cs)
> >      if (!ARM_CPU(cs)->has_pmu) {
> >          return;
> >      }
> > -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> > +    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
> >          error_report("failed to init PMU");
> >          abort();
> >      }
> > @@ -443,7 +444,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
> >      if (!ARM_CPU(cs)->has_pmu) {
> >          return;
> >      }
> > -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> > +    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
> >          error_report("failed to set irq for PMU");
> >          abort();
> >      }
> > --
> > 2.17.1
> >
> >
>

