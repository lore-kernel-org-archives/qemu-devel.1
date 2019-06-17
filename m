Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64994C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8A020861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8A020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcrOk-00044R-FL
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51843)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hcrOD-0003bh-LI
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hcrOC-0008VA-Im
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hcrO9-00088X-QS; Mon, 17 Jun 2019 09:09:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09BEDC1EB205;
 Mon, 17 Jun 2019 13:09:16 +0000 (UTC)
Received: from [10.3.116.74] (ovpn-116-74.phx2.redhat.com [10.3.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 429D17E697;
 Mon, 17 Jun 2019 13:09:08 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190606134814.123689-1-vsementsov@virtuozzo.com>
 <f92b274d-1949-3afa-7353-d3e3d67ae705@redhat.com>
 <dbacab33-ccb4-0c1e-5ce3-7214bd405701@virtuozzo.com>
 <4ec35629-0c64-9727-780f-31e4e494f376@virtuozzo.com>
 <20190617120929.GF7397@linux.fritz.box>
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
Message-ID: <cbec5fee-8c57-f929-28b0-e68e1992c757@redhat.com>
Date: Mon, 17 Jun 2019 08:09:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617120929.GF7397@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Llwg27UwFCiEdADpaqR3dgai0qSWJgDMZ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 17 Jun 2019 13:09:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] block: blk_co_pcache
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Llwg27UwFCiEdADpaqR3dgai0qSWJgDMZ
Content-Type: multipart/mixed; boundary="7JbScUaEDT50Hp1mODDWYD52R6TPdHMJ3";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <cbec5fee-8c57-f929-28b0-e68e1992c757@redhat.com>
Subject: Re: [PATCH 0/3] block: blk_co_pcache
References: <20190606134814.123689-1-vsementsov@virtuozzo.com>
 <f92b274d-1949-3afa-7353-d3e3d67ae705@redhat.com>
 <dbacab33-ccb4-0c1e-5ce3-7214bd405701@virtuozzo.com>
 <4ec35629-0c64-9727-780f-31e4e494f376@virtuozzo.com>
 <20190617120929.GF7397@linux.fritz.box>
In-Reply-To: <20190617120929.GF7397@linux.fritz.box>

--7JbScUaEDT50Hp1mODDWYD52R6TPdHMJ3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/17/19 7:09 AM, Kevin Wolf wrote:

>>>
>>> Hmm, don't you think that blk_co_pcache sends NBD_CMD_CACHE if called=
 on nbd driver?
>>> I didn't implement it. But may be I should..
>>>
>>> May aim was only to avoid extra allocation and unnecessary reads. But=
 if we implement
>>> full-featured io request, what should it do?
>>>
>>> On qcow2 with backing it should pull data from backing to top, like i=
n copy-on-read.
>>> And for nbd it will send NBD_CMD_CACHE?
>>> These semantics seems different, but why not?
>>>
>>
>> Any opinions here? Should I resend or could we use it as a first step,=

>> not touching external API but improving things a little bit?
>=20
> I'm not opposed to making only a first step now. The interface seems to=

> make sense to me; the only thing that I don't really like is the naming=

> both of the operation (blk_co_pcache) and of the flag (BDRV_REQ_CACHE)
> because to me, "cache" doesn't mean "read, but ignore the result".
>=20
> The operation only results in something being cached if the block graph=

> is configured to cache things. And indeed, the most importatn use case
> for the flag is not populating a cache, but triggering copy-on-read. So=

> I think calling this operation "cache" is misleading.
>=20
> Now, I don't have very good ideas for better names either. I guess
> BDRV_REQ_NO_DATA could work, though it's not perfect. (Also, not sure i=
f
> a blk_co_preadv_no_read wrapper is even needed when you can just call
> blk_co_preadv with the right flag.)
>=20
> I'm open for good naming ideas.

Would 'prefetch' be a more useful name? The name NBD_CMD_CACHE was
chosen in the NBD project, but we are not stuck to that name if we think
something better makes more sense.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7JbScUaEDT50Hp1mODDWYD52R6TPdHMJ3--

--Llwg27UwFCiEdADpaqR3dgai0qSWJgDMZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0HkPIACgkQp6FrSiUn
Q2oUngf/f9dp6VX/UKMmXxqtwWeFTZ4/B6rni4rcTqK8j7LAvKeQFOnr159DbMNn
9sBEBdw0wytjXbqwO4Qww4kPRTPImqBWNE2X9v0OGLF7iR+OzitAPLtPA6uk9Zcn
xVXTcAgiEWXofUemIVNa0e5d+WX1yDYwc+WsWv1iyImXoIFoDeETMNAl0BPv1UWo
OYhHE6Y9smPhTb+vpjEs9IhzNA0gC0C/Bx71RybW8QQ4903MlykRlvEhVmgs6x53
/jMAQia18zOhOqZktMsmcoAnp9RA6ccdMhOOtDTbYaJCIxyYMyV8DbpOHOZ/bbez
d9gaM3B4o2Jxw/ok8zn7ZXLgJ3jdhA==
=qW5g
-----END PGP SIGNATURE-----

--Llwg27UwFCiEdADpaqR3dgai0qSWJgDMZ--

