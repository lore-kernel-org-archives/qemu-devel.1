Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74378C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468DC21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468DC21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hikyy-00058v-8p
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 15:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hikxz-0004We-7i
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hikxx-00007G-LH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:30:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hikxs-0008Rs-8I; Wed, 03 Jul 2019 15:30:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C491730832E3;
 Wed,  3 Jul 2019 19:30:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-65.brq.redhat.com
 [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D8DC503ED;
 Wed,  3 Jul 2019 19:30:29 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190701201330.29718-1-jsnow@redhat.com>
 <20190701201330.29718-3-jsnow@redhat.com>
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
Message-ID: <0bd996a0-877f-6658-c120-09512bdacd1b@redhat.com>
Date: Wed, 3 Jul 2019 21:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701201330.29718-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Co9H596dq0muE62hjBYBhEKNROD4whCiL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 03 Jul 2019 19:30:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qapi: implement
 block-dirty-bitmap-remove transaction action
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
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Co9H596dq0muE62hjBYBhEKNROD4whCiL
Content-Type: multipart/mixed; boundary="j4jSKJEehjnN2XgeeYSZIfkXPgkJTImVE";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
Message-ID: <0bd996a0-877f-6658-c120-09512bdacd1b@redhat.com>
Subject: Re: [PATCH v2 2/3] qapi: implement block-dirty-bitmap-remove
 transaction action
References: <20190701201330.29718-1-jsnow@redhat.com>
 <20190701201330.29718-3-jsnow@redhat.com>
In-Reply-To: <20190701201330.29718-3-jsnow@redhat.com>

--j4jSKJEehjnN2XgeeYSZIfkXPgkJTImVE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.07.19 22:13, John Snow wrote:
> It is used to do transactional movement of the bitmap (which is
> possible in conjunction with merge command). Transactional bitmap
> movement is needed in scenarios with external snapshot, when we don't
> want to leave copy of the bitmap in the base image.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/transaction.json          |  2 +
>  include/block/dirty-bitmap.h   |  3 +-
>  block.c                        |  2 +-
>  block/dirty-bitmap.c           | 16 +++----
>  blockdev.c                     | 79 +++++++++++++++++++++++++++++++---=

>  migration/block-dirty-bitmap.c |  2 +-
>  6 files changed, 87 insertions(+), 17 deletions(-)

[...]

> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 95a9c2a5d8..8551f8219e 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -48,10 +48,9 @@ struct BdrvDirtyBitmap {
>      bool inconsistent;          /* bitmap is persistent, but inconsist=
ent.
>                                     It cannot be used at all in any way=
, except
>                                     a QMP user can remove it. */
> -    bool migration;             /* Bitmap is selected for migration, i=
t should
> -                                   not be stored on the next inactivat=
ion
> -                                   (persistent flag doesn't matter unt=
il next
> -                                   invalidation).*/
> +    bool squelch_persistence;   /* We are either migrating or deleting=
 this
> +                                 * bitmap; it should not be stored on =
the next
> +                                 * inactivation. */

I like the English lessons you give me, but why not just dont_store?  Or
skip_storing?

>      QLIST_ENTRY(BdrvDirtyBitmap) list;
>  };
> =20

[...]

> diff --git a/blockdev.c b/blockdev.c
> index 01248252ca..4143ab7bbb 100644
> --- a/blockdev.c
> +++ b/blockdev.c

[...]

> +static void block_dirty_bitmap_remove_abort(BlkActionState *common)
> +{
> +    BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDirtyBitmapState,
> +                                             common, common);
> +
> +    if (state->bitmap) {
> +        bdrv_dirty_bitmap_squelch_persistence(state->bitmap, false);
> +        bdrv_dirty_bitmap_set_busy(state->bitmap, false);

Don=E2=80=99t you need to undo the removal?  Like, re-add it to state->bs=
, and
re-store it?

[...]

> @@ -2892,13 +2944,28 @@ void qmp_block_dirty_bitmap_remove(const char *=
node, const char *name,
>          aio_context_acquire(aio_context);
>          bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
>          aio_context_release(aio_context);
> +
>          if (local_err !=3D NULL) {
>              error_propagate(errp, local_err);
> -            return;
> +            return NULL;
>          }
>      }
> =20
> -    bdrv_release_dirty_bitmap(bs, bitmap);
> +    if (release) {
> +        bdrv_release_dirty_bitmap(bs, bitmap);
> +    }
> +
> +    if (bitmap_bs) {
> +        *bitmap_bs =3D bs;
> +    }
> +
> +    return bitmap;

I=E2=80=99d prefer =E2=80=9Crelease ? NULL : bitmap=E2=80=9D.

Max

> +}
> +
> +void qmp_block_dirty_bitmap_remove(const char *node, const char *name,=

> +                                   Error **errp)
> +{
> +    do_block_dirty_bitmap_remove(node, name, true, NULL, errp);
>  }
> =20
>  /**


--j4jSKJEehjnN2XgeeYSZIfkXPgkJTImVE--

--Co9H596dq0muE62hjBYBhEKNROD4whCiL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0dAlMACgkQ9AfbAGHV
z0ArnwgAk6q4hwpYJhx1dnYTlTSlt8tVFibQ3u2+YW1kg/EFXOabimPPCtKvDpaQ
psZNreGmuq2fenyT++5eIUaLhCD6L5I5nHV12TpBg+aP5dFgX6qiACAdujUbj34Q
WGQ80aDqps/e58K+pTI5meCUue9T6QKctBfDT7b2tewVs9Df+zdUkADOReQyp8HZ
+gtJ+iIHEwAIsLFdKLipVmC+/C0pOL7T5TAJP4jJ8Euvd4yNHWPq5xtPc/fBnZzb
C/aEBN1v38cwLiUrS9fiqi8PE+/lFrYAXMx5vRkrgC8I3zCCdjNYAwnr21eiSYnV
LzBuAlrdwgmhKVAjTyrilb8nouaiZw==
=1tEs
-----END PGP SIGNATURE-----

--Co9H596dq0muE62hjBYBhEKNROD4whCiL--

