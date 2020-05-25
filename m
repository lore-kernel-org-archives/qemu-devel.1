Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC4DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CF92078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CF92078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdC6u-00017g-LJ
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 08:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdC5o-00008m-R8; Mon, 25 May 2020 08:20:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdC5m-0002dw-L8; Mon, 25 May 2020 08:20:32 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04PC3iRY107066; Mon, 25 May 2020 08:20:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316vqey5pc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 08:20:28 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04PC3noY107423;
 Mon, 25 May 2020 08:20:27 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316vqey5nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 08:20:27 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04PCFO9H023803;
 Mon, 25 May 2020 12:20:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 316uf8411r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 12:20:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04PCKNpk53870818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 May 2020 12:20:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0430F11C052;
 Mon, 25 May 2020 12:20:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC2B211C04C;
 Mon, 25 May 2020 12:20:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.30.189])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 May 2020 12:20:22 +0000 (GMT)
Subject: Re: [PATCH v2 2/9] pc-bios: s390x: Consolidate timing functions into
 time.h
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200514123729.156283-1-frankja@linux.ibm.com>
 <20200514123729.156283-3-frankja@linux.ibm.com>
 <21da6890-0951-5488-feaa-74a9a2afe918@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <16ca3fa3-0007-f61a-5e3f-17e1e4a4863d@linux.ibm.com>
Date: Mon, 25 May 2020 14:20:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <21da6890-0951-5488-feaa-74a9a2afe918@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nA7OUFAhw27OlSNjUfTR5bLpiV2ZfG4YX"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-25_07:2020-05-25,
 2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 cotscore=-2147483648 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005250094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:50:15
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nA7OUFAhw27OlSNjUfTR5bLpiV2ZfG4YX
Content-Type: multipart/mixed; boundary="lkHWmvI7JZ4VOX40iA5ylCx5zRqV6PvqG"

--lkHWmvI7JZ4VOX40iA5ylCx5zRqV6PvqG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/20/20 9:53 PM, Thomas Huth wrote:
> On 14/05/2020 14.37, Janosch Frank wrote:
>> Let's consolidate timing related functions into one header.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/menu.c        |  1 +
>>  pc-bios/s390-ccw/netmain.c     | 15 +++----------
>>  pc-bios/s390-ccw/s390-ccw.h    | 18 ----------------
>>  pc-bios/s390-ccw/time.h        | 39 +++++++++++++++++++++++++++++++++=
+
>>  pc-bios/s390-ccw/virtio-net.c  |  1 +
>>  pc-bios/s390-ccw/virtio-scsi.c |  1 +
>>  pc-bios/s390-ccw/virtio.c      | 18 +++-------------
>>  7 files changed, 48 insertions(+), 45 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/time.h
>>
>> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
>> index ce3815b201..7925c33248 100644
>> --- a/pc-bios/s390-ccw/menu.c
>> +++ b/pc-bios/s390-ccw/menu.c
>> @@ -12,6 +12,7 @@
>>  #include "libc.h"
>>  #include "s390-ccw.h"
>>  #include "sclp.h"
>> +#include "time.h"
>> =20
>>  #define KEYCODE_NO_INP '\0'
>>  #define KEYCODE_ESCAPE '\033'
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> index 309ffa30d9..73def8de4f 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -35,6 +35,7 @@
>>  #include "s390-ccw.h"
>>  #include "cio.h"
>>  #include "virtio.h"
>> +#include "time.h"
>=20
> netmain.c already contains a #include <time.h> which pulls in the heade=
r
> with the same name from libnet in SLOF ... so I wonder why you don't ru=
n
> into trouble here, I'd expect that your local time.h now rather gets
> included twice. Did you rebuild s390-netboot.img without problems?
> Anyway, time.h is maybe not the best name for a new header here...
>=20
>  Thomas
>=20

That doesn't seem to be a problem when compiling.
However we could just move all of the function into helper.h as it's
really not a lot of code especially after splitting it up into helper.h
and time.h.

Or we could use s390-time.h


--lkHWmvI7JZ4VOX40iA5ylCx5zRqV6PvqG--

--nA7OUFAhw27OlSNjUfTR5bLpiV2ZfG4YX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7LuAYACgkQ41TmuOI4
ufib+A//af+iTov5KwXp1Caohc88dxoCqSLXl4BCuFhvbzGSXpXJL6cvj6DfV5sf
ar9cONFpwSh/ZjWcLp8bIQKx40Omf/BzMhBmBFqgvAIpELgP8f0j0oVQn8PoXRQC
0qmCJsd27EjnCMI1QsyDb9Json7ANVX9uWjJMC8xj3RhM8+OIp34erYRt26W3YIN
0sGv+G8LOsFWtN/qbU9uZBLZCpNCE6VExvfZuFEp+w+vzNhGWNxmT8mUNgGbwhOT
k77/+mYxDoiLWuhnMZdHsaLSUz3DZpel3KzTpDkI8zs+cC2x8eVRURneTllhDR/B
pqqaVWbSGw5y4Wz0ctOugVfkN3jeWpCnGGypDEut6Ij9/ROimZpKLzX8pi6fe8Xs
iZZX9WjRnSDgPa2G6qhAroncgm33smEFW8DPPBHGZ08MY2veIP1XJpNy8dB805fS
57A5AFXtSj0K5S1YNrr4cOFmezZFSatu9hTA2R6/n7sKw5RbF6gumeomTz+UFOpl
svgeCxXL5RAKYy7N31byTRplESw7Xjdlu+8f9HtKy5VZgixUHUg0CS4uEl4TRDHE
iI9mIirHsk0gz94P4SsR/MBHEgEEthjA7t2Xw24Ci+n8fZXXSboXnhLh5D+h8I2I
t12SHl4rKy7yCyl4Fruc/pLoPLzD2ilPLySutyIwBioxsrZuISs=
=HMKk
-----END PGP SIGNATURE-----

--nA7OUFAhw27OlSNjUfTR5bLpiV2ZfG4YX--


