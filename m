Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F30C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6905C206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6905C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnM5q-0006qd-M3
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jnM4b-00068A-4p; Mon, 22 Jun 2020 09:01:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jnM4X-0006wR-Tb; Mon, 22 Jun 2020 09:01:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05MCWPPc068329; Mon, 22 Jun 2020 09:01:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31shwus7qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 09:01:06 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05MCXdbU076302;
 Mon, 22 Jun 2020 09:01:06 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31shwus7nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 09:01:05 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05MCpJF6024666;
 Mon, 22 Jun 2020 13:01:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma02fra.de.ibm.com with ESMTP id 31sa381b76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 13:01:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 05MCxg9I61014406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2020 12:59:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AB79A4067;
 Mon, 22 Jun 2020 13:01:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC569A4065;
 Mon, 22 Jun 2020 13:01:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.8.171])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2020 13:01:00 +0000 (GMT)
Subject: Re: [PATCH v4 5/9] pc-bios: s390x: Rename and use PSW_MASK_ZMODE
 constant
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200622074235.32528-1-frankja@linux.ibm.com>
 <20200622074235.32528-6-frankja@linux.ibm.com>
 <5990e65c-732a-e3c1-bd4c-1fb870e8f567@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <85aa0f86-a83a-6d1f-6c4d-26f62daee975@linux.ibm.com>
Date: Mon, 22 Jun 2020 15:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5990e65c-732a-e3c1-bd4c-1fb870e8f567@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zJQtgmheQGbieHb7nwYpjdKODGvgEc0im"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-22_04:2020-06-22,
 2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 cotscore=-2147483648 mlxlogscore=999 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220091
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 09:01:08
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
--zJQtgmheQGbieHb7nwYpjdKODGvgEc0im
Content-Type: multipart/mixed; boundary="U5PBBS2MjNSiu7TJKGlFra7RzmXPFyznT"

--U5PBBS2MjNSiu7TJKGlFra7RzmXPFyznT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/22/20 1:40 PM, Thomas Huth wrote:
> On 22/06/2020 09.42, Janosch Frank wrote:
>> ZMODE has a lot of ambiguity with the ESAME architecture mode, but is
>> actually 64 bit addressing.
>>
>> As PSW_MASK_64 is now effectively 33 bit long and the PSWLegacy struct=

>> has 2 32 bit members, let's also use a unsigned long pointer in
>> dasd-ipl.c instead when oring the constant into a 8 byte PSW.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>  pc-bios/s390-ccw/dasd-ipl.c  | 5 ++---
>>  pc-bios/s390-ccw/s390-arch.h | 2 +-
>>  2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c=

