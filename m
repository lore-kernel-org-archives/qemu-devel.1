Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64799C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1E52075E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Euuv4+u0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1E52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWi3K-0002O9-3G
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1iWi0y-0000SU-24
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1iWi0v-0006fC-36
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:28:28 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1iWi0u-0006el-Ls
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:28:25 -0500
Received: by mail-lj1-x242.google.com with SMTP id y23so19148418ljh.10
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=rTF+oGjcIQb0bTzLutCAxtBmDldPTXcEHzEDYnLObM8=;
 b=Euuv4+u0DAEaPbvPj4401J9A3iyBBfYfaX8V2t1KtSVWGML50Mo+A6EJIL4htoJh8J
 VsOFoZHPFpL5vcSUEBLtMijaqo1AZkEuG4uAmcMFdVREaOusf0mSXMVEYSn0nwVVEn69
 BRUOusjyVN5em9cLvyMq5RIVYYzrKHI1NQIHLkkL9oc6E2zkVCvy/SFdae63Czihoofe
 luHK59u88DptYlf/S74wnHP7sVfqla91NVZpzr1eQthFXyMoiRtEkHXPvi+HM1aG1LBR
 +0/5WVghir+KQPVqL6gQR+pKSOcUE32UujltVGW3KdkeyOGToS1KsCwfX7QYIAgg+6lc
 JEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=rTF+oGjcIQb0bTzLutCAxtBmDldPTXcEHzEDYnLObM8=;
 b=GoL+ueCGWSxH6oE9iG88/oxyqMylTxaXKkGwLtmiQt2q0tDZxKlK4sVHQjx8NH14GU
 VDv7OeAOXJgh7IbzgMHT2uIOqWO1A6j2C0H088gxLDqr2msVrtpYU0mrjL13E22zy26u
 y0NhKVUmZ8JR9s9VmKvJT9qHUYWvcfp+Cx8VmakwBAyPBPWhJC0b9TnbZ/cAvSyU+pKy
 TxBUFZOUY9mkYn7GrUiaISU7e2BkVtDLD6+hWLY10GO7BRa1FD+nwqK5n6CLUOzP7ujp
 MpJm/APKq0osXtc0Wt0S2Ih+8HZTTQQDOeDjSfv1igAy7HK035NDZqq+9zQznSB1NCoW
 GbTQ==
X-Gm-Message-State: APjAAAX3oOw9Yax4PQgRumCjkOiRadUgelmh60D9vKfeB19M/ZZYiayr
 K5aYsoz3/BYTRHSvfOvaXT9jDHr8Lxm1ZMzRz+oakekN
X-Google-Smtp-Source: APXvYqwNfQjgw66ZVcNELk2OuPdWEJvQCrptZIh2ZRrOqr8Xgem4wAd08B88sbqPhgzmRQRfEZC8F54ygmoBK2EBDxo=
X-Received: by 2002:a2e:b0d3:: with SMTP id g19mr20765043ljl.135.1574087301798; 
 Mon, 18 Nov 2019 06:28:21 -0800 (PST)
MIME-Version: 1.0
From: Coiby Xu <coiby.xu@gmail.com>
Date: Mon, 18 Nov 2019 22:27:28 +0800
Message-ID: <CAJAkqrWm28qXtsFmaENAcsDNQV7gE=sd+YyA5ADmm2Vo9DKrUQ@mail.gmail.com>
Subject: [RFC] Implementing vhost-user-blk device backend
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Kevin Wolf <kwolf@redhat.com>, Bharat Singh <bharatlkmlkvm@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

This is an implementation of vhost-user-blk device backend by
following https://wiki.qemu.org/Google_Summer_of_Code_2019#vhost-user-blk_device_backend.
raw/qcow2 disk images can now be shared via vhost user protocol. In
this way, it could provide better performance than QEMU's existing NBD
support.

Currently, there are two limitations on this implmention. The first is
the backend can only serve one client at one time. This limitation
will be removed soon. The other limitation is sharing disk images can
only be done in the QEMU's monitor, but a tool similar to qemu-nbd
could be provided if necessary.

`make check` shows the patch doesn't fail exiting tests. I've only
manually tested the code by launching two VMs and haven't written the
tests yet. I post the patch here hoping I can get any feedback earlier
as suggested by Stefan.

