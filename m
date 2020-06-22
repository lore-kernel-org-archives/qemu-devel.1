Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159D7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D3120708
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9wGQi/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D3120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnLP3-0004Ie-4w
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 08:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jnLLR-0001HW-1k
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:14:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48937
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jnLLP-0007Oi-1c
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592828073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrJl2/rwyNsdaivp6bT5sK95BFXGNRp7aXL0LJTJzBY=;
 b=V9wGQi/9iWhjVmzi0X8gr4xFmznXPVCg21cysjwFdFbc6V2s7dATYSbdEa1QVlfY9200LP
 PjIcMJrZ25YvsNs/wVQi4jvG4x1wsnALHxZiyOctUOwWXuGqObeP/4zrHXLcJMBXGwuOct
 A61xfNi85/XOaspTB0uG35hdfcNJWec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Z9tl7HW_P3udf0evi6rbiQ-1; Mon, 22 Jun 2020 08:14:06 -0400
X-MC-Unique: Z9tl7HW_P3udf0evi6rbiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC053107B0E1;
 Mon, 22 Jun 2020 12:14:05 +0000 (UTC)
Received: from localhost (ovpn-115-184.ams2.redhat.com [10.36.115.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DEFD10013D2;
 Mon, 22 Jun 2020 12:14:05 +0000 (UTC)
Date: Mon, 22 Jun 2020 13:14:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Lin Ma <lma@suse.com>
Subject: Re: [PATCH v2 3/3] scsi-disk: Add support for the GET LBA STATUS 16
 command
Message-ID: <20200622121403.GB13543@stefanha-x1.localdomain>
References: <20200617103018.18026-1-lma@suse.com>
 <20200617103018.18026-4-lma@suse.com>
MIME-Version: 1.0
In-Reply-To: <20200617103018.18026-4-lma@suse.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 06:30:18PM +0800, Lin Ma wrote:
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  hw/scsi/scsi-disk.c        | 90 ++++++++++++++++++++++++++++++++++++++
>  include/block/accounting.h |  1 +
>  include/scsi/constants.h   |  1 +
>  3 files changed, 92 insertions(+)
>=20
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 387503e11b..9e3002ddaf 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -1866,6 +1866,89 @@ static void scsi_disk_emulate_write_data(SCSIReque=
st *req)
>      }
>  }
> =20
> +typedef struct GetLbaStatusCBData {
> +    uint32_t num_blocks;
> +    uint32_t is_deallocated;
> +    SCSIDiskReq *r;
> +} GetLbaStatusCBData;
> +
> +static void scsi_get_lba_status_complete(void *opaque, int ret);
> +
> +static void scsi_get_lba_status_complete_noio(GetLbaStatusCBData *data, =
int ret)
> +{
> +    SCSIDiskReq *r =3D data->r;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb =3D=3D NULL);
> +
> +    block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
> +                     s->qdev.blocksize, BLOCK_ACCT_GET_LBA_STATUS);
> +
> +    r->req.aiocb =3D blk_aio_get_lba_status(s->qdev.conf.blk,
> +                                          r->req.cmd.lba * s->qdev.block=
size,
> +                                          s->qdev.blocksize,
> +                                          scsi_get_lba_status_complete, =
data);
> +}
> +
> +static void scsi_get_lba_status_complete(void *opaque, int ret)
> +{
> +    GetLbaStatusCBData *data =3D opaque;
> +    SCSIDiskReq *r =3D data->r;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
> +    if (scsi_disk_req_check_error(r, ret, true)) {
> +        g_free(data);
> +        goto done;
> +    }
> +
> +    block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
> +    scsi_req_unref(&r->req);
> +    g_free(data);
> +
> +done:
> +    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
> +}
> +
> +static void scsi_disk_emulate_get_lba_status(SCSIRequest *req, uint8_t *=
outbuf)
> +{
> +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> +    GetLbaStatusCBData *data;
> +    uint32_t *num_blocks;
> +    uint32_t *is_deallocated;
> +
> +    data =3D g_new0(GetLbaStatusCBData, 1);
> +    data->r =3D r;
> +    num_blocks =3D &(data->num_blocks);
> +    is_deallocated =3D &(data->is_deallocated);
> +
> +    scsi_req_ref(&r->req);
> +    scsi_get_lba_status_complete_noio(data, 0);

scsi_get_lba_status_complete_noio() looks asynchronous. If the
BlockDriver yields in .bdrv_co_block_status() then the operation has not
completed yet when scsi_get_lba_status_complete_noio() returns. It is
not safe to access the GetLbaStatusCBData data until the async operation
is complete.

Also, scsi_get_lba_status_complete() calls g_free(data) so there is a
use-after-free when *num_blocks and *is_deallocated are accessed.

These issues can be solved by making this code asynchronous (similar to
read/write/flush/discard_zeroes/ioctl). outbuf[] will be filled in in
the completion function before g_free(data) is called.

> +
> +    /*
> +     * 8 + 16 is the length in bytes of response header and
> +     * one LBA status descriptor
> +     */
> +    memset(outbuf, 0, 8 + 16);
> +    outbuf[3] =3D 20;
> +    outbuf[8] =3D (req->cmd.lba >> 56) & 0xff;
> +    outbuf[9] =3D (req->cmd.lba >> 48) & 0xff;
> +    outbuf[10] =3D (req->cmd.lba >> 40) & 0xff;
> +    outbuf[11] =3D (req->cmd.lba >> 32) & 0xff;
> +    outbuf[12] =3D (req->cmd.lba >> 24) & 0xff;
> +    outbuf[13] =3D (req->cmd.lba >> 16) & 0xff;
> +    outbuf[14] =3D (req->cmd.lba >> 8) & 0xff;
> +    outbuf[15] =3D req->cmd.lba & 0xff;
> +    outbuf[16] =3D (*num_blocks >> 24) & 0xff;
> +    outbuf[17] =3D (*num_blocks >> 16) & 0xff;
> +    outbuf[18] =3D (*num_blocks >> 8) & 0xff;
> +    outbuf[19] =3D *num_blocks & 0xff;
> +    outbuf[20] =3D *is_deallocated ? 1 : 0;

SCSI defines 3 values and QEMU can represent all of them:

0 - mapped or unknown
1 - deallocated
2 - anchored

See the BDRV_BLOCK_* constants in include/block/block.h. The
is_deallocated boolean is not enough to represent this state, but the
bdrv_block_status() return value can be used instead.

> +}
> +
>  static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
>  {
>      SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> @@ -2076,6 +2159,13 @@ static int32_t scsi_disk_emulate_command(SCSIReque=
st *req, uint8_t *buf)
> =20
>              /* Protection, exponent and lowest lba field left blank. */
>              break;
> +        } else if ((req->cmd.buf[1] & 31) =3D=3D SAI_GET_LBA_STATUS) {
> +            if (req->cmd.lba > s->qdev.max_lba) {
> +                goto illegal_lba;
> +            }
> +            scsi_disk_emulate_get_lba_status(req, outbuf);
> +            r->iov.iov_len =3D req->cmd.xfer;
> +            return r->iov.iov_len;

Is there something tricky going on here with iov_len that prevents us
from using break here and sharing the functions normal return code path?

>          }
>          trace_scsi_disk_emulate_command_SAI_unsupported();
>          goto illegal_request;
> diff --git a/include/block/accounting.h b/include/block/accounting.h
> index 878b4c3581..645014fb0b 100644
> --- a/include/block/accounting.h
> +++ b/include/block/accounting.h
> @@ -38,6 +38,7 @@ enum BlockAcctType {
>      BLOCK_ACCT_WRITE,
>      BLOCK_ACCT_FLUSH,
>      BLOCK_ACCT_UNMAP,
> +    BLOCK_ACCT_GET_LBA_STATUS,
>      BLOCK_MAX_IOTYPE,
>  };
> =20
> diff --git a/include/scsi/constants.h b/include/scsi/constants.h
> index 874176019e..b18377b214 100644
> --- a/include/scsi/constants.h
> +++ b/include/scsi/constants.h
> @@ -154,6 +154,7 @@
>   * SERVICE ACTION IN subcodes
>   */
>  #define SAI_READ_CAPACITY_16  0x10
> +#define SAI_GET_LBA_STATUS    0x12
> =20
>  /*
>   * READ POSITION service action codes
> --=20
> 2.26.0
>=20

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7woIsACgkQnKSrs4Gr
c8hkLAgArVec7E49EmzDmcR1BqNk7QrwOdnv8wHWwUyPQjvkgJDzqlVHHwXW4WNP
SPduZlkk18e+Mqvj1uAdu546SZJkN+38ChKKMQT/L5nsX83Hb2qVHH3/M5GdEfTq
fZUsMcmPTA5FbxMNKEiMjrz8VMHlUqGabk3IzhGmWfbuzk0g2WmFK34EUy6f1a1G
rKCnNm6ixScp6YZxX3HQ60PQLaYM5gCY8u/hfpj2Iiz7Jf/L6vT4A4Jpw3cI7mWd
K/8oRZO9rP9xlzTYJ6ijqTTk32K9v5WYXq61joOlCA58CjLdt7hh/i9Ij/g9c8xN
QjyYBsKHh6jrXbir2oP9S/UedCaPMQ==
=OwlD
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--


