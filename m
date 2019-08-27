Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C684C41514
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7F922CF4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7F922CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2eCi-0006Xy-Vd
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 12:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i2eAb-0005EW-2M
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i2eAZ-0007pQ-0E
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:18:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i2eAY-0007oz-Dl
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:18:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 71194A53260;
 Tue, 27 Aug 2019 16:18:05 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 812285D9E1;
 Tue, 27 Aug 2019 16:18:04 +0000 (UTC)
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-2-yury-kotov@yandex-team.ru>
 <fb324ab9-b7a2-d56e-a0d1-9f4ae86791ce@redhat.com>
 <1097381566920178@vla1-6bb9290e4d68.qloud-c.yandex.net>
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
Message-ID: <ff0428a4-6600-7b41-e246-7858e58e5507@redhat.com>
Date: Tue, 27 Aug 2019 11:18:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1097381566920178@vla1-6bb9290e4d68.qloud-c.yandex.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Of3eZHcyuNs6tmhRbxgYsJx2SSTrLde9M"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 27 Aug 2019 16:18:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Add x-validate-uuid
 capability
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Of3eZHcyuNs6tmhRbxgYsJx2SSTrLde9M
Content-Type: multipart/mixed; boundary="VtvBD7JUBrKKrMlY6Brg6YpoqlsT5dME7";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Message-ID: <ff0428a4-6600-7b41-e246-7858e58e5507@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Add x-validate-uuid
 capability
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-2-yury-kotov@yandex-team.ru>
 <fb324ab9-b7a2-d56e-a0d1-9f4ae86791ce@redhat.com>
 <1097381566920178@vla1-6bb9290e4d68.qloud-c.yandex.net>
In-Reply-To: <1097381566920178@vla1-6bb9290e4d68.qloud-c.yandex.net>

--VtvBD7JUBrKKrMlY6Brg6YpoqlsT5dME7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/27/19 10:36 AM, Yury Kotov wrote:
> 27.08.2019, 17:02, "Eric Blake" <eblake@redhat.com>:
>> On 8/27/19 7:02 AM, Yury Kotov wrote:
>>> =C2=A0This capability realizes simple source validation by UUID.
>>> =C2=A0It's useful for live migration between hosts.
>>>

>>
>> Any reason why this is marked experimental? It seems useful enough tha=
t
>> we could probably just add it as a fully-supported feature (dropping t=
he
>> x- prefix) - but I'll leave that up to the migration maintainers.
>>
>=20
> I thought that all new capabilities have x- prefix... May be it's reall=
y
> unnecessary here, I'm not sure.

New features that need some testing or possible changes to behavior need
x- to mark them as experimental, so we can make those changes without
worrying about breaking back-compat.  But new features that are outright
useful and presumably in their final form, with no further
experimentation needed, can skip going through an x- phase.

>=20
>> In fact, do we even need this to be a tunable feature? Why not just
>> always enable it? As long as the UUID is sent in a way that new->old
>> doesn't break the old qemu from receiving the migration stream, and th=
at
>> old->new copes with UUID being absent, then new->new will always benef=
it
>> from the additional safety check.
>>
>=20
> In such case we couldn't migrate from e.g. 4.2 to 3.1

I don't know the migration format enough to know if there is a way for
4.2 to unconditionally send a UUID as a subsection such that a receiving
3.1 will ignore the unknown subsection. If so, then you don't need a
knob; if not, then you need something to say whether sending the
subsection is safe (perhaps default on in new machine types, but default
off for machine types that might still be migrated back to 3.1).  That's
where I'm hoping the migration experts will chime in.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--VtvBD7JUBrKKrMlY6Brg6YpoqlsT5dME7--

--Of3eZHcyuNs6tmhRbxgYsJx2SSTrLde9M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1lV7sACgkQp6FrSiUn
Q2qYgQf/Y0D8QYjzU40mawstk+HHMCeclIeMXJVEB7tnavfeeVeCgfzBe+LGm25h
g+AgU2EEsnec5jxmSVptp6TQW+SXPYut6pjw4IOXmEaqA4Qty7z69uWNt7kaqmBi
Ac1b+lHZpy9J9DBAMYY5TZBhPbx+VMiQN24+gghimv04PxS/qflOzBWJT2s9Xlpz
fjahXMUsJKykOsD6dMT9yDrR+skKt0cMpX22O5K+RuFUfQfnkh0hHozch6QQwAhJ
g+2QM+eQKCieFKD9LnZ6Il6deObOo84iZfmmURQ1z1dODBS5ryB6cQuvNwatwDW2
S/AqpHY7TMiLsATna9+wplZ3+SvCPQ==
=IPtI
-----END PGP SIGNATURE-----

--Of3eZHcyuNs6tmhRbxgYsJx2SSTrLde9M--

