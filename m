Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECFAC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113A020659
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113A020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsXPU-0007Db-TE
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 15:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hsXOo-0006eT-8Z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hsXOn-0002zV-9B
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:03:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hsXOk-0002wH-S5; Tue, 30 Jul 2019 15:02:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E605D307D90D;
 Tue, 30 Jul 2019 19:02:57 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48DE3600CC;
 Tue, 30 Jul 2019 19:02:57 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-9-mreitz@redhat.com>
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
Message-ID: <fdce3796-8a60-cf7e-cb07-72a21d226b94@redhat.com>
Date: Tue, 30 Jul 2019 14:02:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190730172508.19911-9-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r1DwzP5QR8LipHnrIxEvtncEEidYJ3LOt"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 30 Jul 2019 19:02:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 08/13] qcow2: Fix broken snapshot
 table entries
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r1DwzP5QR8LipHnrIxEvtncEEidYJ3LOt
Content-Type: multipart/mixed; boundary="AafbanJU0Dpx1nCNMHyZqYTsBuu91rqXb";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <fdce3796-8a60-cf7e-cb07-72a21d226b94@redhat.com>
Subject: Re: [PATCH for-4.2 08/13] qcow2: Fix broken snapshot table entries
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-9-mreitz@redhat.com>
In-Reply-To: <20190730172508.19911-9-mreitz@redhat.com>

--AafbanJU0Dpx1nCNMHyZqYTsBuu91rqXb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/30/19 12:25 PM, Max Reitz wrote:
> The only case where we currently reject snapshot table entries is when
> they have too much extra data.  Fix them with qemu-img check -r all by
> counting it as a corruption, reducing their extra_data_size, and then
> letting qcow2_check_fix_snapshot_table() do the rest.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-snapshot.c | 69 ++++++++++++++++++++++++++++++++++--------=

>  1 file changed, 56 insertions(+), 13 deletions(-)
>=20

> @@ -112,16 +141,22 @@ int qcow2_read_snapshots(BlockDriverState *bs, Er=
ror **errp)
>          }
> =20
>          if (sn->extra_data_size > sizeof(extra)) {
> -            /* Store unknown extra data */
>              size_t unknown_extra_data_size =3D
>                  sn->extra_data_size - sizeof(extra);
> =20
> -            sn->unknown_extra_data =3D g_malloc(unknown_extra_data_siz=
e);
> -            ret =3D bdrv_pread(bs->file, offset, sn->unknown_extra_dat=
a,
> -                             unknown_extra_data_size);
> -            if (ret < 0) {
> -                error_setg_errno(errp, -ret, "Failed to read snapshot =
table");
> -                goto fail;
> +            if (discard_unknown_extra_data) {
> +                /* Discard unknown extra data */
> +                sn->extra_data_size =3D sizeof(extra);

This truncates it down to just the data we know. Should it instead
truncate down to the 1024 bytes of QCOW_MAX_SNAPSHOT_EXTRA_DATA defined
in 2/13?  (We can't keep all of the user's extra stuff, but we can at
least try to preserve as much as possible)

Otherwise, looks good.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--AafbanJU0Dpx1nCNMHyZqYTsBuu91rqXb--

--r1DwzP5QR8LipHnrIxEvtncEEidYJ3LOt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1AlGAACgkQp6FrSiUn
Q2qpUQf/UwFqWyQ6o24llndq2n5fnWfcfQ9xk+P7InKJlSli4aHRbs4O7tPvgt+4
xdncnHMyb3w0gnPW/asQlh4tA9qAgobFu3Vc+5fj40koxz/f+CxBM5+kJXfGQPnE
SeVzKJA3wshPTmUqrhMzV9luAaOhfSNT0J8f1h1GBO7keGVgWuzOoezczDmF6jxe
fv3RbM7cw5XL0XktvuG943s3iQ9kbeokyFgJnGoWGF3VxuEGvNxBgpEnfJPvSARq
qCZLwez81LiKGd+M0Jq5j6znSgSV2CvTGmAS7zZhQU7y4YWbs9UixhUGtJgakwGI
3U8vU9uUc8q5sqqFpK8jp7eCViMShw==
=efhF
-----END PGP SIGNATURE-----

--r1DwzP5QR8LipHnrIxEvtncEEidYJ3LOt--

