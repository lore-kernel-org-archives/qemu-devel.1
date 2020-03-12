Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD44BC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A82206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A82206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQPV-000599-NH
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jCQNN-0003oz-Kk
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jCQNM-00041h-5M
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:08:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jCQNL-000411-Pp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:08:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02CG7Gcc069808
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:07:58 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yqpe7ec54-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:07:56 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 12 Mar 2020 16:07:50 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Mar 2020 16:07:46 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02CG7jcW51249194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:07:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3A5352054;
 Thu, 12 Mar 2020 16:07:45 +0000 (GMT)
Received: from dyn-9-152-224-122.boeblingen.de.ibm.com (unknown
 [9.152.224.122])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 882225204F;
 Thu, 12 Mar 2020 16:07:45 +0000 (GMT)
Subject: Re: [PATCH v9 11/15] s390x: protvirt: Disable address checks for PV
 guest IO emulation
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-12-frankja@linux.ibm.com>
 <e17fae02-5195-b4ed-9aca-63b8fb2b8a60@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 12 Mar 2020 17:07:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e17fae02-5195-b4ed-9aca-63b8fb2b8a60@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9lC64ycr25CScjA7CPwqwXH7IItqfoA6Y"
X-TM-AS-GCONF: 00
x-cbid: 20031216-0020-0000-0000-000003B3542F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031216-0021-0000-0000-0000220BA8F3
Message-Id: <46eb4e3f-6dac-c26c-d757-90696c0b095c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-12_09:2020-03-11,
 2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=3 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120083
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9lC64ycr25CScjA7CPwqwXH7IItqfoA6Y
Content-Type: multipart/mixed; boundary="sTnHJ2a8EYZX1l8zEnwWjtlyjBUgD56i8"

--sTnHJ2a8EYZX1l8zEnwWjtlyjBUgD56i8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/12/20 4:41 PM, Christian Borntraeger wrote:
> On 11.03.20 14:21, Janosch Frank wrote:
>> IO instruction data is routed through SIDAD for protected guests, so
>> adresses do not need to be checked, as this is kernel memory.
>=20
> Maybe also mention that the data structures for  the I/O instrutions
> start at offset 0 of the SIDA?

You mean in the comment for get_address_from_regs() or in the commit
message? It would certainly make sense for get_address_from_regs().

