Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E093C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 20:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C22420821
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 20:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C22420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51145 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTY3K-0007X4-Va
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 16:41:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTY2J-00078c-1w
	for qemu-devel@nongnu.org; Wed, 22 May 2019 16:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTY2G-0004Cg-VG
	for qemu-devel@nongnu.org; Wed, 22 May 2019 16:40:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTY2C-00048r-Sj; Wed, 22 May 2019 16:40:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BE9F81E0B;
	Wed, 22 May 2019 20:40:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-123.brq.redhat.com
	[10.40.204.123])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BCF560BF1;
	Wed, 22 May 2019 20:40:04 +0000 (UTC)
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
	<20190516142749.81019-2-anton.nefedov@virtuozzo.com>
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
Message-ID: <6fe54054-899a-48d6-c2db-d43e242f20b3@redhat.com>
Date: Wed, 22 May 2019 22:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516142749.81019-2-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VKRtPNGhGHQVvtQjaAURHhDPGjNufICSr"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 22 May 2019 20:40:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v14 1/1] qcow2: skip writing zero buffers
 to empty COW areas
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
	den@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VKRtPNGhGHQVvtQjaAURHhDPGjNufICSr
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com, vsementsov@virtuozzo.com
Message-ID: <6fe54054-899a-48d6-c2db-d43e242f20b3@redhat.com>
Subject: Re: [PATCH v14 1/1] qcow2: skip writing zero buffers to empty COW
 areas
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
 <20190516142749.81019-2-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190516142749.81019-2-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.05.19 16:27, Anton Nefedov wrote:
> If COW areas of the newly allocated clusters are zeroes on the backing
> image, efficient bdrv_write_zeroes(flags=3DBDRV_REQ_NO_FALLBACK) can be=

> used on the whole cluster instead of writing explicit zero buffers late=
r
> in perform_cow().
>=20
> iotest 060:
> write to the discarded cluster does not trigger COW anymore.
> Use a backing image instead.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  qapi/block-core.json       |  4 +-
>  block/qcow2.h              |  6 +++
>  block/qcow2-cluster.c      |  2 +-
>  block/qcow2.c              | 93 +++++++++++++++++++++++++++++++++++++-=

>  block/trace-events         |  1 +
>  tests/qemu-iotests/060     |  7 ++-
>  tests/qemu-iotests/060.out |  5 +-
>  7 files changed, 112 insertions(+), 6 deletions(-)

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8e024007db..e6b1293ddf 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -2145,6 +2150,80 @@ static bool merge_cow(uint64_t offset, unsigned =
bytes,
>      return false;
>  }
> =20
> +static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64=
_t bytes)
> +{
> +    int64_t nr;
> +    return !bytes ||
> +        (!bdrv_is_allocated_above(bs, NULL, offset, bytes, &nr) && nr =
=3D=3D bytes);

It's a pity that this bdrv_is_allocated() throws away BDRV_BLOCK_ZERO
information.  If something in the backing chain has explicit zero
clusters there, we could get the information for free, but this will
consider it allocated.

Wouldn't it make sense to make bdrv_co_block_status_above() public and
then use that (with want_zero =3D=3D false)?

(But that can be done later, too, of course.)

> +}
> +
> +static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
> +{
> +    /*
> +     * This check is designed for optimization shortcut so it must be
> +     * efficient.
> +     * Instead of is_zero(), use is_unallocated() as it is faster (but=
 not
> +     * as accurate and can result in false negatives).
> +     */
> +    return is_unallocated(bs, m->offset + m->cow_start.offset,
> +                          m->cow_start.nb_bytes) &&
> +           is_unallocated(bs, m->offset + m->cow_end.offset,
> +                          m->cow_end.nb_bytes);
> +}
> +
> +static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta=
)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    QCowL2Meta *m;
> +
> +    if (!(s->data_file->bs->supported_zero_flags & BDRV_REQ_NO_FALLBAC=
K)) {
> +        return 0;
> +    }
> +
> +    if (bs->encrypted) {
> +        return 0;
> +    }
> +
> +    for (m =3D l2meta; m !=3D NULL; m =3D m->next) {
> +        int ret;
> +
> +        if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
> +            continue;
> +        }
> +
> +        if (!is_zero_cow(bs, m)) {
> +            continue;
> +        }
> +
> +        /*
> +         * instead of writing zero COW buffers,
> +         * efficiently zero out the whole clusters
> +         */
> +
> +        ret =3D qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
> +                                            m->nb_clusters * s->cluste=
r_size,
> +                                            true);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
> +        ret =3D bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
> +                                    m->nb_clusters * s->cluster_size,
> +                                    BDRV_REQ_NO_FALLBACK);

