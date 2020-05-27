Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2111C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25EA20723
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25EA20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdrXj-00060A-Qx
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 04:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdrXB-0005Vl-A0; Wed, 27 May 2020 04:35:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdrX9-0003iu-S4; Wed, 27 May 2020 04:35:32 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04R8XKfY118938; Wed, 27 May 2020 04:35:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 317hejk41d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 04:35:29 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04R8XTPg119232;
 Wed, 27 May 2020 04:35:11 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 317hejk3ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 04:35:10 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R8VUHb020387;
 Wed, 27 May 2020 08:34:25 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03ams.nl.ibm.com with ESMTP id 316uf87gda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 08:34:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04R8YMr22752976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2020 08:34:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C24B052057;
 Wed, 27 May 2020 08:34:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.52.97])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6450252051;
 Wed, 27 May 2020 08:34:22 +0000 (GMT)
Subject: Re: [PATCH v3 1/9] pc-bios: s390x: cio.c cleanup and compile fix
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200527074920.43669-1-frankja@linux.ibm.com>
 <20200527074920.43669-2-frankja@linux.ibm.com>
 <78361bb8-5ec5-05f9-4460-76a086c06832@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d05d1556-034c-fd15-ee0f-c63f483adc15@linux.ibm.com>
Date: Wed, 27 May 2020 10:34:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <78361bb8-5ec5-05f9-4460-76a086c06832@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8ifmML2aicffvagRmOrezlhdPlbzXylck"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-27_03:2020-05-26,
 2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 03:49:35
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8ifmML2aicffvagRmOrezlhdPlbzXylck
Content-Type: multipart/mixed; boundary="EPHygnNRoLMtE9obKdhXWWDcTWublt8iV"

--EPHygnNRoLMtE9obKdhXWWDcTWublt8iV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/27/20 10:24 AM, Christian Borntraeger wrote:
>=20
>=20
> On 27.05.20 09:49, Janosch Frank wrote:
>> Let's initialize the structs at the beginning to ease reading and also=

>> zeroing all other fields. This also makes the compiler stop
>> complaining about sense_id_ccw.flags being ored into when it's not
>> initialized.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>  pc-bios/s390-ccw/cio.c | 40 ++++++++++++++++++++++------------------
>>  1 file changed, 22 insertions(+), 18 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
>> index 339ec5fbe7..dbae1e240e 100644
>> --- a/pc-bios/s390-ccw/cio.c
>> +++ b/pc-bios/s390-ccw/cio.c
>> @@ -49,13 +49,13 @@ void enable_subchannel(SubChannelId schid)
>> =20
>>  uint16_t cu_type(SubChannelId schid)
>>  {
>> -    Ccw1 sense_id_ccw;
>>      SenseId sense_data;
>> -
>> -    sense_id_ccw.cmd_code =3D CCW_CMD_SENSE_ID;
>> -    sense_id_ccw.cda =3D ptr2u32(&sense_data);
>> -    sense_id_ccw.count =3D sizeof(sense_data);
>> -    sense_id_ccw.flags |=3D CCW_FLAG_SLI;
>> +    Ccw1 sense_id_ccw =3D {
>> +        .cmd_code =3D CCW_CMD_SENSE_ID,
>> +        .count =3D sizeof(sense_data),
>> +        .flags =3D CCW_FLAG_SLI,
>> +        .cda =3D ptr2u32(&sense_data),
>> +    };
>=20
> nitpicking, since you change the order anyway you _could_ swap count an=
d flag
> to match the order of struct Ccw. Only necessary when redoing.

Sure, if it makes you happy :-)

>=20
>=20
>> =20
>>      if (do_cio(schid, CU_TYPE_UNKNOWN, ptr2u32(&sense_id_ccw), CCW_FM=
T1)) {
>>          panic("Failed to run SenseID CCw\n");
>> @@ -67,13 +67,13 @@ uint16_t cu_type(SubChannelId schid)
>>  int basic_sense(SubChannelId schid, uint16_t cutype, void *sense_data=
,
>>                   uint16_t data_size)
>>  {
>> -    Ccw1 senseCcw;
>> +    Ccw1 senseCcw =3D {
>> +        .cmd_code =3D CCW_CMD_BASIC_SENSE,
>> +        .count =3D data_size,
>> +        .cda =3D ptr2u32(sense_data),
>> +    };
>>      Irb irb;
>> =20
>> -    senseCcw.cmd_code =3D CCW_CMD_BASIC_SENSE;
>> -    senseCcw.cda =3D ptr2u32(sense_data);
>> -    senseCcw.count =3D data_size;
>> -
>=20
> here it is fine, due to the lack of flags.=20
> Was this actually a bug before that senseCcw.flags was
> not zeroed out?

I'd guess so, seems like the compiler went into other code paths with my
recent changes and then started complaining.
But it makes sense to clean them up anyway.

>=20
>=20
> [...]
>=20
> Other than that
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks!



--EPHygnNRoLMtE9obKdhXWWDcTWublt8iV--

--8ifmML2aicffvagRmOrezlhdPlbzXylck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7OJg4ACgkQ41TmuOI4
ufhw0g//cBaWwqB3kP6bQDK0SmDvEqYQQWsUaWAsNw5ZB+G2ljH3o5aHbA+Gvxs0
tp5gCxHnmES0hBja/d6o2TBQu1Ev8Rb0o0LGGZyrl8qKK2ZLw0vKX/nngjUyPM5l
NcwQr0yaxIrtumCA3NR2xANxF4zzlIQs1aL6c9RLvM8zqHfqCi7zDe5PNI37dWjX
HKzXEnrZI7fOUoWWpxlzBs3BVgvdmvpjxXe+7qjt9/3mHO4syZw10/POTtEFlJe+
4KeahwPmuXqaJ56WKe5wwu7+TSgh7ZlPNShVOmE718Y2iElpFmimoTKfznEGPg0B
sK15OhynqQfOz4Dv5JwBQ2XnEWUH2p1PQPilYVKjMuzqvGMqzZ8WIDaEGw46pzm+
sG8jvw+eoeYy4wiKJXyEvGxkLXj+CuCEmhowYj6DIa95VqNvsoqPm6z87bVPCObd
6jzoztJqj5VxabAGAlCwO1PKueqXAdLtgoVgnpa6GtHIOr89B/aNqGOmpixx0H0D
A20zOVnUrjgWEe3zppbARWsgENV4OMOVvVr3NCNNIZ//IQ7khDgKyfeDSJoYEtX+
jgAjEXQWY27fIt4Ef/xAIMpPmslzJqjPghHn8h1EvWXUykC+NUgXlpjB39OUV4ei
4AVgsEXRvZgeJABXsgxts6L3Oxhh7GrHQFf2XJPR/p/1xnOoOQc=
=GDJc
-----END PGP SIGNATURE-----

--8ifmML2aicffvagRmOrezlhdPlbzXylck--


