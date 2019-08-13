Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E2AC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04FF20651
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04FF20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxY94-0004LJ-As
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43168)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hxY8d-0003qo-Vw
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hxY8d-0008GD-29
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hxY8a-0008FJ-Ql; Tue, 13 Aug 2019 10:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A59830016E4;
 Tue, 13 Aug 2019 14:51:00 +0000 (UTC)
Received: from [10.3.117.22] (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DABB060BE2;
 Tue, 13 Aug 2019 14:50:58 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
 <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
 <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
 <94ccf129-cc7e-2778-7688-fd718f8df249@virtuozzo.com>
 <20190813115115.GG4663@localhost.localdomain>
 <b0c32bfc-f4cf-0d46-beb8-ba4cf79b76c5@redhat.com>
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
Message-ID: <be3b647a-f1a3-0723-754e-6b82380e0d0b@redhat.com>
Date: Tue, 13 Aug 2019 09:50:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b0c32bfc-f4cf-0d46-beb8-ba4cf79b76c5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WP7qUv4pR239u3ifUkmHyjLOheKybWQN2"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 13 Aug 2019 14:51:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WP7qUv4pR239u3ifUkmHyjLOheKybWQN2
Content-Type: multipart/mixed; boundary="skKlCief9Uadskosmg6kXP34Lk9uUaoku";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <be3b647a-f1a3-0723-754e-6b82380e0d0b@redhat.com>
Subject: Re: [PATCH 0/2] deal with BDRV_BLOCK_RAW
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
 <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
 <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
 <94ccf129-cc7e-2778-7688-fd718f8df249@virtuozzo.com>
 <20190813115115.GG4663@localhost.localdomain>
 <b0c32bfc-f4cf-0d46-beb8-ba4cf79b76c5@redhat.com>
In-Reply-To: <b0c32bfc-f4cf-0d46-beb8-ba4cf79b76c5@redhat.com>

--skKlCief9Uadskosmg6kXP34Lk9uUaoku
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/13/19 9:31 AM, Max Reitz wrote:
> On 13.08.19 13:51, Kevin Wolf wrote:
>=20
> [...]
>=20
>> Hm... This is a mess. :-)
>=20
> Just out of curiosity: Why?
>=20
> Aren=E2=80=99t there only two things we really need from the block_stat=
us
> infrastructure?
>=20
> (1) Whether something is allocated in the given layer of the backing ch=
ain,

(1)(a) - is it allocated in this layer
(1)(b) - is it allocated in any backing layer

>=20
> (2) Whether we know that a given range reads as zeroes.
>=20
> Do we really need anything else?

qemu-img map needs:

(3) What host-relative offset, if any, corresponds to a given
guest-visible offset.

I also need to find time to revisit my proposed patches on block_status
alignment - there are some cases where we want to ensure that one layer
with large granularity does not pick up mid-granularity changes in
status read from a backing layer with smaller granularity.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--skKlCief9Uadskosmg6kXP34Lk9uUaoku--

--WP7qUv4pR239u3ifUkmHyjLOheKybWQN2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1SzlEACgkQp6FrSiUn
Q2oT+Qf/cm8C8FV/8incpRzeiaTpIR7YECM95jWjRzSldVHCYRjXgVFkVCLUX42D
VWItl6iwn0W0AgW8DYwkqW5FrgTTyqVrRUPnz1RltOCOgnBwFFFTjtmHpN4unfWt
a7LY//p+SUga7imqNdaX7Tn2tT28C74o5yjyEhDg+MsziLuGUm6LbZV7gRw3mGVv
tdVixt17+9sIPEmaV0CEXq6aQIMNpNkJUlTTZrjhIRJIBO2tAA3KSq0nNJRy9zy5
ZNWrepE3V76kbvWGRGVYDASTxwx7Mk+BTE89psiN0VEdFVcCwBEsgkIDSR+EHS3o
aT2uXfzmivJG0tlHoCnaA3SEtshflQ==
=VOsQ
-----END PGP SIGNATURE-----

--WP7qUv4pR239u3ifUkmHyjLOheKybWQN2--

