Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2F0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA2020782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lveCnJ2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA2020782
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrT6a-0003Pk-Rw
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 17:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrT5v-0002sv-CM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:19:39 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:45585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrT5t-00066O-12
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:19:39 -0400
Received: by mail-vs1-xe41.google.com with SMTP id o15so17704766vsp.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 14:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yuU30o8g/Px0gTd4YpwqhPl9ilWvzec7vcR3IpaT5GI=;
 b=lveCnJ2qb+2pH/IgJxdWNP+4kCWv2gmPtPVCtDlqiXKcjFu4WT4QDuSvdqhM9hDKpg
 AsFH4IqKnh21pQjWmvjjRAEVlh2I7QFUrLE3Y7iwmiZI4GpkD0lxfFfUKJqrho8roh/O
 bVcsUF2D2tM4e6cjKIul8+ZsT66Y8qEbDeJve6L+xfEARJDiKrF/xwS+Xx56/A1gj9Bv
 8IUoAp1+8shUjQbG/Sdy3xBK/seEfyopRub0WfUfvixAvZlbe8BDzgdQKvcBJhNmV+zH
 74+mEzzUpAVK3h9fMCGQnHhjKad6Osfo9eAvIT4kWsephRCfdXMOVV+tSKUJqsidHIXa
 fqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yuU30o8g/Px0gTd4YpwqhPl9ilWvzec7vcR3IpaT5GI=;
 b=aXu5Jh5bHQ7dn2n9QgfB+7mCMz1h+cXPMoalg/9zrao1Z+77ddjL3agpw8XhMPRpwq
 6p547FnyHYhr9RWJRdz1gETGzQIldQlco4HG5GUsqN8m1RTTYMbGHUQjS52MzTFJpTq5
 1AUu9z1fiW1G+QQfayKNVfPH1b95N7AtF9DBWvdLWbydGdRNlMiwB8r1Qlpf5Pm9c2a1
 Esqtd+BgfA4+RqhxVLl0SpH/5axzwnpHtQAxwWfM5n+W3y9JkRLWnjt6/+xuvDSFSJcQ
 NBf7RDjyrMgd8+mXLm+KH4Y+9pZZ8MusMKlNltenpp4ecBAZ106V6XR6jLqEsrpdaADQ
 MRhw==
X-Gm-Message-State: AOAM531/gDrfpgfiR4Vpd1q8nEHgkBJOBB5e0t4XbYI9as0/ytn9x++R
 2IADHGdNsiDPYX1EANFiQeYsEECJX9lofw1TzKtoKQ==
X-Google-Smtp-Source: ABdhPJxXZuOxUSg3wTOxNq5NiDUzidUAch+6pSze3agJDK/3VjHk3UYy95n1ljVzIw7mZ1pRDjQIE/Kw1DgISctytqE=
X-Received: by 2002:a67:7f8e:: with SMTP id
 a136mr23106995vsd.232.1593811175040; 
 Fri, 03 Jul 2020 14:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <20200626235519.591734-9-hskinnemoen@google.com>
 <abdb209d-7268-7997-2caa-95cb984269da@amsat.org>
 <CAFQmdRYZWhA-957jRHfiRHfYoOk-c2TJVtqoz6LMOhDgJwMiCg@mail.gmail.com>
In-Reply-To: <CAFQmdRYZWhA-957jRHfiRHfYoOk-c2TJVtqoz6LMOhDgJwMiCg@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 3 Jul 2020 14:19:23 -0700
Message-ID: <CAFQmdRYxzf7LrtsrNUSNpyN-Ve6fSFGJhyRBPMNL=nFCf+zHgg@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe41.google.com
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

On Fri, Jul 3, 2020 at 2:07 PM Havard Skinnemoen <hskinnemoen@google.com> w=
rote:
>
> On Fri, Jul 3, 2020 at 6:46 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> >
> > On 6/27/20 1:55 AM, Havard Skinnemoen wrote:
> > > +static void npcm7xx_otp_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    NPCM7xxOTPClass *oc =3D NPCM7XX_OTP_GET_CLASS(dev);
> > > +    NPCM7xxOTPState *s =3D NPCM7XX_OTP(dev);
> > > +    SysBusDevice *sbd =3D &s->parent;
> > > +
> > > +    s->array =3D g_malloc0(NPCM7XX_OTP_ARRAY_BYTES);
> >
> > The possibility to reuse persistent OTP seems important.
> > This can be added later of course.
>
> Agree, it's an important part of the behavior of the module. But it's
> not essential to be able to boot a BMC firmware image, so I left it
> out initially.
>
> > See simple example in hw/nvram/eeprom_at24c.c which use
> > a BlockBackend so the OTP content is not lost after reset
> > or migration.
>
> I'll take a look at that, thanks!
>
> > > +
> > > +    memory_region_init_io(&s->mmio, OBJECT(s), oc->mmio_ops, s, "reg=
s",
> > > +                          NPCM7XX_OTP_REGS_SIZE);
> > > +    sysbus_init_mmio(sbd, &s->mmio);
> > > +}
> > > +
> > > +static void npcm7xx_otp_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > +
> >
> > Missing migration vmstate for NPCM7xxOTPState::regs[].
>
> Ah, you're right. This is probably true for most of the peripherals in
> this series. I'll see if I can get it sorted out for the next
> iteration.

Btw, do you have any advice on how to test device migration? I'm not
planning to do actual migration of BMCs in the near future, so I'm not
sure if I'd notice if I get it wrong.

