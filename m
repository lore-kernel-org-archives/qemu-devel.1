Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5225CC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50DC20829
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCxDSKPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50DC20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSki-0001hu-HD
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kTSif-00007U-JI; Fri, 16 Oct 2020 12:36:42 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:35650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kTSib-0002q3-Ms; Fri, 16 Oct 2020 12:36:39 -0400
Received: by mail-io1-xd44.google.com with SMTP id k6so4652913ior.2;
 Fri, 16 Oct 2020 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=inORuv0oT/hffetNm/tYoD1ysw6cBw8h5xOracZQ2dE=;
 b=JCxDSKPCzEq4hliW8jAH8gvGrIt0Sco+qV/dnN9ilv+F+k1cK65zJzqBzxqtlnnHpz
 nMS41ITVl7Go/ZAoibExoiH3o2eoPv4ZlCOjU/CLcUVH6y3KBn63bHILbzRoOZXv7IpP
 TVbPaW/BazxHbslODFL5NLOT1S9+ZFCFM2F27Heq5/Be0VjC21tWx0YIu8+F7hRTlqqW
 oy7DKvxrpx/5tF3jx95X9E51ENr8JMjF+Tq6mZ/yUBkMJTdSCqavK1Savm58gcP9MjGS
 zLoD+4re65Yd/jgboyG1jcvfg5zf6sA0XaaQ2NZO/btiBV8rZ+gtGFJkuFt27E/8Un64
 DXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=inORuv0oT/hffetNm/tYoD1ysw6cBw8h5xOracZQ2dE=;
 b=aPapwvLWEE6Zt/Ed+9aL3lFHKAdNwftqmD5klV58R3lRMK66n73kU/bXBPzEk2JgWu
 rf2bjejE4KoT+hKzLGUHnK3Am/VNANLJTGQu5rRpzTFrxFlvcVCXqa0TfDTwiGZZJE0S
 M2peO/EpfrlaHkbyA9UyAQn/funA68vr6bWXw38lRtd11TT+b/63un6mmFeXCiQ7liZv
 w5iWgFIGeRL497dGke46U8Xpob5cMvXGkAtit17QGT/anpVLGLK6Nag7DA3/0bM7krnr
 GrlzTWlxGRccfd2rXxNjqAPt6jWGbZ1dKNtrvEJJauAjnpfQ8/q5m1MYuMFdSoZ5w58s
 JXHQ==
X-Gm-Message-State: AOAM53073Izjr/ub8EPA3QGrNzy1EEzyuwACJUzDhn5xhvKYJnuGvpkw
 LvybWw2HAco5OJbpgqYMZ7yHHwHMJCZtghmuDnY=
X-Google-Smtp-Source: ABdhPJzkKPseAVsWvhjSj6bK6AtfCX5s15Yt9SVh5R4tutLio4sWH/HtvfZNL6+hKUdGleQ12p3TZT7fguaN6jS3rlA=
X-Received: by 2002:a05:6638:a90:: with SMTP id
 16mr3359956jas.91.1602866195991; 
 Fri, 16 Oct 2020 09:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201016123737.8118-1-ivan.griffin@emdalo.com>
 <CAKmqyKNykruYK2AQ05KZyGCGD0rUsqQOVBbnccY+ELATBF=Ozg@mail.gmail.com>
 <DB7PR10MB191544AA04D0B3ECF82C57CDFE030@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB7PR10MB191544AA04D0B3ECF82C57CDFE030@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Oct 2020 09:24:57 -0700
Message-ID: <CAKmqyKODEgnkw4zBbsNK1zQ7qaiKWEAZBpwhnHzEetjgWpxtzQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
To: Ivan Griffin <ivan.griffin@emdalo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 9:31 AM Ivan Griffin <ivan.griffin@emdalo.com> wrot=
e:
>
> I don't know why it isn't documented in that PDF (or in the register map)=
, but if you check https://github.com/polarfire-soc/polarfire-soc-bare-meta=
l-library/blob/master/src/platform/drivers/mss_sys_services/mss_sys_service=
s.h you'll see the following
>
> ```
> typedef struct
> {
>     volatile uint32_t SOFT_RESET;
>     volatile uint32_t VDETECTOR;
>     volatile uint32_t TVS_CONTROL;
>     volatile uint32_t TVS_TEMP_A;
>     volatile uint32_t TVS_TEMP_B;
>     volatile uint32_t TVS_TEMP_C;
>     volatile uint32_t TVS_VOLT_A;
>     volatile uint32_t TVS_VOLT_B;
>     volatile uint32_t TVS_VOLT_C;
>     volatile uint32_t TVS_OUTPUT0;
>     volatile uint32_t TVS_OUTPUT1;
>     volatile uint32_t TVS_TRIGGER;
>     volatile uint32_t TRIM_VDET1P05;
>     volatile uint32_t TRIM_VDET1P8;
>     volatile uint32_t TRIM_VDET2P5;
>     volatile uint32_t TRIM_TVS;
>     volatile uint32_t TRIM_GDET1P05;
>     volatile uint32_t RESERVED0;
>     volatile uint32_t RESERVED1;
>     volatile uint32_t RESERVED2;
>     volatile uint32_t SERVICES_CR;
>     volatile uint32_t SERVICES_SR;
>     volatile uint32_t USER_DETECTOR_SR;
>     volatile uint32_t USER_DETECTOR_CR;
>     volatile uint32_t MSS_SPI_CR;
>
> } SCBCTRL_TypeDef;
>
> #define MSS_SCBCTRL                    ((SCBCTRL_TypeDef*) (0x37020000UL)=
)
>
> /*2kB bytes long mailbox.*/
> #define MSS_SCBMAILBOX                 ((uint32_t*) (0x37020800UL))
> ```
>
> And in https://github.com/polarfire-soc/polarfire-soc-bare-metal-library/=
blob/master/src/platform/drivers/mss_sys_services/mss_sys_services.c you'll=
 see MSS_SCB and MSS_SCBMAILBOX used in many places to interact with the FP=
