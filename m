Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AE9C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 03:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D915820C01
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 03:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D915820C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy62D-0002rp-42
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 23:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hy5kh-00075L-S7
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hy5kg-0003iX-KI
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:44:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hy5kd-0003dw-2K; Wed, 14 Aug 2019 22:44:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AB1A31752A6;
 Thu, 15 Aug 2019 02:44:29 +0000 (UTC)
Received: from [10.3.117.22] (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2466210016EB;
 Thu, 15 Aug 2019 02:44:29 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190326155157.3719-1-kwolf@redhat.com>
 <20190326155157.3719-6-kwolf@redhat.com>
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
Message-ID: <fb6063ca-d4c4-7add-adec-5e92c3805ad8@redhat.com>
Date: Wed, 14 Aug 2019 21:44:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190326155157.3719-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qYS8CcQU3ibYu5tVLPaK52QGhXsjHMwvB"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 15 Aug 2019 02:44:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 5/7] file-posix: Support
 BDRV_REQ_NO_FALLBACK for zero writes
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qYS8CcQU3ibYu5tVLPaK52QGhXsjHMwvB
Content-Type: multipart/mixed; boundary="eTEhoQ3NLadXWPFDIPhWxOb8CWItPTfKs";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <fb6063ca-d4c4-7add-adec-5e92c3805ad8@redhat.com>
Subject: Re: [Qemu-devel] [PULL 5/7] file-posix: Support BDRV_REQ_NO_FALLBACK
 for zero writes
References: <20190326155157.3719-1-kwolf@redhat.com>
 <20190326155157.3719-6-kwolf@redhat.com>
In-Reply-To: <20190326155157.3719-6-kwolf@redhat.com>

--eTEhoQ3NLadXWPFDIPhWxOb8CWItPTfKs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/26/19 10:51 AM, Kevin Wolf wrote:
> We know that the kernel implements a slow fallback code path for
> BLKZEROOUT, so if BDRV_REQ_NO_FALLBACK is given, we shouldn't call it.
> The other operations we call in the context of .bdrv_co_pwrite_zeroes
> should usually be quick, so no modification should be needed for them.
> If we ever notice that there are additional problematic cases, we can
> still make these conditional as well.

Are there cases where fallocate(FALLOC_FL_ZERO_RANGE) falls back to slow
writes?  It may be fast on some file systems, but when used on a block
device, that may equally trigger slow fallbacks.  The man page is not
clear on that fact; I suspect that there may be cases in there that need
to be made conditional (it would be awesome if the kernel folks would
give us another FALLOC_ flag when we want to guarantee no fallback).

By the way, is there an easy setup to prove (maybe some qemu-img convert
command on a specially-prepared source image) whether the no fallback
flag makes a difference?  I'm about to cross-post a series of patches to
nbd/qemu/nbdkit/libnbd that adds a new NBD_CMD_FLAG_FAST_ZERO which fits
the bill of BDRV_REQ_NO_FALLBACK, but would like to include some
benchmark numbers in my cover letter if I can reproduce a setup where it
matters.

And this patch has a bug:

> +++ b/block/file-posix.c
> @@ -652,7 +652,7 @@ static int raw_open_common(BlockDriverState *bs, QD=
ict *options,
>      }
>  #endif
> =20
> -    bs->supported_zero_flags =3D BDRV_REQ_MAY_UNMAP;
> +    bs->supported_zero_flags =3D BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALL=
BACK;
>      ret =3D 0;
>  fail:
>      if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
> @@ -1500,14 +1500,19 @@ static ssize_t handle_aiocb_write_zeroes_block(=
RawPosixAIOData *aiocb)
{
    int ret =3D -ENOTSUP;
    BDRVRawState *s =3D aiocb->bs->opaque;

    if (!s->has_write_zeroes) {
        return -ENOTSUP;
>      }

At this point, ret is -ENOTSUP.

> =20
>  #ifdef BLKZEROOUT
> -    do {
> -        uint64_t range[2] =3D { aiocb->aio_offset, aiocb->aio_nbytes }=
;
> -        if (ioctl(aiocb->aio_fildes, BLKZEROOUT, range) =3D=3D 0) {
> -            return 0;
> -        }
> -    } while (errno =3D=3D EINTR);
> +    /* The BLKZEROOUT implementation in the kernel doesn't set
> +     * BLKDEV_ZERO_NOFALLBACK, so we can't call this if we have to avo=
id slow
> +     * fallbacks. */
> +    if (!(aiocb->aio_type & QEMU_AIO_NO_FALLBACK)) {
> +        do {
> +            uint64_t range[2] =3D { aiocb->aio_offset, aiocb->aio_nbyt=
es };
> +            if (ioctl(aiocb->aio_fildes, BLKZEROOUT, range) =3D=3D 0) =
{
> +                return 0;
> +            }
> +        } while (errno =3D=3D EINTR);
> =20
> -    ret =3D translate_err(-errno);
> +        ret =3D translate_err(-errno);
> +    }

If the very first call to this function is with NO_FALLBACK, then this
'if' is skipped,

>  #endif
> =20
>      if (ret =3D=3D -ENOTSUP) {
        s->has_write_zeroes =3D false;
    }

and we set s->has_write_zeroes to false, permanently disabling any
BLKZEROOUT attempts in future calls, even if the future calls no longer
pass the NO_FALLBACK flag.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--eTEhoQ3NLadXWPFDIPhWxOb8CWItPTfKs--

--qYS8CcQU3ibYu5tVLPaK52QGhXsjHMwvB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1UxwwACgkQp6FrSiUn
Q2ppEAgAlbLBtJN1XWQMICIHKUwANatKcnq/dIhUmZVzwyaHU/QzOH2G8dMSx5Ia
YXT7zDTL2LOIkYOidjvLu6e0EA6HPJHK2JeBuN69TtL0CG/lhIGu+jglPTWPQuQE
Y66B92Cf0pkA4kpOVgUCi1g6JN+qP2ZApwLINzSGC6F3/Q9h3F7PTDvzs5NoOoUQ
wI0434JWXRizRsM7u+s09URb3etayFF0LRSzSTHzLHH+2gfWmanQa0kgunlG4iLf
QER9x8GvYPXiyZDEouOpC87nkvbEeGxMchpLItyoqYVtmSDdgckKipisj7D2rdji
8LAlpRNdzr5VJ/klQnsaGdqnNGq73Q==
=zBgk
-----END PGP SIGNATURE-----

--qYS8CcQU3ibYu5tVLPaK52QGhXsjHMwvB--