The usage is very similar to sharing disk images via NBD protocol.
After launching VM, for example,

  qemu-system-x86_64 -drive file=dpdk.img,format=raw,if=none,id=disk
-device ide-hd,drive=disk -m 256 -enable-kvm

in the QEMU monitor, start vhost-user-blk device backend by
vhost_user_server_start,

(qemu) info block
disk (#block191): dpdk_1.img (raw)
    Attached to:      /machine/peripheral-anon/device[0]
    Cache mode:       writeback
(qemu) help vhost_user_server_start
vhost_user_server_start vhost_user_server_start [-w] unix_socket name
-- serve block devices via vhost user protocol
(qemu) vhost_user_server_start /tmp/vhost-user-blk_vhost.socket disk

If the block device can be shared with write permission, use the `-w`
option. Then a vhost user client can connect to this backend. For
example, the exported disk image could be shared with another VM,

  qemu-system-x86_64 -drive file=dpdk.img,format=raw,if=none,id=disk
-device ide-hd,drive=disk,bootindex=0 -m 256 -enable-kvm -object
memory-backend-memfd,id=mem,size=256M,share=on -numa node,memdev=mem
-chardev socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket -device
vhost-user-blk-pci,id=blk0,chardev=char1

The backend can be stopped by vhost_user_server_stop in the QEMU monitor.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Makefile.objs         |   2 +-
 Makefile.target       |   1 +
 blockdev-vhost.c      | 664 ++++++++++++++++++++++++++++++++++++++++++
 hmp-commands.hx       |  27 ++
 include/block/vhost.h |   5 +
 include/monitor/hmp.h |   2 +
 monitor/hmp-cmds.c    |  33 +++
 7 files changed, 733 insertions(+), 1 deletion(-)
 create mode 100644 blockdev-vhost.c
 create mode 100644 include/block/vhost.h

diff --git a/Makefile.objs b/Makefile.objs
index 11ba1a36bd..df15c58f09 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -43,7 +43,7 @@ io-obj-y = io/
 # single QEMU executable should support all CPUs and machines.

 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = blockdev.o blockdev-nbd.o block/
+common-obj-y = blockdev.o blockdev-nbd.o blockdev-vhost.o block/
 common-obj-y += bootdevice.o iothread.o
 common-obj-y += dump/
 common-obj-y += job-qmp.o
diff --git a/Makefile.target b/Makefile.target
index 24d79d26eb..a4c8b581ff 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -159,6 +159,7 @@ obj-y += monitor/
 obj-y += qapi/
 obj-y += memory.o
 obj-y += memory_mapping.o
+obj-y += ../contrib/libvhost-user/libvhost-user.o
../contrib/libvhost-user/libvhost-user-glib.o
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)

