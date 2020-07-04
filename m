Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144B8C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 00:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BCF206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 00:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDrVjpDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BCF206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrWOS-0005n8-5T
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 20:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrWNp-0005G2-CC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 20:50:21 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:32895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrWNl-00075W-5q
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 20:50:21 -0400
Received: by mail-vs1-xe43.google.com with SMTP id u133so4360190vsc.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 17:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oM8V3dJ30E+i8OPC6HeE0rR8gA6+16SARIhE7deSAUE=;
 b=dDrVjpDQPtxQv578OZtNU8Txdaa9h+WE3aBfMAHcPW3di1BS16bMDLZBkyfSM75I0M
 fhmI52UOUHXgE88ONkrPxp8It2rAbcHinoUPyQcP0aGeaGgSLYiTdny6ZtXy8QfphUej
 lZzX61d3BznQhcw1hhqlj75elB/kC/frIBylay/V77GN3xovt7QZ7aHMQMF7MU99PZTq
 Choluo5Ymc/x18MeAPm0xLhZepz5oal8MdI5GKm7YcgwqBpIy/rj98bYUrEH4sFvp+WT
 5/bRo4NpzCYBGTEpDy/kpYOXBMxMG2p5Mta7RMDhQutXu2cUSFk5iLPfe6rppzW5LMVl
 pJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oM8V3dJ30E+i8OPC6HeE0rR8gA6+16SARIhE7deSAUE=;
 b=IA7elA8qfkWIQJrd2lYsNBv8LuqOaGZe8dLPP8lZokJuOZ4Aay1BJHsyKBjaTtYZwa
 kMOdlMh7bUVC1ZVZWZZeXVxHw9nGVooO+le6jIwAfVPCUcKQlkV9EtEel5suNSclyxhe
 H2ADeGrNDVCWrni1AbCcgWkGyJ3sR58AsBPYEax0rzZWv1ygTLt7f0t1PLzHRUpThh9B
 SwwCVuXWgHrQpgHQAjvSbac0KUwUDv8VbZVJ/tky7JvHuegGkP7nl1HA1NBFVj4KTU9Q
 An50376+my6SrNj0IPOtj+Ht4b8uk6f8vByRQDcn+p5CnUfTWHWTWyYzLbWDmNqDwTa4
 1sDg==
X-Gm-Message-State: AOAM531b88ZViS30wTCejcL213IqYt8CsEzD8NNKYbSwP8dWOFxbFJz5
 g7aoMTR4ENs4ro9Tk8NsPI8TdEoBkk4FC2wb02wCAw==
X-Google-Smtp-Source: ABdhPJxolP+smVhTa9sVL76bobePEsTo5TvIYqCq6ZfQ9RykAixUtyL5XXL1UFD44V9bxH6VcfPI3tvXGn0g7g2mzbk=
X-Received: by 2002:a67:1b85:: with SMTP id
 b127mr24937666vsb.152.1593823815770; 
 Fri, 03 Jul 2020 17:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <20200626235519.591734-9-hskinnemoen@google.com>
 <abdb209d-7268-7997-2caa-95cb984269da@amsat.org>
 <CAFQmdRYZWhA-957jRHfiRHfYoOk-c2TJVtqoz6LMOhDgJwMiCg@mail.gmail.com>
 <9f8c6cb0-cac3-2afe-a98a-c627cb04bd4b@amsat.org>
In-Reply-To: <9f8c6cb0-cac3-2afe-a98a-c627cb04bd4b@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 3 Jul 2020 17:50:03 -0700
Message-ID: <CAFQmdRZ79Fx-tdVaEjiAR=5ignn_Rw95HT7sjDxs7rYtD4ADTg@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] hw/nvram: NPCM7xx OTP device model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e43;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 3, 2020 at 3:24 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 7/3/20 11:07 PM, Havard Skinnemoen wrote:
> > On Fri, Jul 3, 2020 at 6:46 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
> >>
> >> On 6/27/20 1:55 AM, Havard Skinnemoen wrote:
> >>> +static void npcm7xx_otp_realize(DeviceState *dev, Error **errp)
> >>> +{
> >>> +    NPCM7xxOTPClass *oc =3D NPCM7XX_OTP_GET_CLASS(dev);
> >>> +    NPCM7xxOTPState *s =3D NPCM7XX_OTP(dev);
> >>> +    SysBusDevice *sbd =3D &s->parent;
> >>> +
> >>> +    s->array =3D g_malloc0(NPCM7XX_OTP_ARRAY_BYTES);
> >>
> >> The possibility to reuse persistent OTP seems important.
> >> This can be added later of course.
> >
> > Agree, it's an important part of the behavior of the module. But it's
> > not essential to be able to boot a BMC firmware image, so I left it
> > out initially.
>
> This is not a problem until someone else try to use it. And OTP/NVRAM
> are devices currently in hype. Meanwhile we have another technical debt.
> I am just giving generic review comments.
>
> What bugs me particularly is the OTP content zeroed at reset without
> any warning. Maybe you can add something like:
>
>   qemu_log_mask(LOG_UNIMP,
>                 "Persistence not supported, OTP content erased!\n");
>
> in npcm7xx_otp_enter_reset().

Ah, but it only zeroes the registers. The OTP array is only zeroed in reali=
ze().

But I see your point about persistence. I will work on that.

One possible complication is that real boards are expected to be
programmed a certain way, so some reasonable defaults need to be
loaded when the user doesn't specify an image (and perhaps also if the
user specifies an "uninitialized" image, if there's any way to detect
that). Would it make sense to add pc-bios blobs that can be loaded by
default, and used as a starting point or backing file for users that
need persistent OTP arrays? Or maybe just OR the factory-programmed
bits into the user-provided image, since that would match the OTP
nature of those bits.

> >
> >> See simple example in hw/nvram/eeprom_at24c.c which use
> >> a BlockBackend so the OTP content is not lost after reset
> >> or migration.
> >
> > I'll take a look at that, thanks!
> >
> >>> +
> >>> +    memory_region_init_io(&s->mmio, OBJECT(s), oc->mmio_ops, s, "reg=
s",
> >>> +                          NPCM7XX_OTP_REGS_SIZE);
> >>> +    sysbus_init_mmio(sbd, &s->mmio);
> >>> +}
> >>> +
> >>> +static void npcm7xx_otp_class_init(ObjectClass *klass, void *data)
> >>> +{
> >>> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> >>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >>> +
> >>
> >> Missing migration vmstate for NPCM7xxOTPState::regs[].
> >
> > Ah, you're right. This is probably true for most of the peripherals in
> > this series. I'll see if I can get it sorted out for the next
> > iteration.
>
> IIUC Peter is ready to queue your series on Monday if you fix the
> license, but he usually doesn't accept devices without vmstate via
> his tree, you got lucky ;) See:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg643089.html
>
> Adding the vmstate is not a hard task. If you need to respin,
> I strongly recommend you to consider adding them.

Yeah, I'll add vmstate for v4. Thanks for the blog link, that looks
like what I need.

