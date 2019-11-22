Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C1C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF93520714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF93520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY84y-0001vX-RV
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iY83e-00015L-C6
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iY83c-0001al-UO
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:29:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iY83a-0001YL-Sl
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:29:03 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAMCSgcd099942
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 07:28:58 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wdqmj7dyg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 07:28:58 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 22 Nov 2019 12:28:55 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Nov 2019 12:28:51 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAMCSoOh54853634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Nov 2019 12:28:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4507F11C04C;
 Fri, 22 Nov 2019 12:28:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1ECB11C05E;
 Fri, 22 Nov 2019 12:28:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.41.23])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Nov 2019 12:28:49 +0000 (GMT)
Subject: Re: [PATCH] Remove wrappers
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <4793f8ae-a709-2a41-ea71-4197a026b58a@redhat.com>
 <20191122122019.23069-1-frankja@linux.ibm.com>
 <f63f7243-005a-6679-df31-577126938170@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 22 Nov 2019 13:28:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f63f7243-005a-6679-df31-577126938170@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8Ro1Hw2yLIhL8ehPbXw7XvMRon6oTu2PQ"
X-TM-AS-GCONF: 00
x-cbid: 19112212-0028-0000-0000-000003BE03A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112212-0029-0000-0000-000024812FEB
Message-Id: <5efc1cba-2a8b-f4cb-dc03-d2733f089787@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220112
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
--8Ro1Hw2yLIhL8ehPbXw7XvMRon6oTu2PQ
Content-Type: multipart/mixed; boundary="0GM3yb6vLxVnZzFZkaasMoIU9mtNiv4HH"

--0GM3yb6vLxVnZzFZkaasMoIU9mtNiv4HH
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/22/19 1:23 PM, David Hildenbrand wrote:
> On 22.11.19 13:20, Janosch Frank wrote:
>> That's what it would look like.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   target/s390x/cpu-qom.h | 12 ++++++++----
>>   target/s390x/cpu.c     | 28 +++++-----------------------
>>   target/s390x/cpu.h     |  8 +++++---
>>   target/s390x/sigp.c    |  4 ++--
>>   4 files changed, 20 insertions(+), 32 deletions(-)
>>
>> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
>> index b809ec8418..e8ec999e77 100644
>> --- a/target/s390x/cpu-qom.h
>> +++ b/target/s390x/cpu-qom.h
>> @@ -34,13 +34,18 @@
>>   typedef struct S390CPUModel S390CPUModel;
>>   typedef struct S390CPUDef S390CPUDef;
>>  =20
>> +typedef enum cpu_reset_type {
>> +    S390_CPU_RESET_NORMAL,
>> +    S390_CPU_RESET_INITIAL,
>> +    S390_CPU_RESET_CLEAR,
>> +} cpu_reset_type;
>> +
>>   /**
>>    * S390CPUClass:
>>    * @parent_realize: The parent class' realize handler.
>>    * @parent_reset: The parent class' reset handler.
>>    * @load_normal: Performs a load normal.
>> - * @cpu_reset: Performs a CPU reset.
>> - * @initial_cpu_reset: Performs an initial CPU reset.
>> + * @reset: Performs a CPU reset of a given type.
>>    *
>>    * An S/390 CPU model.
>>    */
>> @@ -57,8 +62,7 @@ typedef struct S390CPUClass {
>>       DeviceRealize parent_realize;
>>       void (*parent_reset)(CPUState *cpu);
>>       void (*load_normal)(CPUState *cpu);
>> -    void (*cpu_reset)(CPUState *cpu);
>> -    void (*initial_cpu_reset)(CPUState *cpu);
>> +    void (*reset)(CPUState *cpu, cpu_reset_type type);
>>   } S390CPUClass;
>>  =20
>>   typedef struct S390CPU S390CPU;
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 556afecbc1..970495d042 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -82,12 +82,6 @@ static void s390_cpu_load_normal(CPUState *s)
>>   }
>>   #endif
>>  =20
>> -typedef enum cpu_reset_type {
>> -    S390_CPU_RESET_NORMAL,
>> -    S390_CPU_RESET_INITIAL,
>> -    S390_CPU_RESET_CLEAR,
>> -} cpu_reset_type;
>> -
>>   static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
>>   {
>>       S390CPU *cpu =3D S390_CPU(s);
>> @@ -138,21 +132,6 @@ static void s390_cpu_reset(CPUState *s, cpu_reset=
_type type)
>>   #endif
>>   }
>>  =20
>> -static void s390_cpu_reset_normal(CPUState *s)
>> -{
>> -    return s390_cpu_reset(s, S390_CPU_RESET_NORMAL);
>> -}
>> -
>> -static void s390_cpu_reset_initial(CPUState *s)
>> -{
>> -    return s390_cpu_reset(s, S390_CPU_RESET_INITIAL);
>> -}
>> -
>> -static void s390_cpu_reset_clear(CPUState *s)
>> -{
>> -    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
>> -}
>> -
>>   #if !defined(CONFIG_USER_ONLY)
>>   static void s390_cpu_machine_reset_cb(void *opaque)
>>   {
>> @@ -444,6 +423,11 @@ static Property s390x_cpu_properties[] =3D {
>>       DEFINE_PROP_END_OF_LIST()
>>   };
>>  =20
>> +static void s390_cpu_reset_clear(CPUState *s)
>> +{
>> +    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
>> +}
>> +
>>   static void s390_cpu_class_init(ObjectClass *oc, void *data)
>>   {
>>       S390CPUClass *scc =3D S390_CPU_CLASS(oc);
>> @@ -459,8 +443,6 @@ static void s390_cpu_class_init(ObjectClass *oc, v=
oid *data)
>>   #if !defined(CONFIG_USER_ONLY)
>>       scc->load_normal =3D s390_cpu_load_normal;
>>   #endif
>> -    scc->cpu_reset =3D s390_cpu_reset_normal;
>> -    scc->initial_cpu_reset =3D s390_cpu_reset_initial;
>=20
> You have to set
>=20
> scc->reset =3D s390_cpu_reset;
>=20
> if I'm not wrong.

Yeah, that would make sense :)
I'm also going to tripple check if we are doing the right resets.


>=20
>>       cc->reset =3D s390_cpu_reset_clear;
>>       cc->class_by_name =3D s390_cpu_class_by_name,
>>       cc->has_work =3D s390_cpu_has_work;
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 17460ed7b3..687b31d87e 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -734,21 +734,23 @@ static inline uint64_t s390_build_validity_mcic(=
void)
>>  =20
>>   static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_d=
ata arg)
>>   {
>> -    cpu_reset(cs);
>> +    S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
>> +
>> +    scc->reset(cs, S390_CPU_RESET_CLEAR);
>>   }
>>  =20
>>   static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data a=
rg)
>>   {
>>       S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
>>  =20
>> -    scc->cpu_reset(cs);
>> +    scc->reset(cs, S390_CPU_RESET_CLEAR);
>>   }
>>  =20
>>   static inline void s390_do_cpu_initial_reset(CPUState *cs, run_on_cp=
u_data arg)
>>   {
>>       S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
>>  =20
>> -    scc->initial_cpu_reset(cs);
>> +    scc->reset(cs, S390_CPU_RESET_INITIAL);
>>   }
>>  =20
>>   static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_=
data arg)
>> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
>> index 2ce22d4dc1..727875bb4a 100644
>> --- a/target/s390x/sigp.c
>> +++ b/target/s390x/sigp.c
>> @@ -254,7 +254,7 @@ static void sigp_initial_cpu_reset(CPUState *cs, r=
un_on_cpu_data arg)
>>       SigpInfo *si =3D arg.host_ptr;
>>  =20
>>       cpu_synchronize_state(cs);
>> -    scc->initial_cpu_reset(cs);
>> +    scc->reset(cs, S390_CPU_RESET_INITIAL);
>>       cpu_synchronize_post_reset(cs);
>>       si->cc =3D SIGP_CC_ORDER_CODE_ACCEPTED;
>>   }
>> @@ -266,7 +266,7 @@ static void sigp_cpu_reset(CPUState *cs, run_on_cp=
u_data arg)
>>       SigpInfo *si =3D arg.host_ptr;
>>  =20
>>       cpu_synchronize_state(cs);
>> -    scc->cpu_reset(cs);
>> +    scc->reset(cs, S390_CPU_RESET_NORMAL);
>>       cpu_synchronize_post_reset(cs);
>>       si->cc =3D SIGP_CC_ORDER_CODE_ACCEPTED;
>>   }
>>
>=20
> Looks good and much cleaner to me :)
>=20



