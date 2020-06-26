Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E5AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9131C20C09
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9131C20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jojK3-0006it-S1
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 04:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jojJR-0006IN-79
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 04:02:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jojJP-0005MH-4P
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 04:02:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05Q7XwML048434
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 04:02:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31waw8c8xb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 04:02:11 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05Q7rBXP122546
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 04:02:11 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31waw8c8w4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2020 04:02:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05Q80k0u020922;
 Fri, 26 Jun 2020 08:02:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03ams.nl.ibm.com with ESMTP id 31uus52s7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2020 08:02:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05Q827ax3997956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2020 08:02:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03FDC4C046;
 Fri, 26 Jun 2020 08:02:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A60954C04A;
 Fri, 26 Jun 2020 08:02:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.191.93])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jun 2020 08:02:06 +0000 (GMT)
Subject: Re: [PATCH v5 11/12] pc-bios: s390x: Fix bootmap.c passing PSWs as
 addresses
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624075226.92728-12-frankja@linux.ibm.com>
 <91c99232-91a6-f2f1-d2cc-af26dbb86558@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <88959a67-b5a1-c7fc-ac3e-e4e3f254c7ef@linux.ibm.com>
Date: Fri, 26 Jun 2020 10:02:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <91c99232-91a6-f2f1-d2cc-af26dbb86558@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Nc9C9ud7dXy3to5GuZ8t9sVnsCwV9o9Dq"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-26_04:2020-06-26,
 2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 cotscore=-2147483648
 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 04:02:12
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nc9C9ud7dXy3to5GuZ8t9sVnsCwV9o9Dq
Content-Type: multipart/mixed; boundary="sBRdVlJYnVn3SXodmJ3GxCqmwtP6LQr2j"

--sBRdVlJYnVn3SXodmJ3GxCqmwtP6LQr2j
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/25/20 2:46 PM, Thomas Huth wrote:
> On 24/06/2020 09.52, Janosch Frank wrote:
>> The component entries written by zipl contain short PSWs, not
>> addresses. Let's mask them and only pass the address part to
>> jump_to_IPL_code(uint64_t address) because it expects an address as
>> visible by the name of the argument.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/bootmap.c | 5 +++--
>>   pc-bios/s390-ccw/bootmap.h | 2 +-
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index 97205674e5..8547a140df 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -10,6 +10,7 @@
>>  =20
>>   #include "libc.h"
>>   #include "s390-ccw.h"
>> +#include "s390-arch.h"
>>   #include "bootmap.h"
>>   #include "virtio.h"
>>   #include "bswap.h"
>> @@ -436,7 +437,7 @@ static void zipl_load_segment(ComponentEntry *entr=
y)
>>       char *blk_no =3D &err_msg[30]; /* where to print blockno in (tho=
se ZZs) */
>>  =20
>>       blockno =3D entry->data.blockno;
>> -    address =3D entry->load_address;
>> +    address =3D entry->psw & PSW_MASK_SHORT_ADDR;
>=20
> Are you really sure about this one here? The address does not seem to b=
e=20
> used for any of the jump_to_IPL() functions. And in the zipl sources, I=
=20
> can also see spots like this:

This one slipped through and is indeed wrong.

>=20
>     entry->compdat.load_address =3D data.load_address;
>=20
> ... without any further short mask bits. So I somehow doubt that this=20
> change is really ok?
>=20
>>       debug_print_int("loading segment at block", blockno);
>>       debug_print_int("addr", address);
>> @@ -514,7 +515,7 @@ static void zipl_run(ScsiBlockPtr *pte)
>>       IPL_assert(entry->component_type =3D=3D ZIPL_COMP_ENTRY_EXEC, "N=
o EXEC entry");
>>  =20
>>       /* should not return */
>> -    jump_to_IPL_code(entry->load_address);
>> +    jump_to_IPL_code(entry->psw & PSW_MASK_SHORT_ADDR);
>=20
> That one should be fine, I think.

Yes, as it is a execute type entry, this needs to be a PSW and therefore
needs to be masked.

>=20
>>   }
>>  =20
>>   static void ipl_scsi(void)
>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
>> index 12a0166aae..e07f87e690 100644
>> --- a/pc-bios/s390-ccw/bootmap.h
>> +++ b/pc-bios/s390-ccw/bootmap.h
>> @@ -68,7 +68,7 @@ typedef struct ComponentEntry {
>>       ScsiBlockPtr data;
>>       uint8_t pad[7];
>>       uint8_t component_type;
>> -    uint64_t load_address;
>> +    uint64_t psw;
>=20
> I'd recommend to keep the load_address name. It's the same name as used=
=20
> in the zipl sources, and as far as I can see, the field does not always=
=20
> contain a PSW.

The problem is that this is a union in zipl containing an address, psw
or signature header.

I guess we should also make it a union and use the proper members so it
is clear what we retrieve from the entry. If it is a PSW we need to mask
it if it is a component address masking might be a bad idea.

But I absolutely do not want to have this named PSW and then being used
like a normal address. It took me way too long to figure out why my
guest wasn't booting anymore.

Time for a new series of patches :)

>=20
>>   } __attribute((packed)) ComponentEntry;
>>  =20
>>   typedef struct ComponentHeader {
>>
>=20
>   Thomas
>=20



--sBRdVlJYnVn3SXodmJ3GxCqmwtP6LQr2j--

--Nc9C9ud7dXy3to5GuZ8t9sVnsCwV9o9Dq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl71q34ACgkQ41TmuOI4
ufjKiw/9FgJ7/DY06A4Ztdw4dzRwX5CKhgpV9e0osiWO7l7Vrshlu+wNxvAt5djK
j3twclhX5jQjRW6arYTc9b6O39eVdbyiYb2Q9T1qxy2omgMOh7VkpMXXOV0to3x0
bwtxMqp1wCHaVSB+fsF7FKLXwuSRsheoZO6T2ykNmJyaDv1J8HYaWdw23ZWT1vFo
rvvWF7cZkdw9jdXonbMB7d/LjyNdBK46j1Tpm3KbQ1SoPfhBh4oB6wL7twPtpF1J
KVNvCQrqwR6sHtdU/0DkeqdqUyenbjdu2tMj25xFITDr66hOz1ECxqDaPg24/84i
md3li5E/6CBMhc9ly6V/+2pu4ASFsntjO58mHF4ik2xguvGg6Ze+DnzPDELXTKNk
OU/WR2m6CQlQXHqTyqUjxW1UQGkhyZw8GAMXzWm8VhCm+uAIHNEC6Zc1HpdJsSNs
abRQJ97d4F7lhb38dVCRD7PnNHw/i5HH6NqApq5yCMliH/pxd1nLNRdRLX1aSc9r
BuUQXDJC+W/4CFRrE3geHIqoslUo5rDskZ4XRXCXR4v3HyxxrcG9hduqosbLemjK
wM8wtjnQOLIM9h9/JZMhrsZxlOi+1Pq3XL37UF/8f3+oyDdMPRD4ypW/+44eGhe/
VKtp/zCloYJXMleT7vHVJJTStBOpsc+V5yY73pMOFhRg8NYETF4=
=cxmA
-----END PGP SIGNATURE-----

--Nc9C9ud7dXy3to5GuZ8t9sVnsCwV9o9Dq--


