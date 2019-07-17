Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07182C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 18:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F1C21849
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 18:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F1C21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnp7o-0001F9-68
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 14:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40699)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hnp7d-0000qS-Fm
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 14:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hnp7c-0002ye-8G
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 14:57:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hnp7b-0002t7-VM
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 14:57:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA843C04AC70;
 Wed, 17 Jul 2019 18:57:45 +0000 (UTC)
Received: from [10.3.116.46] (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E80E19C68;
 Wed, 17 Jul 2019 18:57:42 +0000 (UTC)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <20190716174420.GA857@redhat.com>
 <CAL1e-=jvRnp9NBzuMjOjP_WgCxhDSUf4qCkswRvyrpGFPK6cHg@mail.gmail.com>
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
Message-ID: <5b6d1130-73fd-b7c7-28ef-f553d33972e0@redhat.com>
Date: Wed, 17 Jul 2019 13:57:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jvRnp9NBzuMjOjP_WgCxhDSUf4qCkswRvyrpGFPK6cHg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Kn5kxIVeyyRBiUILLrWhZdDpBMJT9h4cK"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 17 Jul 2019 18:57:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
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
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kn5kxIVeyyRBiUILLrWhZdDpBMJT9h4cK
Content-Type: multipart/mixed; boundary="3ILktAOSg5gH72tcYtwGd1I8aWdaH9lCf";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <5b6d1130-73fd-b7c7-28ef-f553d33972e0@redhat.com>
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <20190716174420.GA857@redhat.com>
 <CAL1e-=jvRnp9NBzuMjOjP_WgCxhDSUf4qCkswRvyrpGFPK6cHg@mail.gmail.com>
In-Reply-To: <CAL1e-=jvRnp9NBzuMjOjP_WgCxhDSUf4qCkswRvyrpGFPK6cHg@mail.gmail.com>

--3ILktAOSg5gH72tcYtwGd1I8aWdaH9lCf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/17/19 1:34 PM, Aleksandar Markovic wrote:

>=20
> Daniel, that is fine, I don't question that, I basically wanted to star=
t a talk
> between us to clarify some things. Related to our situation in the fiel=
d,
> I have a sub-question to you:
>=20
> Let's say there is a build system with SDL 1.2, and not SDL 2.0. Should=

> QEMU refuse to build?

If the dependency is soft (when SDL 2.0 is available, we can compile
more things than when it is not), then the build shouldn't fail, but
your resulting binaries will not use SDL.  For example, we treat librbd
as a soft dependency: if it is available, you can build in Ceph support;
if it is not, you lose out on that particular block format, but can
still run guests locally.

If the dependency is hard (when SDL 2.0 is unavailable, we cannot
perform our job), then the build should fail.  For example, we treat
glib2 as a hard dependency: if it is unavailable, we can't implement our
main loop, and there's really nothing left worth compiling.

Some qemu dependencies are hard, some are soft. And your choice of
configure options may further influence things (our KConfig setup may
mean that some libraries are hard dependencies for one board type, but
soft dependencies for others).  Off-hand, I'd guess that SDL 2.0 should
be a soft dependency (but if it is a hard dependency, patches to make it
a soft dependency are welcome); if I'm right, then building when only
SDL 1.2 is available should not fail, but also will not use SDL.

But the presence or absence of SDL 1.2 on a build machine has no bearing
on the real question of whether SDL 2.0 is a hard or soft dependency,
now that the project has decided that SDL 2.0 is easy enough to obtain
across all of the set of systems included in our documented list of
minimum development setups.  In short, if you want to build with SDL,
you need to have SDL 2.0 available because we are not going to support
builds against SDL 1.2 as a reasonable development target any longer;
but having SDL 2.0 development libraries available does not preclude
also keeping SDL 1.2 on the same machine for other reasons.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--3ILktAOSg5gH72tcYtwGd1I8aWdaH9lCf--

--Kn5kxIVeyyRBiUILLrWhZdDpBMJT9h4cK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0vb6UACgkQp6FrSiUn
Q2r9YggAnjFKt/nz4l/opXchhQaIbFEiwbW4vbMYAv6EcpFMFY/8JzHaNI7HZYtt
8Qd2icokEpk1Ruwmc1G/2FGt7OPpY6lu1NggNvbJ9FucZvbnvsOWNTZd77D5t0JZ
8EJmDDrdJcKc7duJi/n1QjUhfaebmCDWaBc6clYtUUvZUiG8k+ZE9ulQxlRNV7ff
Kos/mm1dVV5M9lmjX7WpWKIXqESTw2pH5aGdzY5BFT8nZzDDBmDTZ0ZQWMeaAa6d
eouqlTpy/BlT3OkI2rafD93eKnK4lo2VUKQij5uAVgjgw7KHYDjIN+HanypPAfNP
EyrtkiefxmvoQVeGi5K3Qht1wa5P7A==
=Dabc
-----END PGP SIGNATURE-----

--Kn5kxIVeyyRBiUILLrWhZdDpBMJT9h4cK--

