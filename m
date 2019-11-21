Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F85C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F1720731
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F1720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmFc-0001zX-Nr
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXmEt-0001QG-Ay
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXmEs-0001qd-19
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:11:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXmEr-0001pf-P1
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:11:13 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xALD6lL9103104
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:11:10 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wdu6283md-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:11:10 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 21 Nov 2019 13:11:07 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 13:11:04 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xALDB2a259965582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 13:11:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3D7CAE053;
 Thu, 21 Nov 2019 13:11:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FAA3AE04D;
 Thu, 21 Nov 2019 13:11:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.70.129])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Nov 2019 13:11:02 +0000 (GMT)
Subject: Re: [PATCH 01/15] s390x: Cleanup cpu resets
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-2-frankja@linux.ibm.com>
 <32e994b4-6ae2-8de2-4ae0-fc61a21f5f7a@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 21 Nov 2019 14:11:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <32e994b4-6ae2-8de2-4ae0-fc61a21f5f7a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Aqbzy2EGhA7ACq70xVe28A45wOccvLDrE"
X-TM-AS-GCONF: 00
x-cbid: 19112113-0020-0000-0000-0000038CE0C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112113-0021-0000-0000-000021E31AC1
Message-Id: <b5a83796-792a-3b5b-bbf1-fd806edb8e92@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_02:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210120
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Aqbzy2EGhA7ACq70xVe28A45wOccvLDrE
Content-Type: multipart/mixed; boundary="qJNPJHsSinXVcYPPWo4E2exHPIJWOTzPk"

--qJNPJHsSinXVcYPPWo4E2exHPIJWOTzPk
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/21/19 1:53 PM, Thomas Huth wrote:
> On 20/11/2019 12.43, Janosch Frank wrote:
>> Let's move the resets into one function and switch by type, so we can
>> use fallthroughs for shared reset actions.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c |   3 +
>>  target/s390x/cpu.c         | 111 ++++++++++++++++--------------------=
-
>>  2 files changed, 52 insertions(+), 62 deletions(-)
> [...]
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 3abe7e80fd..10d5b915d8 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -82,67 +82,53 @@ static void s390_cpu_load_normal(CPUState *s)
>>  }
>>  #endif
>> =20
>> -/* S390CPUClass::cpu_reset() */
>> -static void s390_cpu_reset(CPUState *s)
>> +enum {
>> +    S390_CPU_RESET_NORMAL,
>> +    S390_CPU_RESET_INITIAL,
>> +    S390_CPU_RESET_CLEAR,
>> +};
>> +
>> +static void s390_cpu_reset(CPUState *s, uint8_t type)
>=20
> Please give the enum a name and use that instead of uint8_t for "type".=

> Or at least make it an "int". uint8_t is not really appropriate here.

Sure

