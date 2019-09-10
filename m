Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4832081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4832081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cW2-0001Tz-SO
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i7cUe-0000CA-KS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i7cUc-0005cy-Id
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:31:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52244
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i7cUc-0005cV-BX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:31:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8A9R8Jn016684
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 05:31:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ux6hudngs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 05:31:21 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 10 Sep 2019 10:31:19 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Sep 2019 10:31:17 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x8A9UpR238470034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2019 09:30:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 302AE42045;
 Tue, 10 Sep 2019 09:31:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A65754204B;
 Tue, 10 Sep 2019 09:31:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.221])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Sep 2019 09:31:14 +0000 (GMT)
Date: Tue, 10 Sep 2019 15:01:12 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
References: <20190910071019.16689-1-bala24@linux.ibm.com>
 <20190910071019.16689-3-bala24@linux.ibm.com>
 <e311a420-f780-10e4-99fa-53f14599a518@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e311a420-f780-10e4-99fa-53f14599a518@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19091009-0012-0000-0000-000003496ED8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091009-0013-0000-0000-00002183D258
Message-Id: <20190910093112.GA16391@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-10_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100095
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x8A9R8Jn016684
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v1 2/3] hw/ppc/pnv_occ: add sram device
 model for occ common area
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

On Tue, Sep 10, 2019 at 09:19:11AM +0200, C=E9dric Le Goater wrote:
> On 10/09/2019 09:10, Balamuruhan S wrote:
> > emulate occ common area region with occ sram device model which
> > occ and skiboot uses it to communicate regarding sensors, slw
> > and HWMON in PowerNV emulated host.
> >=20
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  hw/ppc/pnv.c             |  8 +++++
> >  hw/ppc/pnv_occ.c         | 78 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> >  include/hw/ppc/pnv_occ.h |  3 ++
> >  3 files changed, 89 insertions(+)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 3f08db7b9e..80338ffe87 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -938,6 +938,10 @@ static void pnv_chip_power8_realize(DeviceState =
*dev, Error **errp)
> >          return;
> >      }
> >      pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xs=
com_regs);
> > +
> > +    /* OCC SRAM model */
> > +    memory_region_add_subregion(get_system_memory(), PNV_OCC_COMMON_=
AREA(chip),
> > +                                &chip8->occ.sram_regs);
> >  }
> > =20
> >  static void pnv_chip_power8e_class_init(ObjectClass *klass, void *da=
ta)
> > @@ -1126,6 +1130,10 @@ static void pnv_chip_power9_realize(DeviceStat=
e *dev, Error **errp)
> >          return;
> >      }
> >      pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.x=
scom_regs);
> > +
> > +    /* OCC SRAM model */
> > +    memory_region_add_subregion(get_system_memory(), PNV9_OCC_COMMON=
_AREA(chip),
> > +                                &chip9->occ.sram_regs);
> >  }
> > =20
> >  static void pnv_chip_power9_class_init(ObjectClass *klass, void *dat=
a)
> > diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> > index 8bead2c930..785653bb67 100644
> > --- a/hw/ppc/pnv_occ.c
> > +++ b/hw/ppc/pnv_occ.c
> > @@ -30,6 +30,24 @@
> >  #define OCB_OCI_OCCMISC_AND     0x4021
> >  #define OCB_OCI_OCCMISC_OR      0x4022
> > =20
> > +/* OCC sensors */
> > +#define OCC_SENSOR_DATA_BLOCK_OFFSET          0x580000
> > +#define OCC_SENSOR_DATA_VALID                 0x580001
> > +#define OCC_SENSOR_DATA_VERSION               0x580002
> > +#define OCC_SENSOR_DATA_READING_VERSION       0x580004
> > +#define OCC_SENSOR_DATA_NR_SENSORS            0x580008
> > +#define OCC_SENSOR_DATA_NAMES_OFFSET          0x580010
> > +#define OCC_SENSOR_DATA_READING_PING_OFFSET   0x580014
> > +#define OCC_SENSOR_DATA_READING_PONG_OFFSET   0x58000c
> > +#define OCC_SENSOR_DATA_NAME_LENGTH           0x58000d
> > +#define OCC_SENSOR_NAME_STRUCTURE_TYPE        0x580023
> > +#define OCC_SENSOR_LOC_CORE                   0x580022
> > +#define OCC_SENSOR_LOC_GPU                    0x580020
> > +#define OCC_SENSOR_TYPE_POWER                 0x580003
> > +#define OCC_SENSOR_NAME                       0x580005
> > +#define HWMON_SENSORS_MASK                    0x58001e
> > +#define SLW_IMAGE_BASE                        0x0
> > +
> >  static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
> >  {
> >      bool irq_state;
> > @@ -82,6 +100,48 @@ static void pnv_occ_power8_xscom_write(void *opaq=
ue, hwaddr addr,
> >      }
> >  }
> > =20
> > +static uint64_t pnv_occ_common_area_read(void *opaque, hwaddr addr,
> > +                                         unsigned width)
> > +{
> > +    switch (addr) {
> > +    /*
> > +     * occ-sensor sanity check that asserts the sensor
> > +     * header block
> > +     */
> > +    case OCC_SENSOR_DATA_BLOCK_OFFSET:
> > +    case OCC_SENSOR_DATA_VALID:
> > +    case OCC_SENSOR_DATA_VERSION:
> > +    case OCC_SENSOR_DATA_READING_VERSION:
> > +    case OCC_SENSOR_DATA_NR_SENSORS:
> > +    case OCC_SENSOR_DATA_NAMES_OFFSET:
> > +    case OCC_SENSOR_DATA_READING_PING_OFFSET:
> > +    case OCC_SENSOR_DATA_READING_PONG_OFFSET:
> > +    case OCC_SENSOR_NAME_STRUCTURE_TYPE:
> > +        return 1;
> > +    case OCC_SENSOR_DATA_NAME_LENGTH:
> > +        return 0x30;
> > +    case OCC_SENSOR_LOC_CORE:
> > +        return 0x0040;
> > +    case OCC_SENSOR_TYPE_POWER:
> > +        return 0x0080;
> > +    case OCC_SENSOR_NAME:
> > +        return 0x1000;
> > +    case HWMON_SENSORS_MASK:
> > +    case OCC_SENSOR_LOC_GPU:
> > +        return 0x8e00;
> > +    case SLW_IMAGE_BASE:
> > +        return 0x1000000000000000;
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void pnv_occ_common_area_write(void *opaque, hwaddr addr,
> > +                                             uint64_t val, unsigned =
width)
> > +{
> > +    /* callback function defined to occ common area write */
> > +    return;
> > +}
> > +
> >  static const MemoryRegionOps pnv_occ_power8_xscom_ops =3D {
> >      .read =3D pnv_occ_power8_xscom_read,
> >      .write =3D pnv_occ_power8_xscom_write,
> > @@ -92,12 +152,24 @@ static const MemoryRegionOps pnv_occ_power8_xsco=
m_ops =3D {
> >      .endianness =3D DEVICE_BIG_ENDIAN,
> >  };
> > =20
> > +const MemoryRegionOps pnv_occ_sram_ops =3D {
> > +    .read =3D pnv_occ_common_area_read,
> > +    .write =3D pnv_occ_common_area_write,
> > +    .valid.min_access_size =3D 1,
> > +    .valid.max_access_size =3D 8,
> > +    .impl.min_access_size =3D 1,
> > +    .impl.max_access_size =3D 8,
> > +    .endianness =3D DEVICE_BIG_ENDIAN,
> > +};
> > +
> >  static void pnv_occ_power8_class_init(ObjectClass *klass, void *data=
)
> >  {
> >      PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
> > =20
> >      poc->xscom_size =3D PNV_XSCOM_OCC_SIZE;
> > +    poc->sram_size =3D PNV_OCC_COMMON_AREA_SIZE;
> >      poc->xscom_ops =3D &pnv_occ_power8_xscom_ops;
> > +    poc->sram_ops =3D &pnv_occ_sram_ops;
> >      poc->psi_irq =3D PSIHB_IRQ_OCC;
> >  }
> > =20
> > @@ -168,7 +240,9 @@ static void pnv_occ_power9_class_init(ObjectClass=
 *klass, void *data)
> >      PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
> > =20
> >      poc->xscom_size =3D PNV9_XSCOM_OCC_SIZE;
> > +    poc->sram_size =3D PNV9_OCC_COMMON_AREA_SIZE;
> >      poc->xscom_ops =3D &pnv_occ_power9_xscom_ops;
> > +    poc->sram_ops =3D &pnv_occ_sram_ops;
> >      poc->psi_irq =3D PSIHB9_IRQ_OCC;
> >  }
> > =20
>=20
> do we plan to have different OCC SRAM operation per chip model ?=20

Cedric, currently I did just tried to handle OCC SRAM access during
boot time and returns skiboot expected default values. I could observe
that P8 does 1 access only for slw image base address, so can we extend
it with per chip model in future ?

-- Bala
>=20
> C. =20
>=20
> > @@ -199,6 +273,10 @@ static void pnv_occ_realize(DeviceState *dev, Er=
ror **errp)
> >      /* XScom region for OCC registers */
> >      pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), poc->xscom_=
ops,
> >                            occ, "xscom-occ", poc->xscom_size);
> > +
> > +    /* XScom region for OCC SRAM registers */
> > +    pnv_xscom_region_init(&occ->sram_regs, OBJECT(dev), poc->sram_op=
s,
> > +                          occ, "occ-common-area", poc->sram_size);
> >  }
> > =20
> >  static void pnv_occ_class_init(ObjectClass *klass, void *data)
> > diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
> > index ed0709bfc0..66b0989be6 100644
> > --- a/include/hw/ppc/pnv_occ.h
> > +++ b/include/hw/ppc/pnv_occ.h
> > @@ -38,6 +38,7 @@ typedef struct PnvOCC {
> >      PnvPsi *psi;
> > =20
> >      MemoryRegion xscom_regs;
> > +    MemoryRegion sram_regs;
> >  } PnvOCC;
> > =20
> >  #define PNV_OCC_CLASS(klass) \
> > @@ -49,7 +50,9 @@ typedef struct PnvOCCClass {
> >      DeviceClass parent_class;
> > =20
> >      int xscom_size;
> > +    int sram_size;
> >      const MemoryRegionOps *xscom_ops;
> > +    const MemoryRegionOps *sram_ops;
> >      int psi_irq;
> >  } PnvOCCClass;
> > =20
> >=20
>=20


