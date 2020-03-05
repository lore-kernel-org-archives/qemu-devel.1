Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38955C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F4720732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F4720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rgJ-0006d5-40
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9rfG-0005GG-1l
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9rfE-0002Kf-LI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:39:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9rfE-0002JN-Cq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:39:52 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 025EY6jg064601
 for <qemu-devel@nongnu.org>; Thu, 5 Mar 2020 09:39:51 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhryexfx5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:39:50 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 5 Mar 2020 14:39:47 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 5 Mar 2020 14:39:44 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 025EciGR43385094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 14:38:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B5AF52050;
 Thu,  5 Mar 2020 14:39:43 +0000 (GMT)
Received: from dyn-9-152-224-184.boeblingen.de.ibm.com (unknown
 [9.152.224.184])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0791252057;
 Thu,  5 Mar 2020 14:39:43 +0000 (GMT)
Subject: Re: [PATCH v6 02/18] s390x: protvirt: Add diag308 subcodes 8 - 10
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-3-frankja@linux.ibm.com>
 <0e56347f-eb63-84e8-3d6d-cbdac47a22f6@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 5 Mar 2020 15:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0e56347f-eb63-84e8-3d6d-cbdac47a22f6@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yyHPuXZZUHUK8zUUW4WK89pfNbhbh9JgF"
X-TM-AS-GCONF: 00
x-cbid: 20030514-0020-0000-0000-000003B0CB22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030514-0021-0000-0000-000022090736
Message-Id: <b0358db9-d3a4-75d5-f10d-26997fe6f403@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_04:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=3 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050095
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
--yyHPuXZZUHUK8zUUW4WK89pfNbhbh9JgF
Content-Type: multipart/mixed; boundary="Y3RVSWn4rCskJKhA0x7xMiFPSQWOc5gdy"

--Y3RVSWn4rCskJKhA0x7xMiFPSQWOc5gdy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/4/20 7:59 PM, Christian Borntraeger wrote:
>=20
>=20
> On 04.03.20 12:42, Janosch Frank wrote:
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
>>  hw/s390x/ipl.c      | 47 ++++++++++++++++++++++++++++++++++++++++++--=
-
>>  hw/s390x/ipl.h      | 32 ++++++++++++++++++++++++++++++
>>  target/s390x/diag.c | 26 ++++++++++++++++++++++---
>>  3 files changed, 99 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 9c1ecd423c..80c6ab233a 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>=20
> Can you update the copyright dates for files that you touch?
>=20
>> @@ -538,15 +538,55 @@ static bool is_virtio_scsi_device(IplParameterBl=
ock *iplb)
>>      return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
>>  }
>> =20
>> +int s390_ipl_pv_check_components(IplParameterBlock *iplb)
>> +{
>> +    int i;
>> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
>> +
>> +    if (ipib_pv->num_comp =3D=3D 0) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
>> +        /* Addr must be 4k aligned */
>> +        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
>> +            return -EINVAL;
>> +        }
>> +
>> +        /* Tweak prefix is monotonously increasing with each componen=
t */
>> +        if (i < ipib_pv->num_comp - 1 &&
>=20
> Why do we need this check? Isnt that already ensured by the for loop?

This is "i < ipib_pv->num_comp - 1" because we use i + 1 below, not "i <
ipib_pv->num_comp"

>=20
>> +            ipib_pv->components[i].tweak_pref >
>> +            ipib_pv->components[i + 1].tweak_pref) {
>=20
> I think i+1 must be greater than i. So ">=3D" instead?

Ack

>=20
>> +            return -EINVAL;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>>  void s390_ipl_update_diag308(IplParameterBlock *iplb)
>=20
> maybe add a comment that explains that a guest can have 2 IPLBs. one fo=
r
> the secure guest and one thsat we go back to when rebooting.

Sure

>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> =20
>> -    ipl->iplb =3D *iplb;
>> -    ipl->iplb_valid =3D true;
>> +    if (iplb->pbt =3D=3D S390_IPL_TYPE_PV) {
>> +        ipl->iplb_pv =3D *iplb;
>> +        ipl->iplb_valid_pv =3D true;
>> +    } else {
>> +        ipl->iplb =3D *iplb;
>> +        ipl->iplb_valid =3D true;
>> +    }
>>      ipl->netboot =3D is_virtio_net_device(iplb);
>>  }
>> =20
>> +IplParameterBlock *s390_ipl_get_iplb_secure(void)
>> +{
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +
>> +    if (!ipl->iplb_valid_pv) {
>> +        return NULL;
>> +    }
>> +    return &ipl->iplb_pv;
>> +}
>> +
>>  IplParameterBlock *s390_ipl_get_iplb(void)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> @@ -561,7 +601,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s39=
0_reset reset_type)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> =20
>> -    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S3=
90_RESET_REIPL) {
>> +    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S3=
90_RESET_REIPL ||
>> +        reset_type =3D=3D S390_RESET_PV) {
>>          /* use CPU 0 for full resets */
>>          ipl->reset_cpu_index =3D 0;
>>      } else {
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index d4813105db..04be63cee1 100644
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
>> +    uint8_t  reserved[87];
>> +    uint8_t  version;
>> +    uint32_t reserved70;
>=20
> Here you have 70 (the offset in hex I guess), I t=C3=9Fhink this is an =
odd name. In addition the reserved field 2 lines above has no address par=
t in its
> name.=20

I wanted to prepare for my ipl cleanup patch set which adds offsets to
all the reserved fields. Do you want me to remove it or make the first
one "reserved18" ?



--Y3RVSWn4rCskJKhA0x7xMiFPSQWOc5gdy--

--yyHPuXZZUHUK8zUUW4WK89pfNbhbh9JgF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5hDy4ACgkQ41TmuOI4
ufiETg/+Polubxwg8Ig3Ln429F800nMRYJpDUA3brMgkeF4JSyF44VT1ucLxroEg
+b4fcdptHMWxEjt5z44f6CS2yNFIG4Pb1vEdmYJ41ZlOwo6B5A5jsPlb3KAdFfJi
bH2rcwrFHrj+SMSoMt/7Td6dkEVYrxCYfKRouPPNwhsa6VxII9KOaK2OQhqXj8J8
lhG2+vJt+mWuuJW/wvkjQ7PFSq/kUKzXQ68vyd/3er35CiesKXWW7xgiJMvk9ag/
VfE0B+B674lUxsayKUxSzd9NnXACQg/svjNj+3aUsJM/JxzhKZgdl1+kz9xTPvMo
A3c6LO7jiWfmc+O0ka0vJEf2Hrum0b5Y099P8hTWTbJimMfO4+uCk4qkREzEdDf/
JGl3/a9f05Vl/ArKOFbKQx1wSBgVxNyE0FVTjov0ayXjoHdZZ1bbk8sDQr3BCTFb
BnOUtEq7aOiSnioBwDI57otN4UZXsNrLIJtyPxkQLYiQCN0lByQ1HBNmb01h7qAj
J3xas7UV5aSTJWHBFK38xopd7T8QGoQNPE1m/e+cm2DWcV5wqKD43I1Q2+QY7uWk
O/7DrDWDBt+snSjVNvuslbejdUfhmJYmojWsYoJEs2NN5Wn91w+7EJPNn/WfyttL
D8U9kehQefpFFiWLmuoC4f8A7iVslrLZFA2J55A7oPzxsCOkN0E=
=5UvV
-----END PGP SIGNATURE-----

--yyHPuXZZUHUK8zUUW4WK89pfNbhbh9JgF--


