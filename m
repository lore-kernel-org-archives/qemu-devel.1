Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEE5C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F00220872
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F00220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXhyY-00045K-I7
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 03:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iXhxs-0003b3-AV
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iXhxr-0001dj-1o
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:37:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41256
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iXhxq-0001cj-TT
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:37:23 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAL8TVoa140707
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:37:21 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wdfxukqeg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:37:21 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Thu, 21 Nov 2019 08:37:19 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 08:37:17 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAL8bGwn53477502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 08:37:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DBEE4C044;
 Thu, 21 Nov 2019 08:37:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B79D4C046;
 Thu, 21 Nov 2019 08:37:15 +0000 (GMT)
Received: from dhcp-9-120-236-104.in.ibm.com (unknown [9.120.236.104])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 21 Nov 2019 08:37:14 +0000 (GMT)
Date: Thu, 21 Nov 2019 14:07:12 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/5] hw/ppc/pnv_xscom: PBA bar mask values are incorrect
 with homer/occ sizes
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-3-bala24@linux.ibm.com>
 <c3d41780-70fb-0088-3458-ef8db48ff7c9@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c3d41780-70fb-0088-3458-ef8db48ff7c9@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19112108-4275-0000-0000-000003844E9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112108-4276-0000-0000-00003897CAFC
Message-Id: <20191121083712.GC14854@dhcp-9-120-236-104.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=3 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911210076
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id xAL8TVoa140707
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

On Wed, Nov 20, 2019 at 08:18:38AM +0100, C=E9dric Le Goater wrote:
> On 19/11/2019 18:50, Balamuruhan S wrote:
> > homer/occ sizes are calculated in skiboot with `(mask | 0xfffff) + 1`=
,
> > and from xscom access should return correct mask values instead of ac=
tual
> > sizes.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  hw/ppc/pnv_xscom.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > index f01d788a65..cdd5fa356e 100644
> > --- a/hw/ppc/pnv_xscom.c
> > +++ b/hw/ppc/pnv_xscom.c
> > @@ -46,6 +46,10 @@
> >  #define P9_PBA_BARMASK0                 0x5012b04
> >  #define P9_PBA_BARMASK2                 0x5012b06
> > =20
> > +/* Mask to calculate Homer/Occ size */
> > +#define HOMER_SIZE_MASK                 0x0000000000300000ull
> > +#define OCC_SIZE_MASK                   0x0000000000700000ull
> > +
>=20
> Can't we deduce these values from the size ?=20

yes, that's a better way.

>=20
> >  static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
> >  {
> >      /*
> > @@ -90,9 +94,8 @@ static uint64_t xscom_read_default(PnvChip *chip, u=
int32_t pcba)
> >          return PNV_HOMER_BASE(chip);
> > =20
> >      case P9_PBA_BARMASK0: /* P9 homer region size */
> > -        return PNV9_HOMER_SIZE;
> >      case P8_PBA_BARMASK0: /* P8 homer region size */
> > -        return PNV_HOMER_SIZE;
> > +        return HOMER_SIZE_MASK;
>=20
> I would prefer to move all the HOMER accesses in a XSCOM region
> under the PnvHomer model than expanding the default handlers.=20
> You will need a different set of handlers for P8 and P9 and a=20
> different mapping address also.=20
>=20
> Could you do that please ?=20

Sure Cedric, I can work on it.

>  =20
> >      case P9_PBA_BAR2: /* P9 occ common area */
> >          return PNV9_OCC_COMMON_AREA(chip);
> > @@ -100,9 +103,8 @@ static uint64_t xscom_read_default(PnvChip *chip,=
 uint32_t pcba)
> >          return PNV_OCC_COMMON_AREA(chip);
> > =20
> >      case P9_PBA_BARMASK2: /* P9 occ common area size */
> > -        return PNV9_OCC_COMMON_AREA_SIZE;
> >      case P8_PBA_BARMASK2: /* P8 occ common area size */
>=20
> Shouldn't that be PBA_*3 under P8 ?=20

:( It's a miss from me. Thanks!

>=20
> C.=20
>=20
> > -        return PNV_OCC_COMMON_AREA_SIZE;
> > +        return OCC_SIZE_MASK;
> > =20
> >      case 0x1010c00:     /* PIBAM FIR */
> >      case 0x1010c03:     /* PIBAM FIR MASK */
> >=20
>=20


