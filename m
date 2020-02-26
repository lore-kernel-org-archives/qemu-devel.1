Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B2C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C4524683
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C4524683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6x3y-0000mL-0m
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j6x2m-0008I3-2J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j6x2k-0007NX-6q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:48:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j6x2j-0007Lf-Nj
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:48:05 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QDisjV063074
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 08:48:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydq6gxfds-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 08:48:04 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 26 Feb 2020 13:48:01 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Feb 2020 13:47:59 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01QDlwBS52756494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 13:47:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A00E0A4060;
 Wed, 26 Feb 2020 13:47:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72A91A405C;
 Wed, 26 Feb 2020 13:47:58 +0000 (GMT)
Received: from dyn-9-152-224-212.boeblingen.de.ibm.com (unknown
 [9.152.224.212])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 13:47:58 +0000 (GMT)
Subject: Re: [PATCH v5 01/18] s390x: Use constant for ESA PSW address
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-2-frankja@linux.ibm.com>
 <0ac821dd-09a8-3b77-d4db-c167f5a4ac77@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Wed, 26 Feb 2020 14:47:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0ac821dd-09a8-3b77-d4db-c167f5a4ac77@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Bp36w0C8WO0TTojepdjJLHO4RvojtrcQP"
X-TM-AS-GCONF: 00
x-cbid: 20022613-0012-0000-0000-0000038A78FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022613-0013-0000-0000-000021C71F0E
Message-Id: <d54288cc-459b-f09b-2201-d849a07ce0bb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_04:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 suspectscore=3 bulkscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260102
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
--Bp36w0C8WO0TTojepdjJLHO4RvojtrcQP
Content-Type: multipart/mixed; boundary="By9X45XKtxrvTrdd72LZksuTxyZrxT801"

--By9X45XKtxrvTrdd72LZksuTxyZrxT801
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/26/20 2:46 PM, Christian Borntraeger wrote:
>=20
>=20
> On 26.02.20 13:20, Janosch Frank wrote:
>> Lets make it a bit more clear that we're extracting the 31 bit address=

>> from the short psw.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>=20
>=20
>=20
> PSW_MASK_ESA_MASK and PSW_MASK_ESA_ADDR look pretty similar, but I cant=
 find
> a good name. We could use ~PSW_MASK_ESA_ADDR as an alternative.

I'm also not too happy about it, if there's a better suggestion I'd take
it any day.

>=20
> Either way, this makes sense.
>=20
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks!

>=20
>> ---
>>  hw/s390x/ipl.c     | 2 +-
>>  target/s390x/cpu.c | 4 ++--
>>  target/s390x/cpu.h | 1 +
>>  3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 7773499d7f..42e21e7a6a 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -179,7 +179,7 @@ static void s390_ipl_realize(DeviceState *dev, Err=
or **errp)
>>                  /* if not Linux load the address of the (short) IPL P=
SW */
>>                  ipl_psw =3D rom_ptr(4, 4);
>>                  if (ipl_psw) {
>> -                    pentry =3D be32_to_cpu(*ipl_psw) & 0x7fffffffUL;
>> +                    pentry =3D be32_to_cpu(*ipl_psw) & PSW_MASK_ESA_A=
DDR;
>>                  } else {
>>                      error_setg(&err, "Could not get IPL PSW");
>>                      goto error;
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 8da1905485..43360912a0 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -78,13 +78,13 @@ static void s390_cpu_load_normal(CPUState *s)
>>      S390CPU *cpu =3D S390_CPU(s);
>>      uint64_t spsw =3D ldq_phys(s->as, 0);
>> =20
>> -    cpu->env.psw.mask =3D spsw & 0xffffffff80000000ULL;
>> +    cpu->env.psw.mask =3D spsw & PSW_MASK_ESA_MASK;
>=20
>=20
>>      /*
>>       * Invert short psw indication, so SIE will report a specificatio=
n
>>       * exception if it was not set.
>>       */
>>      cpu->env.psw.mask ^=3D PSW_MASK_SHORTPSW;
>> -    cpu->env.psw.addr =3D spsw & 0x7fffffffULL;
>> +    cpu->env.psw.addr =3D spsw & PSW_MASK_ESA_ADDR;
>> =20
>>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>>  }
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 8a557fd8d1..74e66fe0c2 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -277,6 +277,7 @@ extern const VMStateDescription vmstate_s390_cpu;
>>  #define PSW_MASK_64             0x0000000100000000ULL
>>  #define PSW_MASK_32             0x0000000080000000ULL
>>  #define PSW_MASK_ESA_ADDR       0x000000007fffffffULL
>> +#define PSW_MASK_ESA_MASK       0xffffffff80000000ULL
>> =20
>>  #undef PSW_ASC_PRIMARY
>>  #undef PSW_ASC_ACCREG
>>



--By9X45XKtxrvTrdd72LZksuTxyZrxT801--

--Bp36w0C8WO0TTojepdjJLHO4RvojtrcQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5Wdw4ACgkQ41TmuOI4
ufhfZw/8DZh7y5ZAkhuNAyYWmYB5XD21nniB9eIW6kCgTEMZPcH/wh3O+RBuq6WV
dXWwzs17j3VJDNuiU330LgE33AT1ZG47ZJ/CrBzU3EybthBC9MFE0E53Yvbr1pNM
tVQZ/4t7wJ+aUKA+/yuhQN/c+9dGm5Te6ZK5NuxSB4NHSy9N6JLJWweIblq33b98
gtraAQ7r845skpb5LxQqwcXBsi4mHZL+vMyMQIhq7taze+tneczZgLDi+DPp6RPi
VsmTguy2YJM2evz9a/C7jTo4VEa9Zpd9eD5sP90L2/lb/IWq5Yf0lt62kRlZttPE
i0G5+etNUiktbHOHyidJjGxOvJUs6VmU5j16CvgNJeiAlIx3Qsonp/IahHCQNy1z
hmiZO4oaoCN05OQtM7BBWfjPHKjKbXdPDxk/UHdZMJM3HWMLt+TCewcIMGUHU/ph
wstZXYUTJpnaeM2ala9hVPIRz4ZP9NQFhkTOZVdw+9zWTmjOX8D6JKT8qXro592a
gaSzkAl6PCPzMnVPU9urMJi2rUPIM6bJrn/RMDWoqxaCmscLa7mk2FG8aMnXonUh
4TgMbJshrNO1jDqoZi+5GW6hauhtX85ngzyDiyUJNg+t67XAiUSm7Rqq4gcf3pty
SWb05ulJ6PxcBeGnWaY6HaY0+Als63r05Loz81YR3N4LK8sUrnc=
=/Pfa
-----END PGP SIGNATURE-----

--Bp36w0C8WO0TTojepdjJLHO4RvojtrcQP--


