Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8AAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4EA20732
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLwSm0mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4EA20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlww4-0000Xv-Eh
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlwvK-0007yw-9n
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:57:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23888
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlwvG-000499-SL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592495870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ya52HZi9I3WVu/BBwHt+eoyrRJM/iMJZ8CX2O+slIgA=;
 b=RLwSm0mFRZFUr4lsVlmWNMfVYccCMr1PzLd+lJcxnnIW3yUduMIq14PvSKCSwN/TRa21rp
 ehY+7dP5GI1xXmxPxlPqqZoOjy6i8enDH8f8h0Q5vj1gXAN2YXmZY81xrNqe3FqB+AqLPR
 LR/C4IINKTscpIO75rspMt9QIG8yjq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-EuDGyEdvPHGUoaeN61YG8A-1; Thu, 18 Jun 2020 11:57:48 -0400
X-MC-Unique: EuDGyEdvPHGUoaeN61YG8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E8AA801503;
 Thu, 18 Jun 2020 15:57:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-87.ams2.redhat.com [10.36.114.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 844605C1D6;
 Thu, 18 Jun 2020 15:57:42 +0000 (UTC)
Date: Thu, 18 Jun 2020 17:57:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 4/5] vhost-user block device backend server
Message-ID: <20200618155740.GE6012@linux.fritz.box>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200614183907.514282-5-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200614183907.514282-5-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
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
Cc: "open list:Block layer core" <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.06.2020 um 20:39 hat Coiby Xu geschrieben:
> By making use of libvhost-user, block device drive can be shared to
> the connected vhost-user client. Only one client can connect to the
> server one time.
> 
> Since vhost-user-server needs a block drive to be created first, delay
> the creation of this object.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  block/Makefile.objs                  |   1 +
>  block/export/vhost-user-blk-server.c | 669 +++++++++++++++++++++++++++
>  block/export/vhost-user-blk-server.h |  35 ++
>  softmmu/vl.c                         |   4 +
>  4 files changed, 709 insertions(+)
>  create mode 100644 block/export/vhost-user-blk-server.c
>  create mode 100644 block/export/vhost-user-blk-server.h
> 
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 3635b6b4c1..0eb7eff470 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -24,6 +24,7 @@ block-obj-y += throttle-groups.o
>  block-obj-$(CONFIG_LINUX) += nvme.o
>  
>  block-obj-y += nbd.o
> +block-obj-$(CONFIG_LINUX) += export/vhost-user-blk-server.o ../contrib/libvhost-user/libvhost-user.o
>  block-obj-$(CONFIG_SHEEPDOG) += sheepdog.o
>  block-obj-$(CONFIG_LIBISCSI) += iscsi.o
>  block-obj-$(if $(CONFIG_LIBISCSI),y,n) += iscsi-opts.o
> diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
> new file mode 100644
> index 0000000000..bbf2ceaa9b
> --- /dev/null
> +++ b/block/export/vhost-user-blk-server.c
> @@ -0,0 +1,669 @@
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
> +#include "util/block-helpers.h"
> +
> +enum {
> +    VHOST_USER_BLK_MAX_QUEUES = 1,
> +};
> +struct virtio_blk_inhdr {
> +    unsigned char status;
> +};
> +
> +
> +typedef struct VuBlockReq {
> +    VuVirtqElement *elem;
> +    int64_t sector_num;
> +    size_t size;
> +    struct virtio_blk_inhdr *in;
> +    struct virtio_blk_outhdr out;
> +    VuServer *server;
> +    struct VuVirtq *vq;
> +} VuBlockReq;
> +
> +
> +static void vu_block_req_complete(VuBlockReq *req)
> +{
> +    VuDev *vu_dev = &req->server->vu_dev;
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
> +static VuBlockDev *get_vu_block_device_by_server(VuServer *server)
> +{
> +    return container_of(server, VuBlockDev, vu_server);
> +}
> +
> +static int coroutine_fn
> +vu_block_discard_write_zeroes(VuBlockReq *req, struct iovec *iov,
> +                              uint32_t iovcnt, uint32_t type)
> +{
> +    struct virtio_blk_discard_write_zeroes desc;
> +    ssize_t size = iov_to_buf(iov, iovcnt, 0, &desc, sizeof(desc));
> +    if (unlikely(size != sizeof(desc))) {
> +        error_report("Invalid size %ld, expect %ld", size, sizeof(desc));
> +        return -EINVAL;
> +    }
> +
> +    VuBlockDev *vdev_blk = get_vu_block_device_by_server(req->server);
> +    uint64_t range[2] = { le64_to_cpu(desc.sector) << 9,
> +                          le32_to_cpu(desc.num_sectors) << 9 };
> +    if (type == VIRTIO_BLK_T_DISCARD) {
> +        if (blk_co_pdiscard(vdev_blk->backend, range[0], range[1]) == 0) {
> +            return 0;
> +        }
> +    } else if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
> +        if (blk_co_pwrite_zeroes(vdev_blk->backend,
> +                                 range[0], range[1], 0) == 0) {
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
> +    VuBlockDev *vdev_blk = get_vu_block_device_by_server(req->server);
> +    BlockBackend *backend = vdev_blk->backend;
> +    blk_co_flush(backend);
> +}
> +
> +
> +struct req_data {
> +    VuServer *server;
> +    VuVirtq *vq;
> +    VuVirtqElement *elem;
> +};
> +
> +static void coroutine_fn vu_block_virtio_process_req(void *opaque)
> +{
> +    struct req_data *data = opaque;
> +    VuServer *server = data->server;
> +    VuVirtq *vq = data->vq;
> +    VuVirtqElement *elem = data->elem;
> +    uint32_t type;
> +    VuBlockReq *req;
> +
> +    VuBlockDev *vdev_blk = get_vu_block_device_by_server(server);
> +    BlockBackend *backend = vdev_blk->backend;
> +
> +    struct iovec *in_iov = elem->in_sg;
> +    struct iovec *out_iov = elem->out_sg;
> +    unsigned in_num = elem->in_num;
> +    unsigned out_num = elem->out_num;
> +    /* refer to hw/block/virtio_blk.c */
> +    if (elem->out_num < 1 || elem->in_num < 1) {
> +        error_report("virtio-blk request missing headers");
> +        free(elem);
> +        return;
> +    }
> +
> +    req = g_new0(VuBlockReq, 1);
> +    req->server = server;
> +    req->vq = vq;
> +    req->elem = elem;
> +
> +    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req->out,
> +                            sizeof(req->out)) != sizeof(req->out))) {
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
> +    req->in = (void *)in_iov[in_num - 1].iov_base
> +              + in_iov[in_num - 1].iov_len
> +              - sizeof(struct virtio_blk_inhdr);
> +    iov_discard_back(in_iov, &in_num, sizeof(struct virtio_blk_inhdr));
> +
> +
> +    type = le32_to_cpu(req->out.type);
> +    switch (type & ~VIRTIO_BLK_T_BARRIER) {
> +    case VIRTIO_BLK_T_IN:
> +    case VIRTIO_BLK_T_OUT: {
> +        ssize_t ret = 0;
> +        bool is_write = type & VIRTIO_BLK_T_OUT;
> +        req->sector_num = le64_to_cpu(req->out.sector);
> +
> +        int64_t offset = req->sector_num * vdev_blk->blk_size;
> +        QEMUIOVector qiov;
> +        if (is_write) {
> +            qemu_iovec_init_external(&qiov, out_iov, out_num);
> +            ret = blk_co_pwritev(backend, offset, qiov.size,
> +                                 &qiov, 0);
> +        } else {
> +            qemu_iovec_init_external(&qiov, in_iov, in_num);
> +            ret = blk_co_preadv(backend, offset, qiov.size,
> +                                &qiov, 0);
> +        }
> +        if (ret >= 0) {
> +            req->in->status = VIRTIO_BLK_S_OK;
> +        } else {
> +            req->in->status = VIRTIO_BLK_S_IOERR;
> +        }
> +        break;
> +    }
> +    case VIRTIO_BLK_T_FLUSH:
> +        vu_block_flush(req);
> +        req->in->status = VIRTIO_BLK_S_OK;
> +        break;
> +    case VIRTIO_BLK_T_GET_ID: {
> +        size_t size = MIN(iov_size(&elem->in_sg[0], in_num),
> +                          VIRTIO_BLK_ID_BYTES);
> +        snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk_server");
> +        req->in->status = VIRTIO_BLK_S_OK;
> +        req->size = elem->in_sg[0].iov_len;
> +        break;
> +    }
> +    case VIRTIO_BLK_T_DISCARD:
> +    case VIRTIO_BLK_T_WRITE_ZEROES: {
> +        int rc;
> +        rc = vu_block_discard_write_zeroes(req, &elem->out_sg[1],
> +                                           out_num, type);
> +        if (rc == 0) {
> +            req->in->status = VIRTIO_BLK_S_OK;
> +        } else {
> +            req->in->status = VIRTIO_BLK_S_IOERR;
> +        }
> +        break;
> +    }
> +    default:
> +        req->in->status = VIRTIO_BLK_S_UNSUPP;
> +        break;
> +    }
> +
> +    vu_block_req_complete(req);
> +    return;
> +
> +err:
> +    free(elem);
> +    g_free(req);
> +    return;
> +}
> +
> +
> +
> +static void vu_block_process_vq(VuDev *vu_dev, int idx)
> +{
> +    VuServer *server;
> +    VuVirtq *vq;
> +
> +    server = container_of(vu_dev, VuServer, vu_dev);
> +    assert(server);
> +
> +    vq = vu_get_queue(vu_dev, idx);
> +    assert(vq);
> +    VuVirtqElement *elem;
> +    while (1) {
> +        elem = vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement) +
> +                                    sizeof(VuBlockReq));
> +        if (elem) {
> +            struct req_data req_data = {
> +                .server = server,
> +                .vq = vq,
> +                .elem = elem
> +            };

This is on the stack of the function.

> +            Coroutine *co = qemu_coroutine_create(vu_block_virtio_process_req,
> +                                                  &req_data);
> +            aio_co_enter(server->ioc->ctx, co);

Therefore, this code is only correct, if co accesses the data only while
the function has not returned yet.

This function is called in the context of vu_dispatch(), which in turn
is called from vu_client_trip(). So we already run in a coroutine. In
this case, aio_co_enter() only schedules co to run after the current
coroutine yields or terminates. In other words, this looks wrong to me
because req_data will be accessed when it's long out of scope.

I think we need to malloc it.

> +        } else {
> +            break;
> +        }
> +    }
> +}
> +
> +static void vu_block_queue_set_started(VuDev *vu_dev, int idx, bool started)
> +{
> +    VuVirtq *vq;
> +
> +    assert(vu_dev);
> +
> +    vq = vu_get_queue(vu_dev, idx);
> +    vu_set_queue_handler(vu_dev, vq, started ? vu_block_process_vq : NULL);
> +}
> +
> +static uint64_t vu_block_get_features(VuDev *dev)
> +{
> +    uint64_t features;
> +    VuServer *server = container_of(dev, VuServer, vu_dev);
> +    VuBlockDev *vdev_blk = get_vu_block_device_by_server(server);
> +    features = 1ull << VIRTIO_BLK_F_SIZE_MAX |
> +               1ull << VIRTIO_BLK_F_SEG_MAX |
> +               1ull << VIRTIO_BLK_F_TOPOLOGY |
> +               1ull << VIRTIO_BLK_F_BLK_SIZE |
> +               1ull << VIRTIO_BLK_F_FLUSH |
> +               1ull << VIRTIO_BLK_F_DISCARD |
> +               1ull << VIRTIO_BLK_F_WRITE_ZEROES |
> +               1ull << VIRTIO_BLK_F_CONFIG_WCE |
> +               1ull << VIRTIO_F_VERSION_1 |
> +               1ull << VIRTIO_RING_F_INDIRECT_DESC |
> +               1ull << VIRTIO_RING_F_EVENT_IDX |
> +               1ull << VHOST_USER_F_PROTOCOL_FEATURES;
> +
> +    if (!vdev_blk->writable) {
> +        features |= 1ull << VIRTIO_BLK_F_RO;
> +    }
> +
> +    return features;
> +}
> +
> +static uint64_t vu_block_get_protocol_features(VuDev *dev)
> +{
> +    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG |
> +           1ull << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD;
> +}
> +
> +static int
> +vu_block_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
> +{
> +    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
> +    VuBlockDev *vdev_blk = get_vu_block_device_by_server(server);
> +    memcpy(config, &vdev_blk->blkcfg, len);
> +
> +    return 0;
> +}
> +
> +static int
> +vu_block_set_config(VuDev *vu_dev, const uint8_t *data,
> +                    uint32_t offset, uint32_t size, uint32_t flags)
> +{
> +    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
> +    VuBlockDev *vdev_blk = get_vu_block_device_by_server(server);
> +    uint8_t wce;
> +
> +    /* don't support live migration */
> +    if (flags != VHOST_SET_CONFIG_TYPE_MASTER) {
> +        return -EINVAL;
> +    }
> +
> +
> +    if (offset != offsetof(struct virtio_blk_config, wce) ||
> +        size != 1) {
> +        return -EINVAL;
> +    }
> +
> +    wce = *data;
> +    if (wce == vdev_blk->blkcfg.wce) {
> +        /* Do nothing as same with old configuration */
> +        return 0;
> +    }

This check is unnecessary. Nothing bad happens if you set the same value
again.

> +    vdev_blk->blkcfg.wce = wce;
> +    blk_set_enable_write_cache(vdev_blk->backend, wce);
> +    return 0;
> +}
> +
> +
> +/*
> + * When the client disconnects, it sends a VHOST_USER_NONE request
> + * and vu_process_message will simple call exit which cause the VM
> + * to exit abruptly.
> + * To avoid this issue,  process VHOST_USER_NONE request ahead
> + * of vu_process_message.
> + *
> + */
> +static int vu_block_process_msg(VuDev *dev, VhostUserMsg *vmsg, int *do_reply)
> +{
> +    if (vmsg->request == VHOST_USER_NONE) {
> +        dev->panic(dev, "disconnect");
> +        return true;
> +    }
> +    return false;
> +}
> +
> +
> +static const VuDevIface vu_block_iface = {
> +    .get_features          = vu_block_get_features,
> +    .queue_set_started     = vu_block_queue_set_started,
> +    .get_protocol_features = vu_block_get_protocol_features,
> +    .get_config            = vu_block_get_config,
> +    .set_config            = vu_block_set_config,
> +    .process_msg           = vu_block_process_msg,
> +};
> +
> +static void blk_aio_attached(AioContext *ctx, void *opaque)
> +{
> +    VuBlockDev *vub_dev = opaque;
> +    aio_context_acquire(ctx);
> +    vhost_user_server_set_aio_context(ctx, &vub_dev->vu_server);
> +    aio_context_release(ctx);
> +}
> +
> +static void blk_aio_detach(void *opaque)
> +{
> +    VuBlockDev *vub_dev = opaque;
> +    AioContext *ctx = vub_dev->vu_server.ctx;
> +    aio_context_acquire(ctx);
> +    vhost_user_server_set_aio_context(NULL, &vub_dev->vu_server);
> +    aio_context_release(ctx);
> +}
> +
> +
> +static void
> +vu_block_initialize_config(BlockDriverState *bs,
> +                           struct virtio_blk_config *config, uint32_t blk_size)
> +{
> +    config->capacity = bdrv_getlength(bs) >> BDRV_SECTOR_BITS;
> +    config->blk_size = blk_size;
> +    config->size_max = 0;
> +    config->seg_max = 128 - 2;
> +    config->min_io_size = 1;
> +    config->opt_io_size = 1;
> +    config->num_queues = VHOST_USER_BLK_MAX_QUEUES;
> +    config->max_discard_sectors = 32768;
> +    config->max_discard_seg = 1;
> +    config->discard_sector_alignment = config->blk_size >> 9;
> +    config->max_write_zeroes_sectors = 32768;
> +    config->max_write_zeroes_seg = 1;
> +}
> +
> +
> +static VuBlockDev *vu_block_init(VuBlockDev *vu_block_device, Error **errp)
> +{
> +
> +    BlockBackend *blk;
> +    Error *local_error = NULL;
> +    const char *node_name = vu_block_device->node_name;
> +    bool writable = vu_block_device->writable;
> +    /*
> +     * Don't allow resize while the vhost user server is running,
> +     * otherwise we don't care what happens with the node.
> +     */

I think this comment belong to the blk_new() below where the shared
permissions are specified.

> +    uint64_t perm = BLK_PERM_CONSISTENT_READ;
> +    int ret;
> +
> +    AioContext *ctx;
> +
> +    BlockDriverState *bs = bdrv_lookup_bs(node_name, node_name, &local_error);
> +
> +    if (!bs) {
> +        error_propagate(errp, local_error);
> +        return NULL;
> +    }
> +
> +    if (bdrv_is_read_only(bs)) {
> +        writable = false;
> +    }
> +
> +    if (writable) {
> +        perm |= BLK_PERM_WRITE;
> +    }
> +
> +    ctx = bdrv_get_aio_context(bs);
> +    aio_context_acquire(ctx);
> +    bdrv_invalidate_cache(bs, NULL);
> +    aio_context_release(ctx);
> +
> +    blk = blk_new(bdrv_get_aio_context(bs), perm,
> +                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
> +                  BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
> +    ret = blk_insert_bs(blk, bs, errp);
> +
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    blk_set_enable_write_cache(blk, false);
> +
> +    blk_set_allow_aio_context_change(blk, true);
> +
> +    vu_block_device->blkcfg.wce = 0;
> +    vu_block_device->backend = blk;
> +    if (!vu_block_device->blk_size) {
> +        vu_block_device->blk_size = BDRV_SECTOR_SIZE;
> +    }
> +    vu_block_device->blkcfg.blk_size = vu_block_device->blk_size;
> +    blk_set_guest_block_size(blk, vu_block_device->blk_size);
> +    vu_block_initialize_config(bs, &vu_block_device->blkcfg,
> +                                   vu_block_device->blk_size);
> +    return vu_block_device;
> +
> +fail:
> +    blk_unref(blk);
> +    return NULL;
> +}
> +
> +static void vhost_user_blk_server_stop(VuBlockDev *vu_block_device)
> +{
> +    if (!vu_block_device) {
> +        return;
> +    }
> +
> +    vhost_user_server_stop(&vu_block_device->vu_server);
> +
> +    if (vu_block_device->backend) {
> +        blk_remove_aio_context_notifier(vu_block_device->backend, blk_aio_attached,
> +                                        blk_aio_detach, vu_block_device);
> +    }
> +
> +    blk_unref(vu_block_device->backend);
> +
> +}
> +
> +
> +static void vhost_user_blk_server_start(VuBlockDev *vu_block_device,
> +                                        Error **errp)
> +{
> +    SocketAddress *addr = vu_block_device->addr;
> +
> +    if (!vu_block_init(vu_block_device, errp)) {
> +        return;
> +    }
> +
> +    AioContext *ctx = bdrv_get_aio_context(blk_bs(vu_block_device->backend));

Please move declarations to the top of the function.

> +    if (!vhost_user_server_start(&vu_block_device->vu_server, addr, ctx,
> +                                 VHOST_USER_BLK_MAX_QUEUES,
> +                                 NULL, &vu_block_iface,
> +                                 errp)) {
> +        goto error;
> +    }
> +
> +    blk_add_aio_context_notifier(vu_block_device->backend, blk_aio_attached,
> +                                 blk_aio_detach, vu_block_device);
> +    vu_block_device->running = true;
> +    return;
> +
> + error:
> +    vhost_user_blk_server_stop(vu_block_device);

vu_block_device hasn't been fully set up. You need to undo only
vu_block_init(). You must not call vhost_user_server_stop().

> +}
> +
> +static bool vu_prop_modificable(VuBlockDev *vus, Error **errp)

The word is "modifiable".

> +{
> +    if (vus->running) {
> +            error_setg(errp, "The property can't be modified "
> +                    "while the server is running");
> +            return false;

The indentation is off here.

> +    }
> +    return true;
> +}
> +static void vu_set_node_name(Object *obj, const char *value, Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +
> +    if (vus->node_name) {
> +        if (!vu_prop_modificable(vus, errp)) {
> +            return;
> +        }

Why don't we need to check vu_prop_modificable() when the property isn't
set yet? I assume it's because the server can't even be started without
a node name, but it would be more obviously correct if the check were
done unconditionally.

> +        g_free(vus->node_name);
> +    }
> +
> +    vus->node_name = g_strdup(value);
> +}
> +
> +static char *vu_get_node_name(Object *obj, Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +    return g_strdup(vus->node_name);
> +}
> +
> +
> +static void vu_set_unix_socket(Object *obj, const char *value,
> +                               Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +
> +    if (vus->addr) {
> +        if (!vu_prop_modificable(vus, errp)) {
> +            return;
> +        }

Same here.

> +        g_free(vus->addr->u.q_unix.path);
> +        g_free(vus->addr);
> +    }
> +
> +    SocketAddress *addr = g_new0(SocketAddress, 1);
> +    addr->type = SOCKET_ADDRESS_TYPE_UNIX;
> +    addr->u.q_unix.path = g_strdup(value);
> +    vus->addr = addr;
> +}
> +
> +static char *vu_get_unix_socket(Object *obj, Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +    return g_strdup(vus->addr->u.q_unix.path);
> +}
> +
> +static bool vu_get_block_writable(Object *obj, Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +    return vus->writable;
> +}
> +
> +static void vu_set_block_writable(Object *obj, bool value, Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +
> +    if (!vu_prop_modificable(vus, errp)) {
> +            return;
> +    }
> +
> +    vus->writable = value;
> +}
> +
> +static void vu_get_blk_size(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +    uint32_t value = vus->blk_size;
> +
> +    visit_type_uint32(v, name, &value, errp);
> +}
> +
> +static void vu_set_blk_size(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +
> +    Error *local_err = NULL;
> +    uint32_t value;
> +
> +    if (!vu_prop_modificable(vus, errp)) {
> +            return;
> +    }
> +
> +    visit_type_uint32(v, name, &value, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    check_logical_block_size(object_get_typename(obj), name, value, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    vus->blk_size = value;
> +
> +out:
> +    error_propagate(errp, local_err);
> +    vus->blk_size = value;

Surely you don't want to set the value here, when some check failed?

> +}
> +
> +
> +static void vhost_user_blk_server_instance_finalize(Object *obj)
> +{
> +    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
> +
> +    vhost_user_blk_server_stop(vub);
> +}
> +
> +static void vhost_user_blk_server_complete(UserCreatable *obj, Error **errp)
> +{
> +    Error *local_error = NULL;
> +    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
> +
> +    vhost_user_blk_server_start(vub, &local_error);
> +
> +    if (local_error) {
> +        error_propagate(errp, local_error);
> +        return;
> +    }

If you don't do anything with local_error (which is named inconsistently
with local_err used above), you can just directly pass errp to
vhost_user_blk_server_start().

> +}
> +
> +static void vhost_user_blk_server_class_init(ObjectClass *klass,
> +                                             void *class_data)
> +{
> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
> +    ucc->complete = vhost_user_blk_server_complete;
> +
> +    object_class_property_add_bool(klass, "writable",
> +                                   vu_get_block_writable,
> +                                   vu_set_block_writable);
> +
> +    object_class_property_add_str(klass, "node-name",
> +                                  vu_get_node_name,
> +                                  vu_set_node_name);
> +
> +    object_class_property_add_str(klass, "unix-socket",
> +                                  vu_get_unix_socket,
> +                                  vu_set_unix_socket);
> +
> +    object_class_property_add(klass, "logical-block-size", "uint32",
> +                              vu_get_blk_size, vu_set_blk_size,
> +                              NULL, NULL);
> +}
> +
> +static const TypeInfo vhost_user_blk_server_info = {
> +    .name = TYPE_VHOST_USER_BLK_SERVER,
> +    .parent = TYPE_OBJECT,
> +    .instance_size = sizeof(VuBlockDev),
> +    .instance_finalize = vhost_user_blk_server_instance_finalize,
> +    .class_init = vhost_user_blk_server_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        {TYPE_USER_CREATABLE},
> +        {}
> +    },
> +};
> +
> +static void vhost_user_blk_server_register_types(void)
> +{
> +    type_register_static(&vhost_user_blk_server_info);
> +}
> +

Please remove the trailing empty line.

Compared to the last version that I reviewed, this seems to get the
architecture for concurrent requests right, which is an important
improvement. I feel we're getting quite close to mergable now.

Kevin


