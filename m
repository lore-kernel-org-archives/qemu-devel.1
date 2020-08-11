Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4952C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 01:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF542075D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 01:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOc/gunO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF542075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5IsI-0003LY-SF
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 21:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k5Ire-0002ZR-LN
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 21:14:06 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:40029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k5Irb-0007lv-Nk
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 21:14:06 -0400
Received: by mail-io1-xd43.google.com with SMTP id b17so3423673ion.7
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 18:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=c1JpP0g9tSj8qs+HkN0i2QSkoW49ZVNeIaewKOAYeq4=;
 b=eOc/gunONv14c7euuK4VLxS4XT1+YUdUD8+WMz85lmdAaLQeFJsQ0j8JYRRM+N4yMq
 fZ4iaEEeqUBWzlzTkxOObRwOOYC50tlHLdd7GEkes2Z3tjbcUdDc8zxoSmr2fr+3tJSR
 v/2UmXBCPHVWh5RC7OA5oniLJqmvVE6NDzPyyQ2EZknCMhqAVqEG2YBVqtH0KEu6LEM7
 h3mZwo3uMq53Cz+nXr8rB1bYjRtuzxdKwjFvTTlJ7jznt7k4r/jqOa5D52OHLA5fVAir
 6ARxLDO7lnE/Xmy9ztvr7EvLL1XfTuDyXBEhS+2U/9qQWHHysHDh0I0RbnX22kTgL7xI
 Bfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c1JpP0g9tSj8qs+HkN0i2QSkoW49ZVNeIaewKOAYeq4=;
 b=nA+ZQda9q8OlmO6l61En6pro2HCv/6Tw1WORkOt1yYennJ1GOP7WVtasD/8CzInkPT
 bCkfgdfV7JDiIRlFXcnblloXCCI4OPOExqsf8rQi/BC252DrZbX/bg0RL07kzO6ctp5Y
 JaOwp7CgYATZgIPJHPPlT6g8lSg+/jNiZBHT7pYCUom1eY94k5oPJKsME58vzfyJVAvi
 0g9hc74dBI8jzUidh3W8rS5RgX6x4IZKqw0t/f3vklvp0X+oBOrpNHUOvl+LHJ0Cvk4h
 MjwaQdYR++v8RynaJRGPEStsCSdGfWt2U/aHRKW5bp4+CgSiq4yh7+Odo114YlE1gbib
 6gpQ==
X-Gm-Message-State: AOAM531ficAcz+RAjZWwJpV2kJq/1D8J8E+fxJ8gJqffyLQHfjmXEZif
 AexSTv5BYZqCbFy0LLt9axaUq8h+Vq0vPTaDBvsq
X-Google-Smtp-Source: ABdhPJxlHySSbKdWWnpFTjHoYIT0e7gmSHFHGfAW8S7qGufFlotnIg6yLYtqP+L/id2/fHVvuRumSEIBAXcyF8G/cYs=
X-Received: by 2002:a5d:8b4f:: with SMTP id c15mr19933001iot.146.1597108442345; 
 Mon, 10 Aug 2020 18:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <3cc31df5191ae6b03e060ccd8e82df74416a3ef5.1596768588.git.haibo.xu@linaro.org>
 <b4790af9-38b7-f74a-4ebc-a7e9d3684ae0@amsat.org>
 <CAJc+Z1HzoREjCfbwct4ARmOZjszuLQEw9vqidChWjVGo19FngQ@mail.gmail.com>
 <20200810102918.jjzqt4awirszsen4@kamzik.brq.redhat.com>
In-Reply-To: <20200810102918.jjzqt4awirszsen4@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Tue, 11 Aug 2020 09:13:51 +0800
Message-ID: <CAJc+Z1FztV1WJNp4tP6XgdrZ_2LZBfmYTcsFrW2spnC4qwDd7g@mail.gmail.com>
Subject: Re: [PATCH 4/7] target/arm/kvm: spe: Unify device attr operatioin
 helper
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd43.google.com
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 18:29, Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Aug 10, 2020 at 10:48:41AM +0800, Haibo Xu wrote:
> > On Fri, 7 Aug 2020 at 16:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> > >
> > > On 8/7/20 10:10 AM, Haibo Xu wrote:
> > > > Rename kvm_arm_pmu_set_attr() to kvm_arm_dev_set_attr(),
> > >
> > > Maybe rename kvm_arm_device_set_attr() to match the structure
> > > name?
> > >
> >
> > Thanks for the review! I will update it in the next version.
>
> I've already renamed it to kvm_arm_set_device_attr() in [1]. Also, it's
> not enough to just rename the function. The error messages the function
> may generate have "PMU" embedded in them.
>
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg727590.html
>
> Thanks,
> drew
>

Thanks for your review, Andrew!
Will rebase on your patches in the next version.

> >
> > > > So both the vPMU and vSPE device can share the same API.
> > > >
> > > > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> > >
> > > Regardless, with the typo "operation" in patch subject fixed:
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >
> > > > ---
> > > >  target/arm/kvm64.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > > > index 1169237905..75a417d65c 100644
> > > > --- a/target/arm/kvm64.c
> > > > +++ b/target/arm/kvm64.c
> > > > @@ -398,7 +398,7 @@ static CPUWatchpoint *find_hw_watchpoint(CPUSta=
te *cpu, target_ulong addr)
> > > >      return NULL;
> > > >  }
> > > >
> > > > -static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_a=
ttr *attr)
> > > > +static bool kvm_arm_dev_set_attr(CPUState *cs, struct kvm_device_a=
ttr *attr)
> > > >  {
> > > >      int err;
> > > >
> > > > @@ -427,7 +427,7 @@ void kvm_arm_pmu_init(CPUState *cs)
> > > >      if (!ARM_CPU(cs)->has_pmu) {
> > > >          return;
> > > >      }
> > > > -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> > > > +    if (!kvm_arm_dev_set_attr(cs, &attr)) {
> > > >          error_report("failed to init PMU");
> > > >          abort();
> > > >      }
> > > > @@ -444,7 +444,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
> > > >      if (!ARM_CPU(cs)->has_pmu) {
> > > >          return;
> > > >      }
> > > > -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> > > > +    if (!kvm_arm_dev_set_attr(cs, &attr)) {
> > > >          error_report("failed to set irq for PMU");
> > > >          abort();
> > > >      }
> > > >
> > >
> >
>

