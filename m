Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62391C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3731920748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3731920748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXhvr-0002fk-BA
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 03:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iXhv3-00027o-NN
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iXhv2-0000W9-CF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:34:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46276
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iXhv2-0000W2-7B
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:34:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAL8TWj8140761
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:34:26 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wdfxukmn0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:34:25 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Thu, 21 Nov 2019 08:34:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 08:34:21 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAL8YKSS25362452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 08:34:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B10655204F;
 Thu, 21 Nov 2019 08:34:20 +0000 (GMT)
Received: from dhcp-9-120-236-104.in.ibm.com (unknown [9.120.236.104])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id A10C35204E;
 Thu, 21 Nov 2019 08:34:19 +0000 (GMT)
Date: Thu, 21 Nov 2019 14:04:17 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/5] hw/ppc/pnv_xscom: PBA bar mask values are incorrect
 with homer/occ sizes
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-3-bala24@linux.ibm.com>
 <20191119215618.GU5582@umbus.fritz.box>
 <20191119220032.GV5582@umbus.fritz.box>
 <20191119220226.GW5582@umbus.fritz.box>
 <20191120030103.GA689@localhost.localdomain>
 <20191120031651.GB689@localhost.localdomain>
 <20191120085940.5c824fca@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191120085940.5c824fca@bahia.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19112108-0020-0000-0000-0000038CC2E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112108-0021-0000-0000-000021E2FB63
Message-Id: <20191121083417.GB14854@dhcp-9-120-236-104.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911210076
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id xAL8TWj8140761
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
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 08:59:40AM +0100, Greg Kurz wrote:
> On Wed, 20 Nov 2019 08:46:51 +0530
> Balamuruhan S <bala24@linux.ibm.com> wrote:
>=20
> > On Wed, Nov 20, 2019 at 08:31:03AM +0530, Balamuruhan S wrote:
> > > On Wed, Nov 20, 2019 at 09:02:26AM +1100, David Gibson wrote:
> > > > On Wed, Nov 20, 2019 at 09:00:32AM +1100, David Gibson wrote:
> > > > > On Wed, Nov 20, 2019 at 08:56:18AM +1100, David Gibson wrote:
> > > > > > On Tue, Nov 19, 2019 at 11:20:53PM +0530, Balamuruhan S wrote=
:
> > > > > > > homer/occ sizes are calculated in skiboot with `(mask | 0xf=
ffff) + 1`,
> > > > > > > and from xscom access should return correct mask values ins=
tead of actual
> > > > > > > sizes.
> > > > > > >=20
> > > > > > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > > > > > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > > > > > > ---
> > > > > > >  hw/ppc/pnv_xscom.c | 10 ++++++----
> > > > > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > > > > > > index f01d788a65..cdd5fa356e 100644
> > > > > > > --- a/hw/ppc/pnv_xscom.c
> > > > > > > +++ b/hw/ppc/pnv_xscom.c
> > > > > > > @@ -46,6 +46,10 @@
> > > > > > >  #define P9_PBA_BARMASK0                 0x5012b04
> > > > > > >  #define P9_PBA_BARMASK2                 0x5012b06
> > > > > > > =20
> > > > > > > +/* Mask to calculate Homer/Occ size */
> > > > > > > +#define HOMER_SIZE_MASK                 0x0000000000300000=
ull
> > > > > > > +#define OCC_SIZE_MASK                   0x0000000000700000=
ull
> > > > > >=20
> > > > > > Uuuhhhhh... AFAICT these defines have identical values to
> > > > > > PNV_HOMER_SIZE and PNV_OCC_COMMON_AREA_SIZE, so I don't see w=
hat this
> > > > > > patch is actually changing.
> > > > >=20
> > > > > Oh, sorry, missed that the values were changed in 1/5.  Would h=
ave
> > > > > been easier to follow if the two patches were folded together, =
but
> > > > > never mind.  Applied.
> > > >=20
> > > > Ugh.. or not.  The first patch doesn't apply for me, looks like i=
t
> > > > needs a rebase (or you have something else in your tree I don't k=
now
> > > > about).
> > >=20
> > > I checked out from upstream master (commit: 8937f17249 ) and worked=
 on
> >                                                  ^
> > 						 |
> > ignore this its my first patch commit id (1/5)----
> >=20
> > > it.
> >=20
> > upstream commit id: f086f22d6c (VFIO fixes 2019-11-18), please let me
> > know if you would like me to respin the patches after rebase with v4.=
2.0
> > rc2 release.
> >=20
>=20
> Or maybe base your patches on David's ppc-for-5.0 branch available at
> https://github.com/dgibson/qemu .

Thanks Greg, going forward I will base my patches on David's recent branc=
h for
the release.

>=20
> > -- Bala
> >=20
> > >=20
> > > -- Bala
> > > >=20
> > > > --=20
> > > > David Gibson			| I'll have my music baroque, and my code
> > > > david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the=
_ _other_
> > > > 				| _way_ _around_!
> > > > http://www.ozlabs.org/~dgibson
> > >=20
> > >=20
> > >=20
> >=20
>=20


