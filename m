Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05618C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 21:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA206233FC
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 21:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA206233FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0uMI-0006d5-LY
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 17:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i0uLJ-00061N-Oc
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i0uLI-0002Xm-Lk
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:10:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i0uLE-0002Un-UR; Thu, 22 Aug 2019 17:09:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 792B58003AC;
 Thu, 22 Aug 2019 21:09:55 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 059975D6A7;
 Thu, 22 Aug 2019 21:09:51 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1566498661-53008-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <218c5855-a8dc-df50-23cb-ebd1a1cd259c@redhat.com>
Date: Thu, 22 Aug 2019 16:09:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566498661-53008-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WNWVpUUrIVUI5HMIdC1RY4dTycemQgRlv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 22 Aug 2019 21:09:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block: workaround for unaligned byte range
 in fallocate()
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WNWVpUUrIVUI5HMIdC1RY4dTycemQgRlv
Content-Type: multipart/mixed; boundary="vRPG7779iUZkcwFIpYxfD5hVUuttqWQlP";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <218c5855-a8dc-df50-23cb-ebd1a1cd259c@redhat.com>
Subject: Re: [PATCH] block: workaround for unaligned byte range in fallocate()
References: <1566498661-53008-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1566498661-53008-1-git-send-email-andrey.shinkevich@virtuozzo.com>

--vRPG7779iUZkcwFIpYxfD5hVUuttqWQlP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/22/19 1:31 PM, Andrey Shinkevich wrote:
> Revert the commit 118f99442d 'block/io.c: fix for the allocation failur=
e'
> and make better error handling for the file systems that do not support=


s/make/use/

> fallocate() for the unaligned byte range. Allow falling back to pwrite

s/the/an/

> in case fallocate() returns EINVAL.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
> Discussed in email thread with the message ID
> <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
>=20
>  block/file-posix.c | 7 +++++++
>  block/io.c         | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index fbeb006..2c254ff 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1588,6 +1588,13 @@ static int handle_aiocb_write_zeroes(void *opaqu=
e)
>      if (s->has_write_zeroes) {
>          int ret =3D do_fallocate(s->fd, FALLOC_FL_ZERO_RANGE,
>                                 aiocb->aio_offset, aiocb->aio_nbytes);
> +        if (ret =3D=3D -EINVAL) {
> +            /*
> +             * Allow falling back to pwrite for file systems that
> +             * do not support fallocate() for unaligned byte range.

s/for/for an/

> +             */
> +            return -ENOTSUP;
> +        }
>          if (ret =3D=3D 0 || ret !=3D -ENOTSUP) {
>              return ret;
>          }
> diff --git a/block/io.c b/block/io.c
> index 56bbf19..58f08cd 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1558,7 +1558,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(=
BlockDriverState *bs,
>              assert(!bs->supported_zero_flags);
>          }
> =20
> -        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
> +        if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
>              /* Fall back to bounce buffer if write zeroes is unsupport=
ed */
>              BdrvRequestFlags write_flags =3D flags & ~BDRV_REQ_ZERO_WR=
ITE;
> =20
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vRPG7779iUZkcwFIpYxfD5hVUuttqWQlP--

--WNWVpUUrIVUI5HMIdC1RY4dTycemQgRlv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1fBJ4ACgkQp6FrSiUn
Q2pwMgf+JHDsCfySlamC7dZ0ZP6a02GDeHgpWNz+Vq0yJZkmbFxu0A562vmwayTQ
tgn+bNSjSIbTaPhxEol0atZkGp5/kxjfLQJqjrFQenne44UgM8rLEdMMW6+8WmJ1
DT5gG57HuZO/yDbqJtUmk70RL4Hny8YkfhqcwLDx9OO/GPboHV+w7ZCsRg3bkXc/
FOA92pT1DJ6UgxSQhqlo9OCUGO1qVgUwUwbjYKTtSqV19s4lZqnOIzukapyXUfET
FKliueNC75Rdm0jhlAcHFGPm2wBl5eFnmGkPFgYmiOmgZ/YJPnwJ8FWvcFR4SKho
SFm7whRpGhx+8V1XsQP4ogIi7XVysw==
=I7B4
-----END PGP SIGNATURE-----

--WNWVpUUrIVUI5HMIdC1RY4dTycemQgRlv--

