Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC61C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 01:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3310821872
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 01:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3310821872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvXOj-00039T-Gt
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 21:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hvXO6-0002f3-L5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 21:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hvXO5-0001GS-Mb
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 21:38:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hvXO3-0001FR-Ei; Wed, 07 Aug 2019 21:38:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61F9D308A958;
 Thu,  8 Aug 2019 01:38:38 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 349CA60BE2;
 Thu,  8 Aug 2019 01:38:37 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20190807070631.9908-1-dplotnikov@virtuozzo.com>
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
Message-ID: <a8f813ea-d6ff-d26e-5afe-d683e5972e9c@redhat.com>
Date: Wed, 7 Aug 2019 20:38:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807070631.9908-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UqSCQcCujaxYVb3isxZi5WnbE8n9N59QO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 08 Aug 2019 01:38:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8] qemu-io: add pattern file for write
 command
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UqSCQcCujaxYVb3isxZi5WnbE8n9N59QO
Content-Type: multipart/mixed; boundary="TIsoCElGvV5oy2MEFmLeYVsXMxyNR1EZY";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <a8f813ea-d6ff-d26e-5afe-d683e5972e9c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8] qemu-io: add pattern file for write
 command
References: <20190807070631.9908-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190807070631.9908-1-dplotnikov@virtuozzo.com>

--TIsoCElGvV5oy2MEFmLeYVsXMxyNR1EZY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/7/19 2:06 AM, Denis Plotnikov wrote:
> The patch allows to provide a pattern file for write
> command. There was no similar ability before.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---

> =20
> +static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
> +                                     const char *file_name)
> +{

No comment on the usage of this function? Existing practice in this file
is not the best, but new code can do better.

> +    char *buf, *buf_origin;
> +    FILE *f =3D fopen(file_name, "r");
> +    int pattern_len;
> +
> +    if (!f) {
> +        perror(file_name);
> +        return NULL;
> +    }
> +
> +    if (qemuio_misalign) {
> +        len +=3D MISALIGN_OFFSET;
> +    }
> +
> +    buf_origin =3D buf =3D blk_blockalign(blk, len);
> +
> +    if (qemuio_misalign) {
> +        buf_origin +=3D MISALIGN_OFFSET;

Here, you are changing where you point...

> +    }
> +
> +    pattern_len =3D fread(buf_origin, 1, len, f);
> +
> +    if (ferror(f)) {
> +        perror(file_name);
> +        goto error;
> +    }

=2E..but if you fail here...


> +
> +error:
> +    qemu_vfree(buf_origin);

=2E..then you free the wrong pointer.  This MUST use
qemu_io_free(buf_origin) (the same as write_f correctly does with the
misaligned pointer that you return on success).

> @@ -1051,8 +1114,9 @@ static int write_f(BlockBackend *blk, int argc, c=
har **argv)
>          return -EINVAL;
>      }
> =20
> -    if (zflag && Pflag) {
> -        printf("-z and -P cannot be specified at the same time\n");
> +    if ((int)zflag + (int)Pflag + (int)sflag > 1) {

The casts to int are not necessary.  Adding two bools promotes to int
naturally.

> +        printf("Only one of -z, -P, and -s"
> +               "can be specified at the same time\n");

Missing a space; you don't want your user to see "and -scan be".

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--TIsoCElGvV5oy2MEFmLeYVsXMxyNR1EZY--

--UqSCQcCujaxYVb3isxZi5WnbE8n9N59QO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1LfRwACgkQp6FrSiUn
Q2pAAwf+OuCocM7Fat0hCCJ76A3xQgvm9mYyA4LqaaDBuUc7Xx9zdJBcmJI+zsI1
wlObtV/9m4T3ugWnzu3/2c6TMCTjRvxcNEDwPa7OtSm/vZaJr5ji2dn84RWxzlv8
hCmrGyQltjCtcfKPPsIj9cNm1UTNDeVOqYs1kH2iba05FagZAjuwC9Vj8bJ5XRvH
bugbhcxA0zEvt4EMfTZd2DCQrNZ6oARPJuDbhAuaVJc0Su9tKEq74IBAL92K1el9
nQcjvjt9GW8+r3GvN96GNroEV6kN9s7+S2HE3eUClodxfXQ3JYCUFWIN2H1ZXLl0
rU32nkoQijhGjr/2NNCf8C+ECgB3xw==
=mpI0
-----END PGP SIGNATURE-----

--UqSCQcCujaxYVb3isxZi5WnbE8n9N59QO--

