Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45EEC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B944020748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B944020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6Y6-0003xV-QI
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1is6LB-0006h3-DE
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1is6L7-00058R-Ms
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:41:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54774
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1is6L7-000585-Hw; Thu, 16 Jan 2020 09:41:41 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00GEci5b101469; Thu, 16 Jan 2020 09:41:34 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xhbpt9ndg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2020 09:41:34 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00GEcoNs102215;
 Thu, 16 Jan 2020 09:41:33 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xhbpt9nd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2020 09:41:33 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00GEeIaB023491;
 Thu, 16 Jan 2020 14:41:33 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03dal.us.ibm.com with ESMTP id 2xf7502v6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2020 14:41:33 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00GEfVoe21234148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2020 14:41:31 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D43FBC6055;
 Thu, 16 Jan 2020 14:41:31 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75FEBC6059;
 Thu, 16 Jan 2020 14:41:30 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.137])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jan 2020 14:41:30 +0000 (GMT)
Message-ID: <0e0d5def1bb42bb12bcabbefbd69f601ce91d860.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/3] target/ppc: single step for KVM HV
From: Leonardo Bras <leonardo@linux.ibm.com>
To: Fabiano Rosas <farosas@linux.ibm.com>, qemu-devel@nongnu.org
Date: Thu, 16 Jan 2020 11:41:26 -0300
In-Reply-To: <20200110151344.278471-1-farosas@linux.ibm.com>
References: <20200110151344.278471-1-farosas@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-RX+k3KO90PzukuuZBhx1"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-16_04:2020-01-16,
 2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=969
 impostorscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160122
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
X-Mailman-Approved-At: Thu, 16 Jan 2020 09:54:15 -0500
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--=-RX+k3KO90PzukuuZBhx1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-10 at 12:13 -0300, Fabiano Rosas wrote:
> Hi,
>=20
> This version contains two major changes. A fix for stepping an
> AIL-changing instruction and a fix for when other breakpoints happen
> mid-step.
>=20

I have being using this patchset for almost an year now. It really
makes debugging guest kernel in Power a much better experience.

I have compiled the last version on monday and used it for running
every VM I needed to since then. Two of them included debugging.
No issue found.

FWIW,=20

Tested-by: Leonardo Bras <leonardo@ibm.com>

--=-RX+k3KO90PzukuuZBhx1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl4gdhYACgkQlQYWtz9S
ttSH/w/7BtNx1rtFd6SbVUJpY+NwhkUygBZxFkSwKMiIR2KD5Hax0ADVjRMio2vi
JRwRz2wjeUWs6IfDVtQXlICyI2XmfRkZzevDDzCnfatOO4HkvwoeRZIlLXuGbwRx
nkqcrGxB6jKch0Yc2pTTXnVHVJ613QMwbA02FbpncSTBIPsaBsOVRTrir8q9ifVk
TmPC8qLZ2K1LTIyBIpCe2RvYsPP2qoo0c+f+Fq+2cjaULHXN4MHJ2TcfL9OlCGXn
lpzMVuy926ZvfrG8j+WyCNxYNBDjHVQFfDnYP0EPSz2sW9cDLmdyNghrwrSSpJuF
uuwNky4OrTY23Bv5rJXWFaDatp+J1E7FWTuVeYBREpQjfOEnHXK61TE3yPQJnW1R
Dz3mXSfvR+ptO50ZKu+NwJH2dfk2C4TOBnQ7UefBoOLFwWxZlev8CpSA/Kx+EuvB
7E6u+bSMcfknpolhMKbSgqdGXxRkbpMGOexgW3AlWj0WaH/yV3FOvQNlzZD0WLpZ
x0KpHoDwecQl/DqtnmRXJnWC+g9SMgr0h5u28XafEWU36bMwZndNiKk9C58OOn6x
4jS0wIUrdCQu/nBEikEChBDnEa+9r/pRRgb9VNBBNSpC6LUD0xd0q2H1oKCbVmZL
jPQac0z4XA+w8e7Efyb6RepzAAVtAPCIe+f600Ake8pLIpiNins=
=AMZe
-----END PGP SIGNATURE-----

--=-RX+k3KO90PzukuuZBhx1--