diff --git a/blockdev-vhost.c b/blockdev-vhost.c
new file mode 100644
index 0000000000..268e062388
--- /dev/null
+++ b/blockdev-vhost.c
@@ -0,0 +1,664 @@
+#include "qemu/osdep.h"
+#include "block/vhost.h"
+#include "qapi/error.h"
+#include "qapi/qapi-types-sockets.h"
+#include "io/net-listener.h"
+
+#include "sysemu/block-backend.h"
+#include "qemu/main-loop.h"
+
+#include "qemu/units.h"
+
+#include "block/block.h"
+
+#include "standard-headers/linux/virtio_blk.h"
+#include "contrib/libvhost-user/libvhost-user-glib.h"
+#include "contrib/libvhost-user/libvhost-user.h"
+
+
+enum {
+    VHOST_USER_BLK_MAX_QUEUES = 8,
+};
+
+struct virtio_blk_inhdr {
+    unsigned char status;
+};
+
+/* vhost user block device */
+typedef struct VubDev {
+    VugDev parent;
+    const char *name;
+    BlockBackend *blk;
+    QIONetListener *listener;
+    QIOChannelSocket *sioc;
+    struct virtio_blk_config blkcfg;
+    bool enable_ro;
+} VubDev;
+
+
+typedef struct VubReq {
+    VuVirtqElement *elem;
+    int64_t sector_num;
+    size_t size;
+    struct virtio_blk_inhdr *in;
+    struct virtio_blk_outhdr *out;
+    VubDev *vdev_blk;
+    struct VuVirtq *vq;
+} VubReq;
+
+static size_t vub_iov_to_buf(const struct iovec *iov,
+                             const unsigned int iov_cnt, void *buf)
+{
+    size_t len;
+    unsigned int i;
+
+    len = 0;
+    for (i = 0; i < iov_cnt; i++) {
+        memcpy(buf + len,  iov[i].iov_base, iov[i].iov_len);
+        len += iov[i].iov_len;
+    }
+    return len;
+}
+
+static  VubDev *vub_device;
+
+static void close_client(void)
+{
+    /*
+     * unmap memory, so the memory can be re-used
+     * remove GSrouce (vug_deinit will also unref GSource)
+     */
+    vu_deinit(&vub_device->parent.parent);
+    g_source_destroy(vub_device->parent.src);
+    vug_deinit(&vub_device->parent);
+    vub_device->sioc = NULL;
+
+}
+static void vub_panic_cb(VuDev *vu_dev, const char *buf)
+{
+    if (buf) {
+        g_warning("vu_panic: %s", buf);
+    }
+    close_client();
+}
+
+
+static void vub_req_complete(VubReq *req)
+{
+    VugDev *gdev = &req->vdev_blk->parent;
+    VuDev *vu_dev = &gdev->parent;
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
+
+
+static int
+vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
+                         uint32_t type)
+{
+    struct virtio_blk_discard_write_zeroes *desc;
+    ssize_t size;
+    void *buf;
+
+    size = iov_size(iov, iovcnt);
+    if (size != sizeof(*desc)) {
+        fprintf(stderr, "Invalid size %ld, expect %ld\n", size, sizeof(*desc));
+        return -1;
+    }
+    buf = g_new0(char, size);
+    vub_iov_to_buf(iov, iovcnt, buf);
+
+    #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
+    VubDev *vdev_blk = req->vdev_blk;
+    desc = (struct virtio_blk_discard_write_zeroes *)buf;
+    uint64_t range[2] = { le64toh(desc->sector) << 9,
+                          le32toh(desc->num_sectors) << 9 };
+    if (type == VIRTIO_BLK_T_DISCARD) {
+        if (blk_pdiscard(vdev_blk->blk, range[0], range[1]) == 0) {
+            g_free(buf);
+            return 0;
+        }
+    } else if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
+        if (blk_pwrite_zeroes(vdev_blk->blk, range[0], range[1]) == 0) {
+            g_free(buf);
+            return 0;
+        }
+    }
+    #endif
+
+    g_free(buf);
+    return -1;
+}
+
+
+static void
+vub_flush(VubReq *req)
+{
+    VubDev *vdev_blk = req->vdev_blk;
+    blk_co_flush(vdev_blk->blk);
+}
+
+
+#define NOT_DONE 0x7fffffff /* used while emulated sync operation in
progress */
+typedef struct BlkRwCo {
+    BlockBackend *blk;
+    int64_t offset;
+    void *iobuf;
+    int ret;
+    BdrvRequestFlags flags;
+} BlkRwCo;
+
+static void blk_read_entry(void *opaque)
+{
+    BlkRwCo *rwco = opaque;
+    QEMUIOVector *qiov = rwco->iobuf;
+
+    rwco->ret = blk_co_preadv(rwco->blk, rwco->offset, qiov->size,
+                              qiov, rwco->flags);
+    aio_wait_kick();
+}
+
+
+static void blk_write_entry(void *opaque)
+{
+    BlkRwCo *rwco = opaque;
+    QEMUIOVector *qiov = rwco->iobuf;
+
+    rwco->ret = blk_co_pwritev(rwco->blk, rwco->offset, qiov->size,
+                              qiov, rwco->flags);
+    aio_wait_kick();
+}
+
+
+static int blk_prw(BlockBackend *blk, QEMUIOVector *qiov, int64_t offset,
+                   CoroutineEntry co_entry, BdrvRequestFlags flags)
+{
+
+    BlkRwCo rwco = {
+        .blk    = blk,
+        .offset = offset,
+        .iobuf  = qiov,
+        .flags  = flags,
+        .ret    = NOT_DONE,
+    };
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        co_entry(&rwco);
+    } else {
+        Coroutine *co = qemu_coroutine_create(co_entry, &rwco);
+        bdrv_coroutine_enter(blk_bs(blk), co);
+        BDRV_POLL_WHILE(blk_bs(blk), rwco.ret == NOT_DONE);
+    }
+
+    return rwco.ret;
+}
+
+
+static ssize_t
+vub_rwv(VubReq *req, struct iovec *iov,
+        uint32_t iovcnt,
+        CoroutineEntry co_entry)
+{
+    VubDev *vdev_blk = req->vdev_blk;
+    ssize_t rc;
+
+    if (!iovcnt) {
+        fprintf(stderr, "Invalid Read/Write IOV count\n");
+        return -1;
+    }
+
+    int64_t offset = req->sector_num * 512;
+    QEMUIOVector *qiov = g_new0(QEMUIOVector, 1);
+    qemu_iovec_init_external(qiov, iov, iovcnt);
+    rc = blk_prw(vdev_blk->blk, qiov, offset, co_entry, 0);
+
+    req->size = iov_size(iov, iovcnt);
+    if (rc < 0) {
+        fprintf(stderr, "%s, Sector %"PRIu64", Size %lu failed with %s\n",
+                vdev_blk->name, req->sector_num, req->size,
+                strerror(errno));
+        return -1;
+    }
+
+    return rc;
+}
+
+static int vub_virtio_process_req(VubDev *vdev_blk,
+                                     VuVirtq *vq)
+{
+    VugDev *gdev = &vdev_blk->parent;
+    VuDev *vu_dev = &gdev->parent;
+    VuVirtqElement *elem;
+    uint32_t type;
+    unsigned in_num;
+    unsigned out_num;
+    VubReq *req;
+
+    elem = vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement) + sizeof(VubReq));
+    if (!elem) {
+        return -1;
+    }
+
+    /* refer to hw/block/virtio_blk.c */
+    if (elem->out_num < 1 || elem->in_num < 1) {
+        fprintf(stderr, "virtio-blk request missing headers\n");
+        free(elem);
+        return -1;
+    }
+
+    req = g_new0(VubReq, 1);
+    req->vdev_blk = vdev_blk;
+    req->vq = vq;
+    req->elem = elem;
+
+    in_num = elem->in_num;
+    out_num = elem->out_num;
+
+    /* don't support VIRTIO_F_ANY_LAYOUT and virtio 1.0 only */
+    if (elem->out_sg[0].iov_len < sizeof(struct virtio_blk_outhdr)) {
+        fprintf(stderr, "Invalid outhdr size\n");
+        goto err;
+    }
+    req->out = (struct virtio_blk_outhdr *)elem->out_sg[0].iov_base;
+    out_num--;
+
+    if (elem->in_sg[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
+        fprintf(stderr, "Invalid inhdr size\n");
+        goto err;
+    }
+    req->in = (struct virtio_blk_inhdr *)elem->in_sg[in_num - 1].iov_base;
+    in_num--;
+
+    type = le32toh(req->out->type);
+    switch (type & ~VIRTIO_BLK_T_BARRIER) {
+    case VIRTIO_BLK_T_IN:
+    case VIRTIO_BLK_T_OUT: {
+        ssize_t ret = 0;
+        bool is_write = type & VIRTIO_BLK_T_OUT;
+        req->sector_num = le64toh(req->out->sector);
+        if (is_write) {
+            ret = vub_rwv(req, &elem->out_sg[1], out_num, blk_write_entry);
+        } else {
+            ret = vub_rwv(req, &elem->in_sg[0], in_num, blk_read_entry);
+        }
+        if (ret >= 0) {
+            req->in->status = VIRTIO_BLK_S_OK;
+        } else {
+            req->in->status = VIRTIO_BLK_S_IOERR;
+        }
+        vub_req_complete(req);
+        break;
+    }
+    case VIRTIO_BLK_T_FLUSH:
+        vub_flush(req);
+        req->in->status = VIRTIO_BLK_S_OK;
+        vub_req_complete(req);
+        break;
+    case VIRTIO_BLK_T_GET_ID: {
+        size_t size = MIN(iov_size(&elem->in_sg[0], in_num),
+                          VIRTIO_BLK_ID_BYTES);
+        snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk");
+        req->in->status = VIRTIO_BLK_S_OK;
+        req->size = elem->in_sg[0].iov_len;
+        vub_req_complete(req);
+        break;
+    }
+    case VIRTIO_BLK_T_DISCARD:
+    case VIRTIO_BLK_T_WRITE_ZEROES: {
+        int rc;
+        rc = vub_discard_write_zeroes(req, &elem->out_sg[1], out_num, type);
+        if (rc == 0) {
+            req->in->status = VIRTIO_BLK_S_OK;
+        } else {
+            req->in->status = VIRTIO_BLK_S_IOERR;
+        }
+        vub_req_complete(req);
+        break;
+    }
+    default:
+        req->in->status = VIRTIO_BLK_S_UNSUPP;
+        vub_req_complete(req);
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
+static void vub_process_vq(VuDev *vu_dev, int idx)
+{
+    VugDev *gdev;
+    VubDev *vdev_blk;
+    VuVirtq *vq;
+    int ret;
+
+    gdev = container_of(vu_dev, VugDev, parent);
+    vdev_blk = container_of(gdev, VubDev, parent);
+    assert(vdev_blk);
+
+    vq = vu_get_queue(vu_dev, idx);
+    assert(vq);
+
+    while (1) {
+        ret = vub_virtio_process_req(vdev_blk, vq);
+        if (ret) {
+            break;
+        }
+    }
+}
+
+
+static void vub_queue_set_started(VuDev *vu_dev, int idx, bool started)
+{
+    VuVirtq *vq;
+
+    assert(vu_dev);
+
+    vq = vu_get_queue(vu_dev, idx);
+    vu_set_queue_handler(vu_dev, vq, started ? vub_process_vq : NULL);
+}
+
+static uint64_t
+vub_get_features(VuDev *dev)
+{
+    uint64_t features;
+    VugDev *gdev;
+    VubDev *vdev_blk;
+
+    gdev = container_of(dev, VugDev, parent);
+    vdev_blk = container_of(gdev, VubDev, parent);
+
+    features = 1ull << VIRTIO_BLK_F_SIZE_MAX |
+               1ull << VIRTIO_BLK_F_SEG_MAX |
+               1ull << VIRTIO_BLK_F_TOPOLOGY |
+               1ull << VIRTIO_BLK_F_BLK_SIZE |
+               1ull << VIRTIO_BLK_F_FLUSH |
+               #if defined(__linux__) && defined(BLKDISCARD) &&
defined(BLKZEROOUT)
+               1ull << VIRTIO_BLK_F_DISCARD |
+               1ull << VIRTIO_BLK_F_WRITE_ZEROES |
+               #endif
+               1ull << VIRTIO_BLK_F_CONFIG_WCE |
+               1ull << VIRTIO_F_VERSION_1 |
+               1ull << VHOST_USER_F_PROTOCOL_FEATURES;
+
+    if (vdev_blk->enable_ro) {
+        features |= 1ull << VIRTIO_BLK_F_RO;
+    }
+
+    return features;
+}
+
+static uint64_t
+vub_get_protocol_features(VuDev *dev)
+{
+    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG |
+           1ull << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD;
+}
+
+static int
+vub_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
+{
+    VugDev *gdev;
+    VubDev *vdev_blk;
+
+    gdev = container_of(vu_dev, VugDev, parent);
+    vdev_blk = container_of(gdev, VubDev, parent);
+    memcpy(config, &vdev_blk->blkcfg, len);
+
+    return 0;
+}
+
+static int
+vub_set_config(VuDev *vu_dev, const uint8_t *data,
+               uint32_t offset, uint32_t size, uint32_t flags)
+{
+    VugDev *gdev;
+    VubDev *vdev_blk;
+    uint8_t wce;
+
+    /* don't support live migration */
+    if (flags != VHOST_SET_CONFIG_TYPE_MASTER) {
+        return -1;
+    }
+
+    gdev = container_of(vu_dev, VugDev, parent);
+    vdev_blk = container_of(gdev, VubDev, parent);
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
+    blk_set_enable_write_cache(vdev_blk->blk, true);
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
+static int vub_process_msg(VuDev *dev, VhostUserMsg *vmsg, int *do_reply)
+{
+    if (vmsg->request == VHOST_USER_NONE) {
+        dev->panic(dev, "disconnect");
+        return true;
+    }
+    return false;
+}
+
+static const VuDevIface vub_iface = {
+    .get_features = vub_get_features,
+    .queue_set_started = vub_queue_set_started,
+    .get_protocol_features = vub_get_protocol_features,
+    .get_config = vub_get_config,
+    .set_config = vub_set_config,
+    .process_msg = vub_process_msg
+};
+
+
+
+static void vub_free(struct VubDev *vub_dev)
+{
+    if (!vub_dev) {
+        return;
+    }
+    blk_unref(vub_dev->blk);
+    g_free(vub_dev);
+}
+
+static void vub_accept(QIONetListener *listener, QIOChannelSocket *sioc,
+                       gpointer opaque)
+{
+    /* only one connection */
+    if (vub_device->sioc) {
+        return;
+    }
+
+    vub_device->sioc = sioc;
+    vub_device->listener = listener;
+    /*
+     * increase the object reference, so cioc will not freeed by
+     * qio_net_listener_channel_func which will call object_unref(OBJECT(sioc))
+     */
+    object_ref(OBJECT(sioc));
+
+    qio_channel_set_name(QIO_CHANNEL(sioc), "vhost-server");
+    if (!vug_init(&vub_device->parent, VHOST_USER_BLK_MAX_QUEUES, sioc->fd,
+                  vub_panic_cb, &vub_iface)) {
+        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
+    }
+
+}
+
+
+static void
+vub_initialize_config(BlockDriverState *bs, struct virtio_blk_config *config)
+{
+    config->capacity = bdrv_getlength(bs) >> BDRV_SECTOR_BITS;
+    config->blk_size = BDRV_SECTOR_SIZE;
+    config->size_max = 65536;
+    config->seg_max = 128 - 2;
+    config->min_io_size = 1;
+    config->opt_io_size = 1;
+    config->num_queues = 1;
+    #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
+    config->max_discard_sectors = 32768;
+    config->max_discard_seg = 1;
+    config->discard_sector_alignment = config->blk_size >> 9;
+    config->max_write_zeroes_sectors = 32768;
+    config->max_write_zeroes_seg = 1;
+    #endif
+}
+
+static void vub_new(bool writable, Error **errp)
+{
+
+    BlockBackend *blk;
+
+    /*
+     * Don't allow resize while the vhost user server is running,
+     * otherwise we don't care what happens with the node.
+     */
+    uint64_t perm = BLK_PERM_CONSISTENT_READ;
+    int ret;
+
+    AioContext *ctx;
+
+    BlockDriverState *bs = bdrv_lookup_bs(vub_device->name,
+                                          vub_device->name,
+                                          errp);
+
+    if (!bs) {
+        return;
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
+
+    vub_device->blkcfg.wce = 0;
+    vub_initialize_config(bs, &vub_device->blkcfg);
+    blk_set_enable_write_cache(blk, false);
+
+    blk_set_allow_aio_context_change(blk, true);
+
+    vub_device->blk = blk;
+    return;
+
+fail:
+    blk_unref(blk);
+    return;
+}
+
+static void vhost_user_server_free(void)
+{
+    if (!vub_device) {
+        return;
+    }
+
+    if (vub_device->sioc) {
+        close_client();
+        qio_net_listener_disconnect(vub_device->listener);
+        object_unref(OBJECT(vub_device->listener));
+    }
+    vub_free(vub_device);
+
+}
+
+void vhost_user_server_start(const char *unix_socket, const char *name,
+                        bool writable, Error **errp)
+{
+    if (vub_device) {
+        error_setg(errp, "Vhost server already running");
+        return;
+    }
+
+    vub_device = g_new0(VubDev, 1);
+    vub_device->name = name;
+    vub_device->enable_ro = !writable;
+    vub_new(writable, errp);
+    if (!vub_device->blk) {
+        goto error;
+    }
+
+    vub_device->listener = qio_net_listener_new();
+
+    qio_net_listener_set_name(vub_device->listener,
+                              "vhost-listener");
+
+    SocketAddress *addr = g_new0(SocketAddress, 1);
+    addr->u.q_unix.path = (char *) unix_socket;
+    addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+    if (qio_net_listener_open_sync(vub_device->listener, addr, 1, errp) < 0) {
+        goto error;
+    }
+
+    qio_net_listener_set_client_func(vub_device->listener,
+                                     vub_accept,
+                                     NULL,
+                                     NULL);
+
+    return;
+
+ error:
+    vub_free(vub_device);
+    vub_device = NULL;
+}
+
+void qmp_vhost_user_server_stop(Error **errp)
+{
+    if (!vub_device) {
+        error_setg(errp, "Vhost user backend server not running");
+        return;
+    }
+
+    vhost_user_server_free();
+    vub_device = NULL;
+}
diff --git a/hmp-commands.hx b/hmp-commands.hx
index cfcc044ce4..d8de179747 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1614,6 +1614,33 @@ STEXI
 @findex acl_reset
 Remove all matches from the access control list, and set the default
 policy back to @code{deny}.
+ETEXI
+
+    {
+        .name       = "vhost_user_server_stop",
+        .args_type  = "",
+        .params     = "vhost_user_server_stop",
+        .help       = "stop vhost-user-blk device backend",
+        .cmd        = hmp_vhost_user_server_stop,
+    },
+STEXI
+@item vhost_user_server_stop
+@findex vhost_user_server_stop
+Stop the QEMU embedded vhost-user-blk device backend server.
+ETEXI
+
+    {
+        .name       = "vhost_user_server_start",
+        .args_type  = "writable:-w,unix_socket:s,name:s",
+        .params     = "vhost_user_server_start [-w] unix_socket name",
+        .help       = "serve block devices via vhost user protocol",
+        .cmd        = hmp_vhost_user_server_start,
+    },
+STEXI
+
+@item vhost_user_server_start @var{unix_socket} @var{name}
+@findex vhost_user_server_start
+Start an Vhost server with given unix socket and block device.
 ETEXI

     {
diff --git a/include/block/vhost.h b/include/block/vhost.h
new file mode 100644
index 0000000000..6f521d2887
--- /dev/null
+++ b/include/block/vhost.h
@@ -0,0 +1,5 @@
+#include "io/channel-socket.h"
+
+void vhost_user_server_start(const char *unix_socket, const char
*blk_file, bool writable, Error **errp);
+void qmp_vhost_user_server_stop(Error **errp);
+
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index a0e9511440..e9de3dff0c 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -104,6 +104,8 @@ void hmp_getfd(Monitor *mon, const QDict *qdict);
 void hmp_closefd(Monitor *mon, const QDict *qdict);
 void hmp_sendkey(Monitor *mon, const QDict *qdict);
 void hmp_screendump(Monitor *mon, const QDict *qdict);
+void hmp_vhost_user_server_start(Monitor *mon, const QDict *qdict);
+void hmp_vhost_user_server_stop(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b2551c16d1..cac58fb276 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -46,6 +46,7 @@
 #include "qom/object_interfaces.h"
 #include "ui/console.h"
 #include "block/nbd.h"
+#include "block/vhost.h"
 #include "block/qapi.h"
 #include "qemu-io.h"
 #include "qemu/cutils.h"
@@ -2312,6 +2313,38 @@ void hmp_screendump(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }

+
+void hmp_vhost_user_server_start(Monitor *mon, const QDict *qdict)
+{
+    const char *unix_socket = qdict_get_str(qdict, "unix_socket");
+    const char *name = qdict_get_str(qdict, "name");
+    bool writable = qdict_get_try_bool(qdict, "writable", false);
+
+    Error *local_err = NULL;
+
+    if (!unix_socket || !name) {
+        error_setg(&local_err, "Usage: vhost_user_server_start [UNIX
domain socket]"
+               " | -w write access | [block name]\n");
+        goto exit;
+    }
+
+    vhost_user_server_start(unix_socket, name, writable, &local_err);
+
+    if (local_err != NULL) {
+        goto exit;
+    }
+
+exit:
+    hmp_handle_error(mon, &local_err);
+}
+
+void hmp_vhost_user_server_stop(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    qmp_vhost_user_server_stop(&err);
+    hmp_handle_error(mon, &err);
+}
+
 void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
 {
     const char *uri = qdict_get_str(qdict, "uri");
--
2.24.0


--
Best regards,
Coiby