>=20
>>  {
>>      S390CPU *cpu =3D S390_CPU(s);
>>      S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
>>      CPUS390XState *env =3D &cpu->env;
>> =20
>> -    env->pfault_token =3D -1UL;
>> -    env->bpbc =3D false;
>>      scc->parent_reset(s);
>>      cpu->env.sigp_order =3D 0;
>>      s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>> -}
>> =20
>> -/* S390CPUClass::initial_reset() */
>> -static void s390_cpu_initial_reset(CPUState *s)
>> -{
>> -    S390CPU *cpu =3D S390_CPU(s);
>> -    CPUS390XState *env =3D &cpu->env;
>> +    /* Set initial values after clearing */
>> +    switch (type) {
>> +    case S390_CPU_RESET_CLEAR:
>> +        /* Fallthrough will clear the rest */
>=20
> I think you could drop the above comment, since /* Fallthrough */ two
> lines later should be enough.
>=20
>> +        memset(env, 0, offsetof(CPUS390XState, start_initial_reset_fi=
elds));
>> +        /* Fallthrough */
>> +    case S390_CPU_RESET_INITIAL:
>> +        memset(&env->start_initial_reset_fields, 0,
>> +               offsetof(CPUS390XState, end_reset_fields) -
>> +               offsetof(CPUS390XState, start_initial_reset_fields));
>> +        /* architectured initial values for CR 0 and 14 */
>> +        env->cregs[0] =3D CR0_RESET;
>> +        env->cregs[14] =3D CR14_RESET;
>> =20
>> -    s390_cpu_reset(s);
>> -    /* initial reset does not clear everything! */
>> -    memset(&env->start_initial_reset_fields, 0,
>> -        offsetof(CPUS390XState, end_reset_fields) -
>> -        offsetof(CPUS390XState, start_initial_reset_fields));
>> -
>> -    /* architectured initial values for CR 0 and 14 */
>> -    env->cregs[0] =3D CR0_RESET;
>> -    env->cregs[14] =3D CR14_RESET;
>> -
>> -    /* architectured initial value for Breaking-Event-Address registe=
r */
>> -    env->gbea =3D 1;
>> -
>> -    env->pfault_token =3D -1UL;
>> -
>> -    /* tininess for underflow is detected before rounding */
>> -    set_float_detect_tininess(float_tininess_before_rounding,
>> -                              &env->fpu_status);
>> +        /* architectured initial value for Breaking-Event-Address reg=
ister */
>> +        env->gbea =3D 1;
>> +        /* tininess for underflow is detected before rounding */
>> +        set_float_detect_tininess(float_tininess_before_rounding,
>> +                                  &env->fpu_status);
>> +        /* Fallthrough */
>> +    case S390_CPU_RESET_NORMAL:
>> +        env->pfault_token =3D -1UL;
>> +        env->bpbc =3D false;
>> +        break;
>> +    }
>> =20
>>      /* Reset state inside the kernel that we cannot access yet from Q=
EMU. */
>> -    if (kvm_enabled()) {
>> -        kvm_s390_reset_vcpu(cpu);
>> +    if (kvm_enabled() && (type =3D=3D S390_CPU_RESET_CLEAR ||
>> +                          type =3D=3D S390_CPU_RESET_INITIAL)) {
>> +            kvm_s390_reset_vcpu(cpu);
>>      }
>=20
> Why don't you simply move that into the switch-case statement, too?

There was a reason for that, time to load it from cold storage...

>=20
> [...]
>=20
> Anyway, re-using code is of course a good idea, but I wonder whether it=

> would be nicer to keep most things in place, and then simply chain the
> functions like this:

I tried that and I prefer the version in the patch.

>=20
> static void s390_cpu_reset_normal(CPUState *s)
> {
>    ...
> }
>=20
> static void s390_cpu_reset_initial(CPUState *s)
> {
>     ...
>     s390_cpu_reset_normal(s);
>     ...
> }
>=20
> static void s390_cpu_reset_clear(CPUState *s)
> {
>     ...
>     s390_cpu_reset_initial()
>     ...
> }
>=20
> Just my 0.02 =80, but at least for me, that's easier to understand than=
 a
> switch-case statement with fallthroughs inbetween.
>=20
>  Thomas
>=20



--qJNPJHsSinXVcYPPWo4E2exHPIJWOTzPk--

--Aqbzy2EGhA7ACq70xVe28A45wOccvLDrE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3WjOUACgkQ41TmuOI4
ufjZSg//W1fdXOQ1tlVRpFrhxWbqT/CeDHLEq8RNPIaI5tKLzll4i3siS25ftzR6
tdJPt6HmCSdXF9+9QDKsLHi7V8vLIrN0/attXO3fBDGNcEzHnEkd0a7q92qoAE1d
tYURfTXaDQU9k8/OI1KzKtMAqlE7XEGC4E4SG8gttVTL46cPHHpaY3I1EXvFWcdc
TLzk5zGsOGONoDKofu0LBXkFeEMpebwLTNrOP79cYOiSPezfYooQSkVihIa57aR4
VPluYAeHEixkI9PB0p8kNjP/VsWgo5zYmyGR/G1XOFcmMDkq6+Mgd1glfkwMaDwj
VALnkOZbrgRVgVJxtJDWjThB8H7FVOxZwTIdh4xMgBrHmG+JMzKQzgG81rTjLtMf
ergKLRxwGBY83/Y3V6nh8B/LvZHyfQlbViKV0/B379EAUcErVLY+/jLQzODtSgQV
gxaJfDqU4nQntyv8AgZs5tQTu+BJnPfqBAC7FdLcwUTO9pbjqgdRqg5hWyLkrRXS
lNRC/GgrZywutW0YeRuo12VNI9mNEIO1muyvbxBWCkwHTOmgqn0X/XUvlpIQ34MT
DJxzzLDi3c6nDla0nTXxeYisfVI/NWUhAAKQDaBdJCSglAAEmZQGDuI86Kk71dOq
cUOo7BvY6jHu5Hnf7E4HoWdhlepuDjPujU9ewvR4y5XzjAQdtBk=
=ANSV
-----END PGP SIGNATURE-----

--Aqbzy2EGhA7ACq70xVe28A45wOccvLDrE--


