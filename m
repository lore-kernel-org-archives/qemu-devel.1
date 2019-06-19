Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D76C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A483206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A483206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcQE-0008TV-D9
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40691)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hdcMs-0006XI-Qh
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hdcMr-0006wc-MY
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hdcMr-0006uy-D4
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:19:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E89DD30C0DCF
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 15:19:14 +0000 (UTC)
Received: from [10.3.116.44] (ovpn-116-44.phx2.redhat.com [10.3.116.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BC1E5C2E4;
 Wed, 19 Jun 2019 15:19:12 +0000 (UTC)
To: Kevin Pouget <kpouget@redhat.com>, qemu-devel@nongnu.org
References: <20190619123042.4822-1-kpouget@redhat.com>
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
Message-ID: <e9fcdbfd-cde2-fc91-ce1d-6bfe06d39c4f@redhat.com>
Date: Wed, 19 Jun 2019 10:19:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619123042.4822-1-kpouget@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kjgLf8JGv89mUxh5yFX84SwP6jbA5c1hS"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 19 Jun 2019 15:19:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] spice-core: allow setting properties from QMP
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
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kjgLf8JGv89mUxh5yFX84SwP6jbA5c1hS
Content-Type: multipart/mixed; boundary="3M2hvykS8pGyTWnK21Q71FjcdbC7grPFf";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Pouget <kpouget@redhat.com>, qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Message-ID: <e9fcdbfd-cde2-fc91-ce1d-6bfe06d39c4f@redhat.com>
Subject: Re: [Qemu-devel] [RFC] spice-core: allow setting properties from QMP
References: <20190619123042.4822-1-kpouget@redhat.com>
In-Reply-To: <20190619123042.4822-1-kpouget@redhat.com>

--3M2hvykS8pGyTWnK21Q71FjcdbC7grPFf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/19/19 7:30 AM, Kevin Pouget wrote:
> Hello,
>=20
> we're investigating the possibility to set some spice properties at
> runtime, through the QMP interface, but we're not sure what's the best
> way to proceed.
> I've prepared the patch below, that adds a new QMP
> command, but is there another way like with a QOM object, that could
> reuse an existing command? I searched but couldn't find an easy/not
> hacky way to create such objects ...
>=20

A new command may be okay, however,


> +##
> +# @set-spice:
> +#
> +# Set Spice properties.
> +# @property: the SPICE property to modify
> +# @value: the new value to affect to this property
> +#
> +# Since: ...
> +#
> +# Example:
> +#
> +# -> { "execute": "set-spice", "arguments": { "property": "video-codec=
s",
> +#                                             "value": "spice:mjpeg;gs=
t:mjpeg;" } }
> +# <- { "returns": {} }
> +##
> +{ 'command': 'set-spice',
> +  'data': {'property': 'str', 'value': 'str'},
> +  'if': 'defined(CONFIG_SPICE)' }

letting 'property' be an open-coded string feels wrong. If you are only
going to accept a specific (limited) set of property names, then
'property' should be typed as an enum:

{ 'enum': 'SpiceProperties', 'data': [ 'video-codecs' ] }

{ 'command': 'set-spice', 'data': { 'property': 'SpiceProperties',
'value': 'str' } }

> +
>  ##
>  # @SPICE_CONNECTED:
>  #
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 2ffc3335f0..5408b16684 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -503,6 +503,19 @@ static QemuOptsList qemu_spice_opts =3D {
>      },
>  };
>=20
> +void qmp_set_spice(const char *property, const char *value, Error **er=
rp) {
> +    if (strcmp(property, "video-codecs") =3D=3D 0) {
> +        int invalid_codecs =3D spice_server_set_video_codecs(spice_ser=
ver, value);
> +
> +        if (invalid_codecs) {
> +            error_setg(errp, "Found %d invalic codecs while setting "

invalid

> +                       "the property %s=3D%s\n", invalid_codecs, prope=
rty, value);
> +        }
> +    } else {
> +        error_setg(errp, "Setting an unknown spice property (%s=3D%s)\=
n", property, value);
> +    }
> +}
> +
>  SpiceInfo *qmp_query_spice(Error **errp)
>  {
>      QemuOpts *opts =3D QTAILQ_FIRST(&qemu_spice_opts.head);
> --
> 2.21.0
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--3M2hvykS8pGyTWnK21Q71FjcdbC7grPFf--

--kjgLf8JGv89mUxh5yFX84SwP6jbA5c1hS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0KUm8ACgkQp6FrSiUn
Q2qLSQf/ekr98/41qVYGW+QbApIhltG4eMgbyca3FQr2W97+0FiJWD6QlG2Omt/b
OWIMbsrseFbvPUNWRBcqQdi+BURML3qzVCMdrVypJhZEc5DbVVmgGSqcExFdtcc3
ZVbhfm37BZ98A8n00pstqRXhOtxJMRGdxeCB40Z+mVY9oP1bDDfRTQwb90oJ3Mdj
ho0qpq7rmQxFe1V1N+/zfQVu6a7CtyLQRrfqVFql0ng5tG+XT26g4CZMRN+T6JW1
xRuH9/jK37jna2oJ2iaQANWRyXMInuh9YPHiRXwyrcIoWB0jrCKEIH1NGLEh48tP
8Xd+/lq+saduX/ZxyoT58K7OKB/ZHQ==
=fUUK
-----END PGP SIGNATURE-----

--kjgLf8JGv89mUxh5yFX84SwP6jbA5c1hS--

