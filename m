Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487B6C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219EE21881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219EE21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1higcS-0000RJ-Bq
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1higb9-0007Ms-Re
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1higb7-0004d0-Sn
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1higb2-0004Yy-Lk; Wed, 03 Jul 2019 10:50:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9BB5031628E6;
 Wed,  3 Jul 2019 14:50:55 +0000 (UTC)
Received: from [10.3.116.152] (ovpn-116-152.phx2.redhat.com [10.3.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3AB17C635;
 Wed,  3 Jul 2019 14:50:52 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190630150855.1016-1-mlevitsk@redhat.com>
 <20190630150855.1016-2-mlevitsk@redhat.com>
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
Message-ID: <70330e00-ebe9-ce2a-5155-6f7e032e0aae@redhat.com>
Date: Wed, 3 Jul 2019 09:50:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190630150855.1016-2-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BSNUoYfn4nUJg7mOeoHxJ6GsSQLqVT7b2"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 03 Jul 2019 14:50:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/1] raw-posix.c - use max transfer length
 / max segemnt count only for SCSI passthrough
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
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 John Ferlan <jferlan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BSNUoYfn4nUJg7mOeoHxJ6GsSQLqVT7b2
Content-Type: multipart/mixed; boundary="s2C8lxX3XGWnK5uUPhAEgRFqdj9BEnAkz";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, John Ferlan <jferlan@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <70330e00-ebe9-ce2a-5155-6f7e032e0aae@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] raw-posix.c - use max transfer length /
 max segemnt count only for SCSI passthrough
References: <20190630150855.1016-1-mlevitsk@redhat.com>
 <20190630150855.1016-2-mlevitsk@redhat.com>
In-Reply-To: <20190630150855.1016-2-mlevitsk@redhat.com>

--s2C8lxX3XGWnK5uUPhAEgRFqdj9BEnAkz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/30/19 10:08 AM, Maxim Levitsky wrote:
> Regular block devices (/dev/sda*, /dev/nvme*, etc) interface is not lim=
ited

The regular block device interface is

or

Regular block devices interfaces are

> by the underlying storage limits, but rather the kernel block layer
> takes care to split the requests that are too large/fragmented.
>=20
> Doing so allows us to have less overhead in qemu.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/file-posix.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index ab05b51a66..66dad34f8a 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1038,15 +1038,13 @@ static void raw_reopen_abort(BDRVReopenState *s=
tate)
>      s->reopen_state =3D NULL;
>  }
> =20
> -static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
> +static int sg_get_max_transfer_length(BlockDriverState *bs, int fd)
>  {
>  #ifdef BLKSECTGET
>      int max_bytes =3D 0;
> -    short max_sectors =3D 0;
> -    if (bs->sg && ioctl(fd, BLKSECTGET, &max_bytes) =3D=3D 0) {
> +
> +    if (ioctl(fd, BLKSECTGET, &max_bytes) =3D=3D 0) {
>          return max_bytes;
> -    } else if (!bs->sg && ioctl(fd, BLKSECTGET, &max_sectors) =3D=3D 0=
) {
> -        return max_sectors << BDRV_SECTOR_BITS;
>      } else {
>          return -errno;
>      }
> @@ -1055,7 +1053,7 @@ static int hdev_get_max_transfer_length(BlockDriv=
erState *bs, int fd)
>  #endif
>  }
> =20
> -static int hdev_get_max_segments(const struct stat *st)
> +static int sg_get_max_segments(const struct stat *st)
>  {
>  #ifdef CONFIG_LINUX
>      char buf[32];
> @@ -1106,12 +1104,12 @@ static void raw_refresh_limits(BlockDriverState=
 *bs, Error **errp)
>      struct stat st;
> =20
>      if (!fstat(s->fd, &st)) {
> -        if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
> -            int ret =3D hdev_get_max_transfer_length(bs, s->fd);

Is it worth delaying the fstat()...

> +        if (bs->sg) {
> +            int ret =3D sg_get_max_transfer_length(bs, s->fd);
>              if (ret > 0 && ret <=3D BDRV_REQUEST_MAX_BYTES) {
>                  bs->bl.max_transfer =3D pow2floor(ret);
>              }
> -            ret =3D hdev_get_max_segments(&st);
> +            ret =3D sg_get_max_segments(&st);

=2E..until inside the if (bs->sg) condition, to avoid wasted work for
other scenarios?

>              if (ret > 0) {
>                  bs->bl.max_transfer =3D MIN(bs->bl.max_transfer,
>                                            ret * getpagesize());
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--s2C8lxX3XGWnK5uUPhAEgRFqdj9BEnAkz--

--BSNUoYfn4nUJg7mOeoHxJ6GsSQLqVT7b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0cwMsACgkQp6FrSiUn
Q2qN8AgAnOr7AIX+CYBiWaV9LSuiEzVHnW7ZbaGKEh1/+GCiBeydxOzwHxIWQjJx
OrueXJOMQSFKYOwxKalggQmvlpWzUEWIJma4SRCmZ0WqhKsdHX2K9X2FQnp8bbkr
XgQ/FMQIFkYPkfBMgWd8OacRufNBxJtMrKdbDCJ1vvOwrtA+2VozL7RaR0UAYZsu
LYyVGaM4Vg4Di6pqSVFTs1I0m6k7MPbUwFxSh7iVCIA1RN6yG97ny24f0wWPeFJD
BvSCh2F/L3OlMmG0JaNHNOWCNdnXGHbW+eUabOceRVwkiZKfwZDkH00d9Zx2tgGu
JnvjSCG6R9SPxj7EmKDFB8ziqWErvA==
=OVZt
-----END PGP SIGNATURE-----

--BSNUoYfn4nUJg7mOeoHxJ6GsSQLqVT7b2--

