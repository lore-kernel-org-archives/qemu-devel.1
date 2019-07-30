Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108F5C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1002089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1002089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsWNN-0000nl-0P
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39836)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hsWMj-0008R4-Av
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hsWMh-0003P9-Rf
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:56:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hsWMe-0003Ne-NC; Tue, 30 Jul 2019 13:56:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 884673001808;
 Tue, 30 Jul 2019 17:56:43 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D06CC60856;
 Tue, 30 Jul 2019 17:56:42 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-3-mreitz@redhat.com>
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
Message-ID: <9f7db4bc-d66a-2069-9f9a-20da842829f3@redhat.com>
Date: Tue, 30 Jul 2019 12:56:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190730172508.19911-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AtnZAUm2TyiO1YCjcXQlLQRXWJYgbpDSn"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 30 Jul 2019 17:56:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 02/13] qcow2: Keep unknown extra
 snapshot data
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
--AtnZAUm2TyiO1YCjcXQlLQRXWJYgbpDSn
Content-Type: multipart/mixed; boundary="eFJwNWsxxY4wOXRhbzqQNSoYrwqrFjUlO";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9f7db4bc-d66a-2069-9f9a-20da842829f3@redhat.com>
Subject: Re: [PATCH for-4.2 02/13] qcow2: Keep unknown extra snapshot data
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-3-mreitz@redhat.com>
In-Reply-To: <20190730172508.19911-3-mreitz@redhat.com>

--eFJwNWsxxY4wOXRhbzqQNSoYrwqrFjUlO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/30/19 12:24 PM, Max Reitz wrote:
> The qcow2 specification says to ignore unknown extra data fields in
> snapshot table entries.  Currently, we discard it whenever we update th=
e
> image, which is a bit different from "ignore".
>=20
> This patch makes the qcow2 driver keep all unknown extra data fields
> when updating an image's snapshot table.

The cover letter questioned whether we want this, but I think we do.

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.h          |  5 ++++
>  block/qcow2-snapshot.c | 59 +++++++++++++++++++++++++++++++++++-------=

