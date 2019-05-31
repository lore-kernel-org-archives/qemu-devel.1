Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACCAC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 11:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB898267FD
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 11:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB898267FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41123 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWfNF-0007yO-6c
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 07:07:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hWf7t-0003lB-Nj
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hWf7s-0000ja-F7
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:51:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hWf7o-0000e3-C4; Fri, 31 May 2019 06:51:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB55081E04;
	Fri, 31 May 2019 10:51:03 +0000 (UTC)
Received: from localhost (ovpn-117-45.ams2.redhat.com [10.36.117.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 09C315D6A6;
	Fri, 31 May 2019 10:51:02 +0000 (UTC)
Date: Fri, 31 May 2019 11:51:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190531105101.GB29868@stefanha-x1.localdomain>
References: <20190528084544.183558-1-vsementsov@virtuozzo.com>
	<20190528084544.183558-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20190528084544.183558-3-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 31 May 2019 10:51:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] block/io: refactor padding
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org,
	qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2019 at 11:45:44AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> We have similar padding code in bdrv_co_pwritev,
> bdrv_co_do_pwrite_zeroes and bdrv_co_preadv. Let's combine and unify
> it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 344 ++++++++++++++++++++++++++++-------------------------

Hmmm...this adds more lines than it removes.  O_o

Merging a change like this can still be useful but there's a risk of
making the code harder to understand due to the additional layers of
abstraction.

>  1 file changed, 179 insertions(+), 165 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index 3134a60a48..840e276269 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1344,28 +1344,155 @@ out:
>  }
> =20
>  /*
> - * Handle a read request in coroutine context
> + * Request padding
> + *
> + *  |<---- align ---->|                     |<---- align ---->|
> + *  |<- head ->|<------------ bytes ------------>|<-- tail -->|
> + *  |          |      |                     |    |            |
> + * -*----------$------*-------- ... --------*----$------------*---
> + *  |          |      |                     |    |            |
> + *  |          offset |                     |    end          |
> + *  ALIGN_UP(offset)  ALIGN_DOWN(offset)    ALIGN_DOWN(end)   ALIGN_UP(e=
nd)

Are ALIGN_UP(offset) and ALIGN_DOWN(offset) in the wrong order?

> + *  [buf   ... )                            [tail_buf         )
> + *
> + * @buf is an aligned allocation needed to store @head and @tail padding=
s. @head
> + * is placed at the beginning of @buf and @tail at the @end.
> + *
> + * @tail_buf is a pointer to sub-buffer, corresponding to align-sized ch=
unk
> + * around tail, if tail exists.
> + *
> + * @merge_reads is true for small requests,
> + * if @buf_len =3D=3D @head + bytes + @tail. In this case it is possible=
 that both
> + * head and tail exist but @buf_len =3D=3D align and @tail_buf =3D=3D @b=
uf.
>   */
> +typedef struct BdrvRequestPadding {
> +    uint8_t *buf;
> +    size_t buf_len;
> +    uint8_t *tail_buf;
> +    size_t head;
> +    size_t tail;
> +    bool merge_reads;
> +    QEMUIOVector local_qiov;
> +} BdrvRequestPadding;
> +
> +static bool bdrv_init_padding(BlockDriverState *bs,
> +                              int64_t offset, int64_t bytes,
> +                              BdrvRequestPadding *pad)
> +{
> +    uint64_t align =3D bs->bl.request_alignment;
> +    size_t sum;
> +
> +    memset(pad, 0, sizeof(*pad));
> +
> +    pad->head =3D offset & (align - 1);
> +    pad->tail =3D ((offset + bytes) & (align - 1));
> +    if (pad->tail) {
> +        pad->tail =3D align - pad->tail;
> +    }
> +
> +    if ((!pad->head && !pad->tail) || !bytes) {
> +        return false;
> +    }
> +
> +    sum =3D pad->head + bytes + pad->tail;
> +    pad->buf_len =3D (sum > align && pad->head && pad->tail) ? 2 * align=
 : align;
> +    pad->buf =3D qemu_blockalign(bs, pad->buf_len);
> +    pad->merge_reads =3D sum =3D=3D pad->buf_len;
> +    if (pad->tail) {
> +        pad->tail_buf =3D pad->buf + pad->buf_len - align;
> +    }
> +
> +    return true;
> +}
> +
> +static int bdrv_padding_read(BdrvChild *child,
> +                             BdrvTrackedRequest *req,
> +                             BdrvRequestPadding *pad,
> +                             bool zero_middle)
> +{
> +    QEMUIOVector local_qiov;
> +    BlockDriverState *bs =3D child->bs;
> +    uint64_t align =3D bs->bl.request_alignment;
> +    int ret;
> +
> +    assert(req->serialising && pad->buf);
> +
> +    if (pad->head || pad->merge_reads) {
> +        uint64_t bytes =3D pad->merge_reads ? pad->buf_len : align;
> +
> +        qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
> +
> +        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);

PWRITEV?  That's unexpected for a function called bdrv_padding_read().
Please rename this to bdrv_padding_rmw_read() so it's clear this is part
of a read-modify-write operation, not a regular read.

> +        ret =3D bdrv_aligned_preadv(child, req, req->overlap_offset, byt=
es,
> +                                  align, &local_qiov, 0);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
> +
> +        if (pad->merge_reads) {
> +            goto zero_mem;
> +        }
> +    }
> +
> +    if (pad->tail) {
> +        qemu_iovec_init_buf(&local_qiov, pad->tail_buf, align);
> +
> +        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
> +        ret =3D bdrv_aligned_preadv(
> +                child, req,
> +                req->overlap_offset + req->overlap_bytes - align,
> +                align, align, &local_qiov, 0);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
> +    }
> +
> +zero_mem:
> +    if (zero_middle) {
> +        memset(pad->buf + pad->head, 0, pad->buf_len - pad->head - pad->=
tail);
> +    }
> +
> +    return 0;
> +}
> +
> +static void bdrv_padding_destroy(BdrvRequestPadding *pad)
> +{
> +    if (pad->buf) {
> +        qemu_vfree(pad->buf);
> +        qemu_iovec_destroy(&pad->local_qiov);
> +    }
> +}
> +
> +static QEMUIOVector *bdrv_pad_request(BlockDriverState *bs, QEMUIOVector=
 *qiov,
> +                                      int64_t *offset, unsigned int *byt=
es,
> +                                      BdrvRequestPadding *pad)

Doc comment missing?

> +{
> +    bdrv_init_padding(bs, *offset, *bytes, pad);
> +    if (!pad->buf) {
> +        return qiov;
> +    }

I think there's no need to peek at pad->buf:

  if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {
      return qiov;
  }

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzxBxUACgkQnKSrs4Gr
c8jtqAf+P5o0E67+8kXmChWPJ51TaX/Mleyz23DoB9rUpkw0CTnyuU8jGvXlyBnK
sqXYjZ0SYTI73iIcStS7mm0EaaXxTPjIoVw7UerupKVXDZvHmFFB5x9Tq9/y3IEq
9ovH1Jnu/61NVwqHg80iNUpJ1BCS2+y7+fwoK5aRBKob84W0BwFYTzj4nXhrfKJ0
Kx4HmFPREyh/KA6OHBvyRRMN32o4doc84tWih5xWiVpxn3/i1OJ3Z5mzyEYydc2K
LORgMqUazyOZTQk0c2rv/Zvd+EoGHA5VpMRF+UpKmXyvbgKVNURomO/SO6bVdz/y
fBeoyGVtlA9dkJVNSQh9RIdILl0W7g==
=rZRO
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--

