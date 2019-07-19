Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AACFC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2B52085A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2B52085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVLg-0001mT-Oq
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 12:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37872)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hoVLL-0001M4-W2
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hoVL6-0004T7-Hz
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:02:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hoVKb-0000bn-HF; Fri, 19 Jul 2019 12:02:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B8874776CD;
 Fri, 19 Jul 2019 15:55:15 +0000 (UTC)
Received: from [10.3.116.46] (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B5E557988;
 Fri, 19 Jul 2019 15:55:14 +0000 (UTC)
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
 <20190719133530.28688-14-mehta.aaru20@gmail.com>
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
Message-ID: <ec33c8fc-04de-8669-0224-57de171aab8f@redhat.com>
Date: Fri, 19 Jul 2019 10:55:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719133530.28688-14-mehta.aaru20@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AWDXnOftyly9G01O9OYzOnw91c0kYIf38"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 19 Jul 2019 15:55:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 13/14] qemu-nbd: adds option for aio
 engines
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AWDXnOftyly9G01O9OYzOnw91c0kYIf38
Content-Type: multipart/mixed; boundary="J47QaPwO4JZPvSKhGMqBbXa3PTfHzm4zi";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Sergio Lopez <slp@redhat.com>, saket.sinha89@gmail.com,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefan@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <ec33c8fc-04de-8669-0224-57de171aab8f@redhat.com>
Subject: Re: [PATCH v6 13/14] qemu-nbd: adds option for aio engines
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
 <20190719133530.28688-14-mehta.aaru20@gmail.com>
In-Reply-To: <20190719133530.28688-14-mehta.aaru20@gmail.com>

--J47QaPwO4JZPvSKhGMqBbXa3PTfHzm4zi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/19/19 8:35 AM, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  qemu-nbd.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20

Missing a patch to qemu-nbd.texi to document this.

> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index a8cb39e510..e5a71b3501 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -135,7 +135,7 @@ static void usage(const char *name)
>  "                            '[ID_OR_NAME]'\n"
>  "  -n, --nocache             disable host cache\n"
>  "      --cache=3DMODE          set cache mode (none, writeback, ...)\n=
"
> -"      --aio=3DMODE            set AIO mode (native or threads)\n"
> +"      --aio=3DMODE            set AIO mode (native, io_uring or threa=
ds)\n"
>  "      --discard=3DMODE        set discard mode (ignore, unmap)\n"
>  "      --detect-zeroes=3DMODE  set detect-zeroes mode (off, on, unmap)=
\n"
>  "      --image-opts          treat FILE as a full set of image options=
\n"
> @@ -718,13 +718,9 @@ int main(int argc, char **argv)
>                  exit(EXIT_FAILURE);
>              }
>              seen_aio =3D true;
> -            if (!strcmp(optarg, "native")) {
> -                flags |=3D BDRV_O_NATIVE_AIO;
> -            } else if (!strcmp(optarg, "threads")) {
> -                /* this is the default */
> -            } else {
> -               error_report("invalid aio mode `%s'", optarg);
> -               exit(EXIT_FAILURE);
> +            if (bdrv_parse_aio(optarg, &flags) < 0) {
> +                error_report("Invalid aio mode `%s'", optarg);
> +                exit(EXIT_FAILURE);

Nice - you're also fixing an indentation error.  We aren't consistent on
whether error messages start with upper or lowercase, so I will overlook
that change.

But as long as you're touching the line, could you also change `' to be
''?  The former form looks awkward in modern type, and while it was
popular 20 years ago, nowadays it makes programs look dated (or
identifies you as a user of m4...).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--J47QaPwO4JZPvSKhGMqBbXa3PTfHzm4zi--

--AWDXnOftyly9G01O9OYzOnw91c0kYIf38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0x5+EACgkQp6FrSiUn
Q2r3BAf/VxB9VsY54ywOEmGF2nhAJ0cn0G18POmoAy0lBjDt8RHhRM1wlSrU3PdS
n738fkfrl49STwbHj/77izvYyTElTc6esFwGrWLrOtk1MKVa0BPRhJJUZM1597dz
DZtxUfkM3JvXHcLIlmQ8FegYSSpzyAGCyUhKAsSNlnCNlbxb1WZPPN54mXzuti7L
87v8dduDJazWWJ1xE9JbAnqaaEkeGIgdBKdb7AmgZT+mR1f1GGEFPUZA45XjBnTJ
sq/xw+lQtM5yV7mRA7hTMWaf4HTajSJhysDnVxoHQaIN2cis3A6QKNlEiZQygI5d
MBIwcY/icFr4rDke413qrvDglF9yZw==
=qvia
-----END PGP SIGNATURE-----

--AWDXnOftyly9G01O9OYzOnw91c0kYIf38--

