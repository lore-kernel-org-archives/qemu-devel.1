Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208E8C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2682053B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2682053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2FAq-0001Zl-4e
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 09:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i2FAC-00018Y-Dg
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i2FAB-0005wm-AM
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:36:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i2FAA-0005w3-Vl
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:36:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3F4A2A09BF;
 Mon, 26 Aug 2019 13:36:01 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1195600CE;
 Mon, 26 Aug 2019 13:35:58 +0000 (UTC)
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 qemu-devel@nongnu.org
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
 <76a0c0fda2f78cfb5f2234aa7e28073aa3e8bd95.1566755452.git.DirtY.iCE.hu@gmail.com>
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
Message-ID: <1e59409e-1754-543f-28e1-03db2b01d634@redhat.com>
Date: Mon, 26 Aug 2019 08:35:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <76a0c0fda2f78cfb5f2234aa7e28073aa3e8bd95.1566755452.git.DirtY.iCE.hu@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="S4FxbDTb0Ni3CzwGSX1Px4DW63z6nx595"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 26 Aug 2019 13:36:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 16/25] audio: add mixeng option
 (documentation)
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S4FxbDTb0Ni3CzwGSX1Px4DW63z6nx595
Content-Type: multipart/mixed; boundary="ZeOlu5R21SFT47yokY24Bka7NYS1ujJyF";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <1e59409e-1754-543f-28e1-03db2b01d634@redhat.com>
Subject: Re: [PATCH 16/25] audio: add mixeng option (documentation)
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
 <76a0c0fda2f78cfb5f2234aa7e28073aa3e8bd95.1566755452.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <76a0c0fda2f78cfb5f2234aa7e28073aa3e8bd95.1566755452.git.DirtY.iCE.hu@gmail.com>

--ZeOlu5R21SFT47yokY24Bka7NYS1ujJyF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/25/19 1:46 PM, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wrote:
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
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>  qapi/audio.json | 5 +++++
>  qemu-options.hx | 6 ++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 9fefdf5186..dc7f9cb1e2 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -11,6 +11,10 @@
>  # General audio backend options that are used for both playback and
>  # recording.
>  #
> +# @mixeng: use QEMU's mixing engine to mix all streams inside QEMU. Wh=
en set to
> +#          off, fixed-settings must be also off. Not every backend com=
patible
> +#          with the off setting (default on, since 4.2)
> +#

'mixeng' looks like an accidental typo, when 3 words later is 'mixing'.
Would 'mix-eng' or 'mix-engine' be more obvious?


>  ##
>  { 'struct': 'AudiodevPerDirectionOptions',
>    'data': {
> +    '*mixeng':         'bool',
>      '*fixed-settings': 'bool',

And the very next member is an example that QAPI doesn't have to use
abbreviations.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ZeOlu5R21SFT47yokY24Bka7NYS1ujJyF--

--S4FxbDTb0Ni3CzwGSX1Px4DW63z6nx595
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1j4D0ACgkQp6FrSiUn
Q2oKawf/ZuMiDgBe+llJfbq+rgEnB0NtgFR5cLYWVYEkDH2W+FSaF4vOOwo8/t5c
qIwZyIafaP5Tq1dNNJkzTZ8Q5Ng7DmJvvfH8VNz63lIXiVLPi2uboBciJq2j6s9x
PiiFxlO04Z17GYVIQDWxcoacoopwo45IgMtKoO8eAGmaNLr8SBHcyf9BYlrlrH9D
xQh55KQKKnrGABFtn4r/uVDlNJdfSOYx4Hjb2N5Xh8w55Pu/tmSUfCvkurO8oeuU
9k9wS/9UIoyaTWoqlpL36wyYePVVgWVyIY+IyMnuAIfrzgSbbdMpZOT5DhWirejf
9xJoq6UYbEjQDe6tCmPlSrEdrdzBPA==
=tCjY
-----END PGP SIGNATURE-----

--S4FxbDTb0Ni3CzwGSX1Px4DW63z6nx595--

