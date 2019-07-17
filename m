Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C8DC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 19:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B4921873
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 19:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B4921873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnq3a-00008m-GN
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 15:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55803)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hnq3N-0007wI-Dr
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hnq3M-0002Wc-4d
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:57:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hnq3L-0002Rg-Qu
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:57:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8F985D674;
 Wed, 17 Jul 2019 19:57:22 +0000 (UTC)
Received: from [10.3.116.46] (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9176A600C8;
 Wed, 17 Jul 2019 19:57:18 +0000 (UTC)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <20190716174420.GA857@redhat.com>
 <CAL1e-=jvRnp9NBzuMjOjP_WgCxhDSUf4qCkswRvyrpGFPK6cHg@mail.gmail.com>
 <5b6d1130-73fd-b7c7-28ef-f553d33972e0@redhat.com>
 <CAL1e-=iJwVGfX-fbHkpYmVFH+YxvDr6LG9ZJXesgmog5q_JhPA@mail.gmail.com>
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
Message-ID: <bbb215d5-3dc8-9c93-7dd5-d765d7bb763e@redhat.com>
Date: Wed, 17 Jul 2019 14:57:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iJwVGfX-fbHkpYmVFH+YxvDr6LG9ZJXesgmog5q_JhPA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AdgKFlCHBO1wlQsQn7DLsSzohF8y7SEnU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 17 Jul 2019 19:57:22 +0000 (UTC)
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AdgKFlCHBO1wlQsQn7DLsSzohF8y7SEnU
Content-Type: multipart/mixed; boundary="93n6AYmQy5FfFB4FvNuKM4LAHVm0vYu9C";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <bbb215d5-3dc8-9c93-7dd5-d765d7bb763e@redhat.com>
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <20190716174420.GA857@redhat.com>
 <CAL1e-=jvRnp9NBzuMjOjP_WgCxhDSUf4qCkswRvyrpGFPK6cHg@mail.gmail.com>
 <5b6d1130-73fd-b7c7-28ef-f553d33972e0@redhat.com>
 <CAL1e-=iJwVGfX-fbHkpYmVFH+YxvDr6LG9ZJXesgmog5q_JhPA@mail.gmail.com>
In-Reply-To: <CAL1e-=iJwVGfX-fbHkpYmVFH+YxvDr6LG9ZJXesgmog5q_JhPA@mail.gmail.com>

--93n6AYmQy5FfFB4FvNuKM4LAHVm0vYu9C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/17/19 2:20 PM, Aleksandar Markovic wrote:

> But, does "configure" list somewhere unmet soft dependencies? (the
> question is general, not looking at SDL only) Is there any other way fo=
r
> an end user to have info on unmet dependencies (whether soft or hard),
> other than see QEMU is not building, or something is not working in
> QEMU run-time?

Yes - at the end of ./configure, the output includes a list similar to:

=2E..
profiler          no
static build      no
SDL support       yes (2.0.9)
SDL image support no
GTK support       yes (3.24.1)
GTK GL support    yes
VTE support       yes (0.54.4)
TLS priority      NORMAL
GNUTLS support    yes
libgcrypt         no
nettle            yes (3.4.1)
=2E..

so on my system, I have SDL 2.0.9 (auto-detected, so it is in use);
whereas a system with no SDL or only SDL 1.2 would probably state "SDL
support no". You can similarly observe how I lack libgcrypt but have
libnettle. Basically, if configure exited with status 0, anything with a
'no' status was a soft dependency and you are building without that
feature; but if you want to ensure that a feature is used, you could use
'./configure --enable-sdl=3Dyes' to force configure to make SDL a hard
dependency (fail it if was not found, instead of the default of probing
if it is available and then deciding yes or no based on the probe
results).  Conversely, you can use './configure --disable-sdl' (also
spelled './configure --enable-sdl=3Dno') to forcefully build without SDL
(and prove that it was a soft dependency, and to see what gets omitted
from the build) even when the probe would otherwise have automatically
built against SDL 2.0.

>=20
> Daniel,
>=20
> We had message "SDL 1.2 is going to be deprecated" in QEMU 3.0
> "configure" and, if I remember well, in QEMU 3.1 as well. And now,
> when we finally deprecated it, is it true that there is no message
> whatsoever on systems with SDL 1.2 only?

You'll get the 'SDL supported no' message, but unless you were explicit
at the configure command line, the default behavior is that it relies on
system probing with silent fallback; you have to supply an
--enable/--disable command-line option if you want better behavior than
an implicit default.  In fact, if you ever look at downstream packages,
you'll notice that the packagers have a very long list of
--enable/--disable to prove that their build is reproducible with the
intended components instead of arbitrary based on whatever probing
happened to find on the system at the time.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--93n6AYmQy5FfFB4FvNuKM4LAHVm0vYu9C--

--AdgKFlCHBO1wlQsQn7DLsSzohF8y7SEnU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0vfZwACgkQp6FrSiUn
Q2pNbwgAkmthTs/pQoh6xBj624DHdcQJzjOf4ZSs2KL96fKuX8u/BYtxbj2rW1xf
nQhAGOTAgrR94waXtUhAFMJ/5UaTZoBsVvrTyW0d98la/Kj59TkbC0lXqT+zIYFX
371HNMTaSXIfKQ5tEnP2UgSm+vHNLi8YXaUmkBKC9zffDIEQAkRlP7Vf0NQWYOqQ
ND2C+tX3p5Iud7d+J2NQ/N1Ki7yflTVr9fqXQ3qBkHG38cXZMJr16QIyAAISZte7
jkS1YPKuCBs4UkYWRvpifKUfBwfOJwG7+gOAL6J5e1XPo/pk8zjG3KVetXkk/J8R
KE8EQK/jOp61CLWrXKreHJur7Eh4Yw==
=GHQa
-----END PGP SIGNATURE-----

--AdgKFlCHBO1wlQsQn7DLsSzohF8y7SEnU--

