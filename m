Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FBEC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC06206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K41zXm3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC06206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwcz-0005wZ-07
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKv-0003Ib-Ta; Thu, 03 Sep 2020 17:00:01 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKt-0007M9-LA; Thu, 03 Sep 2020 17:00:01 -0400
Received: by mail-oi1-x244.google.com with SMTP id d189so4477635oig.12;
 Thu, 03 Sep 2020 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=toeoNpfYSl/ElO5L5zgrTHQpTRhSexoIT3AHev1/A18=;
 b=K41zXm3yPtZh66GpNio+YEWXfx2h3USDuminp96CCGrnPTsjJPH7Mv+Q+v2ily4vrR
 VD600XticEOJmBhV7mSZUM/JdpjMuAxDZkZi6viR1glwHyrdTAbtn6uYnUeMZ5S+dgdu
 f9zmQGcYRr7eVMeeFncJmTFN0HIx6gLcBX7AyeKc9Imi3e0/qOsOyn4wln818Fzo/08O
 2vm9fffAyKAiEPJMH1rp7PGxXbbHgHyuw/Ti8lP9H/30HmV8U3tBuQqjKPcCEQ7uzNPE
 WUVlx3xU+vPutCFclczIL2gCsyIRdPhwkex9KFb1gQuGn23WkaAtLQhg3R3Gqdaikivk
 /3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=toeoNpfYSl/ElO5L5zgrTHQpTRhSexoIT3AHev1/A18=;
 b=IocqSO2O7rRe9UiEv/pGu5jPQU7n8mglw+QA2DX5jUss599pBlGAQi6GzAeC428mru
 hznzUCKNyubQC3/ia4W8cQ/lEvSUOiAZ1uaXimKL/UFAlmuEbQOj1KcjkRCiYYtnzXXW
 OUHkDs8kcwfIQTyquvepyMtjWVU5YVyPnSR8D5e5zdIgXTCqWLZqmLpziCZQfivdVQOO
 rLHEJIiGLqLGXJ0pjHAeFf2021500qBDdaA2/Qc4/PTAxw8T2bVgVy9/T7iINApEvV1W
 XvcuwZS3xljjotgVo4WpevEVW3HYLRF6APLiKEf/5I9u7TODoiS5yVTwI7Q1IY66wfso
 KvPA==
X-Gm-Message-State: AOAM533DPtdRygmtkn8XBGciVVxW2OWWWpW1N+x204y9MsdU6LqcR43d
 gEDXUE2WZlqylUvXRmaa1TGCcXdgSEs=
X-Google-Smtp-Source: ABdhPJw49Z3GJLeQk1dhBFzMfFm9GkJSIRfSrfwMwKoSukVDGPeuLP2DD7WhDOO/2VzeQpBrasWvCQ==
X-Received: by 2002:a05:6808:2d7:: with SMTP id
 a23mr3225672oid.51.1599166797905; 
 Thu, 03 Sep 2020 13:59:57 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id u19sm729310oic.10.2020.09.03.13.59.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 13:59:57 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/77] Revert "9p: init_in_iov_from_pdu can truncate the size"
Date: Thu,  3 Sep 2020 15:58:32 -0500
Message-Id: <20200903205935.27832-15-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Stefano Stabellini <stefano.stabellini@xilinx.com>, qemu-stable@nongnu.org,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

This reverts commit 16724a173049ac29c7b5ade741da93a0f46edff7.
It causes https://bugs.launchpad.net/bugs/1877688.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20200521192627.15259-1-sstabellini@kernel.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit cf45183b718f02b1369e18c795dc51bc1821245d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p.c               | 33 +++++++++++----------------------
 hw/9pfs/9p.h               |  2 +-
 hw/9pfs/virtio-9p-device.c | 11 ++++-------
 hw/9pfs/xen-9p-backend.c   | 15 ++++++---------
 4 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 3301e82eb6..1b729af6e8 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2103,29 +2103,22 @@ out_nofid:
  * with qemu_iovec_destroy().
  */
 static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
-                                    size_t skip, size_t *size,
+                                    size_t skip, size_t size,
                                     bool is_write)
 {
     QEMUIOVector elem;
     struct iovec *iov;
     unsigned int niov;
-    size_t alloc_size = *size + skip;
 
     if (is_write) {
-        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, alloc_size);
+        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, size + skip);
     } else {
-        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, &alloc_size);
-    }
-
-    if (alloc_size < skip) {
-        *size = 0;
-    } else {
-        *size = alloc_size - skip;
+        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size + skip);
     }
 
     qemu_iovec_init_external(&elem, iov, niov);
     qemu_iovec_init(qiov, niov);
