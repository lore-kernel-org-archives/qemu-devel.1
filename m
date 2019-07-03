Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698AC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE75E218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE75E218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1higOg-0008St-HK
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1higNj-0007x4-37
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1higNh-0001sw-5z
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1higNd-0001qH-9m; Wed, 03 Jul 2019 10:37:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A75B81DE9;
 Wed,  3 Jul 2019 14:37:00 +0000 (UTC)
Received: from [10.3.116.152] (ovpn-116-152.phx2.redhat.com [10.3.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 871BD83CD7;
 Wed,  3 Jul 2019 14:36:59 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-4-dplotnikov@virtuozzo.com>
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
Message-ID: <e61d7afc-09ce-d52d-3987-df1d5ba6977f@redhat.com>
Date: Wed, 3 Jul 2019 09:36:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703110044.25610-4-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QRfbkSJ38ffMTwMEw08Ct1oRb7TaqIpId"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 03 Jul 2019 14:37:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 3/3] qcow2: add zstd cluster compression
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QRfbkSJ38ffMTwMEw08Ct1oRb7TaqIpId
Content-Type: multipart/mixed; boundary="5Q4kO8FZMj6EvQisrxv3Jg0drzueLmK3X";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <e61d7afc-09ce-d52d-3987-df1d5ba6977f@redhat.com>
Subject: Re: [PATCH v1 3/3] qcow2: add zstd cluster compression
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-4-dplotnikov@virtuozzo.com>
In-Reply-To: <20190703110044.25610-4-dplotnikov@virtuozzo.com>

--5Q4kO8FZMj6EvQisrxv3Jg0drzueLmK3X
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/3/19 6:00 AM, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of compression ratio in comparison with
> zlib, which, by the moment, has been the only compression
> method available.
>=20

> ---
>  block/qcow2.c        | 96 ++++++++++++++++++++++++++++++++++++++++++++=

>  configure            | 32 +++++++++++++++
>  qapi/block-core.json |  3 +-
>  3 files changed, 130 insertions(+), 1 deletion(-)

Where is the change to docs/interop/qcow2.txt to describe this new
compression format?

>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 37a563a671..caa04b0beb 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -27,6 +27,11 @@
>  #define ZLIB_CONST
>  #include <zlib.h>
> =20

> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    ssize_t ret;
> +    uint32_t *c_size =3D dest;
> +    /* steal some bytes to store compressed chunk size */
> +    char *d_buf =3D ((char *) dest) + sizeof(*c_size);
> +

Do you always want exactly 4 bytes for the compressed size? Or is it
worth some sort of variable-length encoding, since we're already dealing
with non-cacheline-aligned data? You can represent all sizes up to 4M
using a maximum of 3 bytes (set the high bit if the integer continues,
then sizes 0-127 take 1 byte [7 bits], 128-32767 take 2 bytes [15 bits],
and 32768-4194303 take 3 bytes [22 bits]).

> +    if (dest_size < sizeof(*c_size)) {
> +        return -ENOMEM;
> +    }
> +
> +    dest_size -=3D sizeof(*c_size);
> +
> +    ret =3D ZSTD_compress(d_buf, dest_size, src, src_size, 5);

The fact that you are storing the size separate from the data passed to
zstd MUST be documented in the qcow2 spec, for the next person to
produce/consume the same data.


> +++ b/qapi/block-core.json
> @@ -4215,11 +4215,12 @@
>  # Compression type used in qcow2 image file
>  #
>  # @zlib:  zlib compression, see <http://zlib.net/>
> +# @zstd:  zstd compression, see <http://github.com/facebook/zstd>
>  #
>  # Since: 4.1
>  ##
>  { 'enum': 'Qcow2CompressionType',
> -  'data': [ 'zlib' ] }
> +  'data': [ 'zlib', 'zstd' ] }

Since you patched configure so that linking against zstd is optional,
this should use { 'name':'zstd', 'if':'CONDITIONAL' } so that during
introspection, the enum only advertises zstd on a build that linked
against the library.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--5Q4kO8FZMj6EvQisrxv3Jg0drzueLmK3X--

--QRfbkSJ38ffMTwMEw08Ct1oRb7TaqIpId
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0cvYoACgkQp6FrSiUn
Q2rwNggAie163WXrpqMGxZ/Fh/UIuiv/vYyeajcjfjYB2qnB88YebpMPyPQahjMf
fSNzTPYfiGRGFax8a+WmCAX8TsscUpVXHupjZzyUb7mpXbh5Qd2DM4gHrgZAhTSl
soVBdBFs3ShP6/jpG+O0MUKPxos/bIFByxIAS10OLxZfndYaYORrP/ihoZetRsz8
qRS+tTGLspdK3Oqko4dhObAvpgQeyjzTYPrh6p1tbsPe9x6oZP0uFdbIMHIHpCiM
gIOEhmHiyeNcxBBbdXZ691sniMIeAEv5XtJRqgUp6uVTI1LhuGODSacqQ9rKxVkt
lYZQErglQNDUkwT+le/FYSO/jApqTQ==
=mxXm
-----END PGP SIGNATURE-----

--QRfbkSJ38ffMTwMEw08Ct1oRb7TaqIpId--

