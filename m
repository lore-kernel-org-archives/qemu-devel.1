Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FCBC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD0C214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XBLBwras"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD0C214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvwuI-0004ma-S1
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 00:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvwqP-00079N-Ic
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvwqN-0008Qg-HQ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60947)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hvwqM-0008PQ-N2
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464XpL5jBXz9s3Z; Fri,  9 Aug 2019 14:49:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565326170;
 bh=u+LNo0Ab1PPUftNZLlibt6cZM7RqNgqFCMRhN4gjLOo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XBLBwrasbYGiShdY8p3cqXVG8nFSUm1CqIrbluVKdhONekA8Un8AtwjQdfruASjTY
 jwxl4qTXgMdQVKBeI+WqaepqAYGb+iZfBBALhcdLihvqVVqocRGa1ZK672AtburiFY
 SteY5ElSgTyQEh9ThtroqnzCkMRLpovBTAFL1h9k=
Date: Fri, 9 Aug 2019 14:44:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190809044435.GK5465@umbus.fritz.box>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-4-bala24@linux.ibm.com>
 <bfbabf96-fdec-f52a-0204-605420919149@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Tv3+oRj6D9L8lW+H"
Content-Disposition: inline
In-Reply-To: <bfbabf96-fdec-f52a-0204-605420919149@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [RFC PATCH 3/6] hw/ppc/pnv_homer: add homer/occ
 common area emulation for PowerNV
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
Cc: maddy@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 Balamuruhan S <bala24@linux.ibm.com>, anju@linux.vnet.ibm.com,
 hari@linux.vnet.ibm.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Tv3+oRj6D9L8lW+H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 09:54:55AM +0200, C=E9dric Le Goater wrote:
> On 07/08/2019 09:14, Balamuruhan S wrote:
> > Add mmio callback functions to enable homer/occ common area
> > to emulate pstate table, occ-sensors, slw, occ static and
> > dynamic values for Power8 and Power9 chips. It also works for
> > multiple chips as offset remains the same whereas the base
> > address are handled appropriately while initializing device
> > tree.
> >=20
> > currently skiboot disables the homer/occ code path with
> > `QUIRK_NO_PBA`, this quirk have to be removed in skiboot
> > for it to use this infrastructure.
>=20
>=20
> I think this patch can come before the others as it is adding
> support without the python extra facilities.

Right.  In fact it seems to me having it as an entirely separate
series would be preferable.  I don't think we want to tie review of a
basic OCC extension to to the frankly not all that palatable idea of
adding arbitrary scripting into the MMIO path.

