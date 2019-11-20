Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BE7C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6937222449
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6937222449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXGGL-0006C3-Sx
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 22:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iXGF8-0005Ng-Hd
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iXGF6-0008T2-32
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:01:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iXGF4-0008Qe-1M
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:01:18 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAK2v4DU111204
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 22:01:17 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wact7qhbm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 22:01:15 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 20 Nov 2019 03:01:10 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Nov 2019 03:01:08 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAK317AK44106042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 03:01:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11D3CA4065;
 Wed, 20 Nov 2019 03:01:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF25CA4067;
 Wed, 20 Nov 2019 03:01:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.42.238])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 20 Nov 2019 03:01:05 +0000 (GMT)
Date: Wed, 20 Nov 2019 08:31:03 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/5] hw/ppc/pnv_xscom: PBA bar mask values are incorrect
 with homer/occ sizes
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-3-bala24@linux.ibm.com>
 <20191119215618.GU5582@umbus.fritz.box>
 <20191119220032.GV5582@umbus.fritz.box>
 <20191119220226.GW5582@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191119220226.GW5582@umbus.fritz.box>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19112003-0012-0000-0000-000003693653
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112003-0013-0000-0000-000021A4C2CB
Message-Id: <20191120030103.GA689@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_08:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911200026
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xAK2v4DU111204
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 09:02:26AM +1100, David Gibson wrote:
> On Wed, Nov 20, 2019 at 09:00:32AM +1100, David Gibson wrote:
> > On Wed, Nov 20, 2019 at 08:56:18AM +1100, David Gibson wrote:
> > > On Tue, Nov 19, 2019 at 11:20:53PM +0530, Balamuruhan S wrote:
> > > > homer/occ sizes are calculated in skiboot with `(mask | 0xfffff) =
+ 1`,
> > > > and from xscom access should return correct mask values instead o=
f actual
> > > > sizes.
> > > >=20
> > > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > > > ---
> > > >  hw/ppc/pnv_xscom.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > > > index f01d788a65..cdd5fa356e 100644
> > > > --- a/hw/ppc/pnv_xscom.c
> > > > +++ b/hw/ppc/pnv_xscom.c
> > > > @@ -46,6 +46,10 @@
> > > >  #define P9_PBA_BARMASK0                 0x5012b04
> > > >  #define P9_PBA_BARMASK2                 0x5012b06
> > > > =20
> > > > +/* Mask to calculate Homer/Occ size */
> > > > +#define HOMER_SIZE_MASK                 0x0000000000300000ull
> > > > +#define OCC_SIZE_MASK                   0x0000000000700000ull
> > >=20
> > > Uuuhhhhh... AFAICT these defines have identical values to
> > > PNV_HOMER_SIZE and PNV_OCC_COMMON_AREA_SIZE, so I don't see what th=
is
> > > patch is actually changing.
> >=20
> > Oh, sorry, missed that the values were changed in 1/5.  Would have
> > been easier to follow if the two patches were folded together, but
> > never mind.  Applied.
>=20
> Ugh.. or not.  The first patch doesn't apply for me, looks like it
> needs a rebase (or you have something else in your tree I don't know
> about).

I checked out from upstream master (commit: 8937f17249) and worked on
it.

-- Bala
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _oth=
er_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



