Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C327C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B8A20855
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B8A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXiC8-0002Df-1w
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 03:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iXiB2-0001dU-TB
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iXiB1-0006je-QJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:51:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21876
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iXiB1-0006iN-LZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:50:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAL8i0tH117725
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:50:58 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wdhwr99by-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:50:58 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Thu, 21 Nov 2019 08:50:55 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 08:50:51 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAL8opkH61341722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 08:50:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00A26A4051;
 Thu, 21 Nov 2019 08:50:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83294A4040;
 Thu, 21 Nov 2019 08:50:49 +0000 (GMT)
Received: from dhcp-9-120-236-104.in.ibm.com (unknown [9.120.236.104])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 21 Nov 2019 08:50:49 +0000 (GMT)
Date: Thu, 21 Nov 2019 14:20:46 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 5/5] hw/ppc/pnv_xscom: add PBA BARs for Power8 slw image
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-6-bala24@linux.ibm.com>
 <9ad3aae4-1164-74aa-9e35-3a0a4d701d51@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9ad3aae4-1164-74aa-9e35-3a0a4d701d51@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19112108-0012-0000-0000-0000036A371D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112108-0013-0000-0000-000021A5CA72
Message-Id: <20191121085046.GF14854@dhcp-9-120-236-104.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_01:2019-11-20,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 suspectscore=3 impostorscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210077
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id xAL8i0tH117725
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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

On Wed, Nov 20, 2019 at 08:31:50AM +0100, C=E9dric Le Goater wrote:
> On 19/11/2019 18:50, Balamuruhan S wrote:
> > slw base and size mask are accessed during boot in homer_init_chip(),
> > so include BAR2 and BARMASK2 for Power8.
> >=20
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  hw/ppc/pnv_xscom.c   | 10 ++++++++--
> >  include/hw/ppc/pnv.h |  4 ++++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > index f797a5ec7d..828a2e2a5a 100644
> > --- a/hw/ppc/pnv_xscom.c
> > +++ b/hw/ppc/pnv_xscom.c
> > @@ -38,8 +38,10 @@
> > =20
> >  /* PBA BARs */
> >  #define P8_PBA_BAR0                     0x2013f00
> > +#define P8_PBA_BAR2                     0x2013f02
> >  #define P8_PBA_BAR3                     0x2013f03
> >  #define P8_PBA_BARMASK0                 0x2013f04
> > +#define P8_PBA_BARMASK2                 0x2013f06
>=20
> and you add the definitions back ! :)

will make it clean.

>=20
> >  #define P8_PBA_BARMASK3                 0x2013f07
> >  #define P9_PBA_BAR0                     0x5012b00
> >  #define P9_PBA_BAR2                     0x5012b02
> > @@ -49,6 +51,7 @@
> >  /* Mask to calculate Homer/Occ size */
> >  #define HOMER_SIZE_MASK                 0x0000000000300000ull
> >  #define OCC_SIZE_MASK                   0x0000000000700000ull
> > +#define SLW_SIZE_MASK                   0x0
> > =20
> >  static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
> >  {
> > @@ -115,6 +118,11 @@ static uint64_t xscom_read_default(PnvChip *chip=
, uint32_t pcba)
> >          }
> >          return 0;
> > =20
> > +    case P8_PBA_BAR2: /* P8 slw image */
> > +        return PNV_SLW_IMAGE_BASE(chip);
> > +    case P8_PBA_BARMASK2: /* P8 slw image size is 1MB and mask is ze=
ro*/
> > +        return SLW_SIZE_MASK;
>=20
> We need a HOMER XSCOM region.

okay.

>=20
> > +
> >      case 0x1010c00:     /* PIBAM FIR */
> >      case 0x1010c03:     /* PIBAM FIR MASK */
> > =20
> > @@ -135,9 +143,7 @@ static uint64_t xscom_read_default(PnvChip *chip,=
 uint32_t pcba)
> >      case 0x202000f:     /* ADU stuff, receive status register*/
> >          return 0;
> >      case 0x2013f01:     /* PBA stuff */
> > -    case 0x2013f02:     /* PBA stuff */
> >      case 0x2013f05:     /* PBA stuff */
> > -    case 0x2013f06:     /* PBA stuff */
> >          return 0;
> >      case 0x2013028:     /* CAPP stuff */
> >      case 0x201302a:     /* CAPP stuff */
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index e9ed8b928a..bd22dbf8a9 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -212,6 +212,10 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
> >  #define PNV_HOMER_BASE(chip)                                        =
    \
> >      (0x7ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_HOMER_=
SIZE)
> > =20
> > +#define PNV_SLW_SIZE                0x0000000000100000ull
> > +#define PNV_SLW_IMAGE_BASE(chip)                                    =
    \
> > +    (0x2ffda00000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_SLW_SI=
ZE)
> > +
> > =20
> >  /*
> >   * XSCOM 0x20109CA defines the ICP BAR:
> >=20
>=20


