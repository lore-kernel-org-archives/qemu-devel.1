Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE3C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 22:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143F120753
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 22:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143F120753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGVFX-0002Ms-7u
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 18:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1jGVEm-0001jU-O8
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1jGVEl-0003LJ-HM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:08:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1jGVEi-0003Je-Qf; Mon, 23 Mar 2020 18:07:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02NM45JI130738; Mon, 23 Mar 2020 18:07:51 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywf3eb0n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2020 18:07:51 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02NM0jm9025446;
 Mon, 23 Mar 2020 22:07:50 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03wdc.us.ibm.com with ESMTP id 2ywaw9knjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2020 22:07:50 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02NM7nX260162494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2020 22:07:49 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1155FBE077;
 Mon, 23 Mar 2020 22:07:49 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5998BE061;
 Mon, 23 Mar 2020 22:07:32 +0000 (GMT)
Received: from LeoBras (unknown [9.85.202.245])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2020 22:07:32 +0000 (GMT)
Message-ID: <53408dd722b86c69e8b44ba1881bc2053f4ec36f.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] spapr/rtas: Add MinMem to ibm,get-system-parameter
 RTAS call
From: Leonardo Bras <leonardo@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 23 Mar 2020 19:07:21 -0300
In-Reply-To: <20200323032457.GE2213@umbus.fritz.box>
References: <20200321003921.434620-1-leonardo@linux.ibm.com>
 <20200323032457.GE2213@umbus.fritz.box>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-N/RsFC0ovajWWil0mjW1"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-23_09:2020-03-23,
 2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230107
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: ricardom@linux.ibm.com, danielhb@linux.ibm.com, lagarcia@linux.ibm.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--=-N/RsFC0ovajWWil0mjW1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-23 at 14:24 +1100, David Gibson wrote:
> On Fri, Mar 20, 2020 at 09:39:22PM -0300, Leonardo Bras wrote:
> > Add support for MinMem SPLPAR Characteristic on emulated
> > RTAS call ibm,get-system-parameter.
> >=20
> > MinMem represents Minimum Memory, that is described in LOPAPR as:
> > The minimum amount of main store that is needed to power on the
> > partition. Minimum memory is expressed in MB of storage.
>=20
> Where exactly does LoPAPR say that?  The version I'm looking at
> doesn't describe MinMem all that clearly, other than to say it must be
> <=3D DesMem, which currently has the same value here.

Please look for "Minimum Memory". It's on Table 237. SPLPAR Terms.=20

> > This  provides a way for the OS to discern hotplugged LMBs and
> > LMBs that have started with the VM, allowing it to better provide
> > a way for memory hot-removal.
>=20
> This seems a bit dubious.  Surely we should have this information from
> the dynamic-reconfiguration-memory stuff already?  Trying to discern
> this from purely a number seems very fragile - wouldn't that mean
> making assumptions about how qemu / the host is laying out it's fixed
> and dynamic memory which might not be justified?

I agree.=20
I previously sent a RFC proposing the usage of a new flag for this same
reason [1], which I thank you for positive feedback.

Even though I think using a flag is a better solution, I am also
working in this other option (MinMem), that would use parameter already
available on the platform, in case the new flag don't get approved.

So far, using MinMem looks like a very complex solution on kernel side,
and I think it's a poor solution.

I decided to send this patch because it's a simple change to the
platform support, that should cause no harm and could even be useful to
other OSes.


Best regards,
Leonardo

[1] http://patchwork.ozlabs.org/patch/1249931/

--=-N/RsFC0ovajWWil0mjW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl55MxkACgkQlQYWtz9S
ttSrvw//WnLOFIPdQzoEyE8ZA9wFZh1+QPpcFzRqSVo8SFD0IrPp5gHjulsVD0hK
Am99Jsun5lIBrdHVbK8kp0lqrM7lMUk7Ja0MeS6vqlF3NgAYLcR+vFKlr2h4QMUW
XQ++Xck57VweNipk1aPRZlgvWBVaqxAx2xbQzTETQ0NeH3mNXY/kUksjixwGfqNg
7mbNvaMMMbviQ2V2KnF0bAemKbf2evBYsnUr6Oen9BhhrDY8FsreofK0BZvlK8z9
90xQb1fkcNmtSsO4g/Rs8kGeoty926OCFUWhMr9bhwbYM4ka6P+7BSXjmgL1GIm1
uUuYCAzPTCIQQuRMy5D2rIMVcO4NgOFZBWw7HFL3fhJ55wiEbnLVp+0E6PHl2wWK
Clv6Z2TIM5n1EwpqajHaS7JDu3OyNCTD0Yz/z5Z7norvgn3cDoPa52kLVZ8nFkpy
IqIjRmvvzS02ocx/HxPn+YolfjmCpr0Bj5q3t5eqCTp5MgOwUkhhN/tmh59pRF9d
bbYfGQfaVeYwfL/Qp5tm7mMLJ1b9azmeBaRGKBp85qOVCLz99vt+6vkcYkLRPbQp
afCU2/z3fv4vXb1EIjM8YEq6IiHhw8S3UVPObyT8uyHcREocnRNpEloUFKFMG30K
XnRqH/q0OQsET7TQ7XB5oV3o/pa23zT+n2M3O27rFsXRN5aWeTs=
=VmZi
-----END PGP SIGNATURE-----

--=-N/RsFC0ovajWWil0mjW1--


