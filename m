Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D040C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666E32067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666E32067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7kE-0008UL-NO
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49194)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hs7jp-00081B-3h
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hs7jn-0006k6-TX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:39:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hs7jl-0006fR-95; Mon, 29 Jul 2019 11:38:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C7083083392;
 Mon, 29 Jul 2019 15:38:56 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14F6B6012A;
 Mon, 29 Jul 2019 15:38:53 +0000 (UTC)
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190725100550.33801-1-vsementsov@virtuozzo.com>
 <20190729150041.GF6771@stefanha-x1.localdomain>
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
Message-ID: <1634fa73-a1bf-59cf-204d-b1115c912ea1@redhat.com>
Date: Mon, 29 Jul 2019 10:38:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729150041.GF6771@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vdXwoLcrgumIgKngxB3tAGPkgiSxGoJpC"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 29 Jul 2019 15:38:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 for-4.2 0/3] block:
 BDRV_REQ_PREFETCH
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vdXwoLcrgumIgKngxB3tAGPkgiSxGoJpC
Content-Type: multipart/mixed; boundary="6pQ2qVjR6BetJBQsRKwarw47ycgjIZFTg";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Message-ID: <1634fa73-a1bf-59cf-204d-b1115c912ea1@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 for-4.2 0/3] block:
 BDRV_REQ_PREFETCH
References: <20190725100550.33801-1-vsementsov@virtuozzo.com>
 <20190729150041.GF6771@stefanha-x1.localdomain>
In-Reply-To: <20190729150041.GF6771@stefanha-x1.localdomain>

--6pQ2qVjR6BetJBQsRKwarw47ycgjIZFTg
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/29/19 10:00 AM, Stefan Hajnoczi wrote:
> On Thu, Jul 25, 2019 at 01:05:47PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
>> Hi all!
>>
>> Here is small new read flag: BDRV_REQ_PREFETCH, which in combination w=
ith
>> BDRV_REQ_COPY_ON_READ does copy-on-read without
>> extra buffer for read data. This means that only parts that needs COR
>> will be actually read and only corresponding buffers allocated, no mor=
e.
>>
>> This allows to improve a bit block-stream and NBD_CMD_CACHE
>>
>> v3: rebase 02 on master, fix commit message of 03.
>>
>> v2: change interface to be just one flag BDRV_REQ_PREFETCH
>>
>> v1 was "[PATCH 0/3] block: blk_co_pcache"
>>    https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01047.html=

>>
>> Vladimir Sementsov-Ogievskiy (3):
>>   block: implement BDRV_REQ_PREFETCH
>>   block/stream: use BDRV_REQ_PREFETCH
>>   nbd: improve CMD_CACHE: use BDRV_REQ_PREFETCH
>>
>>  include/block/block.h |  8 +++++++-
>>  block/io.c            | 18 ++++++++++++------
>>  block/stream.c        | 20 +++++++-------------
>>  nbd/server.c          | 43 +++++++++++++++++++++++++++++++++++-------=
-
>>  4 files changed, 61 insertions(+), 28 deletions(-)
>>
>> --=20
>> 2.18.0
>>
>>
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

I'm happy to queue this one through my NBD tree for 4.2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6pQ2qVjR6BetJBQsRKwarw47ycgjIZFTg--

--vdXwoLcrgumIgKngxB3tAGPkgiSxGoJpC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0/EwwACgkQp6FrSiUn
Q2ocDAgAmWCuJPb5dYQZNHs1y3PYqNs1rlLQNE4wXn2d6Wdb3VJ/uZkI4QHJeFAf
TgjMgWEgK7TSFoNo7VD8Swuj7mpjKrvqvTy9px4ykI9W1OKigqR9DkdySyEuyYx1
zaeWKjmoP86REd8xjajptdhLqsi+VCFjnfo/R6+NhRMpn37Aqcd+tO04dA5eIHmr
cIoDhiFCME6tBWhvVCP50gXudnt6hC5qxhLbTO5uD9UKMc3ITxUXw6mBq5ABiAb7
utRNyrKvKOsWrP4tabVRL7LdbBjfqcu8QYUHcCfRaSjq1m9oJdSHbgCNjUdmY6Me
eplcxTUwv7pAqmiz2yaYqJYQHQ8rdg==
=2kTI
-----END PGP SIGNATURE-----

--vdXwoLcrgumIgKngxB3tAGPkgiSxGoJpC--

