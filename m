Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4596EC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3C621E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3C621E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIwE-0005Vb-Fb
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40202)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hvIvm-00054z-Kf
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hvIvl-0002oc-CF
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:12:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hvIvl-0002ns-1Y
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:12:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x77ACPu4029513
 for <qemu-devel@nongnu.org>; Wed, 7 Aug 2019 06:12:27 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u7v2q9g8c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:12:26 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 7 Aug 2019 11:12:21 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Aug 2019 11:12:18 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x77ACHCF58196128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 10:12:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD5B2A4057;
 Wed,  7 Aug 2019 10:12:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6425EA404D;
 Wed,  7 Aug 2019 10:12:16 +0000 (GMT)
Received: from dhcp-9-109-247-185.in.ibm.com (unknown [9.124.35.43])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Aug 2019 10:12:16 +0000 (GMT)
Date: Wed, 7 Aug 2019 15:42:14 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-5-bala24@linux.ibm.com>
 <555de06b-a959-76ce-ee89-05c4b7cab25a@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <555de06b-a959-76ce-ee89-05c4b7cab25a@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19080710-0028-0000-0000-0000038C8614
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080710-0029-0000-0000-0000244CEA5B
Message-Id: <20190807101214.GB10532@dhcp-9-109-247-185.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070112
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x77ACPu4029513
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] hw/ppc/pnv: initialize and realize
 homer/occ common area
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
Cc: hari@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 maddy@linux.vnet.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 09:59:26AM +0200, C=E9dric Le Goater wrote:
> On 07/08/2019 09:14, Balamuruhan S wrote:
> > homer and occ common area region base address are initialized
> > to create device tree and realized to map the address with
> > mmio callbacks during `pnv_chip_realize()`.
> >=20
> > `SysBusNum` enum is introduced to set sysbus for XSCOM, ICP,
> > HOMER and OCC appropriately and chip_num to initialize and
> > retrieve base address + size contiguously on a PowerNV with
> > multichip boot.
>=20
> Can't you use the chip_id ?=20

if the chip_id is contiguous always we can use it. I was not
sure about it.

>=20
> >=20
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  hw/ppc/pnv.c         | 49 ++++++++++++++++++++++++++++++++++++++++++=
+++----
> >  include/hw/ppc/pnv.h |  1 +
> >  2 files changed, 46 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index bd4531c822..f6e56e915d 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -675,6 +675,7 @@ static void pnv_init(MachineState *machine)
> >          Object *chip =3D object_new(chip_typename);
> > =20
> >          pnv->chips[i] =3D PNV_CHIP(chip);
> > +        PNV_CHIP(chip)->chip_num =3D i;
> >
> >          /* TODO: put all the memory in one node on chip 0 until we f=
ind a
> >           * way to specify different ranges for each chip
> > @@ -824,18 +825,20 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip=
8, Error **errp)
> >   {
> >      PnvChip *chip =3D PNV_CHIP(chip8);
> >      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(chip);
> >      const char *typename =3D pnv_chip_core_typename(chip);
> >      size_t typesize =3D object_type_get_instance_size(typename);
> >      int i, j;
> >      char *name;
> >      XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
> > =20
> > +    sbd->num_mmio =3D PNV_ICP_SYSBUS;
>=20
> OK. I think I know why you want this but it probably means that you nee=
d=20
> a new PnvHomer model and that you should use PnvOCC instead.=20

okay, I will have to work on it.

>=20
> >      name =3D g_strdup_printf("icp-%x", chip->chip_id);
> >      memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP=
_SIZE);
> > -    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip8->icp_mmio);
> > +    sysbus_init_mmio(sbd, &chip8->icp_mmio);
> >      g_free(name);
> > =20
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
> > +    sysbus_mmio_map(sbd, PNV_ICP_SYSBUS, PNV_ICP_BASE(chip));
> > =20
> >      /* Map the ICP registers for each thread */
> >      for (i =3D 0; i < chip->nr_cores; i++) {
> > @@ -866,7 +869,26 @@ static void pnv_chip_power8_realize(DeviceState =
*dev, Error **errp)
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_XSCOM_SYSBUS,
> > +                                   PNV_XSCOM_BASE(chip));
> > +
> > +    /* homer */
> > +    pnv_homer_realize(chip, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_HOMER_SYSBUS,
> > +                    PNV_HOMER_BASE(chip));
> > +    /* occ common area */
> > +    pnv_occ_common_area_realize(chip, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_OCC_COMMON_AREA_SYSBUS=
,
> > +                    PNV_OCC_COMMON_AREA(chip));
> > =20
> >      pcc->parent_realize(dev, &local_err);
> >      if (local_err) {
> > @@ -1035,7 +1057,26 @@ static void pnv_chip_power9_realize(DeviceStat=
e *dev, Error **errp)
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV9_XSCOM_BASE(chip));
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_XSCOM_SYSBUS,
> > +                    PNV9_XSCOM_BASE(chip));
> > +
> > +    /* homer */
> > +    pnv_homer_realize(chip, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_HOMER_SYSBUS,
> > +                    PNV9_HOMER_BASE(chip));
> > +
> > +    /* occ common area */
> > +    pnv_occ_common_area_realize(chip, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_OCC_COMMON_AREA_SYSBUS=
,
> > +                    PNV9_OCC_COMMON_AREA(chip));
> > =20
> >      pcc->parent_realize(dev, &local_err);
> >      if (local_err) {
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index 6464e32892..dea6772988 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -57,6 +57,7 @@ typedef struct PnvChip {
> > =20
> >      /*< public >*/
> >      uint32_t     chip_id;
> > +    uint32_t     chip_num;
> >      uint64_t     ram_start;
> >      uint64_t     ram_size;
> > =20
> >=20
>=20


