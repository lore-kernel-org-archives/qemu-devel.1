Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990BAC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7114A20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7114A20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2cWi-0001aW-IF
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i2cVE-0000yU-D2
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i2cVD-0001hR-87
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:31:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i2cV1-0001cB-OV; Tue, 27 Aug 2019 10:31:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42669307D84B;
 Tue, 27 Aug 2019 14:31:04 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04A035D9CC;
 Tue, 27 Aug 2019 14:30:59 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1566913973-15490-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4b240066-60b7-0f9b-9f17-d5da43b9da84@redhat.com>
 <7ad1318a-8745-54fe-d6ad-2b27262f1f78@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <847b50d2-446e-9f6c-96b5-adcbb5dd2485@redhat.com>
Date: Tue, 27 Aug 2019 09:30:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7ad1318a-8745-54fe-d6ad-2b27262f1f78@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M5BvDercWu9ngjYntQocurRDHhK97jTEg"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 27 Aug 2019 14:31:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] block: workaround for unaligned byte
 range in fallocate()
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M5BvDercWu9ngjYntQocurRDHhK97jTEg
Content-Type: multipart/mixed; boundary="rfAma2sjuAGuoDP6G4olnNtxQDXVP9Oiy";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <847b50d2-446e-9f6c-96b5-adcbb5dd2485@redhat.com>
Subject: Re: [PATCH v2] block: workaround for unaligned byte range in
 fallocate()
References: <1566913973-15490-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4b240066-60b7-0f9b-9f17-d5da43b9da84@redhat.com>
 <7ad1318a-8745-54fe-d6ad-2b27262f1f78@virtuozzo.com>
In-Reply-To: <7ad1318a-8745-54fe-d6ad-2b27262f1f78@virtuozzo.com>

--rfAma2sjuAGuoDP6G4olnNtxQDXVP9Oiy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/27/19 9:04 AM, Andrey Shinkevich wrote:
>=20
>=20
> On 27/08/2019 16:55, Eric Blake wrote:
>> On 8/27/19 8:52 AM, Andrey Shinkevich wrote:
>>> Revert the commit 118f99442d 'block/io.c: fix for the allocation fail=
ure'
>>> and use better error handling for file systems that do not support
>>> fallocate() for an unaligned byte range. Allow falling back to pwrite=

>>> in case fallocate() returns EINVAL.
>>>
>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>> Suggested-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>   block/file-posix.c | 7 +++++++
>>>   block/io.c         | 2 +-
>>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> Queuing this in my NBD tree (as I performed testing on top of it when
>> working on NBD fast-zero).
>>
> Eric,
> I'm sorry about missing your message in the previous email thread - jus=
t=20
> few minute difference. Please add
> Reviewed-by: Denis V. Lunev <den@openvz.org>
> because I used the stale commit ID from bash history and that line=20
> didn't go to the v2 patch (((

No problem - crossed emails is nothing new. I'll add the R-b.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--rfAma2sjuAGuoDP6G4olnNtxQDXVP9Oiy--

--M5BvDercWu9ngjYntQocurRDHhK97jTEg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1lPqIACgkQp6FrSiUn
Q2q1rQf/XGfyJUoibtIbNQnfUA0g8jCf0Gjh7/mh44e+8ctb1IvQ9MroEjmxUvZF
j18RkWcoXtkpGg7uVm1Euopqq+h0Qxm9v35416Wz9o/7He3kur24bXCkl+l4VWo9
PS0m5YEyCift4HAo2ZrzINsZFiRNG3kIDPuO2zA3VFBuL30IPReWOYQZVRInf53W
j7Y4hFy0mAWlx2dj5NBNX/HPpXiIN9eAcBy8o2JKhLtAqt5/pLEsgBrvN1iJaG2S
U9fJL0T3AUjS8JSYev5F7c1oLvGTh4GXs2ugNmUq2IC/nP4O3q9V3FuEDGLNHXiX
C6wWAZrlh4kyZ2f4CaJJwcad6ydwUQ==
=T2Un
-----END PGP SIGNATURE-----

--M5BvDercWu9ngjYntQocurRDHhK97jTEg--

