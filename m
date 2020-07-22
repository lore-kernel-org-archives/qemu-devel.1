Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEFBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E63820657
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E63820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9ph-00066S-Qn
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jy9lL-0007sF-TS
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:06:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jy9lJ-000497-6F
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:06:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06M84Hef169816
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:05:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32e1xx855b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:05:58 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06M85uUH178355
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:05:58 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32e1xx8546-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 04:05:58 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06M81oEP011122;
 Wed, 22 Jul 2020 08:05:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06ams.nl.ibm.com with ESMTP id 32brbh4pds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 08:05:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06M85sgO61734946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jul 2020 08:05:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1489A4062;
 Wed, 22 Jul 2020 08:05:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 999B8A405C;
 Wed, 22 Jul 2020 08:05:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.169.63])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 22 Jul 2020 08:05:53 +0000 (GMT)
Subject: Re: [PATCH] pc-bios: s390x: Add a comment to the io and external new
 PSW setup
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <033b0db7-7b7d-6eb0-9018-bcc342f13509@de.ibm.com>
 <20200715140820.3401-1-frankja@linux.ibm.com>
 <3216babd-433b-4ec7-5333-43a75df2e331@de.ibm.com>
 <d493a0c2-c0df-4ed5-27af-34a9fc82927d@linux.ibm.com>
 <2e6134fb-3e34-4d3a-1bf8-1665ceffef38@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cd2c8bb2-413f-b6b9-ae16-e79e838b503d@linux.ibm.com>
Date: Wed, 22 Jul 2020 10:05:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2e6134fb-3e34-4d3a-1bf8-1665ceffef38@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KVP8ySZ9JH0NvRpzZnHODUlmqqda8d5hi"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-22_03:2020-07-22,
 2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220061
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 02:50:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KVP8ySZ9JH0NvRpzZnHODUlmqqda8d5hi
Content-Type: multipart/mixed; boundary="3CEmtN9ZyS6Q3rKd3GbygFp76aliqiolf"

--3CEmtN9ZyS6Q3rKd3GbygFp76aliqiolf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/22/20 9:39 AM, Christian Borntraeger wrote:
>=20
>=20
> On 22.07.20 09:24, Janosch Frank wrote:
>> On 7/22/20 8:43 AM, Christian Borntraeger wrote:
>>>
>>>
>>> On 15.07.20 16:08, Janosch Frank wrote:
>>>> Normally they don't need to be set up before waiting for an interrup=
t
>>>> but are set up on boot. The BIOS however might overwrite the lowcore=

>>>> (and hence the PSWs) when loading a blob into memory and therefore
>>>> needs to set up those PSWs more often.
>>>
>>> Now when I read the new comment this actually inidicates a bug.=20
>>> When do we restore the original content? If the loaded program
>>> does have interrupt handlers in the original image and relies on that=

>>> then we are broken, no?
>>
>> I haven't seen references to a save/restore functionality for those
>> PSWs. And I also think it's not that easy to do because we have multip=
le
>> ways of loading data and if we want to print when loading we might end=

>> up overwriting and then saving the written value for a later restore.
>>
>> I need to have a closer look at how virtio works, but wouldn't we have=
 a
>> chicken - egg problem with IO interrupts for IO that writes the prefix=
?
>>
>> The BIOS often has "interesting" solutions to problems.
>> If you have a quick fix, be my guest and send it. If not I'd put it on=

>> my todo list or let Stefan make it a proper dev item.
>=20
> Maybe a global fixup table in BIOS memory that restores all the memory =
that
> we messed with when we hand over control? Can you at least change the c=
omment
> here to add a fixme?

Sure

>=20
>>
>>>
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  pc-bios/s390-ccw/start.S | 10 ++++++++--
>>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
>>>> index 01c4c21b26..b0fcb918cc 100644
>>>> --- a/pc-bios/s390-ccw/start.S
>>>> +++ b/pc-bios/s390-ccw/start.S
>>>> @@ -64,7 +64,10 @@ consume_sclp_int:
>>>>          stctg   %c0,%c0,0(%r15)
>>>>          oi      6(%r15),0x2
>>>>          lctlg   %c0,%c0,0(%r15)
>>>> -        /* prepare external call handler */
>>>> +        /*
>>>> +         * Prepare external new PSW as it might have been overwritt=
en
>>>> +         * by a loaded blob
>>>> +         */
>>>>          larl %r1, external_new_code
>>>>          stg %r1, 0x1b8
>>>>          larl %r1, external_new_mask
>>>> @@ -84,7 +87,10 @@ consume_io_int:
>>>>          stctg %c6,%c6,0(%r15)
>>>>          oi    4(%r15), 0xff
>>>>          lctlg %c6,%c6,0(%r15)
>>>> -        /* prepare i/o call handler */
>>>> +        /*
>>>> +         * Prepare i/o new PSW as it might have been overwritten
>>>> +         * by a loaded blob
>>>> +         */
>>>>          larl  %r1, io_new_code
>>>>          stg   %r1, 0x1f8
>>>>          larl  %r1, io_new_mask
>>>>
>>
>>



--3CEmtN9ZyS6Q3rKd3GbygFp76aliqiolf--

--KVP8ySZ9JH0NvRpzZnHODUlmqqda8d5hi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8X82EACgkQ41TmuOI4
ufhu+A/8Cy8mEmR3Z+VT+5vkn1ZD9d35Cq8RP6TDc/+m/vOfav9sMuIAYUpoWIAN
oKKU7ZFgifigrh61dBxwo3g3Lt7bziNMR8VuAj74nTxBeZ8YpGdDQkUKPpG2N39B
tdva386bxdvFUw+bGgOGCnwB1M+zrLcv0AozKkoQvjlqNunVy0zsUkS+HiH6ZKS2
SEODPN7TQQiT3S4deRPUFODF7EgQ9kGGrKAhWxiQojWUOYamWrVQfkEzqnZZ97Wr
2OGHw+avrEvJ52AQN7hpunXQTWBDv0FNxKhacFcwN63t/cGG3yBVSdX5eVUDv9s0
c8Ig6a+N8lpZINXS1MK7nAB8ej/shlTcxdR6lPp17DV7asElJY+SdABIuL4wcjtd
Xugg13QJiA8ZCyJ6rP1Mr7HSQU0xDna0uQo2jKu18l8KEOLYJvn7oFrdMcMmqV4u
O7nlSdrPgswwjQVe6JWpsf/Lrs5/2llxS6DePvAJpsDTPISQUFqdJCu6/GEeky0x
S3ZjzDf6Px6RuU511q7UuxjpaMeCOyj1dRUCxN/iZoRF/aWeOGJfbvfOb1lYwgxh
+c6gUusjOtvzed7T9jhNb2LjSSLinldcNBtfiROe5DioGavsjnCtE9q7gmbWuBLS
tfaQBMxZ6IkqvUSjFvc+WG7m2qWpPnz7o9yajHVadctH0Pawl0M=
=g1te
-----END PGP SIGNATURE-----

--KVP8ySZ9JH0NvRpzZnHODUlmqqda8d5hi--


