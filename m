Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D0FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073D920838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073D920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCHh-0003Sh-6T
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jJCGz-00031h-CZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jJCGx-0006F9-Ph
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:29:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jJCGx-0006EB-Gj
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:29:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02V83itS061846
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 04:29:22 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3023384qys-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 04:29:22 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 31 Mar 2020 09:29:10 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 31 Mar 2020 09:29:08 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02V8TGPj62259334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2020 08:29:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE2595204F;
 Tue, 31 Mar 2020 08:29:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.158.226])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 65BFE52052;
 Tue, 31 Mar 2020 08:29:16 +0000 (GMT)
Subject: Re: [kvm-unit-tests PATCH v3] s390x: Add stsi 3.2.2 tests
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <2ebc49ff-479a-351d-36f9-cb79fe4b9804@redhat.com>
 <20200331071456.3302-1-frankja@linux.ibm.com>
 <37be8d87-d259-da6f-47c0-d5a314cfa2dc@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 31 Mar 2020 10:29:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <37be8d87-d259-da6f-47c0-d5a314cfa2dc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WUuKVQgYKG9M8fx4ILH54e6d4mj1qYBcp"
X-TM-AS-GCONF: 00
x-cbid: 20033108-0008-0000-0000-00000367A997
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033108-0009-0000-0000-00004A892D57
Message-Id: <4d36c625-8c05-2027-24b9-e7b66839ca45@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_03:2020-03-30,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310072
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WUuKVQgYKG9M8fx4ILH54e6d4mj1qYBcp
Content-Type: multipart/mixed; boundary="PAUHcyUvQ7JoZWg9PqOFD0iiIgBDKXd68"

--PAUHcyUvQ7JoZWg9PqOFD0iiIgBDKXd68
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/31/20 10:24 AM, David Hildenbrand wrote:
> On 31.03.20 09:14, Janosch Frank wrote:
>> Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
>> a bit more thorough.
>>
>> In this test we set a custom name and uuid through the QEMU command
>> line. Both parameters will be passed to the guest on a stsi subcode
>> 3.2.2 call and will then be checked.
>>
>> We also compare the configured cpu numbers against the smp reported
>> numbers and if the reserved + configured add up to the total number
>> reported.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>
>> * Tabify on struct
>> * Moved prefix_push up a bit
>> * Replaced returns with goto out to pop prefix
>>
>> ---
>>  s390x/stsi.c        | 73 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  s390x/unittests.cfg |  1 +
>>  2 files changed, 74 insertions(+)
>>
>> diff --git a/s390x/stsi.c b/s390x/stsi.c
>> index e9206bca137d2edb..17ad33eefb9c948a 100644
>> --- a/s390x/stsi.c
>> +++ b/s390x/stsi.c
>> @@ -14,7 +14,28 @@
>>  #include <asm/page.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/interrupt.h>
>> +#include <smp.h>
>> =20
>> +struct stsi_322 {
>> +    uint8_t reserved[31];
>> +    uint8_t count;
>> +    struct {
>> +	uint8_t reserved2[4];
>> +	uint16_t total_cpus;
>> +	uint16_t conf_cpus;
>> +	uint16_t standby_cpus;
>> +	uint16_t reserved_cpus;
>> +	uint8_t name[8];
>> +	uint32_t caf;
>> +	uint8_t cpi[16];
>> +	uint8_t reserved5[3];
>> +	uint8_t ext_name_encoding;
>> +	uint32_t reserved3;
>> +	uint8_t uuid[16];
>> +    } vm[8];
>> +    uint8_t reserved4[1504];
>> +    uint8_t ext_names[8][256];
>=20
> Sorry, still no proper use of tabs. (can fixup if you agree)
>=20
Sure, go ahead



--PAUHcyUvQ7JoZWg9PqOFD0iiIgBDKXd68--

--WUuKVQgYKG9M8fx4ILH54e6d4mj1qYBcp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6C/1wACgkQ41TmuOI4
ufgUlw/9EiGk7NrqiNx+aTfLoWX+zRvpsqnIF2f30hjwUg85F7h3oVW9YHH1Ccw/
YH/n1rzi7UCx4P85AaR/MB3r1/nVfq7D+lwWaR/SRhSmeci8LxumdAfAHIEhTwNq
XCCdp/CgCTKXO4BhWwgyEIg206kAzMx1Qwv97FjHZbUSnbeX4shXxP+74kWswGuo
Fxg426xibnn+jv7DJaVGvpIuPoly/hX4qiz/VHb7eEHtEXVyEl4xkkQgrIIEpkO+
cXyW+5vAdGG3kFysWFnnH4itWIiNf5IgHyWoWqEdZ8xNM/SCNc9awEAiEmi7idxZ
oJ42s2wTfGPtkrjvHpwyX1jgLKlz4c/EBltAuiUu9djndHfjnh66YbGcrnee9ycN
3N89j2oXRfUUEm+8Yuh8TpHIk2i1hedjubXfRm+jEyUzlFGbvr+0MGMDGbLf9e71
o2UiMzwIXqmUPeeXBK2jay8Q9NNSgk3cGltdI5OMnYbWsT9h4SKd0feFhemiL5fZ
djm4WgR4AoKjNezoUrYthscx49CsA79+55Mpeg+HLbAEtv6FHeJeswTUWLdtQdzS
YngvpRGVWHp4AL9v/xKe2e5zMBRCIUeqKCryDjyDWGfdVmePW3tTMCi8VY/BDWyY
QmDBsE0sXi01uqY8sjKPrSr+Cni0CTvtOedzba3PvFZWvqCmqXM=
=z2JO
-----END PGP SIGNATURE-----

--WUuKVQgYKG9M8fx4ILH54e6d4mj1qYBcp--


