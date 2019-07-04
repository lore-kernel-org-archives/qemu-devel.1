Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3ABC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60D22184B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60D22184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj3kl-0005LM-Fh
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 11:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hj3hP-0003cl-6U
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hj3hO-0001qQ-3X
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:31:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hj3hI-0001l6-BZ; Thu, 04 Jul 2019 11:30:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A5513082A8D;
 Thu,  4 Jul 2019 15:30:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-93.brq.redhat.com
 [10.40.204.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A78CC17DFC;
 Thu,  4 Jul 2019 15:30:41 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-6-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <a9b44438-06ce-54b2-82cb-ee4e196152f6@redhat.com>
Date: Thu, 4 Jul 2019 17:30:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703215542.16123-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SEoXs3EzXcDWA0T8Mc5dQdUzz3a9qLu1Z"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 04 Jul 2019 15:30:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 05/18] block/backup: Add mirror sync
 mode 'bitmap'
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SEoXs3EzXcDWA0T8Mc5dQdUzz3a9qLu1Z
Content-Type: multipart/mixed; boundary="9pa2bXJy38vBpzMIj2r6cvQhwvS3iYBIz";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, vsementsov@virtuozzo.com,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <a9b44438-06ce-54b2-82cb-ee4e196152f6@redhat.com>
Subject: Re: [PATCH v2 05/18] block/backup: Add mirror sync mode 'bitmap'
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-6-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-6-jsnow@redhat.com>

--9pa2bXJy38vBpzMIj2r6cvQhwvS3iYBIz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 23:55, John Snow wrote:
> We don't need or want a new sync mode for simple differences in
> semantics.  Create a new mode simply named "BITMAP" that is designed to=

> make use of the new Bitmap Sync Mode field.
>=20
> Because the only bitmap mode is 'conditional', this adds no new
> functionality to the backup job (yet). The old incremental backup mode
> is maintained as a syntactic sugar for sync=3Dbitmap, mode=3Dconditiona=
l.
>=20
> Add all of the plumbing necessary to support this new instruction.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c            | 20 ++++++++++++--------
>  block/mirror.c            |  6 ++++--
>  block/replication.c       |  2 +-
>  blockdev.c                | 19 +++++++++++++++++--
>  include/block/block_int.h |  4 +++-
>  qapi/block-core.json      | 20 ++++++++++++++------
>  6 files changed, 51 insertions(+), 20 deletions(-)

[...]

> diff --git a/blockdev.c b/blockdev.c
> index cad300d526..d5b089a446 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3473,6 +3473,19 @@ static BlockJob *do_backup_common(BackupCommon *=
backup,
>          goto out;
>      }
> =20
> +    if (backup->sync =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
> +        if (backup->has_bitmap_mode &&
> +            backup->bitmap_mode !=3D BITMAP_SYNC_MODE_CONDITIONAL) {
> +            error_setg(errp, "Bitmap sync mode must be 'conditional' "=

> +                       "when using sync mode '%s'",
> +                       MirrorSyncMode_str(backup->sync));
> +            goto out;
> +        }
> +        backup->has_bitmap_mode =3D true;
> +        backup->sync =3D MIRROR_SYNC_MODE_BITMAP;
> +        backup->bitmap_mode =3D BITMAP_SYNC_MODE_CONDITIONAL;
> +    }
> +

A check for

  backup->sync =3D=3D MIRROR_SYNC_MODE_BITMAP && !backup->has_bitmap_mode=


or maybe even better

  backup->has_bitmap && !backup->has_bitmap_mode

is missing here.

Max

>      if (backup->has_bitmap) {
>          bmap =3D bdrv_find_dirty_bitmap(bs, backup->bitmap);
>          if (!bmap) {


--9pa2bXJy38vBpzMIj2r6cvQhwvS3iYBIz--

--SEoXs3EzXcDWA0T8Mc5dQdUzz3a9qLu1Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0eG6AACgkQ9AfbAGHV
z0AWNgf+PDaaT0tpQbbwweVy8CogZ169Hnee7k4HWIJSSJPa1IeNGAGD8NrslXlu
eZoghs2RVsZOevANsWsGrStMekCmdSEIvYnbCrky1HFR8AfrmGZKsxDeUvisaRO1
rW5UjeZDeNrZizmlUFHSISGs6YxP/YGhNBk1KMph9GW5lX1aWblGRd5BPQa8z3Dp
Z8+2Qzxrf3ZF1lbgvbi04yGAQlHBrDZzjvfDhn4+uvDKr6l/km02Nww+GLxqXtvT
wwdYtMejok6CmS56N2r/xesYRY/dNEMDYDLIctW04eOS5bqpVCwM8y9XpO4rmVaz
84XYC7Z6k7r28LersvclJyHVn+dt1Q==
=l5ID
-----END PGP SIGNATURE-----

--SEoXs3EzXcDWA0T8Mc5dQdUzz3a9qLu1Z--

