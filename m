Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897FFC28EBD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 02:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5981920868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 02:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5981920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ4rM-0002sK-Cv
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 22:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49450)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hZ4qs-0002Ph-5o
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 22:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hZ4qr-0002Ya-00
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 22:43:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hZ4qo-0002G3-5z; Thu, 06 Jun 2019 22:43:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 855A5883D7;
 Fri,  7 Jun 2019 02:43:12 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A657C8BE42;
 Fri,  7 Jun 2019 02:43:06 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-5-vsementsov@virtuozzo.com>
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
Message-ID: <823c5237-02f9-0c03-2658-6259405f696b@redhat.com>
Date: Thu, 6 Jun 2019 21:43:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411172709.205032-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ujPSzc5HW29FQJU8z4seQrYDdzrObrmmy"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 07 Jun 2019 02:43:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 4/7] block/nbd: add cmdline and qapi
 parameter reconnect-delay
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
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ujPSzc5HW29FQJU8z4seQrYDdzrObrmmy
Content-Type: multipart/mixed; boundary="T4QrU399j2v7ZnDEL2oDooB8e0K0ib2PV";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Message-ID: <823c5237-02f9-0c03-2658-6259405f696b@redhat.com>
Subject: Re: [PATCH v6 4/7] block/nbd: add cmdline and qapi parameter
 reconnect-delay
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190411172709.205032-5-vsementsov@virtuozzo.com>

--T4QrU399j2v7ZnDEL2oDooB8e0K0ib2PV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/11/19 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> Reconnect will be implemented in the following commit, so for now,
> in semantics below, disconnect itself is a "serious error".
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json | 12 +++++++++++-
>  block/nbd-client.h   |  1 +
>  block/nbd-client.c   |  1 +
>  block/nbd.c          | 16 +++++++++++++++-
>  4 files changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..815258bd89 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3798,13 +3798,23 @@
>  #                  traditional "base:allocation" block status (see
>  #                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (sin=
ce 3.0)
>  #
> +# @reconnect-delay: Reconnect delay. On unexpected disconnect, nbd cli=
ent tries
> +#                   to connect again, until success or serious error. =
During
> +#                   first @reconnect-delay seconds of reconnecting loo=
p all
> +#                   requests are paused and have a chance to rerun, if=

> +#                   successful connect occurs during this time. After
> +#                   @reconnect-delay seconds all delayed requests are =
failed
> +#                   and all following requests will be failed too (unt=
il
> +#                   successful reconnect). Default 0 (Since 4.1)

Maybe:

On an unexpected disconnect, the nbd client tries to connect again until
succeeding or encountering a serious error.  During the first
@reconnect-delay seconds, all requests are paused and will be rerun on a
successful reconnect. After that time, any delayed requests and all
future requests before a successful reconnect will immediately fail.


> +++ b/block/nbd.c
> @@ -360,6 +360,18 @@ static QemuOptsList nbd_runtime_opts =3D {
>              .help =3D "experimental: expose named dirty bitmap in plac=
e of "
>                      "block status",
>          },
> +        {
> +            .name =3D "reconnect-delay",
> +            .type =3D QEMU_OPT_NUMBER,
> +            .help =3D "Reconnect delay. On unexpected disconnect, nbd =
client "
> +                    "tries to connect again, until success or serious =
error. "
> +                    "During first @reconnect-delay seconds of reconnec=
ting "
> +                    "loop all requests are paused and have a chance to=
 rerun, "
> +                    "if successful connect occurs during this time. Af=
ter"
> +                    "@reconnect-delay seconds all delayed requests are=
 failed"
> +                    "and all following requests will be failed too (un=
til"
> +                    "successful reconnect). Default 0",

And of course copy any changes to the QMP text to here.

I can touch up grammar, so if there's no other reason to respin,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--T4QrU399j2v7ZnDEL2oDooB8e0K0ib2PV--

--ujPSzc5HW29FQJU8z4seQrYDdzrObrmmy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz5zzkACgkQp6FrSiUn
Q2qbUgf9F0R5esX7V3ZlqM4SN7O258tUdyBFrr4k6Uo8iynUhCtZBb90FvTN1eAk
jXTfAvHYgK9aZE4iZ+LaHuwzrrOfagV0oxqd9LfsNcmza+qTphlsBcq0ck3MZCYw
VbuYPkBFvDyBTdZT+kmLA0tmoCmGTEcSfGtDkwR71ZMCZ2/B22xrqMMAd9huXluL
WGqGyO5O83PJrhDRjkqLcHu2W5MNIpU7y0kTkq3EJmwnIElJRTUfyjaMpH/ixWI/
2kpvDif/jNqhZjX4tg+W/nYVthTtvmLS1/1Wq/LloMG5ReqVPfld62LvH87HaTnm
cmxfwxGp1BS3J+L8cLmrvddj3ZwpbQ==
=JB2g
-----END PGP SIGNATURE-----

--ujPSzc5HW29FQJU8z4seQrYDdzrObrmmy--

