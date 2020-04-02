Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76673C2BA12
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 23:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444542077D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 23:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444542077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8qt-0003lc-Dh
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 19:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1jK8pr-0002nL-Lo
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 19:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1jK8pq-0001H3-PA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 19:01:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10976
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1jK8po-0001EB-Id; Thu, 02 Apr 2020 19:01:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 032MiPOV055126; Thu, 2 Apr 2020 19:01:11 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 303uj5suym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 19:01:11 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 032Mp2xi009297;
 Thu, 2 Apr 2020 23:01:10 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma05wdc.us.ibm.com with ESMTP id 301x77cchy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 23:01:10 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 032N18l141812452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2020 23:01:08 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F7A0BE04F;
 Thu,  2 Apr 2020 23:01:08 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD4A7BE051;
 Thu,  2 Apr 2020 23:01:04 +0000 (GMT)
Received: from LeoBras (unknown [9.85.174.86])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2020 23:01:03 +0000 (GMT)
Message-ID: <6eaedb1c412f1e5194b5e9a6e6718af98da5abdd.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM LMBs on
 drmem_v2
From: Leonardo Bras <leonardo@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 02 Apr 2020 20:00:57 -0300
In-Reply-To: <20200402224925.GN47772@umbus.fritz.box>
References: <20200402172339.622720-1-leonardo@linux.ibm.com>
 <20200402224925.GN47772@umbus.fritz.box>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-CkHMGi805wZf3gxbdL2d"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-02_12:2020-04-02,
 2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=763 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020164
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
 qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--=-CkHMGi805wZf3gxbdL2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello David,

On Fri, 2020-04-03 at 09:49 +1100, David Gibson wrote:
>=20
> The change looks reasonable.  Is there a PAPR RFC I can see describing
> the new bit, though?

The ACR is approved and I already added the change to LoPAPR/LOPAR,
it's just a matter of time to get it released.
(I think it's accessible to members of OpenPower Foundation)

This is the snippet of the change:

At the bottom of "Table 3.11: Flag Word", add another line containing:
Hot-removable Memory	| 0x00000100 	| If b'1', this LMB can be hot-
removed.=20
			|		| If b'0', this LMB may not be hot-
removed

Best regards,
Leonardo Bras

--=-CkHMGi805wZf3gxbdL2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6GbqkACgkQlQYWtz9S
ttRhQxAAiwE03GBGudVlVLbXXXhvrc7G3BtR4PkbeUXS4fLW9dHqsz2IOCVO23Op
s/fNGw+/0bNHXM9dABidURFoD3i6SMNcMTwMc/uLf2J3fLky/noepRLYu53BCT7W
DfHh860rtkEhzEhUN1Jfkr17C2f5EaDJ9SJS4+M2sWKKd/jD4BZC++A2RWKy8CYw
BJwpKaqQ9t/fa6NuMRUM2mk8bkTWIgPiV8C1NRha1yT3UkZzQWbX1AgWlTYRktra
pf53JbiVB2XXKhZbuuVhSpbqp595xczHF8IPpNSAWwzJX+BAyq+l0x9N/L0XsJTm
B2sNAN540IQBKBAKnNqa95+hAVwaXOyz0AZKpwSYmAlwjcOrJ27C3D68WbBmh9Ga
oBnv3MAmkSQtQoHHgV+dqyKy0LavV2e0CTE2yBOWJ6R0rQxjn0xV0c2rnpCpLUbC
2zaVMf7xYqpCX/BIhDvbslWMYpowtGWTUYRXc27eOwZcDvDOVI2Km55YOeVZFakM
1rdAz4U0sIyZQnuDbn43/1mxSeRWNysciFugLCP8HxQmBHYiGoctcBR/7imXd125
gozK2CunYLyHxUgxP657frvvSnRIOewgH9wxGRdGHxBYiGfq0u384W5foREAVUQg
o9d6uqfDRNynUWCbMK9xoMoBqLO5zmthHu08QGwup4u/tMTkK9M=
=O6nL
-----END PGP SIGNATURE-----

--=-CkHMGi805wZf3gxbdL2d--