>=20
> Some comments below,=20
> =20
> > Signed-off-by: Hariharan T.S <hari@linux.vnet.ibm.com>
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  hw/ppc/Makefile.objs       |   2 +-
> >  hw/ppc/pnv_homer.c         | 185 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/hw/ppc/pnv.h       |  14 ++++
> >  include/hw/ppc/pnv_homer.h |  41 ++++++++++
> >  4 files changed, 241 insertions(+), 1 deletion(-)
> >  create mode 100644 hw/ppc/pnv_homer.c
> >  create mode 100644 include/hw/ppc/pnv_homer.h
> >=20
> > diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> > index 9da93af905..7260b4a96c 100644
> > --- a/hw/ppc/Makefile.objs
> > +++ b/hw/ppc/Makefile.objs
> > @@ -7,7 +7,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spap=
r_drc.o
> >  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
> >  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
> >  # IBM PowerNV
> > -obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_=
psi.o pnv_occ.o pnv_bmc.o
> > +obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_=
psi.o pnv_occ.o pnv_bmc.o pnv_homer.o
>=20
> add an extra line.
>=20
> >  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
> >  obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
> >  endif
> > diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
> > new file mode 100644
> > index 0000000000..73a94856d0
> > --- /dev/null
> > +++ b/hw/ppc/pnv_homer.c
> > @@ -0,0 +1,185 @@
> > +/*
> > + * QEMU PowerPC PowerNV Homer and OCC common area region
> > + *
> > + * Copyright (c) 2019, IBM Corporation.
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see <http://www.gnu.org/li=
censes/>.
> > + */
> > +#include "qemu/osdep.h"
> > +#include "sysemu/hw_accel.h"
> > +#include "sysemu/cpus.h"
> > +#include "hw/ppc/pnv.h"
> > +
> > +static bool core_max_array(hwaddr addr)
> > +{
> > +    char *cpu_type;
> > +    hwaddr core_max_base =3D 0xe2819;
>=20
> What is this representing ?=20
>=20
> > +    MachineState *ms =3D MACHINE(qdev_get_machine());
> > +    cpu_type =3D strstr(ms->cpu_type, "power8");
>=20
> you need to get this information some other way. The PnvChip should have =
it.
>=20
> > +    if (cpu_type)
> > +        core_max_base =3D 0x1f8810;
>=20
> It could be a PnvChipClass value.
>=20
> > +    for (int i =3D 0; i <=3D ms->smp.cores; i++)
> > +       if (addr =3D=3D (core_max_base + i))
> > +           return true;
> > +    return false;
> > +}
>=20
>=20
> > +static uint64_t homer_read(void *opaque, hwaddr addr, unsigned width)
> > +{
> > +    switch (addr) {
>=20
> We should be using defines for the case statements below.=20
>=20
> Are we accessing one or more structures which are mapped at specific=20
> addresses ? If so I would define them in this file and change the=20
> memory ops to use well known offsets.
>=20
> Are these structures the same on P9 and P8 ?=20
>=20
> Are there default values ? May be we could use a reset handler
> in this case.
>=20
> > +        case 0xe2006:  /* max pstate ultra turbo */
> > +        case 0xe2018:  /* pstate id for 0 */
> > +        case 0x1f8001: /* P8 occ pstate version */
> > +        case 0x1f8003: /* P8 pstate min */
> > +        case 0x1f8010: /* P8 pstate id for 0 */
> > +            return 0;
> > +        case 0xe2000:  /* occ data area */
> > +        case 0xe2002:  /* occ_role master/slave*/
> > +        case 0xe2004:  /* pstate nom */
> > +        case 0xe2005:  /* pstate turbo */
> > +        case 0xe2020:  /* pstate id for 1 */
> > +        case 0xe2818:  /* pstate ultra turbo */
> > +        case 0xe2b85:  /* opal dynamic data (runtime) */
> > +        case 0x1f8000: /* P8 occ pstate valid */
> > +        case 0x1f8002: /* P8 throttle */
> > +        case 0x1f8004: /* P8 pstate nom */
> > +        case 0x1f8005: /* P8 pstate turbo */
> > +        case 0x1f8012: /* vdd voltage identifier */
> > +        case 0x1f8013: /* vcs voltage identifier */
> > +        case 0x1f8018: /* P8 pstate id for 1 */
> > +            return 1;
> > +        case 0xe2003:  /* pstate min (2 as pstate min) */
> > +        case 0xe2028:  /* pstate id for 2 */
> > +        case 0x1f8006: /* P8 pstate ultra turbo */
> > +        case 0x1f8020: /* P8 pstate id for 2 */
> > +            return 2;
> > +        case 0xe2001:  /* major version */
> > +            return 0x90;
> > +        /* 3000 khz frequency for 0, 1, and 2 pstates */
> > +        case 0xe201c:
> > +        case 0xe2024:
> > +        case 0xe202c:
> > +        /* P8 frequency for 0, 1, and 2 pstates */
> > +        case 0x1f8014:
> > +        case 0x1f801c:
> > +        case 0x1f8024:
> > +            return 3000;
> > +        case 0x0:      /* homer base */
> > +        case 0xe2008:  /* occ data area + 8 */
> > +        case 0x1f8008: /* P8 occ data area + 8 */
> > +        case 0x200008: /* homer base access to get homer image pointer=
*/
> > +            return 0x1000000000000000;
> > +    }
> > +    /* pstate table core max array */
> > +    if (core_max_array(addr))
> > +        return 1;
>=20
> I don't understand what the core_max_array is returning
>=20
> > +    return 0;
> > +}
> > +
> > +static void homer_write(void *opaque, hwaddr addr, uint64_t val,
> > +                        unsigned width)
> > +{
> > +    /* callback function defined to homer write */
> > +    return;
> > +}
> > +
> > +const MemoryRegionOps pnv_homer_ops =3D {
> > +    .read =3D homer_read,
> > +    .write =3D homer_write,
> > +    .valid.min_access_size =3D 1,
> > +    .valid.max_access_size =3D 8,
> > +    .impl.min_access_size =3D 1,
> > +    .impl.max_access_size =3D 8,
> > +    .endianness =3D DEVICE_BIG_ENDIAN,
> > +};
> > +
> > +static uint64_t occ_common_area_read(void *opaque, hwaddr addr, unsign=
ed width)
> > +{
> > +    switch (addr) {
> > +        /*
> > +         * occ-sensor sanity check that asserts the sensor
> > +         * header block
> > +         */
>=20
> Same comments as above.=20
>=20
> > +        case 0x580000: /* occ sensor data block */
> > +        case 0x580001: /* valid */
> > +        case 0x580002: /* version */
> > +        case 0x580004: /* reading_version */
> > +        case 0x580008: /* nr_sensors */
> > +        case 0x580010: /* names_offset */
> > +        case 0x580014: /* reading_ping_offset */
> > +        case 0x58000c: /* reading_pong_offset */
> > +        case 0x580023: /* structure_type */
> > +            return 1;
> > +        case 0x58000d: /* name length */
> > +            return 0x30;
> > +        case 0x580022: /* occ sensor loc core */
> > +            return 0x0040;
> > +        case 0x580003: /* occ sensor type power */
> > +            return 0x0080;
> > +        case 0x580005: /* sensor name */
> > +            return 0x1000;
> > +        case 0x58001e: /* HWMON_SENSORS_MASK */
> > +        case 0x580020:
> > +            return 0x8e00;
> > +        case 0x0:      /* P8 slw base access for slw image size */
> > +            return 0x1000000000000000;
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void occ_common_area_write(void *opaque, hwaddr addr, uint64_t =
val,
> > +                                  unsigned width)
> > +{
> > +    /* callback function defined to occ common area write */
> > +    return;
> > +}
> > +
> > +const MemoryRegionOps pnv_occ_common_area_ops =3D {
> > +    .read =3D occ_common_area_read,
> > +    .write =3D occ_common_area_write,
> > +    .valid.min_access_size =3D 1,
> > +    .valid.max_access_size =3D 8,
> > +    .impl.min_access_size =3D 1,
> > +    .impl.max_access_size =3D 8,
> > +    .endianness =3D DEVICE_BIG_ENDIAN,
> > +};
>=20
>=20
> Why aren't you using the PnvOCC model ?=20
>=20
> > +void pnv_occ_common_area_realize(PnvChip *chip, Error **errp)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(chip);
> > +    sbd->num_mmio =3D PNV_OCC_COMMON_AREA_SYSBUS;
> > +    char *occ_common_area;
> > +
> > +    /* occ common area */
> > +    occ_common_area =3D g_strdup_printf("occ-common-area-%x", chip->ch=
ip_id);
> > +    memory_region_init_io(&chip->occ_common_area_mmio, OBJECT(chip),
> > +                          &pnv_occ_common_area_ops, chip, occ_common_a=
rea,
> > +                          PNV_OCC_COMMON_AREA_SIZE);
> > +    sysbus_init_mmio(sbd, &chip->occ_common_area_mmio);
> > +    g_free(occ_common_area);
> > +}
>=20
>=20
> May be this "device" deserves a PnvHomer model, one for P8 and one for P9=
=2E=20
>=20
> > +void pnv_homer_realize(PnvChip *chip, Error **errp)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(chip);
> > +    sbd->num_mmio =3D PNV_HOMER_SYSBUS;
> > +    char *homer;
> > +
> > +    /* homer region */
> > +    homer =3D g_strdup_printf("homer-%x", chip->chip_id);
> > +    memory_region_init_io(&chip->homer_mmio, OBJECT(chip), &pnv_homer_=
ops,
> > +                          chip, homer, PNV_HOMER_SIZE);
> > +    sysbus_init_mmio(sbd, &chip->homer_mmio);
> > +    g_free(homer);
> > +}
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index fb123edc4e..6464e32892 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -28,6 +28,7 @@
> >  #include "hw/ppc/pnv_occ.h"
> >  #include "hw/ppc/pnv_xive.h"
> >  #include "hw/ppc/pnv_core.h"
> > +#include "hw/ppc/pnv_homer.h"
> > =20
> >  #define TYPE_PNV_CHIP "pnv-chip"
> >  #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
> > @@ -36,6 +37,13 @@
> >  #define PNV_CHIP_GET_CLASS(obj) \
> >       OBJECT_GET_CLASS(PnvChipClass, (obj), TYPE_PNV_CHIP)
> > =20
> > +enum SysBusNum {
> > +    PNV_XSCOM_SYSBUS,
> > +    PNV_ICP_SYSBUS,
> > +    PNV_HOMER_SYSBUS,
> > +    PNV_OCC_COMMON_AREA_SYSBUS,
> > +};
>=20
> What is this ?=20
>=20
>=20
> >  typedef enum PnvChipType {
> >      PNV_CHIP_POWER8E,     /* AKA Murano (default) */
> >      PNV_CHIP_POWER8,      /* AKA Venice */
> > @@ -56,6 +64,8 @@ typedef struct PnvChip {
> >      uint64_t     cores_mask;
> >      void         *cores;
> > =20
> > +    MemoryRegion homer_mmio;
> > +    MemoryRegion occ_common_area_mmio;
> >      MemoryRegion xscom_mmio;
> >      MemoryRegion xscom;
> >      AddressSpace xscom_as;
> > @@ -191,6 +201,10 @@ static inline bool pnv_is_power9(PnvMachineState *=
pnv)
> >  void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
> >  void pnv_bmc_powerdown(IPMIBmc *bmc);
> > =20
> > +extern void pnv_occ_common_area_realize(PnvChip *chip, Error **errp);
> > +extern void pnv_homer_realize(PnvChip *chip, Error **errp);
> > +
> > +
> >  /*
> >   * POWER8 MMIO base addresses
> >   */
> > diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
> > new file mode 100644
> > index 0000000000..0fe6469abe
> > --- /dev/null
> > +++ b/include/hw/ppc/pnv_homer.h
> > @@ -0,0 +1,41 @@
> > +/*
> > + * QEMU PowerPC PowerNV Homer and occ common area definitions
> > + *
> > + * Copyright (c) 2019, IBM Corporation.
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see <http://www.gnu.org/li=
censes/>.
> > + */
> > +#ifndef _PPC_PNV_HOMER_H
> > +#define _PPC_PNV_HOMER_H
> > +
> > +#include "qom/object.h"
> > +
> > +/*
> > + *  HOMER region size 4M per OCC (1 OCC is defined per chip  in struct=
 PnvChip)
> > + *  so chip_num can be used to offset between HOMER region from its ba=
se address
> > + */
> > +#define PNV_HOMER_SIZE        0x300000
> > +#define PNV_OCC_COMMON_AREA_SIZE      0x700000
> > +
> > +#define PNV_HOMER_BASE(chip)                                          =
  \
> > +    (0x7ffd800000ull + ((uint64_t)(chip)->chip_num) * PNV_HOMER_SIZE)
> > +#define PNV_OCC_COMMON_AREA(chip)                                     =
  \
> > +    (0x7fff800000ull + ((uint64_t)(chip)->chip_num) * PNV_OCC_COMMON_A=
REA_SIZE)
> > +
> > +#define PNV9_HOMER_BASE(chip)                                         =
   \
> > +    (0x203ffd800000ull + ((uint64_t)(chip)->chip_num) * PNV_HOMER_SIZE)
> > +#define PNV9_OCC_COMMON_AREA(chip)                                    =
   \
> > +    (0x203fff800000ull + ((uint64_t)(chip)->chip_num) * PNV_OCC_COMMON=
_AREA_SIZE)
> > +
> > +#endif /* _PPC_PNV_HOMER_H */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Tv3+oRj6D9L8lW+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1M+jMACgkQbDjKyiDZ
s5Iitg//cJFj061GeMBmc3Ns9SP1pVjr3D/xRsrH2545g+83JBK/gaRiap0mS+z/
OUib1aDQMjzpgnYTHlQmx3LNmKlJz8RDQqlrHLpbW+94zh6TG+a5z7EcHvwsk2+c
P6dduVQqRrXPEw8tMi+EOrEEDDbywTo46A6lpqxtji+K+kekteGrbrc55I/Dfd//
beqgEm0ETx3MjggJ9JtCaC5y9+FH+wSx9ZD+gdX864TbgAx9J5M/m/7YHxLEHqfA
8fjAo5iT8XuvlvGQ8tRXI8M7hbpqVO5Kpy/dZnXJEb+zCkjo7CCQza8jqQnZxE/z
WuRtM3MmaZcpEJD9CgDHWJtvGwawyYAHq3evivKRwPntRz3SRvafaRDeIxhCFpWk
jRWXm1ukAjtug4u8fDFysjylRTpjY/1NfZcuCDDekvU45gwPZjjPC61ac5diPMrP
H2yvAUOaxdEBPHMQh57PiZ0l34V76Zgg14zq5ocxltknHfLwhhlNm869/Mk7HU8d
rjtF2EPN2DK67RSQc5cAvNUhCpsU9+Nt3tXdY67HP5Q4+QzdDIFsI4B356u16S6v
bJyL7gK7jsE64yUnwRd0BvtCF6rHlYez5xk8hT3m7Ee04uQxl1w8+thHYP+Yw93C
QeKprecBPRilW2rfWhfzG3yUPECFf970wgLu/deeVUXSnuKgdkA=
=rps8
-----END PGP SIGNATURE-----

--Tv3+oRj6D9L8lW+H--