Mostly I'm writing this mail because of this.  Zeroing the whole range
seems inefficient to me for very large requests, and the commit message
doesn't say anything about the reasoning behind unconditionally zeroing
everything.

Benchmarking looks like in most cases it is about equal to zeroing head
and tail separately.  But if I pre-filll an image with random data, it
is much slower:

$ qemu-img create -f qcow2 foo.qcow2 10G
$ dd if=3D/dev/urandom of=3Dfoo.qcow2 bs=3D1M seek=3D1 count=3D4096
$ sync

Then doing large unaligned requests on it:

$ ./qemu-img bench -w -t none -s $((400 * 1048576)) \
  -S $((401 * 1048576)) -o 32768 -c 10 -d 2 -f qcow2 foo.qcow2

When zeroing the whole range, this usually takes around 25 s for me;
just zeroing head and tail takes around 14 s. Without this patch, it
takes around 14 s, too.

On the other hand, when doing smaller requests on a single cluster
(which is what this patch is for):

$ ./qemu-img bench -w -t none -s 4096 -S 65536 -o 32768 \
  -f qcow2 foo.qcow2

This takes around 26 s before this patch, 12 s with it, and like 30 to
40 when zeroing head and tail separately.


Now, such large requests surely are the exception, as is allocating
blocks in an area of the image that already contains data.  However, I
just want to ask back that zeroing the whole range unconditionally is
done on purpose.  Maybe it makes sense to split head and tail if they
are like more than, I don't know, 16 MB apart?  But the "I don't know"
is the problem of course.  Is there a way to make a good default?


(Note that I wrote a lot, but it's not like I'm making a good point to
stop this patch.  I just want to have asked about this before I take it.)=


Max

> +        if (ret < 0) {
> +            if (ret !=3D -ENOTSUP && ret !=3D -EAGAIN) {
> +                return ret;
> +            }
> +            continue;
> +        }
> +
> +        trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset, m->nb_c=
lusters);
> +        m->skip_cow =3D true;
> +    }
> +    return 0;
> +}
> +
>  static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_=
t offset,
>                                           uint64_t bytes, QEMUIOVector =
*qiov,
>                                           int flags)


--VKRtPNGhGHQVvtQjaAURHhDPGjNufICSr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzls6IACgkQ9AfbAGHV
z0DRQwf/ZUaNLHoCXNV+7dqJw62arY1BMTsCkfZq1WRTGP4swShSvY6BdLLzLodB
DGoLRglfv4Hh6LyVMdPx/pB6gs2To5wMU7XMorutqAPnT7MxaF2rn4hyhc/FlcPi
ZHTWFEZDvwHXqHsFrAphxU3NesT1THfXPK++/JRRCTiz9fvbZGiMdUosKjVSNZ2T
uZbpcKfnD2syXH/3i1kHctQc+YzCzka/4Q+bHARkGQXn0QJH2V/aYgGxCTWvFrdI
ODBSyxHhdxf/QvtyON0AlqzDFCgaNUPyH+3vEZaQRynQO3RRYQPftT8oukCMvoSx
OWXlj9oXOADUifXHwi71ohKPQTHoLA==
=swl9
-----END PGP SIGNATURE-----

--VKRtPNGhGHQVvtQjaAURHhDPGjNufICSr--

