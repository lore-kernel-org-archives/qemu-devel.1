Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98E3C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF23C20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF23C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyWX-0003QW-T4
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1izyVX-00028W-Ev
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1izyVV-0006TF-VN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:56:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1izyVV-0006Ee-KF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:56:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0177rkhs116688
 for <qemu-devel@nongnu.org>; Fri, 7 Feb 2020 02:56:55 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y0knep5n2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 02:56:55 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 7 Feb 2020 07:56:53 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 7 Feb 2020 07:56:51 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0177unea32178310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Feb 2020 07:56:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 582024C04A;
 Fri,  7 Feb 2020 07:56:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4B904C044;
 Fri,  7 Feb 2020 07:56:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.65.192])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  7 Feb 2020 07:56:48 +0000 (GMT)
Subject: Re: [PATCH 03/15] s390x: protvirt: Add diag308 subcodes 8 - 10
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-4-frankja@linux.ibm.com>
 <9f9d9b6b-55e5-fe69-d6c2-f7c229b4021a@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 7 Feb 2020 08:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9f9d9b6b-55e5-fe69-d6c2-f7c229b4021a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y3XHL4Vsi52IazmCYt8TPkbhhdtjvwsnx"
X-TM-AS-GCONF: 00
x-cbid: 20020707-0028-0000-0000-000003D84486
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020707-0029-0000-0000-0000249CA8E0
Message-Id: <c79d0f60-127a-7f1f-b688-137fc6b2f0f9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-06_04:2020-02-06,
 2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=2 mlxlogscore=999 adultscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070060
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y3XHL4Vsi52IazmCYt8TPkbhhdtjvwsnx
Content-Type: multipart/mixed; boundary="Db7btgIX7MnUVD04K7wJPzif0HCKOUeD4"

--Db7btgIX7MnUVD04K7wJPzif0HCKOUeD4
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/21/19 3:36 PM, Thomas Huth wrote:
> On 20/11/2019 12.43, Janosch Frank wrote:
>> For diag308 subcodes 8 - 10 we have a new ipib of type 5. The ipib
>> holds the address and length of the secure execution header, as well
>> as a list of guest components.
>>
>> Each component is a block of memory, for example kernel or initrd,
>> which needs to be decrypted by the Ultravisor in order to run a
>> protected VM. The secure execution header instructs the Ultravisor on
>> how to handle the protected VM and its components.
>>
>> Subcodes 8 and 9 are similiar to 5 and 6 and subcode 10 will finally
>> start the protected guest.
>>
>> Subcodes 8-10 are not valid in protected mode, we have to do a subcode=

>> 3 and then the 8 and 10 combination for a protected reboot.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
> [...]
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index d4813105db..7b8a493509 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -15,6 +15,24 @@
>>  #include "cpu.h"
>>  #include "hw/qdev-core.h"
>> =20
>> +struct IPLBlockPVComp {
>> +    uint64_t tweak_pref;
>> +    uint64_t addr;
>> +    uint64_t size;
>> +} QEMU_PACKED;
>> +typedef struct IPLBlockPVComp IPLBlockPVComp;
>> +
>> +struct IPLBlockPV {
>> +    uint8_t  reserved[84];
>> +    uint8_t  reserved67[3];
>=20
> What does the "67" mean here?

Was compacted to reserved[87]

>=20
>> +    uint8_t  version;
>> +    uint32_t num_comp;
>> +    uint64_t pv_header_addr;
>> +    uint64_t pv_header_len;
>> +    struct IPLBlockPVComp components[];
>> +} QEMU_PACKED;
>> +typedef struct IPLBlockPV IPLBlockPV;
>=20
> Given the fact that we had quite some headaches with QEMU_PACKED struct=
s
> in the past already, and the structs seem to be naturally aligned ...
> what about dropping the QEMU_PACKED here and using QEMU_BUILD_BUG() to
> assert that the struct has the correct size?

As the struct in which IPLBlockPV is embeded are also packed, removing
the PACKED annotation results in this:

/mnt/dev/qemu/hw/s390x/ipl.c:544:27: error: taking address of packed
member of =91struct <anonymous>=92 may result in an unaligned pointer val=
ue
[-Werror=3Daddress-of-packed-member]


>=20
> [...]
>> @@ -185,4 +211,11 @@ static inline bool iplb_valid_fcp(IplParameterBlo=
ck *iplb)
>>             iplb->pbt =3D=3D S390_IPL_TYPE_FCP;
>>  }
>> =20
>> +static inline bool iplb_valid_se(IplParameterBlock *iplb)
>> +{
>> +    return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_PV_LEN &&
>> +           iplb->pbt =3D=3D S390_IPL_TYPE_PV;
>> +}
>> +
>> +
>=20
> Drop one empty line?
ack.

>=20
>>  #endif
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index 067c667ba7..32049bb4ee 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -52,6 +52,8 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1,=
 uint64_t r3)
