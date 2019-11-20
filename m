Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D262C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1024420885
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1024420885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXGW3-0001ID-8l
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 22:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iXGUY-0000iZ-2t
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iXGUU-0001UP-UL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:17:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iXGUS-0001Iy-50
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:17:13 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAK38bwt103864
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 22:17:02 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcencxhwd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 22:17:01 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 20 Nov 2019 03:16:59 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Nov 2019 03:16:56 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAK3Gtpc60948518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 03:16:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AAB14205E;
 Wed, 20 Nov 2019 03:16:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E483142042;
 Wed, 20 Nov 2019 03:16:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.42.238])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 20 Nov 2019 03:16:53 +0000 (GMT)
Date: Wed, 20 Nov 2019 08:46:51 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/5] hw/ppc/pnv_xscom: PBA bar mask values are incorrect
 with homer/occ sizes
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-3-bala24@linux.ibm.com>
 <20191119215618.GU5582@umbus.fritz.box>
 <20191119220032.GV5582@umbus.fritz.box>
 <20191119220226.GW5582@umbus.fritz.box>
 <20191120030103.GA689@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191120030103.GA689@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19112003-0008-0000-0000-0000033497C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112003-0009-0000-0000-00004A53B907
Message-Id: <20191120031651.GB689@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_08:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200028
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xAK38bwt103864
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
Cc: clg@kaod.org, qemu-ppc@nongnu.org, groug@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 08:31:03AM +0530, Balamuruhan S wrote:
> On Wed, Nov 20, 2019 at 09:02:26AM +1100, David Gibson wrote:
> > On Wed, Nov 20, 2019 at 09:00:32AM +1100, David Gibson wrote:
> > > On Wed, Nov 20, 2019 at 08:56:18AM +1100, David Gibson wrote:
> > > > On Tue, Nov 19, 2019 at 11:20:53PM +0530, Balamuruhan S wrote:
> > > > > homer/occ sizes are calculated in skiboot with `(mask | 0xfffff=
) + 1`,
> > > > > and from xscom access should return correct mask values instead=
 of actual
> > > > > sizes.
> > > > >=20
> > > > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > > > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > > > > ---
> > > > >  hw/ppc/pnv_xscom.c | 10 ++++++----
> > > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > > > > index f01d788a65..cdd5fa356e 100644
> > > > > --- a/hw/ppc/pnv_xscom.c
> > > > > +++ b/hw/ppc/pnv_xscom.c
> > > > > @@ -46,6 +46,10 @@
> > > > >  #define P9_PBA_BARMASK0                 0x5012b04
> > > > >  #define P9_PBA_BARMASK2                 0x5012b06
> > > > > =20
> > > > > +/* Mask to calculate Homer/Occ size */
> > > > > +#define HOMER_SIZE_MASK                 0x0000000000300000ull
> > > > > +#define OCC_SIZE_MASK                   0x0000000000700000ull
> > > >=20
> > > > Uuuhhhhh... AFAICT these defines have identical values to
> > > > PNV_HOMER_SIZE and PNV_OCC_COMMON_AREA_SIZE, so I don't see what =
this
> > > > patch is actually changing.
> > >=20
> > > Oh, sorry, missed that the values were changed in 1/5.  Would have
> > > been easier to follow if the two patches were folded together, but
> > > never mind.  Applied.
> >=20
> > Ugh.. or not.  The first patch doesn't apply for me, looks like it
> > needs a rebase (or you have something else in your tree I don't know
> > about).
>=20
> I checked out from upstream master (commit: 8937f17249 ) and worked on
                                                 ^
						 |
ignore this its my first patch commit id (1/5)----

> it.

upstream commit id: f086f22d6c (VFIO fixes 2019-11-18), please let me
know if you would like me to respin the patches after rebase with v4.2.0
rc2 release.

-- Bala

>=20
> -- Bala
> >=20
> > --=20
> > David Gibson			| I'll have my music baroque, and my code
> > david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _o=
ther_
> > 				| _way_ _around_!
> > http://www.ozlabs.org/~dgibson
>=20
>=20
>=20


