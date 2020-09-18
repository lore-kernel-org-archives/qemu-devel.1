Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4741C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28C22100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTjaI2Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28C22100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBXB-00070q-UO
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSw-0000X9-3A; Fri, 18 Sep 2020 04:10:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:34213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSt-0003IB-6X; Fri, 18 Sep 2020 04:09:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id r19so2605054pls.1;
 Fri, 18 Sep 2020 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sB5Ctj0l7wFscHPpq7CgzTDJHloGrNgiu9Jnr13cFTc=;
 b=GTjaI2XdqFZJ3E+80w3YCA291+Mo2B07evQ5AQ1Y5KxU9YjAETm4PFoZVa90gGaNZZ
 KOwx4QwEp0YJfCg2oAXvLc9pZs2hb2iTk8hJ1ANDRSK3OowYJfZy21T5UFv0pPVC9Gn0
 trvTWJG6IpPO+XdOX9xaBu4+XQLtAAEAYrBxYCcsmmdEk3qhL5mhlz38eK1fcCgo6/gi
 3QkTXq7iZlEVqOroY1oms0cuuA2LPqxhD6EEqF7aN/YuMnC3nUDBjn5d8uHQ5N9XTvkG
 JfPPjPb4HEC5RdyiOos7XJrasrCGKv+m4348oJWv6cgGEGvqlRLEJ2XGsAadEO1NjfPB
 POhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sB5Ctj0l7wFscHPpq7CgzTDJHloGrNgiu9Jnr13cFTc=;
 b=JVO86IoBRp9T2vz21x25ZJ9pag39Gw3PSJooH8BhRdywed/5fCMdsIhWipmGs2Zbca
 ea/k2pRzxj5rqKH6EnyAO02s/x70xVVAlE5FfQjMccAt9dKBfveTvA9ZVB2JEeaqQkrv
 c7S6jcalyI5qwpYX2U6iZeezEM86TTWxzICItd6A82FgWR2to8mh2nP11ilJcS6idfOz
 R3NP+cmfDy5ca1I+TZfySjV1kBHyVqHlCLSW7gOVOIHffpZtRQgw/o5E3qao1cB6um1/
 3nVd2TRjNCJG7YynBmRQVuF6HAES9i3DYlxYxVLYpkGc9vAoxUAgjLpNqJN+nJMu/yAi
 XD/Q==
X-Gm-Message-State: AOAM5319leFfAvI7fZyShq0EXmGxbyf7p2RcSG8J5gbxTwuCQMpI27QZ
 nE9qP1ZD+ttsZzdNl6fYZbqY1qMdZUn2wL58
X-Google-Smtp-Source: ABdhPJzxph+VihBiu9+J26jxS+nMt9FMgDDVxT0dxQGpol3wQ0BN+WFgudyGdpbPcCaKoZwYq8RKYQ==
X-Received: by 2002:a17:90a:eac5:: with SMTP id
 ev5mr11404177pjb.200.1600416592959; 
 Fri, 18 Sep 2020 01:09:52 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id v204sm2177314pfc.10.2020.09.18.01.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:09:52 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 5/7] block/export: vhost-user block device backend server
