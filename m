Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ECFC282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39EEA206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EEA206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGuy-0004Vk-Rp
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47820)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1haGqk-0002Br-C5
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1haGqg-0005BL-M1
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:44:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44305 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
 id 1haGqg-00045n-32
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:44:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 264E61A1FEF;
 Mon, 10 Jun 2019 11:43:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.110] (unknown [10.10.13.110])
 by mail.rt-rk.com (Postfix) with ESMTPSA id CF2991A1E87;
 Mon, 10 Jun 2019 11:43:07 +0200 (CEST)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, philmd@redhat.com
References: <1559828732-23081-1-git-send-email-mateja.marjanovic@rt-rk.com>
 <1559828732-23081-2-git-send-email-mateja.marjanovic@rt-rk.com>
 <CAL1e-=jzqMODPivxcAqrVYDDMVtwMcQQQkbpi-F_EQ61fcntLA@mail.gmail.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <329418c0-8492-bdc2-1c7c-8bf0e9a60169@rt-rk.com>
Date: Mon, 10 Jun 2019 11:43:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jzqMODPivxcAqrVYDDMVtwMcQQQkbpi-F_EQ61fcntLA@mail.gmail.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] target/mips: Add implementation of DSPRAM
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
Cc: arikalo@wavecomp.com, aurelien@aurel32.net, amarkovic@wavecomp.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 8.6.19. 07:32, Aleksandar Markovic wrote:
>
>
> On Jun 6, 2019 3:49 PM, "Mateja Marjanovic"=20
> <mateja.marjanovic@rt-rk.com <mailto:mateja.marjanovic@rt-rk.com>> wrot=
e:
> >
> > From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com=20
> <mailto:Mateja.Marjanovic@rt-rk.com>>
> >
> > Add support for DSPRAM (Data Scratch Pad RAM). It still needs
> > some minor fixing, but the structure is right.
> >
> > Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com=20
> <mailto:mateja.marjanovic@rt-rk.com>>
> > ---
>
> Please consider splitting the patch into several logical units.
>
> Adding Philippe.
>
I will do that in v2.

