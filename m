Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3463CC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01D2208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01D2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55607 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOk1F-0006h4-AC
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:27:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOk0C-000654-Sy
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOk0B-0001Al-8j
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOk07-000182-CR; Thu, 09 May 2019 10:26:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D930230238F0;
	Thu,  9 May 2019 14:26:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-168.brq.redhat.com
	[10.40.204.168])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A80CE5DF4B;
	Thu,  9 May 2019 14:26:18 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20190508155147.10645-1-berto@igalia.com>
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
Message-ID: <ad47a268-b853-6941-34a6-51f73ac992b1@redhat.com>
Date: Thu, 9 May 2019 16:26:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508155147.10645-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TzulHUoabsk8eO0pFuJR22zp7fN3l3rhZ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 09 May 2019 14:26:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] block: Use bdrv_unref_child() for all
 children in bdrv_close()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TzulHUoabsk8eO0pFuJR22zp7fN3l3rhZ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ad47a268-b853-6941-34a6-51f73ac992b1@redhat.com>
Subject: Re: [PATCH v2] block: Use bdrv_unref_child() for all children in
 bdrv_close()
References: <20190508155147.10645-1-berto@igalia.com>
In-Reply-To: <20190508155147.10645-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.19 17:51, Alberto Garcia wrote:
> bdrv_unref_child() does the following things:
>=20
>   - Updates the child->bs->inherits_from pointer.
>   - Calls bdrv_detach_child() to remove the BdrvChild from bs->children=
=2E
>   - Calls bdrv_unref() to unref the child BlockDriverState.
>=20
> When bdrv_unref_child() was introduced in commit 33a604075c it was not
> used in bdrv_close() because the drivers that had additional children
> (like quorum or blkverify) had already called bdrv_unref() on their
> children during their own close functions.
>=20
> This was changed later (in 0bd6e91a7e for quorum, in 3e586be0b2 for
> blkverify) so there's no reason not to use bdrv_unref_child() in
> bdrv_close() anymore.
>=20
> After this there's also no need to remove bs->backing and bs->file
> separately from the rest of the children, so bdrv_close() can be
> simplified.
>=20
> This patch also updates a couple of tests that were doing their own
> bdrv_unref().
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c                     | 16 +++-------------
>  tests/test-bdrv-drain.c     |  6 ------
>  tests/test-bdrv-graph-mod.c |  1 -
>  3 files changed, 3 insertions(+), 20 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 9ae5c0ed2f..96f8e431da 100644
> --- a/block.c
> +++ b/block.c
> @@ -3843,22 +3843,12 @@ static void bdrv_close(BlockDriverState *bs)
>          bs->drv =3D NULL;
>      }
> =20
> -    bdrv_set_backing_hd(bs, NULL, &error_abort);
> -
> -    if (bs->file !=3D NULL) {
> -        bdrv_unref_child(bs, bs->file);
> -        bs->file =3D NULL;
> -    }
> -
>      QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
> -        /* TODO Remove bdrv_unref() from drivers' close function and u=
se
> -         * bdrv_unref_child() here */
> -        if (child->bs->inherits_from =3D=3D bs) {
> -            child->bs->inherits_from =3D NULL;
> -        }
> -        bdrv_detach_child(child);
> +        bdrv_unref_child(bs, child);
>      }
> =20
> +    bs->backing =3D NULL;
> +    bs->file =3D NULL;
>      g_free(bs->opaque);
>      bs->opaque =3D NULL;
>      atomic_set(&bs->copy_on_read, 0);
> diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
> index eda90750eb..5534c2adf9 100644
> --- a/tests/test-bdrv-drain.c
> +++ b/tests/test-bdrv-drain.c
> @@ -1436,12 +1436,6 @@ static void test_detach_indirect(bool by_parent_=
cb)
>      bdrv_unref(parent_b);
>      blk_unref(blk);
> =20
> -    /* XXX Once bdrv_close() unref's children instead of just detachin=
g them,
> -     * this won't be necessary any more. */
> -    bdrv_unref(a);
> -    bdrv_unref(a);
> -    bdrv_unref(c);
> -
>      g_assert_cmpint(a->refcnt, =3D=3D, 1);
>      g_assert_cmpint(b->refcnt, =3D=3D, 1);
>      g_assert_cmpint(c->refcnt, =3D=3D, 1);
> diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
> index 283dc84869..747c0bf8fc 100644
> --- a/tests/test-bdrv-graph-mod.c
> +++ b/tests/test-bdrv-graph-mod.c
> @@ -116,7 +116,6 @@ static void test_update_perm_tree(void)
>      g_assert_nonnull(local_err);
>      error_free(local_err);
> =20
> -    bdrv_unref(bs);
>      blk_unref(root);
>  }

Hm, yes, the comment in test-bdrv-drain makes these changes obvious enoug=
h.

So the =E2=80=9Cproblem=E2=80=9D was that this patch effectively makes
bdrv_attach_child() take the reference to the child BDS on success.
Well, it always kind of did so; it did not increase the refcount for the
link it creates.  But someone still needed to invoke some unref function
to drop the refcount, which is no longer the case as of this patch.

But taking the reference only on success is a bit wonky.  Usually such
functions promise to always take the reference, even on error (they will
just bdrv_unref() the BDS then).  And looking at the callers, that seems
to make sense, actually.  All of them invoke bdrv_unref() on the child
if bdrv_attach_child() fails.  This extends to bdrv_root_attach_child()
-- two of its three callers do not bdrv_unref() the child on failure,
but that's just because they haven't even taken their own reference yet.
 So if bdrv_root_attach_child() always took the reference, they'd just
need to call bdrv_ref() before bdrv_root_attach_child() rather than
afterwards.

Do you agree?  If so, would you mind changing the behavior of
bdrv_attach_child() and bdrv_root_attach_child() and document it?

Max


--TzulHUoabsk8eO0pFuJR22zp7fN3l3rhZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzUOIcACgkQ9AfbAGHV
z0Br2Qf/bQ9eyYE0JCumg516z3AaUmacPcBM7pr40+N/kgmYHrOvhbjAAqzhIcY3
LqyAHQDfNZHHF/OhiJPjgK22aFCvZiPtwR3E/OOcBNBhAOfnVH81pHd5pbn4XllH
d6zuHl3VZ23QRUhefbQpn8ecLFrd5vbJLqEbWdM7uZcfVOPejcvt83qUdfknASbc
WJBhvPlAnjQJsbjs0EkwkUfwj6EGvGpnUrC/L1dDEtWnQEJnEqHim2VS9AKMZOVz
bS4MSXPxmGrMyFSkEJdqq5akNPxHDSGXILh3Pv50+i0L+VvpbOkzEDRXGxZGoeuE
6tKVPYdH5c5POsbuV/Ci9pNZyypX0g==
=v0M+
-----END PGP SIGNATURE-----

--TzulHUoabsk8eO0pFuJR22zp7fN3l3rhZ--

