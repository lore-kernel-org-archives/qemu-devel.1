Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EE1C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 03:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5661320753
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 03:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5661320753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEmCs-0007Fa-E5
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 23:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1jEmA4-000477-9s
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1jEmA3-0004kd-BF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:48:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56692
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1jEmA3-0004jx-53
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:47:59 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02J3XhGp181336; Wed, 18 Mar 2020 23:47:54 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yuxffuua4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2020 23:47:53 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02J3i5Hu032681;
 Thu, 19 Mar 2020 03:47:53 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 2yrpw75md5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2020 03:47:53 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02J3lq2O20381974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 03:47:52 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72273C6057;
 Thu, 19 Mar 2020 03:47:52 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1C70C6059;
 Thu, 19 Mar 2020 03:47:49 +0000 (GMT)
Received: from LeoBras (unknown [9.85.205.198])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 03:47:47 +0000 (GMT)
Message-ID: <6b5ec28798e191887eabb540aae6b10e30be0f2f.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] device_tree: Add info message when dumping dtb to file
From: Leonardo Bras <leonardo@linux.ibm.com>
To: Alistair Francis <alistair.francis@wdc.com>, David Gibson
 <david@gibson.dropbear.id.au>
Date: Thu, 19 Mar 2020 00:47:42 -0300
In-Reply-To: <20200319033200.390008-1-leonardo@linux.ibm.com>
References: <20200319033200.390008-1-leonardo@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-GFSqRDs6pKgpWHXpKYox"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_10:2020-03-18,
 2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190013
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--=-GFSqRDs6pKgpWHXpKYox
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-19 at 00:32 -0300, Leonardo Bras wrote:
>  error_report("%s: Failed dumping dtb to %s", __func__, dumpdtb)

Sorry, missed ending ';'.
I will send a v2.=20

--=-GFSqRDs6pKgpWHXpKYox
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl5y614ACgkQlQYWtz9S
ttSYpRAA5RyMI2Q/OQ09ABiTcTi3wl6Fe+Ii9W+BLeqFNKb64hAn32aYtVoIVygH
h7/WxGoCRnnNvAgg2swy1O+S2fm9db+T0Tz5yuC5d+fHy4SnwNS6S2RMWZtjPIb4
qTpg8lanj3itIkRqHb+QqGdIXYu7ztB6IzSz99ZIKaFDlt6mGpUk1uvWOtu26FfG
FwzIvW4rj7p9DneBGhDSG/BbO6LJACWslrYeH6k/b5U6Ul5XOGnZTLNmSitjNHd0
hHbrR28Bn2wn/NjfENrj9FivYWiE/+J4Kls1vFbqivxrHO1YtjixIiFRa0ukhGba
x/e4TrnG+BSSZANyeNAz1JFiz8Xxrd2zO64XwupUkMuR0lKsCxYoBDyfsEMTK8Vk
IhQX/Y420tszoyi7e3gW4ZbIdW7lFEOjiH2ABUTzn0NXNZDUGQd7UHK6oqe1zi34
MKGgihAXfvnyqrYn6AbvVfiez09wVv15kOj8jh20irSri9P0GgPuqc26GJPdTCsC
GMo/pZQ6Z++DajtTVjgeF8JAMXI99MRJ4EHXkYkakMgm4KNXf7scqSfN24n9e2yF
pmavknJ4iTN3kqdrR5r/aaZqrVOs8wUtXfOUvOGEDWSUZwS8/sEVUMuRUxa73wz5
sVNP9X6j/mrZoY9s2iaGNxLl6C6TqJgDA9DzzqIIYxhsX0vfnk0=
=9WRQ
-----END PGP SIGNATURE-----

--=-GFSqRDs6pKgpWHXpKYox--


