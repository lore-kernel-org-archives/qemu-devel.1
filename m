Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0DC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D50E22CEB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D50E22CEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzm1z-00082c-MF
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hzm1C-0007XA-UV
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hzm1B-0001Gx-Sj
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:04:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hzm18-0001EC-2E; Mon, 19 Aug 2019 14:04:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB1AE30860DC;
 Mon, 19 Aug 2019 18:04:26 +0000 (UTC)
Received: from [10.3.117.3] (ovpn-117-3.phx2.redhat.com [10.3.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7309718B66;
 Mon, 19 Aug 2019 18:04:22 +0000 (UTC)
To: Nir Soffer <nsoffer@redhat.com>
References: <20190815185024.7010-1-eblake@redhat.com>
 <104559cd-a1dc-2b2c-8992-689cbdd0f827@virtuozzo.com>
 <22c4c265-91fc-3639-4a4e-2fffe426ce68@virtuozzo.com>
 <3f1fa92e-af18-87f8-3149-7c11bd186e64@redhat.com>
 <CAMRbyytdGmsoLbg_i=zbbkrkWpAW+jAvUAiwmJEO3MGXpvrTaA@mail.gmail.com>
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
Message-ID: <847b1ef7-0f9d-fd7a-3c0c-368f5d862ecb@redhat.com>
Date: Mon, 19 Aug 2019 13:04:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyytdGmsoLbg_i=zbbkrkWpAW+jAvUAiwmJEO3MGXpvrTaA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="abkSCfWbZfCJ1W6KbM6eGPeqr6JZofq7q"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 19 Aug 2019 18:04:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd: Advertise multi-conn for
 shared read-only connections
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
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Erez <derez@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--abkSCfWbZfCJ1W6KbM6eGPeqr6JZofq7q
Content-Type: multipart/mixed; boundary="FnAmWMfG70PW4sff3iES9i16ZBALbn1Hn";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Daniel Erez <derez@redhat.com>
Message-ID: <847b1ef7-0f9d-fd7a-3c0c-368f5d862ecb@redhat.com>
Subject: Re: [Qemu-block] [PATCH] nbd: Advertise multi-conn for shared
 read-only connections
References: <20190815185024.7010-1-eblake@redhat.com>
 <104559cd-a1dc-2b2c-8992-689cbdd0f827@virtuozzo.com>
 <22c4c265-91fc-3639-4a4e-2fffe426ce68@virtuozzo.com>
 <3f1fa92e-af18-87f8-3149-7c11bd186e64@redhat.com>
 <CAMRbyytdGmsoLbg_i=zbbkrkWpAW+jAvUAiwmJEO3MGXpvrTaA@mail.gmail.com>
In-Reply-To: <CAMRbyytdGmsoLbg_i=zbbkrkWpAW+jAvUAiwmJEO3MGXpvrTaA@mail.gmail.com>

--FnAmWMfG70PW4sff3iES9i16ZBALbn1Hn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/17/19 8:31 PM, Nir Soffer wrote:
>>> Also, for qemu-nbd, shouldn't we allow -e only together with -r ?
>>
>> I'm reluctant to; it might break whatever existing user is okay exposi=
ng
>> it (although such users are questionable, so maybe we can argue they
>> were already broken).  Maybe it's time to start a deprecation cycle?
>>
>=20
> man qemu-nbd (on Centos 7.6) says:
>=20
>        -e, --shared=3Dnum
>            Allow up to num clients to share the device (default 1)
>=20
> I see that in qemu-img 4.1 there is a note about consistency with write=
rs:
>=20
>        -e, --shared=3Dnum
>            Allow up to num clients to share the device (default 1). Saf=
e
> for readers, but for now, consistency is not guaranteed between multipl=
e
> writers.
> But it is not clear what are the consistency guarantees.
>=20
> Supporting multiple writers is important. oVirt is giving the user a UR=
L
> (since 4.3), and the user
> can use multiple connections using the same URL, each having a connecti=
on
> to the same qemu-nbd
> socket. I know that some backup vendors tried to use multiple connectio=
ns
> to speed up backups, and
> they may try to do this also for restore.
>=20
> An interesting use case would be using multiple connections on client s=
ide
> to write in parallel to
> same image, when every client is writing different ranges.

Good to know.

>=20
> Do we have real issue in qemu-nbd serving multiple clients writing to
> different parts of
> the same image?

If a server advertises multi-conn on a writable image, then clients have
stronger guarantees about behavior on what happens with flush on one
client vs. write in another, to the point that you can make some better
assumptions about image consistency, including what one client will read
after another has written.  But as long as multiple clients only ever
access distinct portions of the disk, then multi-conn is not important
to that client (whether for reading or for writing).

So it sounds like I have no reason to deprecate qemu-nbd -e 2, even for
writable images.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FnAmWMfG70PW4sff3iES9i16ZBALbn1Hn--

--abkSCfWbZfCJ1W6KbM6eGPeqr6JZofq7q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1a5KUACgkQp6FrSiUn
Q2p7jAgAmDk9tjIN4OF5M7NdnI2SxAHC6fS34CAl8J0K/+3KHT/nHVAWLcBvFCLb
k2dr0Ew0pJVsirTrDZE76AGs5yf4LaI0yRkdJvZd2PNkXVicxDtxocunqBu5Yjrf
WvNwqEcA3gz1CQgqMzVOH8qDy8C4Fxh4EM4/5ayNM1eI2Js9CCAg6B/03Fq6GZvZ
T08Php3xJEZATBel5YHKrzmJ8FPQ59wBK4PfWnELc1kDMd+2g99MJfvMUZX3y7Wr
wjVy+glLAVtWKcV+jp25wKEArLWZf8awBpVMAVM1EhYE9W9yO5yTiJZBt/dug9rs
vQg8y7/NDs81GlmNY/dqV1c27l6k9g==
=jI3t
-----END PGP SIGNATURE-----

--abkSCfWbZfCJ1W6KbM6eGPeqr6JZofq7q--

