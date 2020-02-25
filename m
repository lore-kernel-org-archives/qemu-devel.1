Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79849C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C872084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnGBwnxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C872084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6coL-0004Y0-FJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6cmn-0002c7-Tm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6cml-0000NS-3p
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:10:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6cmk-0000Lh-SQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582647013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9MUTkymNvg6CsfM1w86jWISOFi/buDmwDtDpy/j7RA=;
 b=YnGBwnxJQsx3wvl+a+U0/ZGVWPXt8bI59G4r77oTGE5vqXA1M+e26GMhGmGLqOOHBPp/8B
 +lpzboaSlCqU/adV8jeoWKfrkikyK29W1c4TrTCsfhW3w3N29dQ7YhmvVVZYW5K5se161/
 0948QeQ3DYHjiiIXQt2yMn6LUoGMCCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-_h3S6LjeO1GfgiKuDaqw0A-1; Tue, 25 Feb 2020 11:10:05 -0500
X-MC-Unique: _h3S6LjeO1GfgiKuDaqw0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 379B08018A8;
 Tue, 25 Feb 2020 16:10:04 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B8B260BF7;
 Tue, 25 Feb 2020 16:10:00 +0000 (UTC)
Date: Tue, 25 Feb 2020 17:09:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v4 3/5] vhost-user block device backend server
Message-ID: <20200225160958.GD7632@linux.fritz.box>
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200218050711.8133-4-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200218050711.8133-4-coiby.xu@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.02.2020 um 06:07 hat Coiby Xu geschrieben:
> By making use of libvhost, multiple block device drives can be exported
> and each drive can serve multiple clients simultaneously.
> Since vhost-user-server needs a block drive to be created first, delay
> the creation of this object.
>=20
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  Makefile.target                  |   1 +
>  backends/Makefile.objs           |   2 +
>  backends/vhost-user-blk-server.c | 718 +++++++++++++++++++++++++++++++
>  backends/vhost-user-blk-server.h |  21 +
>  vl.c                             |   4 +
>  5 files changed, 746 insertions(+)
>  create mode 100644 backends/vhost-user-blk-server.c
>  create mode 100644 backends/vhost-user-blk-server.h
>=20
> diff --git a/Makefile.target b/Makefile.target
> index 6e61f607b1..8c6c01eb3a 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -159,6 +159,7 @@ obj-y +=3D monitor/
>  obj-y +=3D qapi/
>  obj-y +=3D memory.o
>  obj-y +=3D memory_mapping.o
> +obj-$(CONFIG_LINUX) +=3D ../contrib/libvhost-user/libvhost-user.o
>  obj-y +=3D migration/ram.o
>  LIBS :=3D $(libs_softmmu) $(LIBS)
> =20
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index 28a847cd57..4e7be731e0 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -14,6 +14,8 @@ common-obj-y +=3D cryptodev-vhost.o
>  common-obj-$(CONFIG_VHOST_CRYPTO) +=3D cryptodev-vhost-user.o
>  endif
> =20
> +common-obj-$(CONFIG_LINUX) +=3D vhost-user-blk-server.o
> +
>  common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO)) +=3D vhost=
-user.o
> =20
>  common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
> diff --git a/backends/vhost-user-blk-server.c b/backends/vhost-user-blk-s=
erver.c
> new file mode 100644
> index 0000000000..1bf7f7b544
> --- /dev/null
> +++ b/backends/vhost-user-blk-server.c

Please move this to block/export/vhost-user-blk.c. This will
automatically have it covered as a block layer component in MAINTAINERS,
and it will provide a place where other exports can be put, too.

