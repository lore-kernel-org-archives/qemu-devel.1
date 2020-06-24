Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACACFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759CC2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759CC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3F0-00065S-NZ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jo35f-00060i-DY
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:57:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jo35d-0003hg-0g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:57:15 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05OAWdca161747
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 06:57:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ux02bysw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 06:57:11 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05OAX5RW164102
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 06:57:10 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ux02byrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 06:57:10 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05OAoUbI022136;
 Wed, 24 Jun 2020 10:57:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04fra.de.ibm.com with ESMTP id 31uus188j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 10:57:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05OAv5CJ60555460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2020 10:57:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A62F4C059;
 Wed, 24 Jun 2020 10:57:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07CAC4C044;
 Wed, 24 Jun 2020 10:57:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.180.162])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2020 10:57:04 +0000 (GMT)
Subject: Re: [PATCH v5 00/12] pc-bios: s390x: Cleanup part 1
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624124406.2baac59f.cohuck@redhat.com>
 <3c30f41c-1875-d288-9f6c-0e7c63b7b4a9@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5373b97f-e553-629e-326a-f3c703a1288b@linux.ibm.com>
Date: Wed, 24 Jun 2020 12:57:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3c30f41c-1875-d288-9f6c-0e7c63b7b4a9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GLrBPo7LjJZzyi129tVxUeAmS4g4kSiAK"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-24_05:2020-06-24,
 2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 cotscore=-2147483648
 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006240077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 06:57:11
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GLrBPo7LjJZzyi129tVxUeAmS4g4kSiAK
Content-Type: multipart/mixed; boundary="M4a42TX7BsySIRzx4spmDtSGHrw7hqonl"

--M4a42TX7BsySIRzx4spmDtSGHrw7hqonl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/24/20 12:46 PM, Thomas Huth wrote:
> On 24/06/2020 12.44, Cornelia Huck wrote:
>> On Wed, 24 Jun 2020 03:52:14 -0400
>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>
>>> The bios is in dire need for a cleanup as there are still a lot of
>>> magic constants being used throughout as well as duplicated code.
>>>
>>> In the first part of this series we consolidate constants and
>>> functions, as well as doing some minor cleanups and fixes.
>>>
>>> The patches are available here:
>>> https://github.com/frankjaa/qemu/pull/new/cleanup_bios
>>>
>>> v5:
>>> 	* Fixed whitespace damage
>>> 	* Removed reset PSW mask changes in dasd-ipl.c
>>> 	* Added jump2ipl.c cleanup patches
>>>
>>> v4:
>>> 	* Renamed time.h to s390-time.h
>>> 	* Fixed function names in sleep()
>>> 	* Changed order of sense_id_ccw initialization
>>> 	* Added missing include before sleep()
>>>
>>> v3:
>>> 	* Dropped 0x00 to 0x0/0 patch
>>> 	* Moved some timing functions into helper.h instead of time.h
>>> 	* Fixed IPL psw manipulation in dasd-ipl.c
>>>   	* Minor cosmetic fixes found by review
>>>
>>> v2:
>>> 	* Included cio fixup to get rid of compile errors...
>>> 	* Minor cosmetic fixes found by review
>>>
>>>
>>> Janosch Frank (12):
>>>    pc-bios: s390x: cio.c cleanup and compile fix
>>>    pc-bios: s390x: Consolidate timing functions into time.h
>>>    pc-bios: s390x: Move sleep and yield to helper.h
>>>    pc-bios: s390x: Get rid of magic offsets into the lowcore
>>>    pc-bios: s390x: Remove unneeded dasd-ipl.c reset psw mask changes
>>>    pc-bios: s390x: Rename PSW_MASK_ZMODE to PSW_MASK_64
>>>    pc-bios: s390x: Use PSW masks where possible and introduce
>>>      PSW_MASK_SHORT_ADDR
>>>    pc-bios: s390x: Move panic() into header and add infinite loop
>>>    pc-bios: s390x: Use ebcdic2ascii table
>>>    pc-bios: s390x: Make u32 ptr check explicit
>>>    pc-bios: s390x: Fix bootmap.c passing PSWs as addresses
>>>    pc-bios: s390x: Cleanup jump to ipl code
>>>
>>>   pc-bios/s390-ccw/bootmap.c     |  9 ++++----
>>>   pc-bios/s390-ccw/bootmap.h     |  2 +-
>>>   pc-bios/s390-ccw/cio.c         | 40 +++++++++++++++++++------------=
---
>>>   pc-bios/s390-ccw/cio.h         | 17 ++++++++++-----
>>>   pc-bios/s390-ccw/dasd-ipl.c    |  3 ---
>>>   pc-bios/s390-ccw/helper.h      | 19 +++++++++++++++-
>>>   pc-bios/s390-ccw/jump2ipl.c    | 35 ++++++++++++-----------------
>>>   pc-bios/s390-ccw/main.c        | 15 +++----------
>>>   pc-bios/s390-ccw/menu.c        |  1 +
>>>   pc-bios/s390-ccw/netmain.c     | 23 +++----------------
>>>   pc-bios/s390-ccw/s390-arch.h   |  4 +++-
>>>   pc-bios/s390-ccw/s390-ccw.h    | 27 ++++++-----------------
>>>   pc-bios/s390-ccw/s390-time.h   | 23 +++++++++++++++++++
>>>   pc-bios/s390-ccw/start.S       |  5 +++--
>>>   pc-bios/s390-ccw/virtio-net.c  |  2 ++
>>>   pc-bios/s390-ccw/virtio-scsi.c |  2 ++
>>>   pc-bios/s390-ccw/virtio.c      | 18 +++------------
>>>   17 files changed, 120 insertions(+), 125 deletions(-)
>>>   create mode 100644 pc-bios/s390-ccw/s390-time.h
>>>
>>
>> Hm... what's the general status of this? Most of the patches have at
>> least one R-b/A-b already, I see.
>>
>> Do the s390-ccw boot maintainers want to pick this (once the rest has
>> been looked at) and then send me a pull req, or should I pick it when
>> it is good to go? Softfreeze is less than two weeks away :)
>=20
> I'd like to review the missing parts and run my tests with the patches =

