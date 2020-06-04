Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4CFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 23:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AE22075B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 23:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSLSR1FX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AE22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgzR5-0005j0-61
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 19:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jgzPH-0002rM-Nj; Thu, 04 Jun 2020 19:36:19 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:33553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jgzPF-00059Z-TX; Thu, 04 Jun 2020 19:36:19 -0400
Received: by mail-pg1-x52f.google.com with SMTP id s10so4266190pgm.0;
 Thu, 04 Jun 2020 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QWfuvTPPET/oHCt+4cF7hseMNZxKRd3IcqLgERdaOdU=;
 b=JSLSR1FX9lHsoD/IJ7I0CtT6ec51eQ89ARj+Xpel6P5YGFQ6eX0Ytm33MomUFDPlJn
 bFk6t15UWv+4lqyF9t7JyEKaV041ZfTwvgTtb6tAhKqJtpGnjM6XfqOXXfJqdtwuwHib
 dnlt4LmFCQYa28buTylNHRpPrhjDWUxuxGGaCzEWVLDxq/tnlnQQIVnq7cH/b3c80EdE
 p/BzspWEDaRckEwSCBvXmlrQIDbjfoPLbYSK9RkJfdeP+RzbGXbG3EtiRJtjL0Kv95LM
 ijIq9ABQzNVBs4p06e1ALeFrGu5ilec08j00Xg110ofxZJrQVYYYQJfua5D2woM4x6bE
 BSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QWfuvTPPET/oHCt+4cF7hseMNZxKRd3IcqLgERdaOdU=;
 b=kCKb6YAZ7RvSqPTVXDmIA6Xq0JB7MytulishftWGeDJnm9uI/YNlpVHkkip4s+Gto/
 qMwvyhoolLMjktw95h8IJ2Ow2YNxb16POKv5Jhkku/C1rafYtUhFj4fUxUquTSiiJnMr
 BBn/NnILtBkzQzwtjzXvZFC0LeVHJoHjUpECbDin7O/mTo4boP9oajXL+PcMj5lbFPER
 IFoRBmOXbHDX2IBc9pDO15NLP4AYrTu9yXISU27D7YC8ycFnbTg5zyL0UedoG4c/Te9p
 Tt9A719+uccAznZI/PMLQlgXcSw+i4svPaEhGj/j+2FR+rkMZqllzXSysiO12ZwR/1Fm
 5bvA==
X-Gm-Message-State: AOAM530w/D69fyJzIi0IY7ys3kdp2hS4V1FJrUKplzzBBqWy1O5CL9rv
 fMM64Qxf5hqYL54hVx3ay12c2GFQmRbLz3O+
X-Google-Smtp-Source: ABdhPJx3y6g1Qx/HLIEjOX0p0KJt9wFN+J37YJtU4ZnzKE/LNve5nTZGeX+wsSlfdtCV44mZiHtcdw==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr6672221pgf.140.1591313775288; 
 Thu, 04 Jun 2020 16:36:15 -0700 (PDT)
Received: from localhost (tunnel570486-pt.tunnel.tserv25.sin1.ipv6.he.net.
 [2001:470:35:3d5::2])
 by smtp.gmail.com with ESMTPSA id i34sm6315880pje.10.2020.06.04.16.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 16:36:14 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 3/4] vhost-user block device backend server
Date: Fri,  5 Jun 2020 07:35:37 +0800
Message-Id: <20200604233538.256325-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604233538.256325-1-coiby.xu@gmail.com>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=coiby.xu@gmail.com; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, "open list:Block layer core" <qemu-block@nongnu.org>,
 Coiby Xu <coiby.xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
 bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By making use of libvhost-user, block device drive can be shared to
the connected vhost-user client. Only one client can connect to the
server one time.

Since vhost-user-server needs a block drive to be created first, delay
the creation of this object.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 block/Makefile.objs                  |   1 +
 block/export/vhost-user-blk-server.c | 716 +++++++++++++++++++++++++++
 block/export/vhost-user-blk-server.h |  34 ++
 softmmu/vl.c                         |   4 +
 4 files changed, 755 insertions(+)
 create mode 100644 block/export/vhost-user-blk-server.c
 create mode 100644 block/export/vhost-user-blk-server.h

