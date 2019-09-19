Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A983FC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F2020665
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F2020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAyLn-0005Ps-ID
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAyL5-0004xr-QR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAyL4-0002wC-Jt
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAyL4-0002vv-Bw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:27:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4CFB387630;
 Thu, 19 Sep 2019 15:27:21 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42BCD1001938;
 Thu, 19 Sep 2019 15:27:18 +0000 (UTC)
Subject: Re: [PULL 15/26] audio: add mixeng option (documentation)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190919083629.29998-1-kraxel@redhat.com>
 <20190919083629.29998-16-kraxel@redhat.com>
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
Message-ID: <051bc473-f0b3-1ef5-1fef-6fe945dd9db3@redhat.com>
Date: Thu, 19 Sep 2019 10:27:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919083629.29998-16-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RIdYIAvZZf2vRxvGGi6U3VGfI0qea9GDy"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 19 Sep 2019 15:27:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RIdYIAvZZf2vRxvGGi6U3VGfI0qea9GDy
Content-Type: multipart/mixed; boundary="2PHc1oizA3W57TgVM9HegQHaOKhyqJmCi";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Message-ID: <051bc473-f0b3-1ef5-1fef-6fe945dd9db3@redhat.com>
Subject: Re: [PULL 15/26] audio: add mixeng option (documentation)
References: <20190919083629.29998-1-kraxel@redhat.com>
 <20190919083629.29998-16-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-16-kraxel@redhat.com>

--2PHc1oizA3W57TgVM9HegQHaOKhyqJmCi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/19/19 3:36 AM, Gerd Hoffmann wrote:
> From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>
>=20
> This will allow us to disable mixeng when we use a decent backend.
>=20
> Disabling mixeng have a few advantages:
> * we no longer convert the audio output from one format to another, whe=
n
>   the underlying audio system would just convert it to a third format.
>   We no longer convert, only the underlying system, when needed.
> * the underlying system probably has better resampling and sample forma=
t
>   converting methods anyway...
> * we may support formats that the mixeng currently does not support (S2=
4
>   or float samples, more than two channels)
> * when using an audio server (like pulseaudio) different sound card
>   outputs will show up as separate streams, even if we use only one
>   backend
>=20
> Disadvantages:
> * audio capturing no longer works (wavcapture, and vnc audio extension)=

> * some backends only support a single playback stream or very picky
>   about the audio format.  In this case we can't disable mixeng.
>=20
> However mixeng is not removed, only made optional, so this shouldn't be=

> a big concern.
>=20

> +++ b/qemu-options.hx
> @@ -433,6 +433,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>      "                specifies the audio backend to use\n"
>      "                id=3D identifier of the backend\n"
>      "                timer-period=3D timer period in microseconds\n"
> +    "                in|out.mixing-engineeng=3D use mixing engine to m=
ix streams inside QEMU\n"

s/engineeng/engine/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2PHc1oizA3W57TgVM9HegQHaOKhyqJmCi--

--RIdYIAvZZf2vRxvGGi6U3VGfI0qea9GDy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2DnlUACgkQp6FrSiUn
Q2pYkwgAlnXvg8uFP9f+Ms5NnpKplxofLGzZmycbrsAEy2pt9nmeJgGHDa1m9exu
XcdRPO9q/M+GPfyZsbezVsPdNchqKhwTDXtMueGB05FtNv5mirkn/RoFfRXlPLl4
/dGfSn7lBsmsrailQJQyVLWaZRoATNL4b4pjj6bETPicfFYhNC1FA282AsXBY+Oa
RiHLqU6+GQTqfF9sbSaetc96DE6VG0yP8GZKNQYzYuT2DFbGPkXCtfVX3A3gpdC+
vMuhv45j5MaX+kP+qB7Lj9x6jC0DvPsWDIEjlsqQZw5a8v6jLc7gFIgMtuWLBy92
m9MxfV9hzdU5HmEjFjexzMQ99vaCgQ==
=u9gO
-----END PGP SIGNATURE-----

--RIdYIAvZZf2vRxvGGi6U3VGfI0qea9GDy--