>  2 files changed, 55 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 175708cee0..290a48b77e 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -61,6 +61,9 @@
>   * space for snapshot names and IDs */
>  #define QCOW_MAX_SNAPSHOTS_SIZE (1024 * QCOW_MAX_SNAPSHOTS)
> =20
> +/* Maximum amount of extra data per snapshot table entry to accept */
> +#define QCOW_MAX_SNAPSHOT_EXTRA_DATA 1024
> +
>  /* Bitmap header extension constraints */
>  #define QCOW2_MAX_BITMAPS 65535
>  #define QCOW2_MAX_BITMAP_DIRECTORY_SIZE (1024 * QCOW2_MAX_BITMAPS)
> @@ -178,6 +181,8 @@ typedef struct QCowSnapshot {
>      uint32_t date_sec;
>      uint32_t date_nsec;
>      uint64_t vm_clock_nsec;
> +    uint32_t extra_data_size;
> +    void *unknown_extra_data; /* Extra data past QCowSnapshotExtraData=
 */

Is char* going to be any easier to use than void*?

> +++ b/block/qcow2-snapshot.c

> @@ -80,30 +80,52 @@ int qcow2_read_snapshots(BlockDriverState *bs, Erro=
r **errp)

> +
> +        /* Read known extra data */
>          ret =3D bdrv_pread(bs->file, offset, &extra,
> -                         MIN(sizeof(extra), extra_data_size));
> +                         MIN(sizeof(extra), sn->extra_data_size));
>          if (ret < 0) {
>              error_setg_errno(errp, -ret, "Failed to read snapshot tabl=
e");
>              goto fail;
>          }
> -        offset +=3D extra_data_size;
> +        offset +=3D MIN(sizeof(extra), sn->extra_data_size);
> =20
> -        if (extra_data_size >=3D 8) {
> +        if (sn->extra_data_size >=3D 8) {

While touching this, is it worth spelling it:
if (sn->extra_data_size >=3D sizeof(extra.vm_state_size_large)) {

>              sn->vm_state_size =3D be64_to_cpu(extra.vm_state_size_larg=
e);
>          }
> =20
> -        if (extra_data_size >=3D 16) {
> +        if (sn->extra_data_size >=3D 16) {

and a similar use of sizeof() instead of hard-coded 16 here?

>              sn->disk_size =3D be64_to_cpu(extra.disk_size);
>          } else {
>              sn->disk_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
>          }
> =20
> +        if (sn->extra_data_size > sizeof(extra)) {
> +            /* Store unknown extra data */
> +            size_t unknown_extra_data_size =3D
> +                sn->extra_data_size - sizeof(extra);
> +
> +            sn->unknown_extra_data =3D g_malloc(unknown_extra_data_siz=
e);
> +            ret =3D bdrv_pread(bs->file, offset, sn->unknown_extra_dat=
a,
> +                             unknown_extra_data_size);

We're doing two separate bdrv_pread()s. Would it be better to do a
single bdrv_preadv into a vector composed of &extra and
&unknown_extra_data, for less I/O?  (Then again, this micro-optimization
is probably in the noise in the long run)

> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "Failed to read snapshot =
table");
> +                goto fail;
> +            }
> +            offset +=3D unknown_extra_data_size;
> +        }
> +
>          /* Read snapshot ID */
>          sn->id_str =3D g_malloc(id_str_size + 1);
>          ret =3D bdrv_pread(bs->file, offset, sn->id_str, id_str_size);=

> @@ -161,7 +183,7 @@ static int qcow2_write_snapshots(BlockDriverState *=
bs)
>          sn =3D s->snapshots + i;
>          offset =3D ROUND_UP(offset, 8);
>          offset +=3D sizeof(h);
> -        offset +=3D sizeof(extra);
> +        offset +=3D MAX(sizeof(extra), sn->extra_data_size);
>          offset +=3D strlen(sn->id_str);
>          offset +=3D strlen(sn->name);
> =20
> @@ -208,7 +230,8 @@ static int qcow2_write_snapshots(BlockDriverState *=
bs)
>          h.date_sec =3D cpu_to_be32(sn->date_sec);
>          h.date_nsec =3D cpu_to_be32(sn->date_nsec);
>          h.vm_clock_nsec =3D cpu_to_be64(sn->vm_clock_nsec);
> -        h.extra_data_size =3D cpu_to_be32(sizeof(extra));
> +        h.extra_data_size =3D cpu_to_be32(MAX(sizeof(extra),
> +                                            sn->extra_data_size));
> =20
>          memset(&extra, 0, sizeof(extra));
>          extra.vm_state_size_large =3D cpu_to_be64(sn->vm_state_size);
> @@ -233,6 +256,22 @@ static int qcow2_write_snapshots(BlockDriverState =
*bs)
>          }
>          offset +=3D sizeof(extra);
> =20
> +        if (sn->extra_data_size > sizeof(extra)) {
> +            size_t unknown_extra_data_size =3D
> +                sn->extra_data_size - sizeof(extra);
> +
> +            /* qcow2_read_snapshots() ensures no unbounded allocation =
*/
> +            assert(unknown_extra_data_size <=3D INT_MAX);

Should we make this tighter:
 assert(unknown_extra_data_size < QCOW_MAX_SNAPSHOT_EXTRA_DATA);
or even
 assert(unknown_extra_data_size <=3D
        QCOW_MAX_SNAPSHOT_EXTRA_DATA - sizeof(extra));

> +            assert(sn->unknown_extra_data);
> +
> +            ret =3D bdrv_pwrite(bs->file, offset, sn->unknown_extra_da=
ta,
> +                              unknown_extra_data_size);
> +            if (ret < 0) {
> +                goto fail;
> +            }
> +            offset +=3D unknown_extra_data_size;
> +        }
> +
>          ret =3D bdrv_pwrite(bs->file, offset, sn->id_str, id_str_size)=
;
>          if (ret < 0) {
>              goto fail;
> @@ -375,6 +414,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEM=
USnapshotInfo *sn_info)
>      sn->date_sec =3D sn_info->date_sec;
>      sn->date_nsec =3D sn_info->date_nsec;
>      sn->vm_clock_nsec =3D sn_info->vm_clock_nsec;
> +    sn->extra_data_size =3D sizeof(QCowSnapshotExtraData);
> =20
>      /* Allocate the L1 table of the snapshot and copy the current one =
there. */
>      l1_table_offset =3D qcow2_alloc_clusters(bs, s->l1_size * sizeof(u=
int64_t));
> @@ -646,6 +686,7 @@ int qcow2_snapshot_delete(BlockDriverState *bs,
>       * The snapshot is now unused, clean up. If we fail after this poi=
nt, we
>       * won't recover but just leak clusters.
>       */
> +    g_free(sn.unknown_extra_data);
>      g_free(sn.id_str);
>      g_free(sn.name);
> =20
>=20

Tweaks to assertions are minor enough that I'm okay with:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--eFJwNWsxxY4wOXRhbzqQNSoYrwqrFjUlO--

--AtnZAUm2TyiO1YCjcXQlLQRXWJYgbpDSn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1AhNoACgkQp6FrSiUn
Q2qmLwgAht/5EcZOiag4ixxKEdUbkcevjkdOIpd0RgDy7hAio80yvDCWuEtxwCr7
h9cesoqao/6DiJNao+P+9npF5flQvxr8G1SUcw0nVgFen2++MsLO3XfLZvymw+tt
KPxsGyGXKDFtdHhjGWWCet7UuaM1U2rtdWsYwoIKzK01bpBQ8B/CVK5FLn08eK5q
fl4YwefL2fq5JrAGuh9himbZSoa7EMstecwtf2evPBRmr+1QYhmbv4D9e5Om2Jy7
vsBsGvEPSsdSh4LIsIwa5ipdxICwPyEe9Pe+mXw8q2wpe6eTdN5er2K8o096m/H/
mOOMKchKn9mHAlBwp6R2xj/omA+wjA==
=GSS7
-----END PGP SIGNATURE-----

--AtnZAUm2TyiO1YCjcXQlLQRXWJYgbpDSn--

