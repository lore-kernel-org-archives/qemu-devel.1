Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0F8C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C073C21E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C073C21E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvJ6l-0005Fw-3X
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43144)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hvJ62-0004MM-9D
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hvJ61-0001CK-7X
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:23:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23940
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hvJ61-0001BH-2u
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:23:05 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x77AM5C5038487
 for <qemu-devel@nongnu.org>; Wed, 7 Aug 2019 06:23:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2u7v58hxaq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:23:02 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 7 Aug 2019 11:23:01 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Aug 2019 11:22:58 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x77AMvNe35455470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 10:22:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57F3411C04A;
 Wed,  7 Aug 2019 10:22:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0784F11C050;
 Wed,  7 Aug 2019 10:22:56 +0000 (GMT)
Received: from dhcp-9-109-247-185.in.ibm.com (unknown [9.124.35.43])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Aug 2019 10:22:55 +0000 (GMT)
Date: Wed, 7 Aug 2019 15:52:53 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-6-bala24@linux.ibm.com>
 <a2f067c4-d1a7-e729-baa6-dc4f31a8b882@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a2f067c4-d1a7-e729-baa6-dc4f31a8b882@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19080710-0016-0000-0000-0000029B2149
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080710-0017-0000-0000-000032FA32F8
Message-Id: <20190807102253.GD10532@dhcp-9-109-247-185.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070114
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x77AM5C5038487
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] hw/ppc/pnv_xscom: retrieve
 homer/occ base address from PBA BARs
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

On Wed, Aug 07, 2019 at 10:01:58AM +0200, C=E9dric Le Goater wrote:
> On 07/08/2019 09:14, Balamuruhan S wrote:
> > During PowerNV boot skiboot populates the device tree by retrieving
> > base address of homer/occ common area from PBA BARs and prd ipoll
> > mask by accessing xscom read/write accesses.
>=20
> This looks good. If you could add defines it would be better.

sure.

>=20
> Our common XSCOM ops is starting to be a bit messy. May we should think
> about introducing one for P9 and one for P8.

yes, point taken.

Thanks Cedric.
>=20
> Thanks,
>=20
> C.=20
>=20
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  hw/ppc/pnv_xscom.c | 27 +++++++++++++++++++++++----
> >  1 file changed, 23 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > index 5d5b5e9884..18a780bcdf 100644
> > --- a/hw/ppc/pnv_xscom.c
> > +++ b/hw/ppc/pnv_xscom.c
> > @@ -77,6 +77,29 @@ static uint64_t xscom_read_default(PnvChip *chip, =
uint32_t pcba)
> >      case 0x18002:       /* ECID2 */
> >          return 0;
> > =20
> > +    /* PBA BAR0 */
> > +    case 0x5012b00: /* P9 homer base address */
> > +        return PNV9_HOMER_BASE(chip);
> > +    case 0x2013f00: /* P8 homer base address */
> > +        return PNV_HOMER_BASE(chip);
> > +
> > +    /* PBA BARMASK0 */
> > +    case 0x5012b04: /* P9 homer region size */
> > +    case 0x2013f04: /* P8 homer region size */
> > +        return PNV_HOMER_SIZE;
> > +
> > +    /* PBA BAR2 */
> > +    case 0x5012b02: /* P9 occ common area */
> > +        return PNV9_OCC_COMMON_AREA(chip);
> > +    case 0x2013f02: /* P8 occ common area */
> > +        return PNV_OCC_COMMON_AREA(chip);
> > +
> > +    /* PBA BARMASK2 */
> > +    case 0x5012b06: /* P9 occ common area size */
> > +    case 0x2013f06: /* P8 occ common area size */
> > +        return PNV_OCC_COMMON_AREA_SIZE;
> > +
> > +
> >      case 0x1010c00:     /* PIBAM FIR */
> >      case 0x1010c03:     /* PIBAM FIR MASK */
> > =20
> > @@ -96,13 +119,9 @@ static uint64_t xscom_read_default(PnvChip *chip,=
 uint32_t pcba)
> >      case 0x2020009:     /* ADU stuff, error register */
> >      case 0x202000f:     /* ADU stuff, receive status register*/
> >          return 0;
> > -    case 0x2013f00:     /* PBA stuff */
> >      case 0x2013f01:     /* PBA stuff */
> > -    case 0x2013f02:     /* PBA stuff */
> >      case 0x2013f03:     /* PBA stuff */
> > -    case 0x2013f04:     /* PBA stuff */
> >      case 0x2013f05:     /* PBA stuff */
> > -    case 0x2013f06:     /* PBA stuff */
> >      case 0x2013f07:     /* PBA stuff */
> >          return 0;
> >      case 0x2013028:     /* CAPP stuff */
> >=20
>=20