>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20
>=20
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>=20
>=20
>=20
>> ---
>>  target/s390x/ioinst.c | 33 ++++++++++++++++++++++++++-------
>>  1 file changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>> index c437a1d8c6afed80..481d789de9e09a04 100644
>> --- a/target/s390x/ioinst.c
>> +++ b/target/s390x/ioinst.c
>> @@ -16,6 +16,23 @@
>>  #include "hw/s390x/ioinst.h"
>>  #include "trace.h"
>>  #include "hw/s390x/s390-pci-bus.h"
>> +#include "hw/s390x/pv.h"
>> +
>> +static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ip=
b,
>> +                                      uint8_t *ar)
>> +{
>> +    /*
>> +     * Addresses for protected guests are all offsets into the
>> +     * satellite block which holds the IO control structures. Those
>> +     * control structures are always aligned and accessible, so we ca=
n
>> +     * return 0 here which will pass the following address checks.
>> +     */
>> +    if (s390_is_pv()) {
>> +        *ar =3D 0;
>> +        return 0;
>> +    }
>> +    return decode_basedisp_s(env, ipb, ar);
>> +}
>> =20
>>  int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, =
int *ssid,
>>                                   int *schid)
>> @@ -114,7 +131,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg=
1, uint32_t ipb, uintptr_t ra)
>>      CPUS390XState *env =3D &cpu->env;
>>      uint8_t ar;
>> =20
>> -    addr =3D decode_basedisp_s(env, ipb, &ar);
>> +    addr =3D get_address_from_regs(env, ipb, &ar);
>>      if (addr & 3) {
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          return;
>> @@ -171,7 +188,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg=
1, uint32_t ipb, uintptr_t ra)
>>      CPUS390XState *env =3D &cpu->env;
>>      uint8_t ar;
>> =20
>> -    addr =3D decode_basedisp_s(env, ipb, &ar);
>> +    addr =3D get_address_from_regs(env, ipb, &ar);
>>      if (addr & 3) {
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          return;
>> @@ -203,7 +220,7 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ip=
b, uintptr_t ra)
>>      CPUS390XState *env =3D &cpu->env;
>>      uint8_t ar;
>> =20
>> -    addr =3D decode_basedisp_s(env, ipb, &ar);
>> +    addr =3D get_address_from_regs(env, ipb, &ar);
>>      if (addr & 3) {
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          return;
>> @@ -234,7 +251,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t re=
g1, uint32_t ipb,
>>      CPUS390XState *env =3D &cpu->env;
>>      uint8_t ar;
>> =20
>> -    addr =3D decode_basedisp_s(env, ipb, &ar);
>> +    addr =3D get_address_from_regs(env, ipb, &ar);
>>      if (addr & 3) {
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          return;
>> @@ -303,7 +320,7 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1=
, uint32_t ipb, uintptr_t ra)
>>          return -EIO;
>>      }
>>      trace_ioinst_sch_id("tsch", cssid, ssid, schid);
>> -    addr =3D decode_basedisp_s(env, ipb, &ar);
>> +    addr =3D get_address_from_regs(env, ipb, &ar);
>>      if (addr & 3) {
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          return -EIO;
>> @@ -601,7 +618,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb=
, uintptr_t ra)
>>  {
>>      ChscReq *req;
>>      ChscResp *res;
>> -    uint64_t addr;
>> +    uint64_t addr =3D 0;
>>      int reg;
>>      uint16_t len;
>>      uint16_t command;
>> @@ -610,7 +627,9 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb=
, uintptr_t ra)
>> =20
>>      trace_ioinst("chsc");
>>      reg =3D (ipb >> 20) & 0x00f;
>> -    addr =3D env->regs[reg];
>> +    if (!s390_is_pv()) {
>> +        addr =3D env->regs[reg];
>> +    }
>>      /* Page boundary? */
>>      if (addr & 0xfff) {
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>



--sTnHJ2a8EYZX1l8zEnwWjtlyjBUgD56i8--

--9lC64ycr25CScjA7CPwqwXH7IItqfoA6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5qXlEACgkQ41TmuOI4
ufitAg/+K7/+Hxnrt851S5zPS8cy2MYKUZLT9nzQYro7tKJkfQinzph8Ponk/mwJ
NEwRxhFm0r3JMt6r4z357cn5RuQbPKmKd0gDweWMuFD+0bFetIJ0fU+7lErO0E3V
fqZlS+dw2H4ojuT2Y8YQzB3ws7BJkVnpSN6XjwreuXJEItRkf12KTOnp2Q/h0MEb
hbTfGjWEnn5N3OxWeHOwwqvKDYMLNUIKCtS7dGQVYFL1suZ3XXMEe2o9+GhqGg1I
o2u174GP3JlENrvuJOuijw0K2vYlTUP9jqIpiKYGEra9IHLbH6mw687ACH/gDcb1
6VMP69ecC8f+/Y8fiWXt3PWirCAKvc8tB5jbf5b2Z1SgcpxkuEO/TQluTr0X1Mez
1KXByr5qWywtuQJRD3wkq5ADBB3SNkHq1AO22tjfDW3bAO465WET3W0otv6gbax2
UN8Y6ge5jba7JjK+F/7ElxvvvloK0zUcZyWryJkCuSvF6VVJGCKIYTPwmn42Pc24
5F4WFupuTxfCOuwTKXdzypazoUsbYxtEgAgvLvsBzUGoWzo4B3VxXK7FJ/FcQQJ1
rpswye6dSKf4AdkGYzAD8Jx8UFO9uAl7a8alZPoesHXzv/6Hzhry1Z4rTjMht8GU
r+0/t+L6BJeVzNm+LXERjnEd8v3Lmp0SP9VFWuXP5J1pDUbglkU=
=N+KN
-----END PGP SIGNATURE-----

--9lC64ycr25CScjA7CPwqwXH7IItqfoA6Y--


