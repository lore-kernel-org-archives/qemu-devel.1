Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA1DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A6E20782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSDVH1Wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A6E20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSvl-00050a-HO
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 17:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrSud-0004AN-Rc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:07:59 -0400
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42]:38504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrSub-00044d-LN
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:07:59 -0400
Received: by mail-vk1-xa42.google.com with SMTP id t23so7364062vkt.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=itS6dSrCgMMyMc53eXZOLlFFRtRNAyIJ+G+nB3RGmlo=;
 b=HSDVH1Wc257Dy5QhL4tIi+ih069CMZ/oItKyM4ZuLtCz2eWUB9p11m0DlABvhd19R+
 9D0nbIJL5RYtJmCu08KRsmzDC9EDo696UuuYD8gCaepWXIxT5oc1eDaQzihZyjAJYluo
 wlhfxsnP7AHAjvlZQQqhKjjBfEZFzoyjPa9Zr8zWRzhypBRiX2S82+QjeLsAyYUDefsh
 zlNJ1UHvj4yPA3yzlbkNR7hZomAPy7QTbqptasG41RQCaCcvvL6lgGW+zzLnWBYjP1LE
 x+81ONuGsVoCeAUZY5OhQzmmuY1kn4Dr2SspwhHn8/Yh+gHgGvzE++FV6Il2oWyugvnT
 HfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=itS6dSrCgMMyMc53eXZOLlFFRtRNAyIJ+G+nB3RGmlo=;
 b=etrXdhXlUzBCaXnjl2ZpvGtKQvyKSk3r8exw/qxssX84+gsU0gWxT1+UNsMib7xmyN
 Goos85SqRJIMieDc9X/eotV3PGJvb+Kp/ql1WnXRTEprqKMMHMLzPztmDvLY2PqnGFBX
 TwYkp/hHb2ZH+dQES3cHNiwgPRmmfVWz+EM6mx3l0WyEYvEecRr8YKLeA0byQtI5lCp9
 PSmrao207U8hBZwmZQn4jovEAF8OojgjfFLzlOu58QUxEJqhlQ1YSGtMRMa6tdZOEkm0
 lQNkntV+qabNOkEW3S6G+42Erno3GikWTVy7Diybk2HVBqcGQYBUsnK1z72qUuF5jQtj
 xE7A==
X-Gm-Message-State: AOAM531Htib173eamR8lp1PM0pa8fb9d982UDwKlY88zXCcRy3XBBC8z
 mgotAo/ADyuvfJqxqYedtEf1XcBW3Qta91shjSNssA==
X-Google-Smtp-Source: ABdhPJzLSIwARwSBwNV+wzMUJYIlHBGRGjOaf9h9c1sMJFDKPslsSIkThKXHKjLEJF9v0AZ/jZIuyFu1h/k8BYdfeJ0=
X-Received: by 2002:a1f:3113:: with SMTP id x19mr27110586vkx.91.1593810476317; 
 Fri, 03 Jul 2020 14:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <20200626235519.591734-9-hskinnemoen@google.com>
 <abdb209d-7268-7997-2caa-95cb984269da@amsat.org>
In-Reply-To: <abdb209d-7268-7997-2caa-95cb984269da@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 3 Jul 2020 14:07:44 -0700
Message-ID: <CAFQmdRYZWhA-957jRHfiRHfYoOk-c2TJVtqoz6LMOhDgJwMiCg@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a42;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

On Fri, Jul 3, 2020 at 6:46 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 6/27/20 1:55 AM, Havard Skinnemoen wrote:
> > +static void npcm7xx_otp_realize(DeviceState *dev, Error **errp)
> > +{
> > +    NPCM7xxOTPClass *oc =3D NPCM7XX_OTP_GET_CLASS(dev);
> > +    NPCM7xxOTPState *s =3D NPCM7XX_OTP(dev);
> > +    SysBusDevice *sbd =3D &s->parent;
> > +
> > +    s->array =3D g_malloc0(NPCM7XX_OTP_ARRAY_BYTES);
>
> The possibility to reuse persistent OTP seems important.
> This can be added later of course.

Agree, it's an important part of the behavior of the module. But it's
not essential to be able to boot a BMC firmware image, so I left it
out initially.

> See simple example in hw/nvram/eeprom_at24c.c which use
> a BlockBackend so the OTP content is not lost after reset
> or migration.

I'll take a look at that, thanks!

> > +
> > +    memory_region_init_io(&s->mmio, OBJECT(s), oc->mmio_ops, s, "regs"=
,
> > +                          NPCM7XX_OTP_REGS_SIZE);
> > +    sysbus_init_mmio(sbd, &s->mmio);
> > +}
> > +
> > +static void npcm7xx_otp_class_init(ObjectClass *klass, void *data)
> > +{
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
>
> Missing migration vmstate for NPCM7xxOTPState::regs[].

Ah, you're right. This is probably true for most of the peripherals in
this series. I'll see if I can get it sorted out for the next
iteration.