>> index 0fc879bb8e..0dbad051a2 100644
>> --- a/pc-bios/s390-ccw/dasd-ipl.c
>> +++ b/pc-bios/s390-ccw/dasd-ipl.c
>> @@ -206,7 +206,7 @@ static void run_ipl2(SubChannelId schid, uint16_t =
cutype, uint32_t addr)
>>   */
>>  void dasd_ipl(SubChannelId schid, uint16_t cutype)
>>  {
>> -    PSWLegacy *pswl =3D (PSWLegacy *) 0x00;
>> +    unsigned long *pswl =3D 0x0;
>=20
> ... or we could use the "lowcore" pointer from s390-arch.h ... though
> that's PSWLegacy again...
>=20
>>      uint32_t ipl2_addr;
>> =20
>>      /* Construct Read IPL CCW and run it to read IPL1 from boot disk =
*/
>> @@ -229,7 +229,6 @@ void dasd_ipl(SubChannelId schid, uint16_t cutype)=

>>      run_ipl2(schid, cutype, ipl2_addr);
>> =20
>>      /* Transfer control to the guest operating system */
>> -    pswl->mask |=3D PSW_MASK_EAMODE;   /* Force z-mode */
>=20
> Wait, PSW_MASK_EAMODE was 0x0000000100000000 and ->mask was only a
> 32-bit value ... how was that ever supposed to work correctly?
>=20
>> -    pswl->addr |=3D PSW_MASK_BAMODE;   /* ...          */
>> +    *pswl |=3D PSW_MASK_64;   /* Force 64 bit addressing */
>=20
> So is this even a bug fix and not only a cosmetic change?
>=20
> ... the whole logic here looks fishy to me ... do we need this PSW
> modification at all? Shouldn't the guest decide which mode it wants to
> use in its startup code?
>=20
>  Thomas

Looking at jump_to_low_kernel(), jump_to_IPL_code and jump_to_IPL_2 I
think we can remove this line completely.

jump_to_IPL_code() prepares its own PSW and jumps to jump_to_IPL_2() via
diag308 subcode 1.

jump_to_IPL_2() fetches the saved PSW and does a br to the PSW address
so the mask completely goes to waste anyway.


DASD passthrough is rarely used so nobody looks at that code anymore. I
need to ask Jason about the intention behind those lines.


>=20
>=20
>>      jump_to_low_kernel();
>>  }
>> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch=
=2Eh
>> index 5f36361c02..73852029d4 100644
>> --- a/pc-bios/s390-ccw/s390-arch.h
>> +++ b/pc-bios/s390-ccw/s390-arch.h
>> @@ -29,7 +29,7 @@ _Static_assert(sizeof(struct PSWLegacy) =3D=3D 8, "P=
SWLegacy size incorrect");
>>  #define PSW_MASK_WAIT       0x0002000000000000ULL
>>  #define PSW_MASK_EAMODE     0x0000000100000000ULL
>>  #define PSW_MASK_BAMODE     0x0000000080000000ULL
>> -#define PSW_MASK_ZMODE      (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
>> +#define PSW_MASK_64         (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
>> =20
>>  /* Low core mapping */
>>  typedef struct LowCore {
>>
>=20



--U5PBBS2MjNSiu7TJKGlFra7RzmXPFyznT--

--zJQtgmheQGbieHb7nwYpjdKODGvgEc0im
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7wq4wACgkQ41TmuOI4
ufiHUg//UKC2LGZMJKaNHs1OkcS2ezwk2UYqVZP/98dZjHql3uSr1478i8uughGX
ynUAeiwcVRk9QRaN09UR8fT5U9pxxF8e8i7lfptwzbU2y1LSIkkDyejRhsLzQlhr
ck6qjvqWLx/EuuXh1+xzb533i/asr5EGZ6Hn/nBY/HFvkrIfUmWqtQ1EcvraYM6m
KZeJ9c4mV0IDz/OKDY34HXkREZVzMpcvtWa0d491yjt0ysuJDzHJTdGbKjJRIKYw
7Jd3wPH27YTq5ZlRGzaZyggyqT+R2jV3+Urfyg+CpaDLtEHI04czNj15SzVxHdpe
2A7hiCW2ztpOkj/CG5FJBsq1XbWA+UMLeuuncMgyk8C0tOOtVbJC1mqytebO/imn
W5Gwsw0SZVlTUlNwbY1f9FeuyWA9AL7YU0R0C7OyPPzzWoYDttsSZPZAYeplNSlZ
YawrYjF0wlnw8x4ZFUI+0O0CSTwk0ltnu4/Xe1M9KEekYBM+nN4PJum993agvDeg
oyw9LzMIFi6ocKpuF1uIvs/YJZwLqSga+VK4rbcApNX5u3cFo/bXew5yGkJy6arw
f2MRYqo343FUJ3vfGBsTaJzReEKuJBkNzqAKhJYbd4QNX6rq0Pc49GY7YaLnrPvG
W6qZkWwQCbqLOncbWpGq0HKVWdkvV4b7sb3dhm2cXIojzhkj6nQ=
=kkPZ
-----END PGP SIGNATURE-----

--zJQtgmheQGbieHb7nwYpjdKODGvgEc0im--


