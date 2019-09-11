Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C2DC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCED206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCED206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8509-0008MF-QQ
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i84yL-0006tD-Vw
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i84yI-0004t6-Ph
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:55:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i84yI-0004sk-FL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:55:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8BFq5GK065747
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 11:55:53 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uy2fac4nc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 11:55:53 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 11 Sep 2019 16:55:50 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 11 Sep 2019 16:55:48 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x8BFtMdJ25362754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2019 15:55:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6617AE057;
 Wed, 11 Sep 2019 15:55:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C8D6AE058;
 Wed, 11 Sep 2019 15:55:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.50.88])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 11 Sep 2019 15:55:44 +0000 (GMT)
Date: Wed, 11 Sep 2019 21:25:42 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
References: <20190911142925.19197-1-bala24@linux.ibm.com>
 <20190911142925.19197-4-bala24@linux.ibm.com>
 <3befce98-636f-4c8b-3993-5e595126d968@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3befce98-636f-4c8b-3993-5e595126d968@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19091115-0016-0000-0000-000002AA1661
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091115-0017-0000-0000-0000330AA3B2
Message-Id: <20190911155542.GA20050@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-11_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110144
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x8BFq5GK065747
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hw/ppc/pnv_homer: add PowerNV homer
 device model
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org, qemu-devel@nongnu.org,
 anju@linux.vnet.ibm.com, qemu-ppc@nongnu.org, hari@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 04:53:37PM +0200, C=E9dric Le Goater wrote:
> On 11/09/2019 16:29, Balamuruhan S wrote:
> > add PnvHomer device model to emulate homer memory access
> > for pstate table, occ-sensors, slw, occ static and dynamic
> > values for Power8 and Power9 chips.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> I don't remember this "Signed-off-by". Please remove it.

I used the fabric link logic code that was given by you to
use PnvChip struct.

>=20
> A part from that, it looks good. One minor comment below,
>=20
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  hw/ppc/Makefile.objs       |   1 +
> >  hw/ppc/pnv.c               |  30 +++++
> >  hw/ppc/pnv_homer.c         | 269 +++++++++++++++++++++++++++++++++++=
++++++++++
> >  include/hw/ppc/pnv.h       |   3 +
> >  include/hw/ppc/pnv_homer.h |  53 +++++++++
> >  5 files changed, 356 insertions(+)
> >  create mode 100644 hw/ppc/pnv_homer.c
> >  create mode 100644 include/hw/ppc/pnv_homer.h
> >=20
> > diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> > index 2c4e1c8de0..580bb4f0dd 100644
> > --- a/hw/ppc/Makefile.objs
> > +++ b/hw/ppc/Makefile.objs
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
> >  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
> >  # IBM PowerNV
> >  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pn=
v_psi.o pnv_occ.o pnv_bmc.o
> > +obj-$(CONFIG_POWERNV) +=3D pnv_homer.o
> >  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
> >  obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
> >  endif
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 80338ffe87..f249e72356 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -847,6 +847,11 @@ static void pnv_chip_power8_instance_init(Object=
 *obj)
