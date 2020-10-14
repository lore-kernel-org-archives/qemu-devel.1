Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067A6C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89696208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovk5cbG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89696208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSUtj-0000mI-Md
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 20:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSUsX-0008MT-JW; Tue, 13 Oct 2020 20:42:53 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:36924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSUsV-0005fS-M8; Tue, 13 Oct 2020 20:42:53 -0400
Received: by mail-io1-xd43.google.com with SMTP id q25so2942879ioh.4;
 Tue, 13 Oct 2020 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ap0r4uOu7uDsLtFEpddEfv60vcQcKO3TId/po8OXaaE=;
 b=Ovk5cbG/Yb2oDodEQ2VHVtvM68P9tVO/1PJ7UW3tCH/euFz4El1mXbBpz6IzFm1u6O
 /30klKv8WPdosI++v+MjymGNWTTLb3HMGtpoCuxQCiHKvRKB48kRR5mf4Y3VLX6KelyX
 OlG9JntUXxBuASxXKuxdN965tgKQbea7hkNqlXCT/yoPogyr5prwF4OcIXSaWJkOYVh3
 3WR4dpEDJw1rPXtpHNfPOXiQLjk/xx7+6GqeuEy5HXfW4oYJifGdY5TgEJqJMfqP/tFS
 KxOvd858+O+G9yW6cQCBupvuIZMpufaehjT2dOijm9fphMfAhBnufX38Hsj1nzkGcgrg
 KCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ap0r4uOu7uDsLtFEpddEfv60vcQcKO3TId/po8OXaaE=;
 b=hKq3a6431+Vae2ztcNoRVo7waUiVzpwidtLsqTJaOS1KkKq68vR0mmoVVtZlK99gwd
 TZNgGT+FoqvsaFV/Tv1iITDrNUVyltXy/lw6uSMAZdO8gRdl9ypUu3ZNRAIqPhfTIt2o
 W/1dl4M9Ry7GdR484f4vFHsnwz6LJIpAJXjEbhRvrAcQnCjeIpoAQa9t8n7rfsPOrpC8
 e5we90qIlDKNCyGhpJH4YSYiYVbD+AQTFWRQIzzMdde4gCUl5RSGCMPQ7a+AWbOwLt0D
 Xog3Uf2qXJJRhJtNSQHOoeSk5hTbzyrFsCWh/dE1MhopkdsLMEGjWTQLMl5jWC4EO4jr
 Pn6A==
X-Gm-Message-State: AOAM530Odo273oasMcnEdar+DJVP/xZ5HY8DUFQ/AwqtsybHK7mCqOSX
 e9c2Efr1mPWUSN4Jr06lCaC9M274MD41bZ9kMXjIucGu6gM=
X-Google-Smtp-Source: ABdhPJyoJ/pIex0RKv5WizxJ+3iPWoOtfhmWx5ryUu+j3x9a5pfazUgqKIyS2PMjOd4turiX64WMJsX3jgy6QDkTQj4=
X-Received: by 2002:a6b:c9c9:: with SMTP id z192mr975656iof.175.1602636169542; 
 Tue, 13 Oct 2020 17:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201012153408.9747-1-peter.maydell@linaro.org>
 <20201012153408.9747-13-peter.maydell@linaro.org>
 <CAKmqyKO-bRg0WcoqXnt1oaKtgzKTdajwJ-U2YfZh=PzvP77xug@mail.gmail.com>
In-Reply-To: <CAKmqyKO-bRg0WcoqXnt1oaKtgzKTdajwJ-U2YfZh=PzvP77xug@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 Oct 2020 17:31:12 -0700
Message-ID: <CAKmqyKNpkFmXD+FJHXy4MGL03pUkXgWQLz6qPETB0TQBORwkFQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1] hw/arm/netduino2,
 netduinoplus2: Set system_clock_scale
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 5:29 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Mon, Oct 12, 2020 at 8:45 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > The netduino2 and netduinoplus2 boards forgot to set the system_clock_scale
> > global, which meant that if guest code used the systick timer in "use
> > the processor clock" mode it would hang because time never advances.
> >
> > Set the global to match the documented CPU clock speed of these boards.
> > Judging by the data sheet this is slightly simplistic because the
> > SoC allows configuration of the SYSCLK source and frequency via the
> > RCC (reset and clock control) module, but we don't model that.
> >
> > Fixes: https://bugs.launchpad.net/qemu/+bug/1876187

Thanks for fixing this Peter.

Alistair

> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > ---
> > NB: tested with "make check" only...
> >
> >  hw/arm/netduino2.c     | 10 ++++++++++
> >  hw/arm/netduinoplus2.c | 10 ++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
> > index 79e19392b56..8f103341443 100644
> > --- a/hw/arm/netduino2.c
> > +++ b/hw/arm/netduino2.c
> > @@ -30,10 +30,20 @@
> >  #include "hw/arm/stm32f205_soc.h"
> >  #include "hw/arm/boot.h"
> >
> > +/* Main SYSCLK frequency in Hz (120MHz) */
> > +#define SYSCLK_FRQ 120000000ULL
> > +
> >  static void netduino2_init(MachineState *machine)
> >  {
> >      DeviceState *dev;
> >
> > +    /*
> > +     * TODO: ideally we would model the SoC RCC and let it handle
> > +     * system_clock_scale, including its ability to define different
> > +     * possible SYSCLK sources.
> > +     */
> > +    system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
> > +
> >      dev = qdev_new(TYPE_STM32F205_SOC);
> >      qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
> >      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
> > index 958d21dd9f9..68abd3ec69d 100644
> > --- a/hw/arm/netduinoplus2.c
> > +++ b/hw/arm/netduinoplus2.c
> > @@ -30,10 +30,20 @@
> >  #include "hw/arm/stm32f405_soc.h"
> >  #include "hw/arm/boot.h"
> >
> > +/* Main SYSCLK frequency in Hz (168MHz) */
> > +#define SYSCLK_FRQ 168000000ULL
> > +
> >  static void netduinoplus2_init(MachineState *machine)
> >  {
> >      DeviceState *dev;
> >
> > +    /*
> > +     * TODO: ideally we would model the SoC RCC and let it handle
> > +     * system_clock_scale, including its ability to define different
> > +     * possible SYSCLK sources.
> > +     */
> > +    system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
> > +
> >      dev = qdev_new(TYPE_STM32F405_SOC);
> >      qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
> >      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > --
> > 2.20.1
> >
> >