> @@ -0,0 +1,718 @@
> +/*
> + * Sharing QEMU block devices via vhost-user protocal
> + *
> + * Author: Coiby Xu <coiby.xu@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "block/block.h"
> +#include "vhost-user-blk-server.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "sysemu/block-backend.h"
> +
> +enum {
> +    VHOST_USER_BLK_MAX_QUEUES =3D 1,
> +};
> +struct virtio_blk_inhdr {
> +    unsigned char status;
> +};
> +
> +static QTAILQ_HEAD(, VuBlockDev) vu_block_devs =3D
> +                                 QTAILQ_HEAD_INITIALIZER(vu_block_devs);
> +
> +
> +typedef struct VuBlockReq {
> +    VuVirtqElement *elem;
> +    int64_t sector_num;
> +    size_t size;
> +    struct virtio_blk_inhdr *in;
> +    struct virtio_blk_outhdr out;
> +    VuClient *client;
> +    struct VuVirtq *vq;
> +} VuBlockReq;
> +
> +
> +static void vu_block_req_complete(VuBlockReq *req)
> +{
> +    VuDev *vu_dev =3D &req->client->parent;
> +
> +    /* IO size with 1 extra status byte */
> +    vu_queue_push(vu_dev, req->vq, req->elem, req->size + 1);
> +    vu_queue_notify(vu_dev, req->vq);
> +
> +    if (req->elem) {
> +        free(req->elem);
> +    }
> +
> +    g_free(req);
> +}
> +
> +static VuBlockDev *get_vu_block_device_by_client(VuClient *client)
> +{
> +    return container_of(client->server->ptr_in_device, VuBlockDev, vu_se=
rver);
> +}
> +
> +static int coroutine_fn
> +vu_block_discard_write_zeroes(VuBlockReq *req, struct iovec *iov,
> +                              uint32_t iovcnt, uint32_t type)
> +{
> +    struct virtio_blk_discard_write_zeroes desc;
> +    ssize_t size =3D iov_to_buf(iov, iovcnt, 0, &desc, sizeof(desc));
> +    if (unlikely(size !=3D sizeof(desc))) {
> +        error_report("Invalid size %ld, expect %ld", size, sizeof(desc))=
;
> +        return -EINVAL;
> +    }
> +
> +    VuBlockDev *vdev_blk =3D get_vu_block_device_by_client(req->client);
> +    uint64_t range[2] =3D { le64toh(desc.sector) << 9,
> +                          le32toh(desc.num_sectors) << 9 };
> +    if (type =3D=3D VIRTIO_BLK_T_DISCARD) {
> +        if (blk_co_pdiscard(vdev_blk->backend, range[0], range[1]) =3D=
=3D 0) {
> +            return 0;
> +        }
> +    } else if (type =3D=3D VIRTIO_BLK_T_WRITE_ZEROES) {
> +        if (blk_co_pwrite_zeroes(vdev_blk->backend,
> +                                 range[0], range[1], 0) =3D=3D 0) {
> +            return 0;
> +        }
> +    }
> +
> +    return -EINVAL;
> +}
> +
> +
> +static void coroutine_fn vu_block_flush(VuBlockReq *req)
> +{
> +    VuBlockDev *vdev_blk =3D get_vu_block_device_by_client(req->client);
> +    BlockBackend *backend =3D vdev_blk->backend;
> +    blk_co_flush(backend);
> +}
> +
> +
> +static int coroutine_fn vu_block_virtio_process_req(VuClient *client,
> +                                                    VuVirtq *vq)
> +{
> +    VuDev *vu_dev =3D &client->parent;
> +    VuVirtqElement *elem;
> +    uint32_t type;
> +    VuBlockReq *req;
> +
> +    VuBlockDev *vdev_blk =3D get_vu_block_device_by_client(client);
> +    BlockBackend *backend =3D vdev_blk->backend;
> +    elem =3D vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement) +
> +                                    sizeof(VuBlockReq));
> +    if (!elem) {
> +        return -1;
> +    }
> +
> +    struct iovec *in_iov =3D elem->in_sg;
> +    struct iovec *out_iov =3D elem->out_sg;
> +    unsigned in_num =3D elem->in_num;
> +    unsigned out_num =3D elem->out_num;
> +    /* refer to hw/block/virtio_blk.c */
> +    if (elem->out_num < 1 || elem->in_num < 1) {
> +        error_report("virtio-blk request missing headers");
> +        free(elem);
> +        return -EINVAL;
> +    }
> +
> +    req =3D g_new0(VuBlockReq, 1);
> +    req->client =3D client;
> +    req->vq =3D vq;
> +    req->elem =3D elem;

You can keep req on the stack, it will be freed before this function
returns.

