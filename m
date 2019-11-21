Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF0DC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5E120714
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5E120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkgY-0001Yh-23
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXkdJ-0006Vj-OH
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXkdI-0002fd-Dh
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:28:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXkdI-0002fM-59
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:28:20 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xALBRH60061117
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 06:28:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wdhxa6qrh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 06:28:19 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 21 Nov 2019 11:28:16 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 11:28:12 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xALBRXm241812354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 11:27:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B745A405F;
 Thu, 21 Nov 2019 11:28:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87E12A4054;
 Thu, 21 Nov 2019 11:28:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.70.129])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Nov 2019 11:28:10 +0000 (GMT)
Subject: Re: [PATCH 02/15] s390x: Beautify diag308 handling
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-3-frankja@linux.ibm.com>
 <f4eca3d1-f5ac-8d5a-5b30-4a15a5987358@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 21 Nov 2019 12:28:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f4eca3d1-f5ac-8d5a-5b30-4a15a5987358@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vH2pVTml2dPELYPtLpORat4KxEVNMVWxF"
X-TM-AS-GCONF: 00
x-cbid: 19112111-0020-0000-0000-0000038CD898
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112111-0021-0000-0000-000021E31225
Message-Id: <933f425e-7353-775c-f8b4-efb0c21e9bf8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_02:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=2 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210104
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vH2pVTml2dPELYPtLpORat4KxEVNMVWxF
Content-Type: multipart/mixed; boundary="HagdVoBrpDaWBO7eA0fmFJe5e7tjtlGB4"

--HagdVoBrpDaWBO7eA0fmFJe5e7tjtlGB4
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/21/19 12:21 PM, David Hildenbrand wrote:
> On 20.11.19 12:43, Janosch Frank wrote:
>> Let's improve readability by:
>> * Using constants for the subcodes
>> * Moving parameter checking into a function
>> * Removing subcode > 6 check as the default case catches that
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   target/s390x/diag.c | 54 +++++++++++++++++++++++++++----------------=
--
>>   1 file changed, 32 insertions(+), 22 deletions(-)
>>
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index 53c2f81f2a..067c667ba7 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -53,6 +53,29 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1=
, uint64_t r3)
>>   #define DIAG_308_RC_NO_CONF         0x0102
>>   #define DIAG_308_RC_INVALID         0x0402
>>  =20
>> +#define DIAG308_RES_MOD_CLR		0
>> +#define DIAG308_RES_LOAD_NORM		1
>> +#define DIAG308_LOAD_CLEAR		3
>> +#define DIAG308_LOAD_NORMAL_DUMP	4
>> +#define DIAG308_SET			5
>> +#define DIAG308_STORE			6
>> +
>> +static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64=
_t addr,
>> +                              uintptr_t ra, bool write)
>> +{
>> +    if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
>> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +        return -EINVAL;
>> +    }
>> +    if (!address_space_access_valid(&address_space_memory, addr,
>> +                                    sizeof(IplParameterBlock), write,=

>> +                                    MEMTXATTRS_UNSPECIFIED)) {
>> +        s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +        return -EINVAL;
>> +    }
>> +    return 0;
>> +}
>> +
>>   void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, u=
intptr_t ra)
>>   {
>>       CPUState *cs =3D env_cpu(env);
>> @@ -65,30 +88,24 @@ void handle_diag_308(CPUS390XState *env, uint64_t =
r1, uint64_t r3, uintptr_t ra)
>>           return;
>>       }
>>  =20
>> -    if ((subcode & ~0x0ffffULL) || (subcode > 6)) {
>> +    if (subcode & ~0x0ffffULL) {
>=20
> Strange, the default case in the switch was basically dead code.
>=20
>>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>           return;
>>       }
>>  =20
>>       switch (subcode) {
>> -    case 0:
>> +    case DIAG308_RES_MOD_CLR:
>>           s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
>>           break;
>> -    case 1:
>> +    case DIAG308_RES_LOAD_NORM:
>>           s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
>>           break;
>> -    case 3:
>> +    case DIAG308_LOAD_CLEAR:
>> +        /* Well we still lack the clearing bit... */
>>           s390_ipl_reset_request(cs, S390_RESET_REIPL);
>>           break;
>> -    case 5:
>> -        if ((r1 & 1) || (addr & 0x0fffULL)) {
>> -            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> -            return;
>> -        }
>> -        if (!address_space_access_valid(&address_space_memory, addr,
>> -                                        sizeof(IplParameterBlock), fa=
lse,
>> -                                        MEMTXATTRS_UNSPECIFIED)) {
>> -            s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +    case DIAG308_SET:
>> +        if (diag308_parm_check(env, r1, addr, ra, false)) {
>>               return;
>>           }
>>           iplb =3D g_new0(IplParameterBlock, 1);
>> @@ -110,15 +127,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t=
 r1, uint64_t r3, uintptr_t ra)
>>   out:
>>           g_free(iplb);
>>           return;
>> -    case 6:
>> -        if ((r1 & 1) || (addr & 0x0fffULL)) {
>> -            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> -            return;
>> -        }
>> -        if (!address_space_access_valid(&address_space_memory, addr,
>> -                                        sizeof(IplParameterBlock), tr=
ue,
>> -                                        MEMTXATTRS_UNSPECIFIED)) {
>> -            s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +    case DIAG308_STORE:
>> +        if (diag308_parm_check(env, r1, addr, ra, true)) {
>>               return;
>>           }
>>           iplb =3D s390_ipl_get_iplb();
>>
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!




--HagdVoBrpDaWBO7eA0fmFJe5e7tjtlGB4--

--vH2pVTml2dPELYPtLpORat4KxEVNMVWxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3WdMoACgkQ41TmuOI4
ufhklQ/+NsQf9u4YlPYN8s07JKtAuAxEqd8r9WZJLK8ZOM8+RpJ+VwSm2PKZdVbv
/km0iYc6EjlSskDEUl9xXkUQPmBEeDmhmTRpmha1gwS3V7xitiFPESCo/BI2/kRm
GOCZA4C75nDmgFsXyICpoynkfi6ETIR5ATw0uij2aGatjYPI8C2ajOwIr4+FfpwW
oOdmXQVGE9uKIhhg+OkHZj4NGA1lnKfCdfYcKkb7I8VnyeZp3nY+HqXZpL+sgmvL
j+r1ZzhgSxK/Yew7lNHmc7eZ9sjRPosoHEEgQWMppV5kl4gAFh0hGIdX4JjR0T+Y
lnCp5Ubt382LCXBDLjLWJZT6YxvY6M1/AaOVsRxY+9XajatbdYOCm5bhWNFTsQDc
/dV4rUBtEjMU/rPyDRgB4IT540a2Ts2qiY0F2PoswrqYrRKN0QKa2fT0R/TAcMoU
hCEqmNshUAf+DZ2UDIUe1Y0SA4nGsPP/Qb8auVF/mP1L010S2KJkrNCr4DYPGFGC
IrBG4VfpaeX37gRIAiW+qfT5aa6XbUpqLvoG5hzsVL6Pd7iaPxSjeHj0HMooqXpv
b/Hb9EBEwwo75/+584v1umxJczai/K6VSGByZco2VKBKsOnVxH97YtoIyN5qBf5h
5uEBI6upsDftXKGr9NFqwK8EZ0WVqCPo/EL0w3+4c3E4ba3NOpA=
=Ahkl
-----END PGP SIGNATURE-----

--vH2pVTml2dPELYPtLpORat4KxEVNMVWxF--