--0GM3yb6vLxVnZzFZkaasMoIU9mtNiv4HH--

--8Ro1Hw2yLIhL8ehPbXw7XvMRon6oTu2PQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3X1IEACgkQ41TmuOI4
ufibBA/9Ewv2TO8C2L3Nb6k+n5f3+42lhq9CgXxwKIa6YFyQgMoawCPry6iWgbbx
7hsdtVF8bPkwQbRHqRZicSOAtyQ0QITFP/30MXK11ZOGW/6THNdjvS+hDnIlgcN7
xBWi03YyxjVlqTZUBcRGlcR1jiRNvl9eGVtDpD05TntMgY1d1iwYhHVCSb9YKRgH
QjsPLCqeJsKebw62JLju5YlDrzwiGsTOEGmY3PQ2ODg2Wct74pTuEqzG6Vj5w3oh
XkoM+LoNzELkBBjcbxpdItMDS3cTRm7SgH2sNTsWl+gUZy4IGY6WvxJHscz8jE5/
bX+nGBDSAbAwormKZxr+HVfDs5GlArc6FnAB9ek+sIObgLUCaB/CmuhblDqo30in
Y9M4/CUXrsHgs2cb8EwoyEpgiR9UVgD90Jsu0VtIJH/xKtOqr6KpoHBz2Xt/YTAK
eQjVBbmqhUAo7VA/IL9WQAckZwTiD5mv5U+Gby8tiaQx1VQy7e0eNa4if3APDdSd
lCJOWTzw4dwQVAsksPydTlV4K9RjFC8xFRfUJMa91lGoIL/DocIfxsLMlt/sodXC
LqaYHDgvc1VPZkYH9prXD3p0jnJ5yKHzOcgzWlTlIHfxbtjfBnbQ+b8vearnXsdq
guaTBryF5yS415fFNrrlETKudKCI+DFxMaV+xJd2KLciTnVD3Sc=
=R8Le
-----END PGP SIGNATURE-----

--8Ro1Hw2yLIhL8ehPbXw7XvMRon6oTu2PQ--