> applied ... I'm just a little bit swamped right now, so please give me =

> some more time...
>=20
>   Thomas

I'd suggest we hold off on the RFC patch since it makes testing all of
the boot methods necessary and I was only able to test direct, dasd
passthrough and virtio-ccw up to now. Time to build a testing environment=
=2E..

I can move that patch into the next series for further discussion. It
was mostly added to prove the 64 bit PSW mask removal in patch #5.


--M4a42TX7BsySIRzx4spmDtSGHrw7hqonl--

--GLrBPo7LjJZzyi129tVxUeAmS4g4kSiAK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7zMYAACgkQ41TmuOI4
ufjbYRAAzSnvv1vj1K5zXPCKi1XUDCPds2xziukmvcGtlix7mkkxO+VoDSqLH8F/
UMGcP5T6NRxuSN9EJ+1PDaH5tKidPMt7sVqaG/cJZJx8yeAZSiaL0Qldl4C2rcXV
yxF44vnfPBHqJysNlYD+PFZkUwH7r27EQzBEvlQ+HBseZsN7bywSR0Gt8TaNz6iT
p46njAZWx3gB9G9K2YeW2y8JvP991ezwkRpQfbxsoQdBaAsWetAzT9ewgSmGECFi
+elwMrX0cLSi+cdTZMYRyXLWnUrbn2HcDdzcfmJ7rA8fFvqeuR/WubZ9KHCelqtn
peIUQCn48ZTXSXlvbqF7Edyl9si63y5H+QwId91K9IOAz9PwdXGov5wLQA+itoKw
0+LZbEjzFAJ6a0fTi/mIJR5GwQ4/btDvUHSVwzfrCj4tXBWa9Ey+jLAgpVK5viy2
F5pBt27ZqLCszdHG+wenb0qrZAZUtdYbfYmibBXUtHNEoryThAoKlAEyOdMYVn6h
KOQJ4qlzSENaCE3eEfFH/gZtccNHt7GUpAZGWM+n14htLded1CqeIJZGIfFjCHUV
jw7jRO2YSFJRKzjJPr8IixpXKSwqquVFDgb5KoIzy4seRgOd4DvAtKxUsiJu6kYg
PeOze7+5IcEZqW6P2GoQvisxlDAjgdoTmrblbLohcDFROb/TD4c=
=oBUM
-----END PGP SIGNATURE-----

--GLrBPo7LjJZzyi129tVxUeAmS4g4kSiAK--


