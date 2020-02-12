Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AFEC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF1920714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="genqD3ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF1920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ojO-00078V-Ib
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j1ogm-0003uu-55
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j1ogj-0006OO-CY
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:52:12 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j1ogj-0006NA-2n
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:52:09 -0500
Received: by mail-pl1-x644.google.com with SMTP id y1so765669plp.7
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 01:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A7P1toJC9+7FjqzkLd4TC50F+zVWyY9EEQQLVrVA31U=;
 b=genqD3pszVIo6++mH3TSs331foPTvFjYWAyDmQDX3wUlsUwe9uKXAXWy98bPArJ3Ij
 6DT4E7v6k8BHuaSnMz18fs5zwdAoWrrTQahsSJNHl89XfhZ4ifwsbUqYOisT5lN06/zf
 HlxiggG0FusABUdSFH8QH0IrTvSiqQydXqc+slP2gxSGkaqcjOoE4qc1XIBw/GLA12Pj
 VA09Y1MwsJxec36B7fzBi9QonCHTSEDuAv+uy26qcRfcxEqZeBVAjiVi8XOf5fqtliTo
 tXP+aZPC5OBDkqURv4/UsMAAtnroEgZmWtA15NlVjmfpMGfrKuJTEFYcLpiHJTVRTc3M
 oTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A7P1toJC9+7FjqzkLd4TC50F+zVWyY9EEQQLVrVA31U=;
 b=nAXYY6RKjq14PH+qUVFfP+xVEptIVBtBf69sRZ1vBjpmhDppkyGKw9yjScURCtpa0R
 NS1mpDBSnMBAMny+vuVJi3eGNLrK9KROL94e3u5W9XhoKVLpElVVw6spXduI+i7XK8se
 N0ldVRqk34GkfpwAxcMegwIy6hKTvXh4F2oUSQggeb5GpHON6JlvehnK4DDYVFk5fDhF
 9jsOz351Q7bvJ/WoI1cqKdGD3AZPZmN+xLUUkDSNxGCtjTklg1iP9HjiY8cg9ub4kKC6
 65loEaou3FHTYK95uAynmsPc0r3vVvEOloRaHkyMpJL6zx9j0phNFQr1wiSSMDiDPbKh
 lTRQ==
X-Gm-Message-State: APjAAAUnxtc1rJesvrhs3qml6sy/jDya1b/UDvXObKAwKKGf7xJ/9P52
 G5Wvs6MFnGnBa+dBRrXpslHGHIZM
X-Google-Smtp-Source: APXvYqy1McGz0OQgKKGhMb9sW6bLXtQNxaAyNq0JNWQvIMsjqTUvXMbMF76Pn8tCfYz6zPewZBOA/Q==
X-Received: by 2002:a17:902:6bc3:: with SMTP id
 m3mr7711455plt.27.1581501127433; 
 Wed, 12 Feb 2020 01:52:07 -0800 (PST)
Received: from localhost.localdomain ([2402:9e80:0:1000::1:4ad5])
 by smtp.googlemail.com with ESMTPSA id o19sm6298595pjr.2.2020.02.12.01.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 01:52:06 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] vhost-user block device backend server
Date: Wed, 12 Feb 2020 17:51:35 +0800
Message-Id: <20200212095137.7977-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212095137.7977-1-coiby.xu@gmail.com>
References: <20200212095137.7977-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, Coiby Xu <coiby.xu@gmail.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By making use of libvhost, multiple block device drives can be exported
and each drive can serve multiple clients simultaneously.
Since vhost-user-server needs a block drive to be created first, delay
the creation of this object.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Makefile.target                  |   1 +
 backends/Makefile.objs           |   2 +
 backends/vhost-user-blk-server.c | 716 +++++++++++++++++++++++++++++++
 backends/vhost-user-blk-server.h |  21 +
 vl.c                             |   4 +
 5 files changed, 744 insertions(+)
 create mode 100644 backends/vhost-user-blk-server.c
 create mode 100644 backends/vhost-user-blk-server.h

diff --git a/Makefile.target b/Makefile.target
index 6e61f607b1..8c6c01eb3a 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -159,6 +159,7 @@ obj-y += monitor/
 obj-y += qapi/
 obj-y += memory.o
 obj-y += memory_mapping.o
