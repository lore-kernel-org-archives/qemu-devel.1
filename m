Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20033C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88B620679
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88B620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i32Ag-0000iL-0j
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i327Y-0007ME-7Z
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i327W-0000g9-Ns
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:52:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i327S-0000es-9E; Wed, 28 Aug 2019 13:52:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4ED93086202;
 Wed, 28 Aug 2019 17:52:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-32.brq.redhat.com
 [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFDD51001B00;
 Wed, 28 Aug 2019 17:52:16 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-13-vsementsov@virtuozzo.com>
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
Message-ID: <5ce15418-4320-49bf-f6eb-f6dface5c61d@redhat.com>
Date: Wed, 28 Aug 2019 19:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826161312.489398-13-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TQLVhvG0ehtfnarhq6oJNX0OVFwjJTYdI"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 28 Aug 2019 17:52:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 12/13] block: introduce backup-top
 filter driver
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
Cc: fam@euphon.net, kwolf@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TQLVhvG0ehtfnarhq6oJNX0OVFwjJTYdI
Content-Type: multipart/mixed; boundary="SeHr5Z3q0AunMdAl3KynjP3vdtBvhJnxg";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net,
 stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <5ce15418-4320-49bf-f6eb-f6dface5c61d@redhat.com>
Subject: Re: [PATCH v9 12/13] block: introduce backup-top filter driver
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-13-vsementsov@virtuozzo.com>
In-Reply-To: <20190826161312.489398-13-vsementsov@virtuozzo.com>

--SeHr5Z3q0AunMdAl3KynjP3vdtBvhJnxg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.19 18:13, Vladimir Sementsov-Ogievskiy wrote:
> Backup-top filter caches write operations and does copy-before-write
> operations.
>=20
> The driver will be used in backup instead of write-notifiers.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup-top.h  |  37 +++++++
>  block/backup-top.c  | 245 ++++++++++++++++++++++++++++++++++++++++++++=

>  block/Makefile.objs |   2 +
>  3 files changed, 284 insertions(+)
>  create mode 100644 block/backup-top.h
>  create mode 100644 block/backup-top.c

[...]

> +static void backup_top_refresh_filename(BlockDriverState *bs)
> +{
> +    if (bs->backing =3D=3D NULL) {
> +        /*
> +         * we can be here after failed bdrv_attach_child in
> +         * bdrv_set_backing_hd
> +         */
> +        return;
> +    }
> +    bdrv_refresh_filename(bs->backing->bs);

bdrv_refresh_filename() should have done this already.

> +    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
> +            bs->backing->bs->filename);
> +}

[...]

> +BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
> +                                         const char *filter_node_name,=

> +                                         Error **errp)
> +{
[...]
> +    assert(!(top->backing->shared_perm & BLK_PERM_WRITE));

Not wrong, but why?

> +
> +    return top;
> +}
> +
> +void bdrv_backup_top_set_bcs(BlockDriverState *bs, BlockCopyState *cop=
y_state)
> +{
> +    BDRVBackupTopState *s =3D bs->opaque;
> +
> +    assert(blk_bs(copy_state->source) =3D=3D bs->backing->bs);
> +    s->bcs =3D copy_state;
> +}
> +
> +void bdrv_backup_top_drop(BlockDriverState *bs)
> +{
> +    AioContext *aio_context =3D bdrv_get_aio_context(bs);
> +
> +    aio_context_acquire(aio_context);
> +
> +    bdrv_drained_begin(bs);
> +
> +    bdrv_child_try_set_perm(bs->backing, 0, BLK_PERM_ALL, &error_abort=
);

I would prefer a state->active =3D false and bdrv_child_refresh_perms().

Max


--SeHr5Z3q0AunMdAl3KynjP3vdtBvhJnxg--

--TQLVhvG0ehtfnarhq6oJNX0OVFwjJTYdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1mv04ACgkQ9AfbAGHV
z0AUmwf+JyVvnz97tihfzKtvJCjg9NmuCxwFSa5piEN/G221wUJCWzc6cU/SG2q7
iuqxwvvEF20LuA9/xRHuhirJ47x7KTc0lmDxw9VC8XIcScbfILqrFh+m5K2RcB6L
jq2A/Vwi//PR/j/puxILYa8i5igzaOuKgdzRI5zHtAVU/t8cbStjH7aqKS7C3fQk
VC74ubmpMxeftboFzuaAzXHYlMC/3kvcmNJkRIowlaOtYuwXqpCIQxsHAXiQJwRJ
ef75Zf270wyL8sKM6Pw+XxqD0nmMXBtdQpoX8XI8qxe2Cr7G3WtCu5ZUuDaDWy0T
BjPuo3ReZOahlbZiWzrIgvZ6Kba6/A==
=DbKF
-----END PGP SIGNATURE-----

--TQLVhvG0ehtfnarhq6oJNX0OVFwjJTYdI--

