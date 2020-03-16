Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BD2C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FD22071C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FD22071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsfW-0006nO-Nk
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jDr1x-0007HP-GV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jDr1w-0008Rf-6X
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:47:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17866
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jDr1w-0008Ob-0i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:47:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02GEYY4j109956
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:47:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ytb3n911x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:47:46 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 16 Mar 2020 14:47:45 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 16 Mar 2020 14:47:43 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02GElgj231785216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2020 14:47:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B6E35204E;
 Mon, 16 Mar 2020 14:47:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.172.134])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0B4EC52050;
 Mon, 16 Mar 2020 14:47:42 +0000 (GMT)
Subject: Re: [PATCH v9] fixup! Fix subcode/pbt
To: Cornelia Huck <cohuck@redhat.com>
References: <a1ed33c4-91c0-90fa-2f95-417e320e172c@de.ibm.com>
 <20200313095232.2392-1-frankja@linux.ibm.com>
 <20200316152738.4c1c65ee.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Mon, 16 Mar 2020 15:47:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200316152738.4c1c65ee.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H9DTz14gWTq5JiybbZDfigVDbVtomHfQq"
X-TM-AS-GCONF: 00
x-cbid: 20031614-0028-0000-0000-000003E5B965
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031614-0029-0000-0000-000024AB0AE2
Message-Id: <bbbabbb0-2325-406d-a619-f2d03f447c8c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-16_06:2020-03-12,
 2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160070
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H9DTz14gWTq5JiybbZDfigVDbVtomHfQq
Content-Type: multipart/mixed; boundary="3Jda7EdJcfEmaSqzaZJWnP2HsZ9k17LwT"

--3Jda7EdJcfEmaSqzaZJWnP2HsZ9k17LwT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/16/20 3:27 PM, Cornelia Huck wrote:
> On Fri, 13 Mar 2020 05:52:32 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/ipl.h      | 11 +++++++----
>>  target/s390x/diag.c |  2 +-
>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index 95e3183c9cccf8b6..f799f7cfcf4763b1 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -261,15 +261,18 @@ static inline bool ipl_valid_pv_header(IplParame=
terBlock *iplb)
>>          return true;
>>  }
>> =20
>> -static inline bool iplb_valid(IplParameterBlock *iplb)
>> +static inline bool iplb_valid(IplParameterBlock *iplb, uint64_t subco=
de)
>>  {
>>      switch (iplb->pbt) {
>>      case S390_IPL_TYPE_FCP:
>> -        return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_FCP_LEN;
>> +        return (subcode =3D=3D DIAG308_SET &&
>> +                be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_FCP_LEN);
>>      case S390_IPL_TYPE_CCW:
>> -        return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_CCW_LEN;
>> +        return (subcode =3D=3D DIAG308_SET &&
>> +                be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_CCW_LEN);
>>      case S390_IPL_TYPE_PV:
>> -        if (be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN) {
>> +        if (subcode !=3D DIAG308_PV_SET ||
>> +            be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN) {
>>              return false;
>=20
> I'm not sure I like passing the subcode here...

I could move this to diag.c and call it iplb_valid_for_subcode()

>=20
>>          }
>>          if (!ipl_valid_pv_header(iplb)) {
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index b1ca81633b83bbdc..d4f33db5c23c818d 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -118,7 +118,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t =
r1, uint64_t r3, uintptr_t ra)
>> =20
>>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));=

>> =20
>> -        if (!iplb_valid(iplb)) {
>> +        if (!iplb_valid(iplb, subcode)) {
>>              env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
>>              goto out;
>>          }
>=20
> ...because you're basically checking whether you either have a valid
> normal iplb, or a valid pv iplb, with the two being mutually exclusive,=

> IIUC. So what about introducing iplb_valid_pv and calling that for the
> pv case? Would be a bit nicer to read, I think, and also matches what
> you do for the STORE case.
>=20

The idea was to get rid of all of these ifs and elses and only have one
iplb_valid function. Your suggestion would defeat hiding that complexity
behind this function.



--3Jda7EdJcfEmaSqzaZJWnP2HsZ9k17LwT--

--H9DTz14gWTq5JiybbZDfigVDbVtomHfQq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5vkY0ACgkQ41TmuOI4
ufjKgw//bxblGJZT/TVNAgrgElpatxCU2uwk2MPLMiYhz5pF6yq00oZwYEH467Ix
SBeJzdD/hWkFI57FiKhaBk+cegwGvTR5nWoCPSWpzX+h8nmUZzivSjJeW5IuDh4k
v9jr96AK/CHzmRpyOny44dYnZyLf/VusdpkcOpB03RfVWCbARoKoLVjzWJpGjEVx
2+afOH6xzMoUpQy9B05G+BJnGsXDDj4kFgRyTXki/BwY8Jdzls/48h/+sMG9Vnw3
OE4YkskNBv1nBGGuoP8EJMW9CeRlJNSJoqNZ344A/qyHw0T5MJihj+7NDwfQ3uUR
sBBTnIP1VW0kuh5OA8oFs30h8qyFCybtZo+zlH2hL2rJ+r9Z2rySdqPSL6/Ps4F1
a0NfIAfAoL90JpMpF3PeepiUzP5rPS8EIGFwkx1N3N/HxbbYrINRybMiSeGhWYqr
ejX9o7R8fsYM76sl7pvvCYbWBevY9SnZCpBykMcgDQKO291Zw1yilfBwW0OsMHJh
EcnurQclj/sEDy45OL+GR7p0vgZH8dUfg3fr5uYW7XO2/iuPNefP+CH4hEm/eS90
1BR9hJ8bbMH4RzxCX1iFYE8r/7PeteQNT/9h2iuAw0oYXh8bo+k7xwLXMTDL5w/A
Qd9ZdRBKRoDUErGR2JO2XKLH/VTyz23X8pvrcmdKFN6kvA/knBc=
=IdhF
-----END PGP SIGNATURE-----

--H9DTz14gWTq5JiybbZDfigVDbVtomHfQq--