> >                              TYPE_PNV8_OCC, &error_abort, NULL);
> >      object_property_add_const_link(OBJECT(&chip8->occ), "psi",
> >                                     OBJECT(&chip8->psi), &error_abort=
);
> > +
> > +    object_initialize_child(obj, "homer",  &chip8->homer, sizeof(chi=
p8->homer),
> > +                            TYPE_PNV8_HOMER, &error_abort, NULL);
> > +    object_property_add_const_link(OBJECT(&chip8->homer), "chip", ob=
j,
> > +                                   &error_abort);
> >  }
> > =20
> >  static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
> > @@ -942,6 +947,16 @@ static void pnv_chip_power8_realize(DeviceState =
*dev, Error **errp)
> >      /* OCC SRAM model */
> >      memory_region_add_subregion(get_system_memory(), PNV_OCC_COMMON_=
AREA(chip),
> >                                  &chip8->occ.sram_regs);
> > +
> > +    /* HOMER */
> > +    object_property_set_bool(OBJECT(&chip8->homer), true, "realized"=
,
> > +                             &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +    memory_region_add_subregion(get_system_memory(), PNV_HOMER_BASE(=
chip),
> > +                                &chip8->homer.regs);
> >  }
> > =20
> >  static void pnv_chip_power8e_class_init(ObjectClass *klass, void *da=
ta)
> > @@ -1024,6 +1039,11 @@ static void pnv_chip_power9_instance_init(Obje=
ct *obj)
> >                              TYPE_PNV9_OCC, &error_abort, NULL);
> >      object_property_add_const_link(OBJECT(&chip9->occ), "psi",
> >                                     OBJECT(&chip9->psi), &error_abort=
);
> > +
> > +    object_initialize_child(obj, "homer",  &chip9->homer, sizeof(chi=
p9->homer),
> > +                            TYPE_PNV9_HOMER, &error_abort, NULL);
> > +    object_property_add_const_link(OBJECT(&chip9->homer), "chip", ob=
j,
> > +                                   &error_abort);
> >  }
> > =20
> >  static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
> > @@ -1134,6 +1154,16 @@ static void pnv_chip_power9_realize(DeviceStat=
e *dev, Error **errp)
> >      /* OCC SRAM model */
> >      memory_region_add_subregion(get_system_memory(), PNV9_OCC_COMMON=
_AREA(chip),
> >                                  &chip9->occ.sram_regs);
> > +
> > +    /* HOMER */
> > +    object_property_set_bool(OBJECT(&chip9->homer), true, "realized"=
,
> > +                             &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +    memory_region_add_subregion(get_system_memory(), PNV9_HOMER_BASE=
(chip),
> > +                                &chip9->homer.regs);
> >  }
> > =20
> >  static void pnv_chip_power9_class_init(ObjectClass *klass, void *dat=
a)
> > diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
> > new file mode 100644
> > index 0000000000..707219c73c
> > --- /dev/null
> > +++ b/hw/ppc/pnv_homer.c
> > @@ -0,0 +1,269 @@
> > +/*
> > + * QEMU PowerPC PowerNV Emulation of a few HOMER related registers
> > + *
> > + * Copyright (c) 2019, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or mod=
ify
> > + * it under the terms of the GNU General Public License, version 2, =
as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses=
/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "exec/hwaddr.h"
> > +#include "exec/memory.h"
> > +#include "sysemu/cpus.h"
> > +#include "hw/qdev-core.h"
> > +#include "hw/ppc/pnv.h"
> > +#include "hw/ppc/pnv_homer.h"
> > +
> > +
> > +static bool core_max_array(void *opaque, hwaddr addr)
>=20
> you can pass directly 'PnvHomer *homer' here.

okay, will do that.

>=20
>=20
> > +{
> > +    int i;
> > +    PnvHomer *homer =3D PNV_HOMER(opaque);
> > +    PnvHomerClass *hmrc =3D PNV_HOMER_GET_CLASS(homer);
> > +
> > +    for (i =3D 0; i <=3D homer->chip->nr_cores; i++) {
> > +        if (addr =3D=3D (hmrc->core_max_base + i)) {
> > +            return true;
> > +       }
> > +    }
> > +    return false;
> > +}
> > +
> > +/* P8 Pstate table */
> > +
> > +#define PNV8_OCC_PSTATE_VERSION          0x1f8001
> > +#define PNV8_OCC_PSTATE_MIN              0x1f8003
> > +#define PNV8_OCC_PSTATE_VALID            0x1f8000
> > +#define PNV8_OCC_PSTATE_THROTTLE         0x1f8002
> > +#define PNV8_OCC_PSTATE_NOM              0x1f8004
> > +#define PNV8_OCC_PSTATE_TURBO            0x1f8005
> > +#define PNV8_OCC_PSTATE_ULTRA_TURBO      0x1f8006
> > +#define PNV8_OCC_PSTATE_DATA             0x1f8008
> > +#define PNV8_OCC_PSTATE_ID_ZERO          0x1f8010
> > +#define PNV8_OCC_PSTATE_ID_ONE           0x1f8018
> > +#define PNV8_OCC_PSTATE_ID_TWO           0x1f8020
> > +#define PNV8_OCC_VDD_VOLTAGE_IDENTIFIER  0x1f8012
> > +#define PNV8_OCC_VCS_VOLTAGE_IDENTIFIER  0x1f8013
> > +#define PNV8_OCC_PSTATE_ZERO_FREQUENCY   0x1f8014
> > +#define PNV8_OCC_PSTATE_ONE_FREQUENCY    0x1f801c
> > +#define PNV8_OCC_PSTATE_TWO_FREQUENCY    0x1f8024
> > +#define PNV8_CORE_MAX_BASE               0x1f8810
> > +
> > +
> > +static uint64_t pnv_power8_homer_read(void *opaque, hwaddr addr,
> > +                                      unsigned size)
> > +{
>=20
> PnvHomer *homer =3D PNV_HOMER(opaque);

yes, got it.

>=20
> > +    switch (addr) {
> > +    case PNV8_OCC_PSTATE_VERSION:
> > +    case PNV8_OCC_PSTATE_MIN:
> > +    case PNV8_OCC_PSTATE_ID_ZERO:
> > +        return 0;
> > +    case PNV8_OCC_PSTATE_VALID:
> > +    case PNV8_OCC_PSTATE_THROTTLE:
> > +    case PNV8_OCC_PSTATE_NOM:
> > +    case PNV8_OCC_PSTATE_TURBO:
> > +    case PNV8_OCC_PSTATE_ID_ONE:
> > +    case PNV8_OCC_VDD_VOLTAGE_IDENTIFIER:
> > +    case PNV8_OCC_VCS_VOLTAGE_IDENTIFIER:
> > +        return 1;
> > +    case PNV8_OCC_PSTATE_ULTRA_TURBO:
> > +    case PNV8_OCC_PSTATE_ID_TWO:
> > +        return 2;
> > +    case PNV8_OCC_PSTATE_DATA:
> > +        return 0x1000000000000000;
> > +    /* P8 frequency for 0, 1, and 2 pstates */
> > +    case PNV8_OCC_PSTATE_ZERO_FREQUENCY:
> > +    case PNV8_OCC_PSTATE_ONE_FREQUENCY:
> > +    case PNV8_OCC_PSTATE_TWO_FREQUENCY:
> > +        return 3000;
> > +    }
> > +    /* pstate table core max array */
> > +    if (core_max_array(opaque, addr)) {
>=20
>         if (core_max_array(homer, addr)) {

:+1: Thanks

-- Bala

>=20
> > +        return 1;
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void pnv_power8_homer_write(void *opaque, hwaddr addr,
> > +                                   uint64_t val, unsigned size)
> > +{
> > +    /* callback function defined to homer write */
> > +    return;
> > +}
> > +
> > +static const MemoryRegionOps pnv_power8_homer_ops =3D {
> > +    .read =3D pnv_power8_homer_read,
> > +    .write =3D pnv_power8_homer_write,
> > +    .valid.min_access_size =3D 1,
> > +    .valid.max_access_size =3D 8,
> > +    .impl.min_access_size =3D 1,
> > +    .impl.max_access_size =3D 8,
> > +    .endianness =3D DEVICE_BIG_ENDIAN,
> > +};
> > +
> > +static void pnv_homer_power8_class_init(ObjectClass *klass, void *da=
ta)
> > +{
> > +    PnvHomerClass *homer =3D PNV_HOMER_CLASS(klass);
> > +
> > +    homer->homer_size =3D PNV_HOMER_SIZE;
> > +    homer->homer_ops =3D &pnv_power8_homer_ops;
> > +    homer->core_max_base =3D PNV8_CORE_MAX_BASE;
> > +}
> > +
> > +static const TypeInfo pnv_homer_power8_type_info =3D {
> > +    .name          =3D TYPE_PNV8_HOMER,
> > +    .parent        =3D TYPE_PNV_HOMER,
> > +    .instance_size =3D sizeof(PnvHomer),
> > +    .class_init    =3D pnv_homer_power8_class_init,
> > +};
> > +
> > +/* P9 Pstate table */
> > +
> > +#define PNV9_OCC_PSTATE_ID_ZERO          0xe2018
> > +#define PNV9_OCC_PSTATE_ID_ONE           0xe2020
> > +#define PNV9_OCC_PSTATE_ID_TWO           0xe2028
> > +#define PNV9_OCC_PSTATE_DATA             0xe2000
> > +#define PNV9_OCC_PSTATE_DATA_AREA        0xe2008
> > +#define PNV9_OCC_PSTATE_MIN              0xe2003
> > +#define PNV9_OCC_PSTATE_NOM              0xe2004
> > +#define PNV9_OCC_PSTATE_TURBO            0xe2005
> > +#define PNV9_OCC_PSTATE_ULTRA_TURBO      0xe2818
> > +#define PNV9_OCC_MAX_PSTATE_ULTRA_TURBO  0xe2006
> > +#define PNV9_OCC_PSTATE_MAJOR_VERSION    0xe2001
> > +#define PNV9_OCC_OPAL_RUNTIME_DATA       0xe2b85
> > +#define PNV9_CHIP_HOMER_IMAGE_POINTER    0x200008
> > +#define PNV9_CHIP_HOMER_BASE             0x0
> > +#define PNV9_OCC_PSTATE_ZERO_FREQUENCY   0xe201c
> > +#define PNV9_OCC_PSTATE_ONE_FREQUENCY    0xe2024
> > +#define PNV9_OCC_PSTATE_TWO_FREQUENCY    0xe202c
> > +#define PNV9_OCC_ROLE_MASTER_OR_SLAVE    0xe2002
> > +#define PNV9_CORE_MAX_BASE               0xe2819
> > +
> > +
> > +static uint64_t pnv_power9_homer_read(void *opaque, hwaddr addr,
> > +                                      unsigned size)
> > +{
> > +    switch (addr) {
> > +    case PNV9_OCC_MAX_PSTATE_ULTRA_TURBO:
> > +    case PNV9_OCC_PSTATE_ID_ZERO:
> > +        return 0;
> > +    case PNV9_OCC_PSTATE_DATA:
> > +    case PNV9_OCC_ROLE_MASTER_OR_SLAVE:
> > +    case PNV9_OCC_PSTATE_NOM:
> > +    case PNV9_OCC_PSTATE_TURBO:
> > +    case PNV9_OCC_PSTATE_ID_ONE:
> > +    case PNV9_OCC_PSTATE_ULTRA_TURBO:
> > +    case PNV9_OCC_OPAL_RUNTIME_DATA:
> > +        return 1;
> > +    case PNV9_OCC_PSTATE_MIN:
> > +    case PNV9_OCC_PSTATE_ID_TWO:
> > +        return 2;
> > +
> > +    /* 3000 khz frequency for 0, 1, and 2 pstates */
> > +    case PNV9_OCC_PSTATE_ZERO_FREQUENCY:
> > +    case PNV9_OCC_PSTATE_ONE_FREQUENCY:
> > +    case PNV9_OCC_PSTATE_TWO_FREQUENCY:
> > +        return 3000;
> > +    case PNV9_OCC_PSTATE_MAJOR_VERSION:
> > +        return 0x90;
> > +    case PNV9_CHIP_HOMER_BASE:
> > +    case PNV9_OCC_PSTATE_DATA_AREA:
> > +    case PNV9_CHIP_HOMER_IMAGE_POINTER:
> > +        return 0x1000000000000000;
> > +    }
> > +    /* pstate table core max array */
> > +    if (core_max_array(opaque, addr)) {
> > +        return 1;
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void pnv_power9_homer_write(void *opaque, hwaddr addr,
> > +                                   uint64_t val, unsigned size)
> > +{
> > +    /* callback function defined to homer write */
> > +    return;
> > +}
> > +
> > +static const MemoryRegionOps pnv_power9_homer_ops =3D {
> > +    .read =3D pnv_power9_homer_read,
> > +    .write =3D pnv_power9_homer_write,
> > +    .valid.min_access_size =3D 1,
> > +    .valid.max_access_size =3D 8,
> > +    .impl.min_access_size =3D 1,
> > +    .impl.max_access_size =3D 8,
> > +    .endianness =3D DEVICE_BIG_ENDIAN,
> > +};
> > +
> > +static void pnv_homer_power9_class_init(ObjectClass *klass, void *da=
ta)
> > +{
> > +    PnvHomerClass *homer =3D PNV_HOMER_CLASS(klass);
> > +
> > +    homer->homer_size =3D PNV9_HOMER_SIZE;
> > +    homer->homer_ops =3D &pnv_power9_homer_ops;
> > +    homer->core_max_base =3D PNV9_CORE_MAX_BASE;
> > +}
> > +
> > +static const TypeInfo pnv_homer_power9_type_info =3D {
> > +    .name          =3D TYPE_PNV9_HOMER,
> > +    .parent        =3D TYPE_PNV_HOMER,
> > +    .instance_size =3D sizeof(PnvHomer),
> > +    .class_init    =3D pnv_homer_power9_class_init,
> > +};
> > +
> > +static void pnv_homer_realize(DeviceState *dev, Error **errp)
> > +{
> > +    PnvHomer *homer =3D PNV_HOMER(dev);
> > +    PnvHomerClass *hmrc =3D PNV_HOMER_GET_CLASS(homer);
> > +    Object *obj;
> > +    Error *local_err =3D NULL;
> > +
> > +    obj =3D object_property_get_link(OBJECT(dev), "chip", &local_err=
);
> > +    if (!obj) {
> > +        error_propagate(errp, local_err);
> > +        error_prepend(errp, "required link 'chip' not found: ");
> > +        return;
> > +    }
> > +    homer->chip =3D PNV_CHIP(obj);
> > +    /* homer region */
> > +    memory_region_init_io(&homer->regs, OBJECT(dev),
> > +                          hmrc->homer_ops, homer, "homer-main-memory=
",
> > +                          hmrc->homer_size);
> > +}
> > +
> > +static void pnv_homer_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D pnv_homer_realize;
> > +    dc->desc =3D "PowerNV HOMER Memory";
> > +}
> > +
> > +static const TypeInfo pnv_homer_type_info =3D {
> > +    .name          =3D TYPE_PNV_HOMER,
> > +    .parent        =3D TYPE_DEVICE,
> > +    .instance_size =3D sizeof(PnvHomer),
> > +    .class_init    =3D pnv_homer_class_init,
> > +    .class_size    =3D sizeof(PnvHomerClass),
> > +    .abstract      =3D true,
> > +};
> > +
> > +static void pnv_homer_register_types(void)
> > +{
> > +    type_register_static(&pnv_homer_type_info);
> > +    type_register_static(&pnv_homer_power8_type_info);
> > +    type_register_static(&pnv_homer_power9_type_info);
> > +}
> > +
> > +type_init(pnv_homer_register_types);
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index 63a4b7b6a7..1cdbe55bf8 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -26,6 +26,7 @@
> >  #include "hw/ppc/pnv_lpc.h"
> >  #include "hw/ppc/pnv_psi.h"
> >  #include "hw/ppc/pnv_occ.h"
> > +#include "hw/ppc/pnv_homer.h"
> >  #include "hw/ppc/pnv_xive.h"
> >  #include "hw/ppc/pnv_core.h"
> > =20
> > @@ -76,6 +77,7 @@ typedef struct Pnv8Chip {
> >      PnvLpcController lpc;
> >      Pnv8Psi      psi;
> >      PnvOCC       occ;
> > +    PnvHomer     homer;
> >  } Pnv8Chip;
> > =20
> >  #define TYPE_PNV9_CHIP "pnv9-chip"
> > @@ -90,6 +92,7 @@ typedef struct Pnv9Chip {
> >      Pnv9Psi      psi;
> >      PnvLpcController lpc;
> >      PnvOCC       occ;
> > +    PnvHomer     homer;
> > =20
> >      uint32_t     nr_quads;
> >      PnvQuad      *quads;
> > diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
> > new file mode 100644
> > index 0000000000..abaec43c2d
> > --- /dev/null
> > +++ b/include/hw/ppc/pnv_homer.h
> > @@ -0,0 +1,53 @@
> > +/*
> > + * QEMU PowerPC PowerNV Emulation of a few HOMER related registers
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
> > + * License along with this library; if not, see <http://www.gnu.org/=
licenses/>.
> > + */
> > +
> > +#ifndef PPC_PNV_HOMER_H
> > +#define PPC_PNV_HOMER_H
> > +
> > +#include "hw/ppc/pnv.h"
> > +
> > +#define TYPE_PNV_HOMER "pnv-homer"
> > +#define PNV_HOMER(obj) OBJECT_CHECK(PnvHomer, (obj), TYPE_PNV_HOMER)
> > +#define TYPE_PNV8_HOMER TYPE_PNV_HOMER "-POWER8"
> > +#define PNV8_HOMER(obj) OBJECT_CHECK(PnvHomer, (obj), TYPE_PNV8_HOME=
R)
> > +#define TYPE_PNV9_HOMER TYPE_PNV_HOMER "-POWER9"
> > +#define PNV9_HOMER(obj) OBJECT_CHECK(PnvHomer, (obj), TYPE_PNV9_HOME=
R)
> > +
> > +typedef struct PnvHomer {
> > +    DeviceState parent;
> > +
> > +    struct PnvChip *chip;
> > +    MemoryRegion regs;
> > +} PnvHomer;
> > +
> > +#define PNV_HOMER_CLASS(klass)   \
> > +     OBJECT_CLASS_CHECK(PnvHomerClass, (klass), TYPE_PNV_HOMER)
> > +#define PNV_HOMER_GET_CLASS(obj) \
> > +     OBJECT_GET_CLASS(PnvHomerClass, (obj), TYPE_PNV_HOMER)
> > +
> > +typedef struct PnvHomerClass {
> > +    DeviceClass parent_class;
> > +
> > +    int homer_size;
> > +    const MemoryRegionOps *homer_ops;
> > +
> > +    hwaddr core_max_base;
> > +} PnvHomerClass;
> > +
> > +#endif /* PPC_PNV_HOMER_H */
> >=20
>=20


