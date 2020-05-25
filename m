Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87CDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFDD2078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFDD2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBuj-0004Io-JV
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 08:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdBtx-0003Zv-9C; Mon, 25 May 2020 08:08:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdBtv-0008Qz-Rw; Mon, 25 May 2020 08:08:16 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04PBinn4115268; Mon, 25 May 2020 08:08:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 317hegrrdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 08:08:14 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04PB3bvv116248;
 Mon, 25 May 2020 08:08:13 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 317hegrrcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 08:08:13 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04PC5OpU013210;
 Mon, 25 May 2020 12:08:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03ams.nl.ibm.com with ESMTP id 316uf840f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 12:08:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04PC87NS27918530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 May 2020 12:08:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D854B11C04C;
 Mon, 25 May 2020 12:08:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D7EC11C04A;
 Mon, 25 May 2020 12:08:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.30.189])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 May 2020 12:08:07 +0000 (GMT)
Subject: Re: [PATCH v2 5/9] pc-bios: s390x: Use PSW masks where possible
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200514123729.156283-1-frankja@linux.ibm.com>
 <20200514123729.156283-6-frankja@linux.ibm.com>
 <f4e7b4fa-b2f4-13ee-2a20-3e7ce1a26c54@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9a32e805-9946-63d0-9918-040f7c62b41a@linux.ibm.com>
Date: Mon, 25 May 2020 14:08:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f4e7b4fa-b2f4-13ee-2a20-3e7ce1a26c54@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nvkkXZH0QO40KsF6mkGLzhiXq0sHqHejQ"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-25_05:2020-05-25,
 2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:03:14
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
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
--nvkkXZH0QO40KsF6mkGLzhiXq0sHqHejQ
Content-Type: multipart/mixed; boundary="6yUaRrKgI0JU6UMZeCOyAwFuySoQWgHd8"

--6yUaRrKgI0JU6UMZeCOyAwFuySoQWgHd8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/21/20 7:50 AM, Thomas Huth wrote:
> On 14/05/2020 14.37, Janosch Frank wrote:
>> Let's move some of the PSW mask defines into s390-arch.h and use them
>> in jump2ipl.c
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>  pc-bios/s390-ccw/jump2ipl.c  | 10 ++++------
>>  pc-bios/s390-ccw/s390-arch.h |  2 ++
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c=

>> index 4eba2510b0..767012bf0c 100644
>> --- a/pc-bios/s390-ccw/jump2ipl.c
>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>> @@ -8,12 +8,10 @@
>> =20
>>  #include "libc.h"
>>  #include "s390-ccw.h"
>> +#include "s390-arch.h"
>> =20
>>  #define KERN_IMAGE_START 0x010000UL
>> -#define PSW_MASK_64 0x0000000100000000ULL
>> -#define PSW_MASK_32 0x0000000080000000ULL
>> -#define PSW_MASK_SHORTPSW 0x0008000000000000ULL
>> -#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_32 | PSW_MASK_64=
)
>> +#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>> =20
>>  typedef struct ResetInfo {
>>      uint64_t ipl_psw;
>> @@ -54,7 +52,7 @@ void jump_to_IPL_code(uint64_t address)
>> =20
>>      current->ipl_psw =3D (uint64_t) &jump_to_IPL_2;
>>      current->ipl_psw |=3D RESET_PSW_MASK;
>> -    current->ipl_continue =3D address & 0x7fffffff;
>> +    current->ipl_continue =3D address & PSW_MASK_SHORT_ADDR;
>> =20
>>      debug_print_int("set IPL addr to", current->ipl_continue);
>> =20
>> @@ -86,7 +84,7 @@ void jump_to_low_kernel(void)
>> =20
>>      /* Trying to get PSW at zero address */
>>      if (*((uint64_t *)0) & RESET_PSW_MASK) {
>> -        jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
>> +        jump_to_IPL_code((*((uint64_t *)0)) & PSW_MASK_SHORT_ADDR);
>>      }
>> =20
>>      /* No other option left, so use the Linux kernel start address */=

>> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch=
=2Eh
>> index 73852029d4..6da44d4436 100644
>> --- a/pc-bios/s390-ccw/s390-arch.h
>> +++ b/pc-bios/s390-ccw/s390-arch.h
>> @@ -26,9 +26,11 @@ _Static_assert(sizeof(struct PSWLegacy) =3D=3D 8, "=
PSWLegacy size incorrect");
>> =20
>>  /* s390 psw bit masks */
>>  #define PSW_MASK_IOINT      0x0200000000000000ULL
>> +#define PSW_MASK_SHORTPSW   0x0008000000000000ULL
>>  #define PSW_MASK_WAIT       0x0002000000000000ULL
>>  #define PSW_MASK_EAMODE     0x0000000100000000ULL
>>  #define PSW_MASK_BAMODE     0x0000000080000000ULL
>> +#define PSW_MASK_SHORT_ADDR 0x000000007fffffffULL
>=20
> Please also mention that new define in the patch description.
>=20
>  Thomas
>=20
>=20
pc-bios: s390x: Use PSW masks where possible and introduce
PSW_MASK_SHORT_ADDR

Let's move some of the PSW mask defines into s390-arch.h and use them
in jump2ipl.c. Also let's introduce a new constant for the address
mask of 8 byte (short) PSWs.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>



--6yUaRrKgI0JU6UMZeCOyAwFuySoQWgHd8--

--nvkkXZH0QO40KsF6mkGLzhiXq0sHqHejQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7LtScACgkQ41TmuOI4
ufjEkA/5AXDcqsE6Fmau8RRA2EbzPSGoXBgXT0rcf/hznCkbUC4TnXknKTa0V/Ey
c9RQ4/2k+zPZ9KS8Y1N94xHlqV6XcBUn59RAXDtKhS28+hjfm3flw5jtexLMl3o4
ovj9GpcLhbCSval5B7GBhKoNROdsXlUfPuzDM9pMSiG3hx3Z/NFN058aFbKoLWCZ
ZiWf56o6hBlT4g14EHwTbJXSDY9kBiF6FHHNV76uSF9XKVzRN2Emk0OT4fddx4p0
AFN5pdQgs0Kyb5ddAMYvh1PXCMxXbU8iBmj3Y5RW2I+AhU7x+lrNLHrzeo3FN+Lr
gx2RfZevqLfwP4j9hlWkdHKirTu5ikWzsRmmsiPcdUxxmNOWVjGrbEhcqIqav5//
FrU9KCHEZZQGX0in9ZjjM1N3Wh4bgqRoBFXhXI39HKxgAMGU3zsgQli7NJ0vIpjZ
090obUdWMjz9kGiNPl2I9NEf/w/R+JwYobpxM1VvZzD+mOppY1TF4DXhvVJTzPKR
ULBoCUzja/Mq6kuxcsjOyZb3MChY8CAA8Ryjr9UvXNCNy0JYZBA8CwHHiURBlaHw
HSl+rI04GfmN4vJISPTemflmo+N3jKMIAUyMev74ABJMVBcvLIQdkIrgHCqqUNSy
TB+lSctm9g7xPunAnwp+Qj9hJT3au+YLoyOB8zxEPCt7H8oZy1s=
=Vpcx
-----END PGP SIGNATURE-----

--nvkkXZH0QO40KsF6mkGLzhiXq0sHqHejQ--


