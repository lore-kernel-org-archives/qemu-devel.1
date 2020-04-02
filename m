Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D3BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D14212CC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D14212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3OM-0005Cl-TZ
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1jK3NJ-0004Lc-O6
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1jK3NI-0001eM-EM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:11:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28690
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1jK3NI-0001dv-9J; Thu, 02 Apr 2020 13:11:28 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 032GYCNF109118; Thu, 2 Apr 2020 13:11:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 305khm95cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 13:11:22 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 032GYMtZ110059;
 Thu, 2 Apr 2020 13:11:22 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 305khm95c9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 13:11:22 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 032H9k4V013787;
 Thu, 2 Apr 2020 17:11:21 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma04wdc.us.ibm.com with ESMTP id 301x772frg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 17:11:21 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 032HBLSD51839324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2020 17:11:21 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CF44AE05C;
 Thu,  2 Apr 2020 17:11:21 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6AF6AE05F;
 Thu,  2 Apr 2020 17:11:16 +0000 (GMT)
Received: from LeoBras (unknown [9.85.174.86])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2020 17:11:16 +0000 (GMT)
Message-ID: <e9caef7692520a63aad60d418a20f2d7cf58fcdc.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] ppc/spapr: Add hotplugged flag on DIMM LMBs on
 drmem_v2
From: Leonardo Bras <leonardo@linux.ibm.com>
To: Bharata B Rao <bharata.rao@gmail.com>, David Gibson
 <david@gibson.dropbear.id.au>
Date: Thu, 02 Apr 2020 14:11:12 -0300
In-Reply-To: <CAGZKiBpO4HxrE06dT39sj95_qcTvQK_g5Ev5TKC5T9wimphM_Q@mail.gmail.com>
References: <20200306002202.176732-1-leonardo@linux.ibm.com>
 <20200310023943.GH660117@umbus.fritz.box>
 <CAGZKiBpO4HxrE06dT39sj95_qcTvQK_g5Ev5TKC5T9wimphM_Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-qWbytmRUWCMrXi+u3r9y"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-02_06:2020-04-02,
 2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 clxscore=1011 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020131
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Bharata B Rao <bharata.rao@in.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--=-qWbytmRUWCMrXi+u3r9y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Bharata, thank you for reviewing and testing!

During review of this new flag, it was suggested to change it's name to
a better one (on platform's viewpoint).=20

So I will have to change the flag name from SPAPR_LMB_FLAGS_HOTPLUGGED
to SPAPR_LMB_FLAGS_HOTREMOVABLE.

Everything should work the same as today.

Best regards,
Leonardo



On Thu, 2020-04-02 at 14:46 +0530, Bharata B Rao wrote:
> On Tue, Mar 10, 2020 at 8:24 AM David Gibson
> <david@gibson.dropbear.id.au> wrote:
> > On Thu, Mar 05, 2020 at 09:22:02PM -0300, Leonardo Bras wrote:
> > > On reboot, all memory that was previously added using object_add and
> > > device_add is placed in this DIMM area.
> > >=20
> > > The new SPAPR_LMB_FLAGS_HOTPLUGGED flag helps Linux to put this memor=
y in
> > > the correct memory zone, so no unmovable allocations are made there,
> > > allowing the object to be easily hot-removed by device_del and
> > > object_del.
> > >=20
> > > Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> > >=20
> > > ---
> > > The new flag was already proposed on Power Architecture documentation=
,
> > > and it's waiting for approval.
> > >=20
> > > I would like to get your comments on this change, but it's still not
> > > ready for being merged.
> >=20
> > This looks reasonable to me - at the very least it doesn't look like
> > it could do much harm.
>=20
> Looks good to me, also tested with PowerKVM guests.
>=20
> Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>
>=20
> Regards,
> Bharata.

--=-qWbytmRUWCMrXi+u3r9y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6GHLAACgkQlQYWtz9S
ttRsihAA5HJfNqF69sgy8rWwW2maRAl0b08e5Ub8o/dQ4dvL3bXmdzGVgc5QMgjB
weRI67HlEM8aVjJTa+Qzem/mf90Oi3uJCtfSVFuLtt9SCr4FD45n6Xaltmy0YDlq
Z5t/eHMcUjzOWkyBnoL0dckhqkUj5cB9jL5dxpxgzjSllOIcnB8crMRqgAjc9Taf
00hnn8E3lF3UhSgN2FXvTEKofv18WQ0IKnLcULzHUMZkPgFhWmbMn0EZXojcEOoN
y2e5KMM7XobUwiJCupZ7TQDQfSiz4SFQbLKDhn+yqqBmo2OMTqvZE5PM3DZkgDxF
3KqQ/YX5cEgKKxMxrbES/KhnoRocGie499r+8JMmwaJEFuFBVLFbRxDK88HCM/Tw
OhqlXQ5q48x2pZkKa/n53+XcrGjGUBPWkZCM2WLfvWrZEqUho/aPLMSroaERgvHU
UAHlPluNT7C6FSsBxpk2SaWHJsf2X6pTp/vS8HrsgH0k8Ij+jEWknMSVqHwELwTL
K9WfQRobDvuOxpHCgDfVm+HuIQlIkiAZL5TY3KTZPRTN6+YqDoEaK8Vm+/3ZFvna
Es8n4nbQLg1jP1W/wFSy/fM6dH/nuwXWOp9yZWebB7Zr16+X66i9ylNukr/pu8MG
tB0yJFqSpARgHGHIaU0paXbS107Ujpp13CuAksGz3AT2ynE/sTw=
=cNYZ
-----END PGP SIGNATURE-----

--=-qWbytmRUWCMrXi+u3r9y--


