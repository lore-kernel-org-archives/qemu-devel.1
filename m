Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB4BC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCFA20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCFA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEApa-0000zU-SO
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEAoJ-0007eG-GF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEAoI-0004xH-4n
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEAoH-0004pm-S1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:02 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02HBqxjL136933
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 07:55:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yrubnxxd2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 07:55:00 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 17 Mar 2020 11:54:57 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Mar 2020 11:54:56 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02HBstqA35717252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2020 11:54:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ADA34203F;
 Tue, 17 Mar 2020 11:54:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1254E4204C;
 Tue, 17 Mar 2020 11:54:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.9.241])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2020 11:54:54 +0000 (GMT)
Subject: Re: [PATCH v9 08/15] s390x: protvirt: SCLP interpretation
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-9-frankja@linux.ibm.com>
 <da7d6747-bf56-6888-2d9f-8f689fa42b32@de.ibm.com>
 <20200317120529.3c5cd2b2.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 17 Mar 2020 12:54:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200317120529.3c5cd2b2.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VFDo73V3hhS6J8KosGAQPvz3lsBW8W2l5"
X-TM-AS-GCONF: 00
x-cbid: 20031711-0012-0000-0000-000003928583
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031711-0013-0000-0000-000021CF6426
Message-Id: <511c84ef-950f-ab82-04db-d0fb08e76973@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-17_03:2020-03-17,
 2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 mlxlogscore=858 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170049
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VFDo73V3hhS6J8KosGAQPvz3lsBW8W2l5
Content-Type: multipart/mixed; boundary="Wp2G1zcUTMk0PLLL9uPRC5qYUzdksKEqE"

--Wp2G1zcUTMk0PLLL9uPRC5qYUzdksKEqE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/17/20 12:05 PM, Cornelia Huck wrote:
> On Fri, 13 Mar 2020 14:14:35 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> On 11.03.20 14:21, Janosch Frank wrote:
>>> SCLP for a protected guest is done over the SIDAD, so we need to use
>>> the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
>>> memory when reading/writing SCBs.
>>>
>>> To not confuse the sclp emulation, we set 0x4000 as the SCCB address,=

>>> since the function that injects the sclp external interrupt would
>>> reject a zero sccb address.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  hw/s390x/sclp.c         | 30 ++++++++++++++++++++++++++++++
>>>  include/hw/s390x/sclp.h |  2 ++
>>>  target/s390x/kvm.c      | 24 +++++++++++++++++++-----
>>>  3 files changed, 51 insertions(+), 5 deletions(-)
>=20
>>> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>>> +                                uint32_t code)
>>> +{
>>> +    SCLPDevice *sclp =3D get_sclp_device();
>>> +    SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
>>> +    SCCB work_sccb;
>>> +    hwaddr sccb_len =3D sizeof(SCCB);
>>> +
>>> +    /*
>>> +     * Only a very limited amount of calls is permitted by the
>>> +     * Ultravisor and we support all of them, so we don't check for
>>> +     * them. All other specification exceptions are also interpreted=

>>> +     * by the Ultravisor and hence never cause an exit we need to
>>> +     * handle.
>>> +     *
>>> +     * Setting the CC is also done by the Ultravisor.
>>> +     */ =20
>>
>> This is fine for the current architecture which specifies a list of sc=
lp=20
>> commands that are passed through (and this is fine). Question is still=
 if
>> we replace this comment with an assertion that this is the case?
>> Or maybe even really do the same as sclp_service_call and return 0x1f0=
 for
>> unknown commands?
>=20
> That would be a case of older QEMU on newer hardware, right? Signaling
> that the command is unsupported seems the most reasonable to me
> (depending on what the architecture allows.)

Question is if we want to check for the non-pv codes as the hardware
will currently only allow a smaller subset anyway. Then if the IO codes
are passed through by SIE we would support them right away.

>=20
>>
>> Anyway, whatever you decide.
>>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>
>>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);=

>>> +    sclp_c->execute(sclp, &work_sccb, code);
>>> +    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
>>> +                          be16_to_cpu(work_sccb.h.length));
>>> +    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
>>> +    return 0;
>>> +}
>>> +
>=20
>=20



--Wp2G1zcUTMk0PLLL9uPRC5qYUzdksKEqE--

--VFDo73V3hhS6J8KosGAQPvz3lsBW8W2l5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5wuo4ACgkQ41TmuOI4
ufidAQ/9HLyslz0Gss+hXRkV2Wynv4/Qg3SkXSMHuphXTuUK+/+XS0DkiBy36nCT
vW/eJcyg7SzAg/j8480GSdfEvdkRKIWvlMz6ksAQ/aQidTEJDVYerOooHawYmcxp
evnOrDhFUs/p6derzTQIwgPXwOzhh8TVjEMg3pDA1d9VKQXRCX8xz5GqAM1okR6j
Ili7maHMptgT9LFqcdVl4oGiStSOBeOCd8oAtDyaKuvD6E0jGUXx0Hs0CbfTfxA5
Fc0cWMqMrCLRyVnQvFF7v5lCYa7ofkjujP4e+tws8jWVZE29fw/o7Cj59/DFJG2D
b+1b+qamFqonTTkbWk0VHifEjnx6KQNla2eID4BhopxW0QkVuX91qNLSOFFI/e5U
nNEukl3oxykDQGH1iugJfgwi4di8FnHZT4IZ5H67f3WV4aQIPsr5AnhO5X/AcUSE
2q1rVptSNJ5IXLBFQPhN3a37PRcipD79XfEnpInl3ZAt6P8oBXsZN/+BtAPfNsrZ
bBzc8Cr/0pSFFt2Muo70/lCPocsmLmAplqx6nNRMeegeWQebtJRKXcQWZMJk6PlA
CUMfeOgvTJSQFN26VQIkGbDNVnPqE0ws8fbpmA9TBaR5MB1rGTGghwab5IK0Jx0s
XhaCcOxdw20nKhGg3ydJ0GMlp2s3I8WMqnXkpI5qOJfcE3mNfr0=
=ESzG
-----END PGP SIGNATURE-----

--VFDo73V3hhS6J8KosGAQPvz3lsBW8W2l5--