-    qemu_iovec_concat(qiov, &elem, skip, *size);
+    qemu_iovec_concat(qiov, &elem, skip, size);
 }
 
 static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
@@ -2133,14 +2126,15 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
 {
     ssize_t err;
     size_t offset = 7;
-    size_t read_count;
+    uint64_t read_count;
     QEMUIOVector qiov_full;
 
     if (fidp->fs.xattr.len < off) {
         read_count = 0;
-    } else if (fidp->fs.xattr.len - off < max_count) {
-        read_count = fidp->fs.xattr.len - off;
     } else {
+        read_count = fidp->fs.xattr.len - off;
+    }
+    if (read_count > max_count) {
         read_count = max_count;
     }
     err = pdu_marshal(pdu, offset, "d", read_count);
@@ -2149,7 +2143,7 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
     }
     offset += err;
 
-    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &read_count, false);
+    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count, false);
     err = v9fs_pack(qiov_full.iov, qiov_full.niov, 0,
                     ((char *)fidp->fs.xattr.value) + off,
                     read_count);
@@ -2278,11 +2272,9 @@ static void coroutine_fn v9fs_read(void *opaque)
         QEMUIOVector qiov_full;
         QEMUIOVector qiov;
         int32_t len;
-        size_t size = max_count;
 
-        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, &size, false);
+        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, max_count, false);
         qemu_iovec_init(&qiov, qiov_full.niov);
-        max_count = size;
         do {
             qemu_iovec_reset(&qiov);
             qemu_iovec_concat(&qiov, &qiov_full, count, qiov_full.size - count);
@@ -2533,7 +2525,6 @@ static void coroutine_fn v9fs_write(void *opaque)
     int32_t len = 0;
     int32_t total = 0;
     size_t offset = 7;
-    size_t size;
     V9fsFidState *fidp;
     V9fsPDU *pdu = opaque;
     V9fsState *s = pdu->s;
@@ -2546,9 +2537,7 @@ static void coroutine_fn v9fs_write(void *opaque)
         return;
     }
     offset += err;
-    size = count;
-    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &size, true);
-    count = size;
+    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, count, true);
     trace_v9fs_write(pdu->tag, pdu->id, fid, off, count, qiov_full.niov);
 
     fidp = get_fid(pdu, fid);
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index c381fe091a..656527beb9 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -436,7 +436,7 @@ struct V9fsTransport {
     ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const char *fmt,
                                   va_list ap);
     void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
-                                        unsigned int *pniov, size_t *size);
+                                        unsigned int *pniov, size_t size);
     void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
                                          unsigned int *pniov, size_t size);
     void        (*push_and_notify)(V9fsPDU *pdu);
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 536447a355..f821236356 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -147,22 +147,19 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
 }
 
 static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
-                                        unsigned int *pniov, size_t *size)
+                                        unsigned int *pniov, size_t size)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
     size_t buf_size = iov_size(elem->in_sg, elem->in_num);
 
-    if (buf_size < P9_IOHDRSZ) {
+    if (buf_size < size) {
         VirtIODevice *vdev = VIRTIO_DEVICE(v);
 
         virtio_error(vdev,
-                     "VirtFS reply type %d needs %zu bytes, buffer has %zu, less than minimum",
-                     pdu->id + 1, *size, buf_size);
-    }
-    if (buf_size < *size) {
-        *size = buf_size;
+                     "VirtFS reply type %d needs %zu bytes, buffer has %zu",
+                     pdu->id + 1, size, buf_size);
     }
 
     *piov = elem->in_sg;
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index f04caabfe5..fc197f6c8a 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -188,7 +188,7 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
 static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
                                           struct iovec **piov,
                                           unsigned int *pniov,
-                                          size_t *size)
+                                          size_t size)
 {
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
@@ -198,19 +198,16 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
     g_free(ring->sg);
 
     ring->sg = g_new0(struct iovec, 2);
-    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
+    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
 
     buf_size = iov_size(ring->sg, num);
-    if (buf_size  < P9_IOHDRSZ) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d needs "
-                      "%zu bytes, buffer has %zu, less than minimum\n",
-                      pdu->id + 1, *size, buf_size);
+    if (buf_size  < size) {
+        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
+                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
+                buf_size);
         xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
         xen_9pfs_disconnect(&xen_9pfs->xendev);
     }
-    if (buf_size  < *size) {
-        *size = buf_size;
-    }
 
     *piov = ring->sg;
     *pniov = num;
-- 
2.17.1