> +    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req->out,
> +                            sizeof(req->out)) !=3D sizeof(req->out))) {
> +        error_report("virtio-blk request outhdr too short");
> +        goto err;
> +    }
> +
> +    iov_discard_front(&out_iov, &out_num, sizeof(req->out));
> +
> +    if (in_iov[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
> +        error_report("virtio-blk request inhdr too short");
> +        goto err;
> +    }
> +
> +    /* We always touch the last byte, so just see how big in_iov is.  */
> +    req->in =3D (void *)in_iov[in_num - 1].iov_base
> +              + in_iov[in_num - 1].iov_len
> +              - sizeof(struct virtio_blk_inhdr);
> +    iov_discard_back(in_iov, &in_num, sizeof(struct virtio_blk_inhdr));
> +
> +
> +    type =3D le32toh(req->out.type);
> +    switch (type & ~VIRTIO_BLK_T_BARRIER) {
> +    case VIRTIO_BLK_T_IN:
> +    case VIRTIO_BLK_T_OUT: {
> +        ssize_t ret =3D 0;
> +        bool is_write =3D type & VIRTIO_BLK_T_OUT;
> +        req->sector_num =3D le64toh(req->out.sector);
> +
> +        int64_t offset =3D req->sector_num * vdev_blk->blk_size;
> +        QEMUIOVector *qiov =3D g_new0(QEMUIOVector, 1);
> +        if (is_write) {
> +            qemu_iovec_init_external(qiov, out_iov, out_num);
> +            ret =3D blk_co_pwritev(backend, offset, qiov->size,
> +                                 qiov, 0);
> +        } else {
> +            qemu_iovec_init_external(qiov, in_iov, in_num);
> +            ret =3D blk_co_preadv(backend, offset, qiov->size,
> +                                 qiov, 0);
> +        }
> +        aio_wait_kick();

What purpose does this aio_wait_kick() serve? Usually you do this if you
want to signal completion fo something to a different thread, but I
don't see that we changed any control state that could be visible to
other threads.

> +        if (ret >=3D 0) {
> +            req->in->status =3D VIRTIO_BLK_S_OK;
> +        } else {
> +            req->in->status =3D VIRTIO_BLK_S_IOERR;
> +        }
> +        vu_block_req_complete(req);
> +        break;
> +    }
> +    case VIRTIO_BLK_T_FLUSH:
> +        vu_block_flush(req);
> +        req->in->status =3D VIRTIO_BLK_S_OK;
> +        vu_block_req_complete(req);
> +        break;
> +    case VIRTIO_BLK_T_GET_ID: {
> +        size_t size =3D MIN(iov_size(&elem->in_sg[0], in_num),
> +                          VIRTIO_BLK_ID_BYTES);
> +        snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk_se=
rver");
> +        req->in->status =3D VIRTIO_BLK_S_OK;
> +        req->size =3D elem->in_sg[0].iov_len;
> +        vu_block_req_complete(req);
> +        break;
> +    }
> +    case VIRTIO_BLK_T_DISCARD:
> +    case VIRTIO_BLK_T_WRITE_ZEROES: {
> +        int rc;
> +        rc =3D vu_block_discard_write_zeroes(req, &elem->out_sg[1],
> +                                           out_num, type);
> +        if (rc =3D=3D 0) {
> +            req->in->status =3D VIRTIO_BLK_S_OK;
> +        } else {
> +            req->in->status =3D VIRTIO_BLK_S_IOERR;
> +        }
> +        vu_block_req_complete(req);
> +        break;
> +    }
> +    default:
> +        req->in->status =3D VIRTIO_BLK_S_UNSUPP;
> +        vu_block_req_complete(req);
> +        break;
> +    }

You have vu_block_req_complete() as the last thing in every branch. You
could have it just once after the switch block.

> +    return 0;
> +
> +err:
> +    free(elem);
> +    g_free(req);
> +    return -EINVAL;
> +}

Okay, so vu_block_virtio_process_req() takes a single request from the
virtqueue and processes it. This makes sense as a building block, but it
doesn't allow parallelism yet. I expect to see the creation of multiple
coroutines below that can run in parallel.

> +
> +static void vu_block_process_vq(VuDev *vu_dev, int idx)
> +{
> +    VuClient *client;
> +    VuVirtq *vq;
> +    int ret;
> +
> +    client =3D container_of(vu_dev, VuClient, parent);
> +    assert(client);
> +
> +    vq =3D vu_get_queue(vu_dev, idx);
> +    assert(vq);
> +
> +    while (1) {
> +        ret =3D vu_block_virtio_process_req(client, vq);

If you call vu_block_virtio_process_req(), then this one need to be a
coroutine_fn, too.

> +        if (ret) {
> +            break;
> +        }
> +    }
> +}
> +
> +static void vu_block_queue_set_started(VuDev *vu_dev, int idx, bool star=
ted)
> +{
> +    VuVirtq *vq;
> +
> +    assert(vu_dev);
> +
> +    vq =3D vu_get_queue(vu_dev, idx);
> +    vu_set_queue_handler(vu_dev, vq, started ? vu_block_process_vq : NUL=
L);
> +}

If vu_block_process_vq() is used as a vq->handler, will it not be called
outside coroutine context? How can this work when
vu_block_virtio_process_req() required to be run in coroutine context?

Another problem is that vu_block_process_vq() runs a loop as long as
there are requests that aren't completed yet. During this time,
vu_kick_cb() will block. I don't think this is what was intended.
Instead, we should start the requests (without waiting for their
completion) and return.

> diff --git a/vl.c b/vl.c
> index 794f2e5733..0332ab70da 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2538,6 +2538,10 @@ static bool object_create_initial(const char *type=
, QemuOpts *opts)
>      }
>  #endif
> =20
> +    /* Reason: vhost-user-server property "name" */

"node-name" now.

> +    if (g_str_equal(type, "vhost-user-blk-server")) {
> +        return false;
> +    }
>      /*
>       * Reason: filter-* property "netdev" etc.
>       */

Kevin