GA system controller to perform various services.

Ok, so the memory map exists, but not documented in the official documentat=
ion.

In this case it's fine to add. Can you add a comment though saying
that it's not documented in the official documentation though?
Otherwise it will confuse developers.

Alistair

>
>
> Cheers,
> Ivan
>
>
> -----Original Message-----
> From: Alistair Francis <alistair23@gmail.com>
> Sent: Friday 16 October 2020 17:08
> To: Ivan Griffin <ivan.griffin@emdalo.com>
> Cc: Bin Meng <bin.meng@windriver.com>; QEMU Trivial <qemu-trivial@nongnu.=
org>; open list:RISC-V <qemu-riscv@nongnu.org>; qemu-devel@nongnu.org Devel=
opers <qemu-devel@nongnu.org>
> Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
>
> On Fri, Oct 16, 2020 at 8:04 AM Ivan Griffin <ivan.griffin@emdalo.com> wr=
ote:
> >
> > Adding the PolarFire SoC IOSCBCTRL memory region to prevent QEMU
> > reporting a STORE/AMO Access Fault.
> >
> > This region is used by the PolarFire SoC port of U-Boot to interact
> > with the FPGA system controller.
> >
> > Signed-off-by: Ivan Griffin <ivan.griffin@emdalo.com>
> > ---
> >  hw/riscv/microchip_pfsoc.c         | 6 ++++++
> >  include/hw/riscv/microchip_pfsoc.h | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> > index 4627179cd3..20e1496e3e 100644
> > --- a/hw/riscv/microchip_pfsoc.c
> > +++ b/hw/riscv/microchip_pfsoc.c
> > @@ -97,6 +97,7 @@ static const struct MemmapEntry {
> >      [MICROCHIP_PFSOC_GPIO2] =3D           { 0x20122000,     0x1000 },
> >      [MICROCHIP_PFSOC_ENVM_CFG] =3D        { 0x20200000,     0x1000 },
> >      [MICROCHIP_PFSOC_ENVM_DATA] =3D       { 0x20220000,    0x20000 },
> > +    [MICROCHIP_PFSOC_IOSCB_CTRL] =3D      { 0x37020000,     0x1000 },
>
> I don't see this in the UG0880 "User Guide PolarFire SoC FPGA Microproces=
sor Sub-System" memory map.
>
> Where is this documented?
>
> Alistair
>
> >      [MICROCHIP_PFSOC_IOSCB_CFG] =3D       { 0x37080000,     0x1000 },
> >      [MICROCHIP_PFSOC_DRAM] =3D            { 0x80000000,        0x0 },
> >  };
> > @@ -341,6 +342,11 @@ static void microchip_pfsoc_soc_realize(DeviceStat=
e *dev, Error **errp)
> >      create_unimplemented_device("microchip.pfsoc.ioscb.cfg",
> >          memmap[MICROCHIP_PFSOC_IOSCB_CFG].base,
> >          memmap[MICROCHIP_PFSOC_IOSCB_CFG].size);
> > +
> > +    /* IOSCBCTRL */
> > +    create_unimplemented_device("microchip.pfsoc.ioscb.ctrl",
> > +        memmap[MICROCHIP_PFSOC_IOSCB_CTRL].base,
> > +        memmap[MICROCHIP_PFSOC_IOSCB_CTRL].size);
> >  }
> >
> >  static void microchip_pfsoc_soc_class_init(ObjectClass *oc, void
> > *data) diff --git a/include/hw/riscv/microchip_pfsoc.h
> > b/include/hw/riscv/microchip_pfsoc.h
> > index 8bfc7e1a85..3f1874b162 100644
> > --- a/include/hw/riscv/microchip_pfsoc.h
> > +++ b/include/hw/riscv/microchip_pfsoc.h
> > @@ -95,6 +95,7 @@ enum {
> >      MICROCHIP_PFSOC_ENVM_CFG,
> >      MICROCHIP_PFSOC_ENVM_DATA,
> >      MICROCHIP_PFSOC_IOSCB_CFG,
> > +    MICROCHIP_PFSOC_IOSCB_CTRL,
> >      MICROCHIP_PFSOC_DRAM,
> >  };
> >
> > --
> > 2.17.1
> >
> >