diff --git a/block/Makefile.objs b/block/Makefile.objs
index 3635b6b4c1..0eb7eff470 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -24,6 +24,7 @@ block-obj-y += throttle-groups.o
 block-obj-$(CONFIG_LINUX) += nvme.o
 
 block-obj-y += nbd.o
+block-obj-$(CONFIG_LINUX) += export/vhost-user-blk-server.o ../contrib/libvhost-user/libvhost-user.o
 block-obj-$(CONFIG_SHEEPDOG) += sheepdog.o
 block-obj-$(CONFIG_LIBISCSI) += iscsi.o
 block-obj-$(if $(CONFIG_LIBISCSI),y,n) += iscsi-opts.o
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
new file mode 100644
index 0000000000..a9dec0625f
--- /dev/null
+++ b/block/export/vhost-user-blk-server.c
@@ -0,0 +1,716 @@
+/*
+ * Sharing QEMU block devices via vhost-user protocal
+ *
+ * Author: Coiby Xu <coiby.xu@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "block/block.h"
+#include "vhost-user-blk-server.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "sysemu/block-backend.h"
+
+enum {
+    VHOST_USER_BLK_MAX_QUEUES = 1,
+};
+struct virtio_blk_inhdr {
+    unsigned char status;
+};
+
+static QTAILQ_HEAD(, VuBlockDev) vu_block_devs =
+                                 QTAILQ_HEAD_INITIALIZER(vu_block_devs);
+
+
+typedef struct VuBlockReq {
+    VuVirtqElement *elem;
+    int64_t sector_num;
+    size_t size;
+    struct virtio_blk_inhdr *in;
+    struct virtio_blk_outhdr out;
+    VuServer *server;
+    struct VuVirtq *vq;
+} VuBlockReq;
+
+
+static void vu_block_req_complete(VuBlockReq *req)
+{
+    VuDev *vu_dev = &req->server->vu_dev;
+
+    /* IO size with 1 extra status byte */
+    vu_queue_push(vu_dev, req->vq, req->elem, req->size + 1);
+    vu_queue_notify(vu_dev, req->vq);
+
+    if (req->elem) {
+        free(req->elem);
+    }
+
+    g_free(req);
+}
+
+static VuBlockDev *get_vu_block_device_by_server(VuServer *server)
+{
+    return container_of(server, VuBlockDev, vu_server);
+}
+
+static int coroutine_fn
+vu_block_discard_write_zeroes(VuBlockReq *req, struct iovec *iov,
+                              uint32_t iovcnt, uint32_t type)
+{
+    struct virtio_blk_discard_write_zeroes desc;
+    ssize_t size = iov_to_buf(iov, iovcnt, 0, &desc, sizeof(desc));
+    if (unlikely(size != sizeof(desc))) {
+        error_report("Invalid size %ld, expect %ld", size, sizeof(desc));
+        return -EINVAL;
+    }
+
+    VuBlockDev *vdev_blk = get_vu_block_device_by_server(req->server);
+    uint64_t range[2] = { le64toh(desc.sector) << 9,
+                          le32toh(desc.num_sectors) << 9 };
+    if (type == VIRTIO_BLK_T_DISCARD) {
+        if (blk_co_pdiscard(vdev_blk->backend, range[0], range[1]) == 0) {
+            return 0;
+        }
+    } else if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
+        if (blk_co_pwrite_zeroes(vdev_blk->backend,
+                                 range[0], range[1], 0) == 0) {
+            return 0;
+        }
+    }
+
+    return -EINVAL;
+}
+
+
+static void coroutine_fn vu_block_flush(VuBlockReq *req)
+{
+    VuBlockDev *vdev_blk = get_vu_block_device_by_server(req->server);
+    BlockBackend *backend = vdev_blk->backend;
+    blk_co_flush(backend);
+}
+
+
+struct req_data {
+    VuServer *server;
+    VuVirtq *vq;
+    VuVirtqElement *elem;
+};
+
+static void coroutine_fn vu_block_virtio_process_req(void *opaque)
+{
+    struct req_data *data = opaque;
+    VuServer *server = data->server;
+    VuVirtq *vq = data->vq;
+    VuVirtqElement *elem = data->elem;
+    uint32_t type;
+    VuBlockReq *req;
+
+    VuBlockDev *vdev_blk = get_vu_block_device_by_server(server);
+    BlockBackend *backend = vdev_blk->backend;
+
+    struct iovec *in_iov = elem->in_sg;
+    struct iovec *out_iov = elem->out_sg;
+    unsigned in_num = elem->in_num;
+    unsigned out_num = elem->out_num;
+    /* refer to hw/block/virtio_blk.c */
+    if (elem->out_num < 1 || elem->in_num < 1) {
+        error_report("virtio-blk request missing headers");
+        free(elem);
+        return;
+    }
+
+    req = g_new0(VuBlockReq, 1);
+    req->server = server;
+    req->vq = vq;
+    req->elem = elem;
+
+    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req->out,
+                            sizeof(req->out)) != sizeof(req->out))) {
+        error_report("virtio-blk request outhdr too short");
+        goto err;
+    }
+
+    iov_discard_front(&out_iov, &out_num, sizeof(req->out));
+
+    if (in_iov[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
+        error_report("virtio-blk request inhdr too short");
+        goto err;
+    }
+
+    /* We always touch the last byte, so just see how big in_iov is.  */
+    req->in = (void *)in_iov[in_num - 1].iov_base
+              + in_iov[in_num - 1].iov_len
+              - sizeof(struct virtio_blk_inhdr);
+    iov_discard_back(in_iov, &in_num, sizeof(struct virtio_blk_inhdr));
+
+
+    type = le32toh(req->out.type);
+    switch (type & ~VIRTIO_BLK_T_BARRIER) {
+    case VIRTIO_BLK_T_IN:
+    case VIRTIO_BLK_T_OUT: {
+        ssize_t ret = 0;
+        bool is_write = type & VIRTIO_BLK_T_OUT;
+        req->sector_num = le64toh(req->out.sector);
+
+        int64_t offset = req->sector_num * vdev_blk->blk_size;
+        QEMUIOVector *qiov = g_new0(QEMUIOVector, 1);
+        if (is_write) {
+            qemu_iovec_init_external(qiov, out_iov, out_num);
+            ret = blk_co_pwritev(backend, offset, qiov->size,
+                                 qiov, 0);
+        } else {
+            qemu_iovec_init_external(qiov, in_iov, in_num);
+            ret = blk_co_preadv(backend, offset, qiov->size,
+                                qiov, 0);
+        }
+        if (ret >= 0) {
+            req->in->status = VIRTIO_BLK_S_OK;
+        } else {
+            req->in->status = VIRTIO_BLK_S_IOERR;
+        }
+        g_free(qiov);
+        break;
+    }
+    case VIRTIO_BLK_T_FLUSH:
+        vu_block_flush(req);
+        req->in->status = VIRTIO_BLK_S_OK;
+        break;
+    case VIRTIO_BLK_T_GET_ID: {
+        size_t size = MIN(iov_size(&elem->in_sg[0], in_num),
+                          VIRTIO_BLK_ID_BYTES);
+        snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk_server");
+        req->in->status = VIRTIO_BLK_S_OK;
+        req->size = elem->in_sg[0].iov_len;
+        break;
+    }
+    case VIRTIO_BLK_T_DISCARD:
+    case VIRTIO_BLK_T_WRITE_ZEROES: {
+        int rc;
+        rc = vu_block_discard_write_zeroes(req, &elem->out_sg[1],
+                                           out_num, type);
+        if (rc == 0) {
+            req->in->status = VIRTIO_BLK_S_OK;
+        } else {
+            req->in->status = VIRTIO_BLK_S_IOERR;
+        }
+        break;
+    }
+    default:
+        req->in->status = VIRTIO_BLK_S_UNSUPP;
+        break;
+    }
+
+    vu_block_req_complete(req);
+    return;
+
+err:
+    free(elem);
+    g_free(req);
+    return;
+}
+
+
+
+static void vu_block_process_vq(VuDev *vu_dev, int idx)
+{
+    VuServer *server;
+    VuVirtq *vq;
+
+    server = container_of(vu_dev, VuServer, vu_dev);
+    assert(server);
+
+    vq = vu_get_queue(vu_dev, idx);
+    assert(vq);
+    VuVirtqElement *elem;
+    while (1) {
+        elem = vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement) +
+                                    sizeof(VuBlockReq));
+        if (elem) {
+            struct req_data req_data = {
+                .server = server,
+                .vq = vq,
+                .elem = elem
+            };
+            Coroutine *co = qemu_coroutine_create(vu_block_virtio_process_req,
+                                                  &req_data);
+            aio_co_enter(server->ioc->ctx, co);
+        } else {
+            break;
+        }
+    }
+}
+
+static void vu_block_queue_set_started(VuDev *vu_dev, int idx, bool started)
+{
+    VuVirtq *vq;
+
+    assert(vu_dev);
+
+    vq = vu_get_queue(vu_dev, idx);
+    vu_set_queue_handler(vu_dev, vq, started ? vu_block_process_vq : NULL);
+}
+
+static uint64_t vu_block_get_features(VuDev *dev)
+{
+    uint64_t features;
+    VuServer *server = container_of(dev, VuServer, vu_dev);
+    VuBlockDev *vdev_blk = get_vu_block_device_by_server(server);
+    features = 1ull << VIRTIO_BLK_F_SIZE_MAX |
+               1ull << VIRTIO_BLK_F_SEG_MAX |
+               1ull << VIRTIO_BLK_F_TOPOLOGY |
+               1ull << VIRTIO_BLK_F_BLK_SIZE |
+               1ull << VIRTIO_BLK_F_FLUSH |
+               1ull << VIRTIO_BLK_F_DISCARD |
+               1ull << VIRTIO_BLK_F_WRITE_ZEROES |
+               1ull << VIRTIO_BLK_F_CONFIG_WCE |
+               1ull << VIRTIO_F_VERSION_1 |
+               1ull << VIRTIO_RING_F_INDIRECT_DESC |
+               1ull << VIRTIO_RING_F_EVENT_IDX |
+               1ull << VHOST_USER_F_PROTOCOL_FEATURES;
+
+    if (!vdev_blk->writable) {
+        features |= 1ull << VIRTIO_BLK_F_RO;
+    }
+
+    return features;
+}
+
+static uint64_t vu_block_get_protocol_features(VuDev *dev)
+{
+    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG |
+           1ull << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD;
+}
+
+static int
+vu_block_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
+{
+    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
+    VuBlockDev *vdev_blk = get_vu_block_device_by_server(server);
+    memcpy(config, &vdev_blk->blkcfg, len);
+
+    return 0;
+}
+
+static int
+vu_block_set_config(VuDev *vu_dev, const uint8_t *data,
+                    uint32_t offset, uint32_t size, uint32_t flags)
+{
+    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
+    VuBlockDev *vdev_blk = get_vu_block_device_by_server(server);
+    uint8_t wce;
+
+    /* don't support live migration */
+    if (flags != VHOST_SET_CONFIG_TYPE_MASTER) {
+        return -EINVAL;
+    }
+
+
+    if (offset != offsetof(struct virtio_blk_config, wce) ||
+        size != 1) {
+        return -EINVAL;
+    }
+
+    wce = *data;
+    if (wce == vdev_blk->blkcfg.wce) {
+        /* Do nothing as same with old configuration */
+        return 0;
+    }
+
+    vdev_blk->blkcfg.wce = wce;
+    blk_set_enable_write_cache(vdev_blk->backend, wce);
+    return 0;
+}
+
+
+/*
+ * When the client disconnects, it sends a VHOST_USER_NONE request
+ * and vu_process_message will simple call exit which cause the VM
+ * to exit abruptly.
+ * To avoid this issue,  process VHOST_USER_NONE request ahead
+ * of vu_process_message.
+ *
+ */
+static int vu_block_process_msg(VuDev *dev, VhostUserMsg *vmsg, int *do_reply)
+{
+    if (vmsg->request == VHOST_USER_NONE) {
+        dev->panic(dev, "disconnect");
+        return true;
+    }
+    return false;
+}
+
+
+static const VuDevIface vu_block_iface = {
+    .get_features          = vu_block_get_features,
+    .queue_set_started     = vu_block_queue_set_started,
+    .get_protocol_features = vu_block_get_protocol_features,
+    .get_config            = vu_block_get_config,
+    .set_config            = vu_block_set_config,
+    .process_msg           = vu_block_process_msg,
+};
+
+static void blk_aio_attached(AioContext *ctx, void *opaque)
+{
+    VuBlockDev *vub_dev = opaque;
+    aio_context_acquire(ctx);
+    vhost_user_server_set_aio_context(ctx, &vub_dev->vu_server);
+    aio_context_release(ctx);
+}
+
+static void blk_aio_detach(void *opaque)
+{
+    VuBlockDev *vub_dev = opaque;
+    AioContext *ctx = vub_dev->vu_server.ctx;
+    aio_context_acquire(ctx);
+    vhost_user_server_set_aio_context(NULL, &vub_dev->vu_server);
+    aio_context_release(ctx);
+}
+
+static void vu_block_free(VuBlockDev *vu_block_dev)
+{
+    if (!vu_block_dev) {
+        return;
+    }
+
+    if (vu_block_dev->backend) {
+        blk_remove_aio_context_notifier(vu_block_dev->backend, blk_aio_attached,
+                                        blk_aio_detach, vu_block_dev);
+    }
+
+    blk_unref(vu_block_dev->backend);
+
+    if (vu_block_dev->next.tqe_circ.tql_prev) {
+        /*
+         * remove vu_block_device from the list
+         *
+         * if vu_block_dev->next.tqe_circ.tql_prev = null,
+         * vu_block_dev hasn't been inserted into the queue and
+         * vu_block_free is called by obj->instance_finalize.
+         */
+        QTAILQ_REMOVE(&vu_block_devs, vu_block_dev, next);
+    }
+}
+
+static void
+vu_block_initialize_config(BlockDriverState *bs,
+                           struct virtio_blk_config *config, uint32_t blk_size)
+{
+    config->capacity = bdrv_getlength(bs) >> BDRV_SECTOR_BITS;
+    config->blk_size = blk_size;
+    config->size_max = 0;
+    config->seg_max = 128 - 2;
+    config->min_io_size = 1;
+    config->opt_io_size = 1;
+    config->num_queues = VHOST_USER_BLK_MAX_QUEUES;
+    config->max_discard_sectors = 32768;
+    config->max_discard_seg = 1;
+    config->discard_sector_alignment = config->blk_size >> 9;
+    config->max_write_zeroes_sectors = 32768;
+    config->max_write_zeroes_seg = 1;
+}
+
+
+static VuBlockDev *vu_block_init(VuBlockDev *vu_block_device, Error **errp)
+{
+
+    BlockBackend *blk;
+    Error *local_error = NULL;
+    const char *node_name = vu_block_device->node_name;
+    bool writable = vu_block_device->writable;
+    /*
+     * Don't allow resize while the vhost user server is running,
+     * otherwise we don't care what happens with the node.
+     */
+    uint64_t perm = BLK_PERM_CONSISTENT_READ;
+    int ret;
+
+    AioContext *ctx;
+
+    BlockDriverState *bs = bdrv_lookup_bs(node_name, node_name, &local_error);
+
+    if (!bs) {
+        error_propagate(errp, local_error);
+        return NULL;
+    }
+
+    if (bdrv_is_read_only(bs)) {
+        writable = false;
+    }
+
+    if (writable) {
+        perm |= BLK_PERM_WRITE;
+    }
+
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
+    bdrv_invalidate_cache(bs, NULL);
+    aio_context_release(ctx);
+
+    blk = blk_new(bdrv_get_aio_context(bs), perm,
+                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                  BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
+    ret = blk_insert_bs(blk, bs, errp);
+
+    if (ret < 0) {
+        goto fail;
+    }
+
+    blk_set_enable_write_cache(blk, false);
+
+    blk_set_allow_aio_context_change(blk, true);
+
+    vu_block_device->blkcfg.wce = 0;
+    vu_block_device->backend = blk;
+    if (!vu_block_device->blk_size) {
+        vu_block_device->blk_size = BDRV_SECTOR_SIZE;
+    }
+    vu_block_device->blkcfg.blk_size = vu_block_device->blk_size;
+    blk_set_guest_block_size(blk, vu_block_device->blk_size);
+    vu_block_initialize_config(bs, &vu_block_device->blkcfg,
+                                   vu_block_device->blk_size);
+    return vu_block_device;
+
+fail:
+    blk_unref(blk);
+    return NULL;
+}
+
+static void vhost_user_blk_server_free(VuBlockDev *vu_block_device)
+{
+    if (!vu_block_device) {
+        return;
+    }
+    vhost_user_server_stop(&vu_block_device->vu_server);
+    vu_block_free(vu_block_device);
+
+}
+
+/*
+ * A exported drive can serve multiple multiple clients simutateously,
+ * thus no need to export the same drive twice.
+ *
+ */
+static VuBlockDev *vu_block_dev_find(const char *node_name)
+{
+    VuBlockDev *vu_block_device;
+    QTAILQ_FOREACH(vu_block_device, &vu_block_devs, next) {
+        if (strcmp(node_name, vu_block_device->node_name) == 0) {
+            return vu_block_device;
+        }
+    }
+
+    return NULL;
+}
+
+
+static VuBlockDev
+*vu_block_dev_find_by_unix_socket(const char *unix_socket)
+{
+    VuBlockDev *vu_block_device;
+    QTAILQ_FOREACH(vu_block_device, &vu_block_devs, next) {
+        if (strcmp(unix_socket, vu_block_device->addr->u.q_unix.path) == 0) {
+            return vu_block_device;
+        }
+    }
+
+    return NULL;
+}
+
+
+static void vhost_user_blk_server_start(VuBlockDev *vu_block_device,
+                                        Error **errp)
+{
+
+    const char *name = vu_block_device->node_name;
+    SocketAddress *addr = vu_block_device->addr;
+    char *unix_socket = vu_block_device->addr->u.q_unix.path;
+
+    if (vu_block_dev_find(name)) {
+        error_setg(errp, "Vhost-user-blk server with node-name '%s' "
+                   "has already been started",
+                   name);
+        return;
+    }
+
+    if (vu_block_dev_find_by_unix_socket(unix_socket)) {
+        error_setg(errp, "Vhost-user-blk server with with socket_path '%s' "
+                   "has already been started", unix_socket);
+        return;
+    }
+
+    if (!vu_block_init(vu_block_device, errp)) {
+        return;
+    }
+
+
+    AioContext *ctx = bdrv_get_aio_context(blk_bs(vu_block_device->backend));
+
+    if (!vhost_user_server_start(VHOST_USER_BLK_MAX_QUEUES, addr, ctx,
+                                 &vu_block_device->vu_server,
+                                 NULL, &vu_block_iface,
+                                 errp)) {
+        goto error;
+    }
+
+    QTAILQ_INSERT_TAIL(&vu_block_devs, vu_block_device, next);
+    blk_add_aio_context_notifier(vu_block_device->backend, blk_aio_attached,
+                                 blk_aio_detach, vu_block_device);
+    return;
+
+ error:
+    vu_block_free(vu_block_device);
+}
+
+static void vu_set_node_name(Object *obj, const char *value, Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+
+    if (vus->node_name) {
+        error_setg(errp, "evdev property already set");
+        return;
+    }
+
+    vus->node_name = g_strdup(value);
+}
+
+static char *vu_get_node_name(Object *obj, Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+    return g_strdup(vus->node_name);
+}
+
+
+static void vu_set_unix_socket(Object *obj, const char *value,
+                               Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+
+    if (vus->addr) {
+        error_setg(errp, "unix_socket property already set");
+        return;
+    }
+
+    SocketAddress *addr = g_new0(SocketAddress, 1);
+    addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr->u.q_unix.path = g_strdup(value);
+    vus->addr = addr;
+}
+
+static char *vu_get_unix_socket(Object *obj, Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+    return g_strdup(vus->addr->u.q_unix.path);
+}
+
+static bool vu_get_block_writable(Object *obj, Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+    return vus->writable;
+}
+
+static void vu_set_block_writable(Object *obj, bool value, Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+
+    vus->writable = value;
+}
+
+static void vu_get_blk_size(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+    uint32_t value = vus->blk_size;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void vu_set_blk_size(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+
+    Error *local_err = NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    if (value != BDRV_SECTOR_SIZE && value != 4096) {
+        error_setg(&local_err,
+                   "Property '%s.%s' can only take value 512 or 4096",
+                   object_get_typename(obj), name);
+        goto out;
+    }
+
+    vus->blk_size = value;
+
+out:
+    error_propagate(errp, local_err);
+    vus->blk_size = value;
+}
+
+
+static void vhost_user_blk_server_instance_finalize(Object *obj)
+{
+    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
+
+    vhost_user_blk_server_free(vub);
+}
+
+static void vhost_user_blk_server_complete(UserCreatable *obj, Error **errp)
+{
+    Error *local_error = NULL;
+    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
+
+    vhost_user_blk_server_start(vub, &local_error);
+
+    if (local_error) {
+        error_propagate(errp, local_error);
+        return;
+    }
+}
+
+static void vhost_user_blk_server_class_init(ObjectClass *klass,
+                                             void *class_data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
+    ucc->complete = vhost_user_blk_server_complete;
+
+    object_class_property_add_bool(klass, "writable",
+                                   vu_get_block_writable,
+                                   vu_set_block_writable);
+
+    object_class_property_add_str(klass, "node-name",
+                                  vu_get_node_name,
+                                  vu_set_node_name);
+
+    object_class_property_add_str(klass, "unix-socket",
+                                  vu_get_unix_socket,
+                                  vu_set_unix_socket);
+
+    object_class_property_add(klass, "blk-size", "uint32",
+                              vu_get_blk_size, vu_set_blk_size,
+                              NULL, NULL);
+}
+
+static const TypeInfo vhost_user_blk_server_info = {
+    .name = TYPE_VHOST_USER_BLK_SERVER,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(VuBlockDev),
+    .instance_finalize = vhost_user_blk_server_instance_finalize,
+    .class_init = vhost_user_blk_server_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        {TYPE_USER_CREATABLE},
+        {}
+    },
+};
+
+static void vhost_user_blk_server_register_types(void)
+{
+    type_register_static(&vhost_user_blk_server_info);
+}
+
+type_init(vhost_user_blk_server_register_types)
diff --git a/block/export/vhost-user-blk-server.h b/block/export/vhost-user-blk-server.h
new file mode 100644
index 0000000000..6a393ed49d
--- /dev/null
+++ b/block/export/vhost-user-blk-server.h
@@ -0,0 +1,34 @@
+/*
+ * Sharing QEMU block devices via vhost-user protocal
+ *
+ * Author: Coiby Xu <coiby.xu@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef VHOST_USER_BLK_SERVER_H
+#define VHOST_USER_BLK_SERVER_H
+#include "util/vhost-user-server.h"
+
+typedef struct VuBlockDev VuBlockDev;
+#define TYPE_VHOST_USER_BLK_SERVER "vhost-user-blk-server"
+#define VHOST_USER_BLK_SERVER(obj) \
+   OBJECT_CHECK(VuBlockDev, obj, TYPE_VHOST_USER_BLK_SERVER)
+
+/* vhost user block device */
+struct VuBlockDev {
+    Object parent_obj;
+    char *node_name;
+    SocketAddress *addr;
+    AioContext *ctx;
+    VuServer vu_server;
+    uint32_t blk_size;
+    BlockBackend *backend;
+    QIOChannelSocket *sioc;
+    QTAILQ_ENTRY(VuBlockDev) next;
+    struct virtio_blk_config blkcfg;
+    bool writable;
+};
+
+#endif /* VHOST_USER_BLK_SERVER_H */
diff --git a/softmmu/vl.c b/softmmu/vl.c
index ae5451bc23..e4549871e1 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2520,6 +2520,10 @@ static bool object_create_initial(const char *type, QemuOpts *opts)
     }
 #endif
 
+    /* Reason: vhost-user-blk-server property "node-name" */
+    if (g_str_equal(type, "vhost-user-blk-server")) {
+        return false;
+    }
     /*
      * Reason: filter-* property "netdev" etc.
      */
-- 
2.26.2