+obj-$(CONFIG_LINUX) += ../contrib/libvhost-user/libvhost-user.o
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 28a847cd57..4e7be731e0 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -14,6 +14,8 @@ common-obj-y += cryptodev-vhost.o
 common-obj-$(CONFIG_VHOST_CRYPTO) += cryptodev-vhost-user.o
 endif
 
+common-obj-$(CONFIG_LINUX) += vhost-user-blk-server.o
+
 common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO)) += vhost-user.o
 
 common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
diff --git a/backends/vhost-user-blk-server.c b/backends/vhost-user-blk-server.c
new file mode 100644
index 0000000000..7293ad87be
--- /dev/null
+++ b/backends/vhost-user-blk-server.c
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
+    VuClient *client;
+    struct VuVirtq *vq;
+} VuBlockReq;
+
+
+static void vu_block_req_complete(VuBlockReq *req)
+{
+    VuDev *vu_dev = &req->client->parent;
+
+    /* IO size with 1 extra status byte */
+    vu_queue_push(vu_dev, req->vq, req->elem,
+                  req->size + 1);
+    vu_queue_notify(vu_dev, req->vq);
+
+    if (req->elem) {
+        free(req->elem);
+    }
+
+    g_free(req);
+}
+
+static VuBlockDev *get_vu_block_device_by_client(VuClient *client)
+{
+    return container_of(client->server->ptr_in_device, VuBlockDev, vu_server);
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
+        return -1;
+    }
+
+    VuBlockDev *vdev_blk = get_vu_block_device_by_client(req->client);
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
+    return -1;
+}
+
+
+static void coroutine_fn vu_block_flush(VuBlockReq *req)
+{
+    VuBlockDev *vdev_blk = get_vu_block_device_by_client(req->client);
+    BlockBackend *backend = vdev_blk->backend;
+    blk_co_flush(backend);
+}
+
+
+static int coroutine_fn vu_block_virtio_process_req(VuClient *client,
+                                                    VuVirtq *vq)
+{
+    VuDev *vu_dev = &client->parent;
+    VuVirtqElement *elem;
+    uint32_t type;
+    VuBlockReq *req;
+
+    VuBlockDev *vdev_blk = get_vu_block_device_by_client(client);
+    BlockBackend *backend = vdev_blk->backend;
+    elem = vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement) +
+                                    sizeof(VuBlockReq));
+    if (!elem) {
+        return -1;
+    }
+
+    struct iovec *in_iov = elem->in_sg;
+    struct iovec *out_iov = elem->out_sg;
+    unsigned in_num = elem->in_num;
+    unsigned out_num = elem->out_num;
+    /* refer to hw/block/virtio_blk.c */
+    if (elem->out_num < 1 || elem->in_num < 1) {
+        error_report("virtio-blk request missing headers");
+        free(elem);
+        return -1;
+    }
+
+    req = g_new0(VuBlockReq, 1);
+    req->client = client;
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
+                                 qiov, 0);
+        }
+        aio_wait_kick();
+        if (ret >= 0) {
+            req->in->status = VIRTIO_BLK_S_OK;
+        } else {
+            req->in->status = VIRTIO_BLK_S_IOERR;
+        }
+        vu_block_req_complete(req);
+        break;
+    }
+    case VIRTIO_BLK_T_FLUSH:
+        vu_block_flush(req);
+        req->in->status = VIRTIO_BLK_S_OK;
+        vu_block_req_complete(req);
+        break;
+    case VIRTIO_BLK_T_GET_ID: {
+        size_t size = MIN(iov_size(&elem->in_sg[0], in_num),
+                          VIRTIO_BLK_ID_BYTES);
+        snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk_server");
+        req->in->status = VIRTIO_BLK_S_OK;
+        req->size = elem->in_sg[0].iov_len;
+        vu_block_req_complete(req);
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
+        vu_block_req_complete(req);
+        break;
+    }
+    default:
+        req->in->status = VIRTIO_BLK_S_UNSUPP;
+        vu_block_req_complete(req);
+        break;
+    }
+
+    return 0;
+
+err:
+    free(elem);
+    g_free(req);
+    return -1;
+}
+
+
+static void vu_block_process_vq(VuDev *vu_dev, int idx)
+{
+    VuClient *client;
+    VuVirtq *vq;
+    int ret;
+
+    client = container_of(vu_dev, VuClient, parent);
+    assert(client);
+
+    vq = vu_get_queue(vu_dev, idx);
+    assert(vq);
+
+    while (1) {
+        ret = vu_block_virtio_process_req(client, vq);
+        if (ret) {
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
+    VuClient *client = container_of(dev, VuClient, parent);
+    VuBlockDev *vdev_blk = get_vu_block_device_by_client(client);
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
+    VuClient *client = container_of(vu_dev, VuClient, parent);
+    VuBlockDev *vdev_blk = get_vu_block_device_by_client(client);
+    memcpy(config, &vdev_blk->blkcfg, len);
+
+    return 0;
+}
+
+static int
+vu_block_set_config(VuDev *vu_dev, const uint8_t *data,
+                    uint32_t offset, uint32_t size, uint32_t flags)
+{
+    VuClient *client = container_of(vu_dev, VuClient, parent);
+    VuBlockDev *vdev_blk = get_vu_block_device_by_client(client);
+    uint8_t wce;
+
+    /* don't support live migration */
+    if (flags != VHOST_SET_CONFIG_TYPE_MASTER) {
+        return -1;
+    }
+
+
+    if (offset != offsetof(struct virtio_blk_config, wce) ||
+        size != 1) {
+        return -1;
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
+ * When the client disconnects, it send a VHOST_USER_NONE request
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
+    .get_features = vu_block_get_features,
+    .queue_set_started = vu_block_queue_set_started,
+    .get_protocol_features = vu_block_get_protocol_features,
+    .get_config = vu_block_get_config,
+    .set_config = vu_block_set_config,
+    .process_msg = vu_block_process_msg,
+};
+
+
+static void vu_block_free(VuBlockDev *vu_block_dev)
+{
+    if (!vu_block_dev) {
+        return;
+    }
+
+    blk_unref(vu_block_dev->backend);
+
+    if (vu_block_dev->next.tqe_circ.tql_prev) {
+        /*
+         * if vu_block_dev->next.tqe_circ.tql_prev = null,
+         * vu_block_dev hasn't been inserted into the queue and
+         * vu_block_free is called by obj->instance_finalize.
+         */
+        QTAILQ_REMOVE(&vu_block_devs, vu_block_dev, next);
+    }
+}
+
+static void blk_aio_attached(AioContext *ctx, void *opaque)
+{
+    VuBlockDev *vub_dev = opaque;
+    aio_context_acquire(ctx);
+    change_vu_context(ctx, vub_dev->vu_server);
+    aio_context_release(ctx);
+}
+
+
+static void blk_aio_detach(void *opaque)
+{
+    VuBlockDev *vub_dev = opaque;
+    AioContext *ctx = vub_dev->vu_server->ctx;
+    aio_context_acquire(ctx);
+    change_vu_context(NULL, vub_dev->vu_server);
+    aio_context_release(ctx);
+}
+
+
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
+    BlockDriverState *bs = bdrv_lookup_bs(node_name,
+                                          node_name,
+                                          &local_error);
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
+    vhost_user_server_stop(vu_block_device->vu_server);
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
+static VuBlockDev *vu_block_dev_find_by_unix_socket(const char *unix_socket)
+{
+    VuBlockDev *vu_block_device;
+    QTAILQ_FOREACH(vu_block_device, &vu_block_devs, next) {
+        if (strcmp(unix_socket, vu_block_device->unix_socket) == 0) {
+            return vu_block_device;
+        }
+    }
+
+    return NULL;
+}
+
+
+static void device_panic_notifier(VuClient *client)
+{
+    VuBlockDev *vdev_blk = get_vu_block_device_by_client(client);
+    if (vdev_blk->exit_when_panic) {
+        vdev_blk->vu_server->close = true;
+    }
+}
+
+static void vhost_user_blk_server_start(VuBlockDev *vu_block_device,
+                                        Error **errp)
+{
+
+    const char *name = vu_block_device->node_name;
+    char *unix_socket = vu_block_device->unix_socket;
+    if (vu_block_dev_find(name) ||
+        vu_block_dev_find_by_unix_socket(unix_socket)) {
+        error_setg(errp, "Vhost user server with name '%s' or "
+                   "with socket_path '%s' has already been started",
+                   name, unix_socket);
+        return;
+    }
+
+    if (!vu_block_init(vu_block_device, errp)) {
+        return;
+    }
+
+
+    AioContext *ctx = bdrv_get_aio_context(blk_bs(vu_block_device->backend));
+    VuServer *vu_server = vhost_user_server_start(VHOST_USER_BLK_MAX_QUEUES,
+                                                  unix_socket,
+                                                  ctx,
+                                                  &vu_block_device->vu_server,
+                                                  device_panic_notifier,
+                                                  &vu_block_iface,
+                                                  errp);
+
+    if (!vu_server) {
+        goto error;
+    }
+    vu_block_device->vu_server = vu_server;
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
+    if (vus->unix_socket) {
+        error_setg(errp, "unix_socket property already set");
+        return;
+    }
+
+    vus->unix_socket = g_strdup(value);
+}
+
+static char *vu_get_unix_socket(Object *obj, Error **errp)
+{
+    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
+    return g_strdup(vus->unix_socket);
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
+static void vhost_user_blk_server_instance_init(Object *obj)
+{
+
+    object_property_add_bool(obj, "writable",
+                             vu_get_block_writable,
+                             vu_set_block_writable, NULL);
+
+    object_property_add_str(obj, "node-name",
+                            vu_get_node_name,
+                            vu_set_node_name, NULL);
+
+    object_property_add_str(obj, "unix-socket",
+                            vu_get_unix_socket,
+                            vu_set_unix_socket, NULL);
+
+    object_property_add(obj, "blk-size", "uint32",
+                        vu_get_blk_size, vu_set_blk_size,
+                        NULL, NULL, NULL);
+
+}
+
+static void vhost_user_blk_server_instance_finalize(Object *obj)
+{
+    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
+
+    blk_remove_aio_context_notifier(vub->backend, blk_aio_attached,
+                                    blk_aio_detach, vub);
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
+}
+
+static const TypeInfo vhost_user_blk_server_info = {
+    .name = TYPE_VHOST_USER_BLK_SERVER,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(VuBlockDev),
+    .instance_init = vhost_user_blk_server_instance_init,
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
diff --git a/backends/vhost-user-blk-server.h b/backends/vhost-user-blk-server.h
new file mode 100644
index 0000000000..e572ae3801
--- /dev/null
+++ b/backends/vhost-user-blk-server.h
@@ -0,0 +1,21 @@
+#include "util/vhost-user-server.h"
+typedef struct VuBlockDev VuBlockDev;
+#define TYPE_VHOST_USER_BLK_SERVER "vhost-user-blk-server"
+#define VHOST_USER_BLK_SERVER(obj) \
+   OBJECT_CHECK(VuBlockDev, obj, TYPE_VHOST_USER_BLK_SERVER)
+
+/* vhost user block device */
+struct VuBlockDev {
+    Object parent_obj;
+    char *node_name;
+    char *unix_socket;
+    bool exit_when_panic;
+    AioContext *ctx;
+    VuServer *vu_server;
+    uint32_t blk_size;
+    BlockBackend *backend;
+    QIOChannelSocket *sioc;
+    QTAILQ_ENTRY(VuBlockDev) next;
+    struct virtio_blk_config blkcfg;
+    bool writable;
+};
diff --git a/vl.c b/vl.c
index 7dcb0879c4..d0d593c0d3 100644
--- a/vl.c
+++ b/vl.c
@@ -2572,6 +2572,10 @@ static bool object_create_initial(const char *type, QemuOpts *opts)
     }
 #endif
 
+    /* Reason: vhost-user-server property "name" */
+    if (g_str_equal(type, "vhost-user-blk-server")) {
+        return false;
+    }
     /*
      * Reason: filter-* property "netdev" etc.
      */
-- 
2.25.0


