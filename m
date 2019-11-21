Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3EFC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827572089D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827572089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXiAO-00015S-L9
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 03:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iXi9l-0000YA-IS
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iXi9k-0005pE-FX
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:49:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iXi9k-0005ne-88
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:49:40 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAL8iGFR101549
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:49:37 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf730368-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:49:37 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Thu, 21 Nov 2019 08:49:35 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 08:49:31 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAL8nU0r20447482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 08:49:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C236B11C05B;
 Thu, 21 Nov 2019 08:49:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F2DD11C050;
 Thu, 21 Nov 2019 08:49:29 +0000 (GMT)
Received: from dhcp-9-120-236-104.in.ibm.com (unknown [9.120.236.104])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 21 Nov 2019 08:49:29 +0000 (GMT)
Date: Thu, 21 Nov 2019 14:19:26 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 4/5] hw/ppc/pnv_xscom: occ common area to be mapped only
 once
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-5-bala24@linux.ibm.com>
 <b180f87b-f713-3843-bfc4-fff316b3510d@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b180f87b-f713-3843-bfc4-fff316b3510d@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19112108-0016-0000-0000-000002CA3BFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112108-0017-0000-0000-0000332C006A
Message-Id: <20191121084926.GE14854@dhcp-9-120-236-104.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_01:2019-11-20,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=3
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210077
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xAL8iGFR101549
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

On Wed, Nov 20, 2019 at 08:30:03AM +0100, C=E9dric Le Goater wrote:
> On 19/11/2019 18:50, Balamuruhan S wrote:
> > occ common area should be mapped once=20
>=20
> It's the same address on each chip.=20
>=20
> the question is how the HW knows from which chip the OCC access is=20
> being done ? How does it target the correct OCC if the address is=20
> the same ?=20

I am not aware of it for now to answer/comment, will try to find
it.

>=20
> > and disable it for every other chip.
>=20
> On P8 OpenPOWER systems, the PBA3 registers are still set, not on
> tuletas though (different hostboot I suppose). On OpenPOWER systems,
> they are still set also.

Will have to do some study on skiboot.

> =20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> nah. I didn't write any of this :)=20
>=20
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  hw/ppc/pnv_xscom.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > index cb6d6bbcfc..f797a5ec7d 100644
> > --- a/hw/ppc/pnv_xscom.c
> > +++ b/hw/ppc/pnv_xscom.c
> > @@ -98,13 +98,22 @@ static uint64_t xscom_read_default(PnvChip *chip,=
 uint32_t pcba)
> >          return HOMER_SIZE_MASK;
> > =20
> >      case P9_PBA_BAR2: /* P9 occ common area */
> > -        return PNV9_OCC_COMMON_AREA(chip);
> > +        if (!PNV_CHIP_INDEX(chip)) {
>=20
> Yes that it is the idea. XIVE uses directly 'chip->chip_id'.=20

:)

>=20
>=20
> > +            return PNV9_OCC_COMMON_AREA(chip);
> > +        }
> > +        return 0;
> >      case P8_PBA_BAR3: /* P8 occ common area */
> > -        return PNV_OCC_COMMON_AREA(chip);
> > +        if (!PNV_CHIP_INDEX(chip)) {
> > +            return PNV_OCC_COMMON_AREA(chip);
> > +        }
> > +        return 0;
> > =20
> >      case P9_PBA_BARMASK2: /* P9 occ common area size */
> >      case P8_PBA_BARMASK3: /* P8 occ common area size */
> > -        return OCC_SIZE_MASK;
> > +        if (!PNV_CHIP_INDEX(chip)) {
> > +            return OCC_SIZE_MASK;
> > +        }
> > +        return 0;
> > =20
> >      case 0x1010c00:     /* PIBAM FIR */
> >      case 0x1010c03:     /* PIBAM FIR MASK */
> >=20
>=20