Regards,
Mateja
>
> Thanks,
> Aleksandar
>
> > =C2=A0default-configs/mips-softmmu-common.mak |=C2=A0 =C2=A01 +
> > =C2=A0hw/mips/cps.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 28 +++++-
> > =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +
> > =C2=A0hw/misc/mips_dspram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 153=20
> ++++++++++++++++++++++++++++++++
> > =C2=A0include/hw/mips/cps.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +
> > =C2=A0include/hw/misc/mips_dspram.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 46 ++++++++++
> > =C2=A0target/mips/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 +-
> > =C2=A0target/mips/internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-
> > =C2=A0target/mips/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +++
> > =C2=A0target/mips/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 ++
> > =C2=A0target/mips/translate_init.inc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +
> > =C2=A011 files changed, 262 insertions(+), 5 deletions(-)
> > =C2=A0create mode 100644 hw/misc/mips_dspram.c
> > =C2=A0create mode 100644 include/hw/misc/mips_dspram.h
> >
> > diff --git a/default-configs/mips-softmmu-common.mak=20
> b/default-configs/mips-softmmu-common.mak
> > index ded7498..d3f85b0 100644
> > --- a/default-configs/mips-softmmu-common.mak
> > +++ b/default-configs/mips-softmmu-common.mak
> > @@ -35,6 +35,7 @@ CONFIG_ISA_TESTDEV=3Dy
> > =C2=A0CONFIG_EMPTY_SLOT=3Dy
> > =C2=A0CONFIG_MIPS_CPS=3Dy
> > =C2=A0CONFIG_MIPS_ITU=3Dy
> > +CONFIG_MIPS_DSPRAM=3Dy
> > =C2=A0CONFIG_I2C=3Dy
> > =C2=A0CONFIG_R4K=3Dy
> > =C2=A0CONFIG_MALTA=3Dy
> > diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> > index fc97f59..0205556 100644
> > --- a/hw/mips/cps.c
> > +++ b/hw/mips/cps.c
> > @@ -90,7 +90,8 @@ static void mips_cps_realize(DeviceState *dev,=20
> Error **errp)
> >
> > =C2=A0 =C2=A0 =C2=A0cpu =3D MIPS_CPU(first_cpu);
> > =C2=A0 =C2=A0 =C2=A0env =3D &cpu->env;
> > -=C2=A0 =C2=A0 saar_present =3D (bool)env->saarp;
> > +=C2=A0 =C2=A0 saar_present =3D env->saarp;
> > +=C2=A0 =C2=A0 bool dspram_present =3D env->dspramp;
> >
> > =C2=A0 =C2=A0 =C2=A0/* Inter-Thread Communication Unit */
> > =C2=A0 =C2=A0 =C2=A0if (itu_present) {
> > @@ -102,7 +103,8 @@ static void mips_cps_realize(DeviceState *dev,=20
> Error **errp)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(OBJECT(&s-=
>itu), saar_present,=20
> "saar-present",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &err);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (saar_present) {
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_ptr(DEVICE(&=
s->itu), "saar", (void=20
> *)&env->CP0_SAAR);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_ptr(DEVICE(&=
s->itu), "saar",
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (void *) &env->CP0_SAAR[0]);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(OBJECT(&s-=
>itu), true, "realized",=20
> &err);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D NULL) {
> > @@ -113,6 +115,28 @@ static void mips_cps_realize(DeviceState *dev,=20
> Error **errp)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(&s->con=
tainer, 0,
> > sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->itu), 0));
> > =C2=A0 =C2=A0 =C2=A0}
> > +=C2=A0 =C2=A0 env->dspram =3D g_new0(MIPSDSPRAMState, 1);
> > +
> > +=C2=A0 =C2=A0 /* Data Scratch Pad RAM */
> > +=C2=A0 =C2=A0 if (dspram_present) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!saar_present) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report("%s: DSPRAM r=
equires SAAR registers",=20
> __func__);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize(&s->dspram, sizeof(MIP=
SDSPRAMState),
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_MIPS_DSPRAM);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_set_parent_bus(DEVICE(&s->dspram), =
sysbus_get_default());
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_ptr(DEVICE(&s->dspram), "s=
aar",
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &env->CP0_SAAR[1]);
> > + object_property_set_bool(OBJECT(&s->dspram), true, "realized", &err=
);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err !=3D NULL) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report("%s: DSPRAM i=
nitialisation failed", __func__);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err)=
;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(&s->containe=
r, 0,
> > + sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dspram), 0));
> > +=C2=A0 =C2=A0 }
> >
> > =C2=A0 =C2=A0 =C2=A0/* Cluster Power Controller */
> > =C2=A0 =C2=A0 =C2=A0object_initialize(&s->cpc, sizeof(s->cpc), TYPE_M=
IPS_CPC);
> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > index 74c91d2..37c4108 100644
> > --- a/hw/misc/Makefile.objs
> > +++ b/hw/misc/Makefile.objs
> > @@ -60,6 +60,7 @@ obj-$(CONFIG_STM32F2XX_SYSCFG) +=3D stm32f2xx_syscf=
g.o
> > =C2=A0obj-$(CONFIG_MIPS_CPS) +=3D mips_cmgcr.o
> > =C2=A0obj-$(CONFIG_MIPS_CPS) +=3D mips_cpc.o
> > =C2=A0obj-$(CONFIG_MIPS_ITU) +=3D mips_itu.o
> > +obj-$(CONFIG_MIPS_DSPRAM) +=3D mips_dspram.o
> > =C2=A0obj-$(CONFIG_MPS2_FPGAIO) +=3D mps2-fpgaio.o
> > =C2=A0obj-$(CONFIG_MPS2_SCC) +=3D mps2-scc.o
> >
> > diff --git a/hw/misc/mips_dspram.c b/hw/misc/mips_dspram.c
> > new file mode 100644
> > index 0000000..9bc155b
> > --- /dev/null
> > +++ b/hw/misc/mips_dspram.c
> > @@ -0,0 +1,153 @@
> > +/*
> > + * Data Scratch Pad RAM
> > + *
> > + * Copyright (c) 2017 Imagination Technologies
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see=20
> <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "cpu.h"
> > +#include "qemu/log.h"
> > +#include "exec/exec-all.h"
> > +#include "hw/hw.h"
> > +#include "hw/sysbus.h"
> > +#include "sysemu/sysemu.h"
> > +#include "hw/misc/mips_dspram.h"
> > +
> > +static void raise_exception(int excp)
> > +{
> > +=C2=A0 =C2=A0 current_cpu->exception_index =3D excp;
> > +=C2=A0 =C2=A0 cpu_loop_exit(current_cpu);
> > +}
> > +
> > +static uint64_t dspram_read(void *opaque, hwaddr addr, unsigned size=
)
> > +{
> > +=C2=A0 =C2=A0 MIPSDSPRAMState *s =3D (MIPSDSPRAMState *)opaque;
> > +
> > +=C2=A0 =C2=A0 switch (size) {
> > +=C2=A0 =C2=A0 case 1:
> > +=C2=A0 =C2=A0 case 2:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_exception(EXCP_AdEL);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> > +=C2=A0 =C2=A0 case 4:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return *(uint32_t *) &s->ramblock[addr %=
 (1 << s->size)];
> > +=C2=A0 =C2=A0 case 8:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return *(uint64_t *) &s->ramblock[addr %=
 (1 << s->size)];
> > +=C2=A0 =C2=A0 }
> > +=C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +static void dspram_write(void *opaque, hwaddr addr, uint64_t data,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0unsigned size)
> > +{
> > +=C2=A0 =C2=A0 MIPSDSPRAMState *s =3D (MIPSDSPRAMState *)opaque;
> > +
> > +=C2=A0 =C2=A0 switch (size) {
> > +=C2=A0 =C2=A0 case 1:
> > +=C2=A0 =C2=A0 case 2:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_exception(EXCP_AdES);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > +=C2=A0 =C2=A0 case 4:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(uint32_t *) &s->ramblock[addr % (1 << =
s->size)] =3D=20
> (uint32_t) data;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +=C2=A0 =C2=A0 case 8:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(uint64_t *) &s->ramblock[addr % (1 << =
s->size)] =3D data;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +=C2=A0 =C2=A0 }
> > +}
> > +
> > +void dspram_reconfigure(struct MIPSDSPRAMState *dspram)
> > +{
> > +=C2=A0 =C2=A0 MemoryRegion *mr =3D &dspram->mr;
> > +=C2=A0 =C2=A0 hwaddr address;
> > +=C2=A0 =C2=A0 bool is_enabled;
> > +
> > +=C2=A0 =C2=A0 address =3D ((*(uint64_t *) dspram->saar) & 0xFFFFFFFE=
000ULL) << 4;
> > +=C2=A0 =C2=A0 is_enabled =3D *(uint64_t *) dspram->saar & 1;
> > +
> > +=C2=A0 =C2=A0 memory_region_transaction_begin();
> > +=C2=A0 =C2=A0 memory_region_set_size(mr, (1 << dspram->size));
> > +=C2=A0 =C2=A0 memory_region_set_address(mr, address);
> > +=C2=A0 =C2=A0 memory_region_set_enabled(mr, is_enabled);
> > +=C2=A0 =C2=A0 memory_region_transaction_commit();
> > +}
> > +
> > +static const MemoryRegionOps dspram_ops =3D {
> > +=C2=A0 =C2=A0 .read =3D dspram_read,
> > +=C2=A0 =C2=A0 .write =3D dspram_write,
> > +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +=C2=A0 =C2=A0 .valid =3D {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .unaligned =3D false,
> > +=C2=A0 =C2=A0 }
> > +};
> > +
> > +static void mips_dspram_init(Object *obj)
> > +{
> > +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +=C2=A0 =C2=A0 MIPSDSPRAMState *s =3D MIPS_DSPRAM(obj);
> > +
> > +=C2=A0 =C2=A0 memory_region_init_io(&s->mr, OBJECT(s), &dspram_ops, =
s,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "mips-dspram", (1 << s->size));
> > +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &s->mr);
> > +}
> > +
> > +static void mips_dspram_realize(DeviceState *dev, Error **errp)
> > +{
> > +=C2=A0 =C2=A0 MIPSDSPRAMState *s =3D MIPS_DSPRAM(dev);
> > +
> > +=C2=A0 =C2=A0 /* some error handling here */
> > +
> > +=C2=A0 =C2=A0 s->ramblock =3D g_malloc0(1 << s->size);
> > +}
> > +
> > +static void mips_dspram_reset(DeviceState *dev)
> > +{
> > +=C2=A0 =C2=A0 MIPSDSPRAMState *s =3D MIPS_DSPRAM(dev);
> > +
> > +=C2=A0 =C2=A0 *(uint64_t *) s->saar =3D s->size << 1;
> > +=C2=A0 =C2=A0 memset(s->ramblock, 0, (1 << s->size));
> > +}
> > +
> > +static Property mips_dspram_properties[] =3D {
> > +=C2=A0 =C2=A0 DEFINE_PROP_PTR("saar", MIPSDSPRAMState, saar),
> > +=C2=A0 =C2=A0 /* default DSPRAM size is 64 KB */
> > +=C2=A0 =C2=A0 DEFINE_PROP_SIZE("size", MIPSDSPRAMState, size, 0x10),
> > +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void mips_dspram_class_init(ObjectClass *klass, void *data)
> > +{
> > +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +=C2=A0 =C2=A0 dc->props =3D mips_dspram_properties;
> > +=C2=A0 =C2=A0 dc->realize =3D mips_dspram_realize;
> > +=C2=A0 =C2=A0 dc->reset =3D mips_dspram_reset;
> > +}
> > +
> > +static const TypeInfo mips_dspram_info =3D {
> > +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_MIPS_=
DSPRAM,
> > +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DE=
VICE,
> > +=C2=A0 =C2=A0 .instance_size =3D sizeof(MIPSDSPRAMState),
> > +=C2=A0 =C2=A0 .instance_init =3D mips_dspram_init,
> > +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D mips_dspram_class_init,
> > +};
> > +
> > +static void mips_dspram_register_types(void)
> > +{
> > +=C2=A0 =C2=A0 type_register_static(&mips_dspram_info);
> > +}
> > +
> > +type_init(mips_dspram_register_types);
> > diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
> > index aab1af9..a637036 100644
> > --- a/include/hw/mips/cps.h
> > +++ b/include/hw/mips/cps.h
> > @@ -25,6 +25,7 @@
> > =C2=A0#include "hw/intc/mips_gic.h"
> > =C2=A0#include "hw/misc/mips_cpc.h"
> > =C2=A0#include "hw/misc/mips_itu.h"
> > +#include "hw/misc/mips_dspram.h"
> >
> > =C2=A0#define TYPE_MIPS_CPS "mips-cps"
> > =C2=A0#define MIPS_CPS(obj) OBJECT_CHECK(MIPSCPSState, (obj), TYPE_MI=
PS_CPS)
> > @@ -41,6 +42,7 @@ typedef struct MIPSCPSState {
> > =C2=A0 =C2=A0 =C2=A0MIPSGICState gic;
> > =C2=A0 =C2=A0 =C2=A0MIPSCPCState cpc;
> > =C2=A0 =C2=A0 =C2=A0MIPSITUState itu;
> > +=C2=A0 =C2=A0 MIPSDSPRAMState dspram;
> > =C2=A0} MIPSCPSState;
> >
> > =C2=A0qemu_irq get_cps_irq(MIPSCPSState *cps, int pin_number);
> > diff --git a/include/hw/misc/mips_dspram.h=20
> b/include/hw/misc/mips_dspram.h
> > new file mode 100644
> > index 0000000..ee99e17
> > --- /dev/null
> > +++ b/include/hw/misc/mips_dspram.h
> > @@ -0,0 +1,46 @@
> > +/*
> > + * Data Scratch Pad RAM
> > + *
> > + * Copyright (c) 2017 Imagination Technologies
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see=20
> <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef MIPS_DSPRAM_H
> > +#define MIPS_DSPRAM_H
> > +
> > +#include "hw/sysbus.h"
> > +
> > +#define TYPE_MIPS_DSPRAM "mips-dspram"
> > +#define MIPS_DSPRAM(obj) OBJECT_CHECK(MIPSDSPRAMState, (obj),=20
> TYPE_MIPS_DSPRAM)
> > +
> > +typedef struct MIPSDSPRAMState {
> > +=C2=A0 =C2=A0 /*< private >*/
> > +=C2=A0 =C2=A0 SysBusDevice parent_obj;
> > +=C2=A0 =C2=A0 /*< public >*/
> > +
> > +=C2=A0 =C2=A0 /* 2 ^ SIZE */
> > +=C2=A0 =C2=A0 uint64_t size;
> > +
> > +=C2=A0 =C2=A0 MemoryRegion mr;
> > +
> > +=C2=A0 =C2=A0 /* SAAR */
> > +=C2=A0 =C2=A0 bool saar_present;
> > +=C2=A0 =C2=A0 void *saar;
> > +
> > +=C2=A0 =C2=A0 /* ramblock */
> > +=C2=A0 =C2=A0 uint8_t *ramblock;
> > +} MIPSDSPRAMState;
> > +
> > +#endif /* MIPS_DSPRAM_H */
> > diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> > index a10eeb0..8b15e6c 100644
> > --- a/target/mips/cpu.h
> > +++ b/target/mips/cpu.h
> > @@ -445,6 +445,7 @@ struct TCState {
> >
> > =C2=A0};
> >
> > +struct MIPSDSPRAMState;
> > =C2=A0struct MIPSITUState;
> > =C2=A0typedef struct CPUMIPSState CPUMIPSState;
> > =C2=A0struct CPUMIPSState {
> > @@ -1021,8 +1022,8 @@ struct CPUMIPSState {
> > =C2=A0 =C2=A0 =C2=A0uint32_t CP0_Status_rw_bitmask; /* Read/write bit=
s in CP0_Status */
> > =C2=A0 =C2=A0 =C2=A0uint32_t CP0_TCStatus_rw_bitmask; /* Read/write b=
its in=20
> CP0_TCStatus */
> > =C2=A0 =C2=A0 =C2=A0uint64_t insn_flags; /* Supported instruction set=
 */
> > -=C2=A0 =C2=A0 int saarp;
> > -
> > +=C2=A0 =C2=A0 bool saarp;
> > +=C2=A0 =C2=A0 bool dspramp;
> > =C2=A0 =C2=A0 =C2=A0/* Fields up to this point are cleared by a CPU r=
eset */
> > =C2=A0 =C2=A0 =C2=A0struct {} end_reset_fields;
> >
> > @@ -1039,6 +1040,7 @@ struct CPUMIPSState {
> > =C2=A0 =C2=A0 =C2=A0QEMUTimer *timer; /* Internal timer */
> > =C2=A0 =C2=A0 =C2=A0struct MIPSITUState *itu;
> > =C2=A0 =C2=A0 =C2=A0MemoryRegion *itc_tag; /* ITC Configuration Tags =
*/
> > +=C2=A0 =C2=A0 struct MIPSDSPRAMState *dspram;
> > =C2=A0 =C2=A0 =C2=A0target_ulong exception_base; /* ExceptionBase inp=
ut to the core */
> > =C2=A0};
> >
> > @@ -1181,6 +1183,9 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int=20
> irq, int level);
> > =C2=A0/* mips_itu.c */
> > =C2=A0void itc_reconfigure(struct MIPSITUState *tag);
> >
> > +/* mips_dspram.c */
> > +void dspram_reconfigure(struct MIPSDSPRAMState *dspram);
> > +
> > =C2=A0/* helper.c */
> > =C2=A0target_ulong exception_resume_pc (CPUMIPSState *env);
> >
> > diff --git a/target/mips/internal.h b/target/mips/internal.h
> > index 8f6fc91..650bddd 100644
> > --- a/target/mips/internal.h
> > +++ b/target/mips/internal.h
> > @@ -61,7 +61,8 @@ struct mips_def_t {
> > =C2=A0 =C2=A0 =C2=A0target_ulong CP0_EBaseWG_rw_bitmask;
> > =C2=A0 =C2=A0 =C2=A0uint64_t insn_flags;
> > =C2=A0 =C2=A0 =C2=A0enum mips_mmu_types mmu_type;
> > -=C2=A0 =C2=A0 int32_t SAARP;
> > +=C2=A0 =C2=A0 bool SAARP;
> > +=C2=A0 =C2=A0 bool DSPRAMP;
> > =C2=A0};
> >
> > =C2=A0extern const struct mips_def_t mips_defs[];
> > diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> > index c921032..5136e33 100644
> > --- a/target/mips/op_helper.c
> > +++ b/target/mips/op_helper.c
> > @@ -1614,7 +1614,14 @@ void helper_mtc0_saar(CPUMIPSState *env,=20
> target_ulong arg1)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0itc_rec=
onfigure(env->itu);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env->dspram) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dspram_recon=
figure(env->dspram);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > +=C2=A0 =C2=A0 } else {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_raise_exception(env, EXCP_RI);
> > =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0}
> >
> > @@ -1631,7 +1638,14 @@ void helper_mthc0_saar(CPUMIPSState *env,=20
> target_ulong arg1)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0itc_rec=
onfigure(env->itu);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env->dspram) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dspram_recon=
figure(env->dspram);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > +=C2=A0 =C2=A0 } else {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_raise_exception(env, EXCP_RI);
> > =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0}
> >
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index c79fa1e..40584e9 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -31383,6 +31383,8 @@ void cpu_state_reset(CPUMIPSState *env)
> > =C2=A0 =C2=A0 =C2=A0env->active_fpu.fcr31 =3D env->cpu_model->CP1_fcr=
31;
> > =C2=A0 =C2=A0 =C2=A0env->msair =3D env->cpu_model->MSAIR;
> > =C2=A0 =C2=A0 =C2=A0env->insn_flags =3D env->cpu_model->insn_flags;
> > +=C2=A0 =C2=A0 env->saarp =3D env->cpu_model->SAARP;
> > +=C2=A0 =C2=A0 env->dspramp =3D env->cpu_model->DSPRAMP;
> >
> > =C2=A0#if defined(CONFIG_USER_ONLY)
> > =C2=A0 =C2=A0 =C2=A0env->CP0_Status =3D (MIPS_HFLAG_UM << CP0St_KSU);
> > @@ -31537,6 +31539,12 @@ void cpu_state_reset(CPUMIPSState *env)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msa_reset(env);
> > =C2=A0 =C2=A0 =C2=A0}
> >
> > +=C2=A0 =C2=A0 /* DSPRAM */
> > +=C2=A0 =C2=A0 if (env->dspramp) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fixed DSPRAM size with Default Value =
*/
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_SAAR[1] =3D 0x10 << 1;
> > +=C2=A0 =C2=A0 }
> > +
> > =C2=A0 =C2=A0 =C2=A0compute_hflags(env);
> > =C2=A0 =C2=A0 =C2=A0restore_fp_status(env);
> > =C2=A0 =C2=A0 =C2=A0restore_pamask(env);
> > diff --git a/target/mips/translate_init.inc.c=20
> b/target/mips/translate_init.inc.c
> > index bf559af..4c49a0e 100644
> > --- a/target/mips/translate_init.inc.c
> > +++ b/target/mips/translate_init.inc.c
> > @@ -760,6 +760,8 @@ const mips_def_t mips_defs[] =3D
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.PABITS =3D 48,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.insn_flags =3D CPU_MIPS64R6 | ASE_=
MSA,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mmu_type =3D MMU_TYPE_R4000,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .SAARP =3D 1,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .DSPRAMP =3D 1,
> > =C2=A0 =C2=A0 =C2=A0},
> > =C2=A0 =C2=A0 =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D "Loongson-2E",
> > --
> > 2.7.4
> >
> >
>
