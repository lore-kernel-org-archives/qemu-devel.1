Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC1CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E440B20718
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E440B20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXhuY-0001ab-29
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 03:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iXhtK-0000hC-O5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iXhtJ-00006v-DO
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:32:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iXhtJ-00006Y-5m
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:32:41 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAL8TYi7139708
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:32:38 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf5rppt3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:32:38 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Thu, 21 Nov 2019 08:32:36 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 08:32:32 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAL8WW3750397376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 08:32:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F259052054;
 Thu, 21 Nov 2019 08:32:31 +0000 (GMT)
Received: from dhcp-9-120-236-104.in.ibm.com (unknown [9.120.236.104])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 9015D5204F;
 Thu, 21 Nov 2019 08:32:30 +0000 (GMT)
Date: Thu, 21 Nov 2019 14:02:28 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/5] hw/ppc/pnv: incorrect homer and occ common area size
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-2-bala24@linux.ibm.com>
 <15b1557e-4bb4-434e-2554-99cd475150a4@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <15b1557e-4bb4-434e-2554-99cd475150a4@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19112108-0012-0000-0000-0000036A3434
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112108-0013-0000-0000-000021A5C776
Message-Id: <20191121083228.GA14854@dhcp-9-120-236-104.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=3 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210076
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xAL8TYi7139708
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 08:13:50AM +0100, C=E9dric Le Goater wrote:
> On 19/11/2019 18:50, Balamuruhan S wrote:
> > Homer size is 4MB and OCC common area size is 8MB, but currently
> > it is assigned with bar mask value. Also pass on the occ sram
> > size 3 bits right shifted to initialize the size appropriately.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  hw/ppc/pnv_occ.c     | 2 +-
> >  include/hw/ppc/pnv.h | 8 ++++----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> > index 785653bb67..05c51c9de0 100644
> > --- a/hw/ppc/pnv_occ.c
> > +++ b/hw/ppc/pnv_occ.c
> > @@ -276,7 +276,7 @@ static void pnv_occ_realize(DeviceState *dev, Err=
or **errp)
> > =20
> >      /* XScom region for OCC SRAM registers */
> >      pnv_xscom_region_init(&occ->sram_regs, OBJECT(dev), poc->sram_op=
s,
> > -                          occ, "occ-common-area", poc->sram_size);
> > +                          occ, "occ-common-area", poc->sram_size >> =
3);
>=20
> the OCC common area seems to be accessed through MMIO also. Not only XS=
COM.
>=20
> In skiboot  :=20
>=20
>     bool occ_sensors_init(void)
>     {
>         ...
> 	occ_sensor_base =3D chip->occ_common_base + OCC_SENSOR_DATA_BLOCK_OFFS=
ET;
>         ...
>     }
>=20
> OCC would need two regions. One for the XSCOM access and one for the MM=
IO.
>=20
> >  }

Okay, I will follow it.

> > =20
> >  static void pnv_occ_class_init(ObjectClass *klass, void *data)
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index 0b4c722e6b..e9ed8b928a 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -203,12 +203,12 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
> >  #define PNV_XSCOM_BASE(chip)                                        =
    \
> >      (0x0003fc0000000000ull + ((uint64_t)(chip)->chip_id) * PNV_XSCOM=
_SIZE)
> > =20
> > -#define PNV_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
> > +#define PNV_OCC_COMMON_AREA_SIZE    0x0000000000800000ull
>=20
> ok. These are the BAR sizes. Can we deduce the barmask from the size ?=20

Correct! we can do that, will make the respective change.

>=20
>=20
> >  #define PNV_OCC_COMMON_AREA(chip)                                   =
    \
> >      (0x7fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
> >                           PNV_OCC_COMMON_AREA_SIZE))
> > =20
> > -#define PNV_HOMER_SIZE              0x0000000000300000ull
> > +#define PNV_HOMER_SIZE              0x0000000000400000ull
> >  #define PNV_HOMER_BASE(chip)                                        =
    \
> >      (0x7ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_HOMER_=
SIZE)
> > =20
> > @@ -271,12 +271,12 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
> >  #define PNV9_XSCOM_SIZE              0x0000000400000000ull
> >  #define PNV9_XSCOM_BASE(chip)        PNV9_CHIP_BASE(chip, 0x00603fc0=
0000000ull)
> > =20
> > -#define PNV9_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
> > +#define PNV9_OCC_COMMON_AREA_SIZE    0x0000000000800000ull
> >  #define PNV9_OCC_COMMON_AREA(chip)                                  =
    \
> >      (0x203fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
> >                             PNV9_OCC_COMMON_AREA_SIZE))
> > =20
> > -#define PNV9_HOMER_SIZE              0x0000000000300000ull
> > +#define PNV9_HOMER_SIZE              0x0000000000400000ull
> >  #define PNV9_HOMER_BASE(chip)                                       =
    \
> >      (0x203ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV9_HOM=
ER_SIZE)
> >  #endif /* PPC_PNV_H */
> >=20
>=20


