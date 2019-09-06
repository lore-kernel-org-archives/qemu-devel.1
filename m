Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DCCC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 18:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5EC20838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 18:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5EC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6IYy-00071G-Px
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 14:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i6IXj-0006LP-07
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 14:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i6IXh-0000BE-Md
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 14:01:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i6IXc-00006d-6y; Fri, 06 Sep 2019 14:01:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2206881DF7;
 Fri,  6 Sep 2019 18:00:56 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39F71194BE;
 Fri,  6 Sep 2019 18:00:55 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190906173201.7926-1-mlevitsk@redhat.com>
 <20190906173201.7926-2-mlevitsk@redhat.com>
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
Message-ID: <e7f3febc-63cb-ea09-0761-45ecae74ad14@redhat.com>
Date: Fri, 6 Sep 2019 13:00:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906173201.7926-2-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6jvL0YYdAV73BtdHxiRduzlGLRnGZrJEe"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 06 Sep 2019 18:00:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] block/qcow2: refactoring of threaded
 encryption code
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6jvL0YYdAV73BtdHxiRduzlGLRnGZrJEe
Content-Type: multipart/mixed; boundary="pIxiioNujRO128Rl0a6NK4LTubTKCVrOg";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <e7f3febc-63cb-ea09-0761-45ecae74ad14@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] block/qcow2: refactoring of threaded
 encryption code
References: <20190906173201.7926-1-mlevitsk@redhat.com>
 <20190906173201.7926-2-mlevitsk@redhat.com>
In-Reply-To: <20190906173201.7926-2-mlevitsk@redhat.com>

--pIxiioNujRO128Rl0a6NK4LTubTKCVrOg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/6/19 12:31 PM, Maxim Levitsky wrote:
> This commit tries to clarify few function arguments,
> and add comments describing the encrypt/decrypt interface
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/qcow2-cluster.c |  8 +++----
>  block/qcow2-threads.c | 53 ++++++++++++++++++++++++++++++++++---------=

>  2 files changed, 46 insertions(+), 15 deletions(-)
>=20

> +++ b/block/qcow2-threads.c
> @@ -234,15 +234,19 @@ static int qcow2_encdec_pool_func(void *opaque)
>  }
> =20
>  static int coroutine_fn
> -qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
> -                  uint64_t offset, void *buf, size_t len, Qcow2EncDecF=
unc func)

Pre-existing bug in alignment...

> +qcow2_co_encdec(BlockDriverState *bs, uint64_t host_cluster_offset,
> +                  uint64_t guest_offset, void *buf, size_t len,
> +                  Qcow2EncDecFunc func)

=2E..so this would be a great time to fix it.

>  {
>      BDRVQcow2State *s =3D bs->opaque;
> +
> +    uint64_t offset =3D s->crypt_physical_offset ?
> +        host_cluster_offset + offset_into_cluster(s, guest_offset) :
> +        guest_offset;
> +
>      Qcow2EncDecData arg =3D {
>          .block =3D s->crypto,
> -        .offset =3D s->crypt_physical_offset ?
> -                      file_cluster_offset + offset_into_cluster(s, off=
set) :
> -                      offset,
> +        .offset =3D offset,

I'm ambivalent on whether the new 'offset' variable gains us anything.
But it doesn't hurt.


>          .buf =3D buf,
>          .len =3D len,
>          .func =3D func,
> @@ -251,18 +255,45 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t fi=
le_cluster_offset,
>      return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
>  }
> =20
> +
> +/*
> + * qcow2_co_encrypt()
> + *
> + * Encrypts a sector size aligned contiguous area
> + *
> + * @host_cluster_offset - on disk offset of the cluster in which
> + *                        the buffer resides
> + *
> + * @guest_offset - guest (virtual) offset of the buffer
> + * @buf - buffer with the data to encrypt
> + * @len - length of the buffer
> + *
> + * Note that the area is not cluster aligned and might cross a cluster=

> + * boundary

Umm, how is it possible for a sector to cross a cluster boundary?  All
clusters are sector-aligned, and encryption only works on aligned
sectors.  Oh, I see - if @len is a multiple larger than sector size,
then we have multiple sectors, and then indeed we may cross clusters.
But then the docs about being 'a sector size aligned contiguous area' is
not quite right.

> + *
> + *
> + */
>  int coroutine_fn
> -qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> -                 uint64_t offset, void *buf, size_t len)
> +qcow2_co_encrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
> +                 uint64_t guest_offset, void *buf, size_t len)
>  {
> -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
> +    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, buf,=
 len,
>                               qcrypto_block_encrypt);


Another alignment worth fixing up while in the area.

>  }
> =20
> +
> +/*
> + * qcow2_co_decrypt()
> + *
> + * Decrypts a sector size aligned contiguous area
> + * Same function as qcow2_co_encrypt
> + *
> + */
> +
>  int coroutine_fn
> -qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> -                 uint64_t offset, void *buf, size_t len)
> +qcow2_co_decrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
> +                 uint64_t guest_offset, void *buf, size_t len)
>  {
> -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
> +    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, buf,=
 len,
>                               qcrypto_block_decrypt);

and again.

>  }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--pIxiioNujRO128Rl0a6NK4LTubTKCVrOg--

--6jvL0YYdAV73BtdHxiRduzlGLRnGZrJEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1yntYACgkQp6FrSiUn
Q2rVXAgAo3VwEFpB62thuE38LOs+0Wtsby3ZYhyVLKymyOyvIDk0i8vLVNJ15zz2
zo3Go8wzTPwh5067YJWkU2MQ3nC0JHJROQsjFfwfFZTvB3PJdaOch2kWvlK4wLZ+
cQ7zPFLs/PvaQBkGbDsfnUV+AuJTSRdWZ3LwdrpOS9LjTwYxIriUBlBNFnDeWrVv
xNNFPDE6WxzqWAjKDWcLKX20LZdkQPs9EDoAqbdAb63fD2CfZgG4ZJchyW28LdkX
IWT1eZ+GaM/u1qqeOzKqAItgUxzpgp4KZ3mYDehL7LzWDWlNLlRhYFPteumJG8Ee
IeGLJOgTDC5qQnJsDqQ7XjwJSESAlA==
=krQE
-----END PGP SIGNATURE-----

--6jvL0YYdAV73BtdHxiRduzlGLRnGZrJEe--