>>  #define DIAG_308_RC_OK              0x0001
>>  #define DIAG_308_RC_NO_CONF         0x0102
>>  #define DIAG_308_RC_INVALID         0x0402
>> +#define DIAG_308_RC_NO_PV_CONF      0x0a02
>> +#define DIAG_308_RC_INV_FOR_PV      0x0b02
>> =20
>>  #define DIAG308_RES_MOD_CLR		0
>>  #define DIAG308_RES_LOAD_NORM		1
>> @@ -59,6 +61,9 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1,=
 uint64_t r3)
>>  #define DIAG308_LOAD_NORMAL_DUMP	4
>>  #define DIAG308_SET			5
>>  #define DIAG308_STORE			6
>> +#define DIAG308_PV_SET			8
>> +#define DIAG308_PV_STORE		9
>> +#define DIAG308_PV_START		10
>> =20
>>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64=
_t addr,
>>                                uintptr_t ra, bool write)
>> @@ -105,6 +110,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t =
r1, uint64_t r3, uintptr_t ra)
>>          s390_ipl_reset_request(cs, S390_RESET_REIPL);
>>          break;
>>      case DIAG308_SET:
>> +    case DIAG308_PV_SET: /* Set SE parms */
>>          if (diag308_parm_check(env, r1, addr, ra, false)) {
>>              return;
>>          }
>> @@ -117,7 +123,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t =
r1, uint64_t r3, uintptr_t ra)
>> =20
>>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));=

>> =20
>> -        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
>> +        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
>> +            !(iplb_valid_se(iplb) && s390_ipl_pv_check_comp(iplb) >=3D=
 0)) {
>>              env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
>>              goto out;
>>          }
>> @@ -128,10 +135,15 @@ out:
>>          g_free(iplb);
>>          return;
>>      case DIAG308_STORE:
>> +    case DIAG308_PV_STORE: /* Get SE parms */
>>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>>              return;
>>          }
>> -        iplb =3D s390_ipl_get_iplb();
>> +        if (subcode =3D=3D DIAG308_PV_STORE) {
>> +            iplb =3D s390_ipl_get_iplb_secure();
>> +        } else {
>> +            iplb =3D s390_ipl_get_iplb();
>> +        }
>>          if (iplb) {
>>              cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->l=
en));
>>              env->regs[r1 + 1] =3D DIAG_308_RC_OK;
>> @@ -139,6 +151,16 @@ out:
>>              env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
>>          }
>>          return;
>> +        break;
>=20
> <hamletmode>
> To return or to break, that's the question...
> </hamletmode>
>=20
> ... please choose one of the two.
>=20
>> +    case DIAG308_PV_START: /* SE start */
>> +        iplb =3D s390_ipl_get_iplb_secure();
>> +        if (!iplb_valid_se(iplb)) {
>> +            env->regs[r1 + 1] =3D DIAG_308_RC_NO_PV_CONF;
>> +            return;
>> +        }
>> +
>> +        s390_ipl_reset_request(cs, S390_RESET_PV);
>> +        break;
>>      default:
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          break;
>>
>=20
>  Thomas
>=20
>=20



--Db7btgIX7MnUVD04K7wJPzif0HCKOUeD4--

--y3XHL4Vsi52IazmCYt8TPkbhhdtjvwsnx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl49GEAACgkQ41TmuOI4
ufg1EQ//e5cLZrTvxmbF53dp6XPLglT47ZrGCNLiZ6V46i1dhAps6Nw0pacxlyZ6
TaSNxnjaIsjrM+hJiqK6xERxFoSGILvzmHhiQla+CC402S+x7uWk9Hkm+8kCZa5R
wJb+0XtqjuT2IkkqrfoCDpOXodOV6jJOW/FetjdaQEfQ4yqP885iAS3TUAfPWlwn
zoJT5TceB0KLvLUTiT3fiwwAtzJQXws4JKO2AuPk3uFhxDtPqYvz/80w5FL8LVwa
0osTn56aZ5YvpRxQEsEd6lH5Ytgq131sLxaByv7cv/5TO+4nvkGfTONADiUBLl4u
EpwZ+dAdOsTHs65XbWoZYGsKsl0X9P84+Q2a0m6j69QjSz9YJ8iR8tCydfyc4Vqw
yb3rR6s/5G8fS4mgh+zeIa1tDyXUuw0Th8pTSLhQiBibsIPNaARClwuYkE6RGddp
faHCC5I6wkgGNpfczjNae/LDhKuf+5dAmPNk0e7d+cJwtshRrwWb2Icf41ZGlNh3
eN3LHzZ96osFzlNeu3iS+LH3Fd4rHT+hgoQZ0YoEIrdKjyEvBffgnegwbXmRVDpd
+N34Agc9jKdCp+iPu4DgQFH5a/Z6Au/EGBJ8wpB7dJLUIbCQm6ke7HudsE8IzxRS
7R8sqK5MAMyaHGuV0tjWnNsUZhXaEmuGaaKq+ThcFdZfmZZd3Hs=
=Yb5+
-----END PGP SIGNATURE-----

--y3XHL4Vsi52IazmCYt8TPkbhhdtjvwsnx--


