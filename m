Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AE0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7B020814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukIUO8xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7B020814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbtX7-0002PJ-1R
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 18:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jbtWR-00020K-W3; Thu, 21 May 2020 18:18:40 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:42112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jbtWQ-00011C-Vs; Thu, 21 May 2020 18:18:39 -0400
Received: by mail-il1-x141.google.com with SMTP id 18so8862841iln.9;
 Thu, 21 May 2020 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tnT6/bezgmoSKNRFgPtR/obPQBE8mHp/3IQx4yme7+E=;
 b=ukIUO8xcKdyMBav3mRXSg/wlk8UKe2krtjWw9xd3TskhyFAt2MYDEsMNVy/zzZmFYt
 cIPojjgSNFh4hiO5uTfu3n+1o9FbhZmmjWMTzrNAyEBqEOpO0u5EtfSMEEL9a+ehyxoI
 iH50ZVYNxeHQBU0YmcIwn0KxWGsNu9o9PGsH5iSwLD3umYgLWe8eippoTTGv6eI/vnQP
 vYptRr7ndUH1FZZj8FMfVPqyQCMed+7NjPVNgfwu9H6LM2bW8tCr6AkNmapoFjUG/gqb
 IPehKm5CJtRxMy91R8JbYRnezQDzcwYoN5k570YfU4HEtAdI21up37yrqCZ3RrK3PO7n
 WlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tnT6/bezgmoSKNRFgPtR/obPQBE8mHp/3IQx4yme7+E=;
 b=Fd7vUSKiUCdbhV1i3AzLdk2MSANFQYzSYnwWtO7cesBBrAOmfKoM4+JEuw4x5QHLkO
 buHyJYfXP/QlmyFKiXaGrAFL2nBVzF0/lLxZyrmf/vnBfLvE2l3QM3+P4LCjS3hdJ3gY
 dbCILxFRFES0W+w7r1zl4qh3Kxq0BEl7UxmwCcKbPjY5BV6IHZFgAmhw5NYqc7QeUCjW
 Xe4UvbUCXmoND0NbKtuGUZlE1b4eTLL+eKKlhA960onB32Ouc5BB8L5W7B0c88SAAGfm
 TaF28Pai2cAJLrxNkj7zHa4HXjUYQOxylKJODOBmmJeft8BHj8s8IyqbO03BViSUHX+S
 CSBQ==
X-Gm-Message-State: AOAM5319ouKOZIT1aMQ+m1zum/x38M6p+BYFzSZZp0e8arPbKv0KD3TO
 6+VW+mWfEoRqusvjtR5hRQJPYCQ6wE2JtwuxTe8=
X-Google-Smtp-Source: ABdhPJwHQa0vivvd4FpB8reQIE0tE+YtZc/hkTZZaKFEAaRQNVDn6IJ89NNYM9ci1BIexpkUVAA9ZpbZq6vK0gD0igw=
X-Received: by 2002:a92:d087:: with SMTP id h7mr11311887ilh.227.1590099517375; 
 Thu, 21 May 2020 15:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <1590072147-13035-1-git-send-email-bmeng.cn@gmail.com>
 <c6fba5b7-1191-29bf-a4b7-4707efecb973@amsat.org>
In-Reply-To: <c6fba5b7-1191-29bf-a4b7-4707efecb973@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 21 May 2020 15:09:41 -0700
Message-ID: <CAKmqyKOLYwy3U=Wye9K1NuDuOoUNi8M1EKj+EeLoHEZQsLCdtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/riscv: sifive_u: Remove the riscv_ prefix of the
 soc* functions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 7:48 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 5/21/20 4:42 PM, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > To keep consistency with the machine* functions, remove the riscv_
> > prefix of the soc* functions.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> > ---
> >
> >   hw/riscv/sifive_u.c | 24 ++++++++++++------------
> >   1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index 4299bdf..f9fef2b 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -481,7 +481,7 @@ static void sifive_u_machine_init_register_types(vo=
id)
> >
> >   type_init(sifive_u_machine_init_register_types)
> >
> > -static void riscv_sifive_u_soc_init(Object *obj)
> > +static void sifive_u_soc_instance_init(Object *obj)
> >   {
> >       MachineState *ms =3D MACHINE(qdev_get_machine());
> >       SiFiveUSoCState *s =3D RISCV_U_SOC(obj);
> > @@ -520,7 +520,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
> >                             TYPE_CADENCE_GEM);
> >   }
> >
> > -static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> > +static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
> >   {
> >       MachineState *ms =3D MACHINE(qdev_get_machine());
> >       SiFiveUSoCState *s =3D RISCV_U_SOC(dev);
> > @@ -635,32 +635,32 @@ static void riscv_sifive_u_soc_realize(DeviceStat=
e *dev, Error **errp)
> >           memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].siz=
e);
> >   }
> >
> > -static Property riscv_sifive_u_soc_props[] =3D {
> > +static Property sifive_u_soc_props[] =3D {
> >       DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL)=
,
> >       DEFINE_PROP_END_OF_LIST()
> >   };
> >
> > -static void riscv_sifive_u_soc_class_init(ObjectClass *oc, void *data)
> > +static void sifive_u_soc_class_init(ObjectClass *oc, void *data)
> >   {
> >       DeviceClass *dc =3D DEVICE_CLASS(oc);
> >
> > -    device_class_set_props(dc, riscv_sifive_u_soc_props);
> > -    dc->realize =3D riscv_sifive_u_soc_realize;
> > +    device_class_set_props(dc, sifive_u_soc_props);
> > +    dc->realize =3D sifive_u_soc_realize;
> >       /* Reason: Uses serial_hds in realize function, thus can't be use=
d twice */
> >       dc->user_creatable =3D false;
> >   }
> >
> > -static const TypeInfo riscv_sifive_u_soc_type_info =3D {
> > +static const TypeInfo sifive_u_soc_type_info =3D {
> >       .name =3D TYPE_RISCV_U_SOC,
> >       .parent =3D TYPE_DEVICE,
> >       .instance_size =3D sizeof(SiFiveUSoCState),
> > -    .instance_init =3D riscv_sifive_u_soc_init,
> > -    .class_init =3D riscv_sifive_u_soc_class_init,
> > +    .instance_init =3D sifive_u_soc_instance_init,
> > +    .class_init =3D sifive_u_soc_class_init,
> >   };
> >
> > -static void riscv_sifive_u_soc_register_types(void)
> > +static void sifive_u_soc_register_types(void)
> >   {
> > -    type_register_static(&riscv_sifive_u_soc_type_info);
> > +    type_register_static(&sifive_u_soc_type_info);
> >   }
> >
> > -type_init(riscv_sifive_u_soc_register_types)
> > +type_init(sifive_u_soc_register_types)
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>