Date: Fri, 18 Sep 2020 16:09:10 +0800
Message-Id: <20200918080912.321299-6-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918080912.321299-1-coiby.xu@gmail.com>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Coiby Xu <Coiby.Xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
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

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 block/export/vhost-user-blk-server.c | 661 +++++++++++++++++++++++++++
 block/export/vhost-user-blk-server.h |  36 ++
 block/meson.build                    |   1 +
 softmmu/vl.c                         |   4 +
 4 files changed, 702 insertions(+)
 create mode 100644 block/export/vhost-user-blk-server.c
 create mode 100644 block/export/vhost-user-blk-server.h

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
new file mode 100644
index 0000000000..ec78130f09
--- /dev/null
+++ b/block/export/vhost-user-blk-server.c
@@ -0,0 +1,661 @@
+/*
+ * Sharing QEMU block devices via vhost-user protocal
+ *
+ * Parts of the code based on nbd/server.c.
+ *
+ * Copyright (c) Coiby Xu <coiby.xu@gmail.com>.
+ * Copyright (c) 2020 Red Hat, Inc.
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
+#include "util/block-helpers.h"
+
+enum {
+    VHOST_USER_BLK_MAX_QUEUES = 1,
+};
+struct virtio_blk_inhdr {
+    unsigned char status;
+};
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
+    uint64_t range[2] = { le64_to_cpu(desc.sector) << 9,
+                          le32_to_cpu(desc.num_sectors) << 9 };
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
+static void coroutine_fn vu_block_flush(VuBlockReq *req)
+{
+    VuBlockDev *vdev_blk = get_vu_block_device_by_server(req->server);
+    BlockBackend *backend = vdev_blk->backend;
+    blk_co_flush(backend);
+}
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
+    type = le32_to_cpu(req->out.type);
+    switch (type & ~VIRTIO_BLK_T_BARRIER) {
+    case VIRTIO_BLK_T_IN:
+    case VIRTIO_BLK_T_OUT: {
+        ssize_t ret = 0;
+        bool is_write = type & VIRTIO_BLK_T_OUT;
+        req->sector_num = le64_to_cpu(req->out.sector);
+
+        int64_t offset = req->sector_num * vdev_blk->blk_size;
+        QEMUIOVector qiov;
+        if (is_write) {
+            qemu_iovec_init_external(&qiov, out_iov, out_num);
+            ret = blk_co_pwritev(backend, offset, qiov.size,
+                                 &qiov, 0);
+        } else {
+            qemu_iovec_init_external(&qiov, in_iov, in_num);
+            ret = blk_co_preadv(backend, offset, qiov.size,
+                                &qiov, 0);
+        }
+        if (ret >= 0) {
+            req->in->status = VIRTIO_BLK_S_OK;
+        } else {
+            req->in->status = VIRTIO_BLK_S_IOERR;
+        }
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
+static void vu_block_process_vq(VuDev *vu_dev, int idx)
+{
+    VuServer *server;
+    VuVirtq *vq;
+    struct req_data *req_data;
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
+            req_data = g_new0(struct req_data, 1);
+            req_data->server = server;
+            req_data->vq = vq;
+            req_data->elem = elem;
+            Coroutine *co = qemu_coroutine_create(vu_block_virtio_process_req,
+                                                  req_data);
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
+    if (offset != offsetof(struct virtio_blk_config, wce) ||
+        size != 1) {
+        return -EINVAL;
+    }
+
+    wce = *data;
+    vdev_blk->blkcfg.wce = wce;
+    blk_set_enable_write_cache(vdev_blk->backend, wce);
+    return 0;
+}
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
+    vhost_user_server_set_aio_context(&vub_dev->vu_server, ctx);
+    aio_context_release(ctx);
+}
+
+static void blk_aio_detach(void *opaque)
+{
+    VuBlockDev *vub_dev = opaque;
+    AioContext *ctx = vub_dev->vu_server.ctx;
+    aio_context_acquire(ctx);
+    vhost_user_server_set_aio_context(&vub_dev->vu_server, NULL);
+    aio_context_release(ctx);
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
+static VuBlockDev *vu_block_init(VuBlockDev *vu_block_device, Error **errp)
+{
+
+    BlockBackend *blk;
+    Error *local_error = NULL;
+    const char *node_name = vu_block_device->node_name;
+    bool writable = vu_block_device->writable;
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
+    /*
+     * Don't allow resize while the vhost user server is running,
+     * otherwise we don't care what happens with the node.
+     */
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
+static void vu_block_deinit(VuBlockDev *vu_block_device)
+{
+    if (vu_block_device->backend) {
+        blk_remove_aio_context_notifier(vu_block_device->backend, blk_aio_attached,
+                                        blk_aio_detach, vu_block_device);
+    }
+
+    blk_unref(vu_block_device->backend);
+}
+
+static void vhost_user_blk_server_stop(VuBlockDev *vu_block_device)
+{
+    vhost_user_server_stop(&vu_block_device->vu_server);
+    vu_block_deinit(vu_block_device);
+}
+
+static void vhost_user_blk_server_start(VuBlockDev *vu_block_device,
+                                        Error **errp)
+{
+    AioContext *ctx;
+    SocketAddress *addr = vu_block_device->addr;
+
+    if (!vu_block_init(vu_block_device, errp)) {
+        return;
+    }
+
+    ctx = bdrv_get_aio_context(blk_bs(vu_block_device->backend));
+
+    if (!vhost_user_server_start(&vu_block_device->vu_server, addr, ctx,
+                                 VHOST_USER_BLK_MAX_QUEUES,
+                                 NULL, &vu_block_iface,
+                                 errp)) {
+        goto error;
+    }
+
+    blk_add_aio_context_notifier(vu_block_device->backend, blk_aio_attached,
+                                 blk_aio_detach, vu_block_device);
+    vu_block_device->running = true;
+    return;
+
+ error:
+    vu_block_deinit(vu_block_device);
+}
+
+static bool vu_prop_modifiable(VuBlockDev *vus, Error **errp)
+{
+    if (vus->running) {
+            error_setg(errp, "The property can't be modified "
+                       "while the server is running");
+            return false;
+    }
+    return true;
+}
+
+static void vu_set_node_name(Object *obj, const char *value, Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+
+    if (!vu_prop_modifiable(vus, errp)) {
+        return;
+    }
+
+    if (vus->node_name) {
+        g_free(vus->node_name);
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
+static void free_socket_addr(SocketAddress *addr)
+{
+        g_free(addr->u.q_unix.path);
+        g_free(addr);
+}
+
+static void vu_set_unix_socket(Object *obj, const char *value,
+                               Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+
+    if (!vu_prop_modifiable(vus, errp)) {
+        return;
+    }
+
+    if (vus->addr) {
+        free_socket_addr(vus->addr);
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
+    if (!vu_prop_modifiable(vus, errp)) {
+            return;
+    }
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
+    if (!vu_prop_modifiable(vus, errp)) {
+            return;
+    }
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    check_block_size(object_get_typename(obj), name, value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    vus->blk_size = value;
+
+out:
+    error_propagate(errp, local_err);
+}
+
+static void vhost_user_blk_server_instance_finalize(Object *obj)
+{
+    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
+
+    vhost_user_blk_server_stop(vub);
+
+    /*
+     * Unlike object_property_add_str, object_class_property_add_str
+     * doesn't have a release method. Thus manual memory freeing is
+     * needed.
+     */
+    free_socket_addr(vub->addr);
+    g_free(vub->node_name);
+}
+
+static void vhost_user_blk_server_complete(UserCreatable *obj, Error **errp)
+{
+    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
+
+    vhost_user_blk_server_start(vub, errp);
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
+    object_class_property_add(klass, "logical-block-size", "uint32",
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
index 0000000000..f06f37c4c8
--- /dev/null
+++ b/block/export/vhost-user-blk-server.h
@@ -0,0 +1,36 @@
+/*
+ * Sharing QEMU block devices via vhost-user protocal
+ *
+ * Copyright (c) Coiby Xu <coiby.xu@gmail.com>.
+ * Copyright (c) 2020 Red Hat, Inc.
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
+    bool running;
+    uint32_t blk_size;
+    BlockBackend *backend;
+    QIOChannelSocket *sioc;
+    QTAILQ_ENTRY(VuBlockDev) next;
+    struct virtio_blk_config blkcfg;
+    bool writable;
+};
+
+#endif /* VHOST_USER_BLK_SERVER_H */
diff --git a/block/meson.build b/block/meson.build
index a3e56b7cd1..6c7d9400e4 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -60,6 +60,7 @@ block_ss.add(when: 'CONFIG_WIN32', if_true: files('file-win32.c', 'win32-aio.c')
 block_ss.add(when: 'CONFIG_POSIX', if_true: [files('file-posix.c'), coref, iokit])
 block_ss.add(when: 'CONFIG_LIBISCSI', if_true: files('iscsi-opts.c'))
 block_ss.add(when: 'CONFIG_LINUX', if_true: files('nvme.c'))
+block_ss.add(when: 'CONFIG_LINUX', if_true: files('export/vhost-user-blk-server.c', '../contrib/libvhost-user/libvhost-user.c'))
 block_ss.add(when: 'CONFIG_REPLICATION', if_true: files('replication.c'))
 block_ss.add(when: 'CONFIG_SHEEPDOG', if_true: files('sheepdog.c'))
 block_ss.add(when: ['CONFIG_LINUX_AIO', libaio], if_true: files('linux-aio.c'))
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f7b103467c..5128b81d40 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2537,6 +2537,10 @@ static bool object_create_initial(const char *type, QemuOpts *opts)
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
2.28.0


