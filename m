Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E97C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 02:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B2B206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 02:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJrdEQ5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B2B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4xsQ-0008Te-QK
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 22:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k4xrs-0007yB-8i
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 22:48:56 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:43691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k4xrq-0004Ho-MM
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 22:48:55 -0400
Received: by mail-io1-xd44.google.com with SMTP id k23so7408878iom.10
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2020 19:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3fMoH270+qW7vq3WlK8SY8mVJoSWpFyEV40E3e18lxY=;
 b=AJrdEQ5oToyCfEo0UqE0GVXCjjdAN1gYHzu2nG2/90qHiSv+kAb58Ma7wrMhHmZpSj
 45UJICKRzB+24PpGrCaSbpnOqF+SV5Hrz3w5yAoZQhmeVNhVcf3PclHAYCkhCUfgCai/
 pVqIPSZ4FlNuv1Fr20p+D1XQnO8WtAIADmLZmlphtZHkPO4tkhQEUCCdM4ytdqN/DEGS
 /c0wGugLgHmZPhOOSAtQ/udHcpxF4N3NjRCSHRE2skrBaDam5ftWd8exAfN2EsZlpMbf
 yGvINQVbqFhiziaZmzxN+Zm5KAwFASuaTSPyLPzDtqcwbuPUP6rJFobfkBMBDV22iqUK
 UHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3fMoH270+qW7vq3WlK8SY8mVJoSWpFyEV40E3e18lxY=;
 b=SawjbuN4eUOP3z9U5NOO/vu/xkubRMEfIORLt8cc4LWIfhcOOL5azYJg2AMZOoD/6F
 WSg6XmFR3sc1hVZcq3DAIslEN0BOd8fnzTSuZTwMkc5+poZcXLTg0Xvjg2sWLpykUpHy
 jNwNzbe1JWN5Y9mIQi3JyUgtbq5KbmPY2vmV1AJkWHlZ4y5Zjht7tTyKNO8246M6FGxE
 eAh5DRtz5wfIFO03oaVEHvnLif8ewBhFgcdkHuOaKv/mFrWpCA9ZxI5pfxB+KpVY2oHP
 8mX9NAnlvSkF4AJsb8poUO2Q9/wfDggdThYf0M2yQsOdU4hQawqbWyLmCl5WH1XZUawQ
 ZuOw==
X-Gm-Message-State: AOAM533SdrrkszMcZuZKSCfa9dp84rsiLbDS7R1seVimfdlfjoH7auKb
 AwTMeXtoH5hjD7/Itj3xid0YL2kdip9d7dyCHHiO
X-Google-Smtp-Source: ABdhPJwHDrNa7OvbIZvfyPdlhJ9bQZAf6OavJC2KSTr78Ww3jazZhmXpgWuDkbhH32ell4b7Vd4+PY5Cf7Qca/Ivi9k=
X-Received: by 2002:a05:6602:2246:: with SMTP id
 o6mr15401798ioo.35.1597027732602; 
 Sun, 09 Aug 2020 19:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <3cc31df5191ae6b03e060ccd8e82df74416a3ef5.1596768588.git.haibo.xu@linaro.org>
 <b4790af9-38b7-f74a-4ebc-a7e9d3684ae0@amsat.org>
In-Reply-To: <b4790af9-38b7-f74a-4ebc-a7e9d3684ae0@amsat.org>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Mon, 10 Aug 2020 10:48:41 +0800
Message-ID: <CAJc+Z1HzoREjCfbwct4ARmOZjszuLQEw9vqidChWjVGo19FngQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] target/arm/kvm: spe: Unify device attr operatioin
 helper
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, drjones@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 at 16:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> On 8/7/20 10:10 AM, Haibo Xu wrote:
> > Rename kvm_arm_pmu_set_attr() to kvm_arm_dev_set_attr(),
>
> Maybe rename kvm_arm_device_set_attr() to match the structure
> name?
>

Thanks for the review! I will update it in the next version.

> > So both the vPMU and vSPE device can share the same API.
> >
> > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
>
> Regardless, with the typo "operation" in patch subject fixed:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> > ---
> >  target/arm/kvm64.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index 1169237905..75a417d65c 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -398,7 +398,7 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *=
cpu, target_ulong addr)
> >      return NULL;
> >  }
> >
> > -static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr =
*attr)
> > +static bool kvm_arm_dev_set_attr(CPUState *cs, struct kvm_device_attr =
*attr)
> >  {
> >      int err;
> >
> > @@ -427,7 +427,7 @@ void kvm_arm_pmu_init(CPUState *cs)
> >      if (!ARM_CPU(cs)->has_pmu) {
> >          return;
> >      }
> > -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> > +    if (!kvm_arm_dev_set_attr(cs, &attr)) {
> >          error_report("failed to init PMU");
> >          abort();
> >      }
> > @@ -444,7 +444,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
> >      if (!ARM_CPU(cs)->has_pmu) {
> >          return;
> >      }
> > -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> > +    if (!kvm_arm_dev_set_attr(cs, &attr)) {
> >          error_report("failed to set irq for PMU");
> >          abort();
> >      }
> >
>

