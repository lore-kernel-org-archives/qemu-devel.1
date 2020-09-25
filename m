Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27254C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71AA2076B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2rf8a22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71AA2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnSn-0003A5-OA
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJl-0002c8-2W
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJi-0002HJ-9c
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id k15so3471710wrn.10
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q4iTHSBorxk55Li2+GvTNnYqx3kRUnXXkY6aAFMYM/s=;
 b=v2rf8a22kBUgvdat3avWZaW4mN0N/9L+GeS8rZBwFpbXgyNEA8VuJfT+y6TXOJi/jn
 8771/fqeQCE4KnqcuWbyEHsU1A1oyvnct5X0a7zqa6y+v5zKAfikbc6M5TtDu3Vv9KDn
 eCzpC+XQnacfBUplYEg6WMnBxG+69iasXx9vAWv6aJzUxGNRpuw8gcDthchF1kMwSM7U
 +4I+PcinNdi8sBnAG4CS1BVzAXnyOcYRp3hzoTca3/k8gTUvmMEW9z5dLqfC8mEs0q2A
 2Pfp/TqleOQeL0aOB3Zudp1/B7yTNGO+dN4xcrtnA4CSXUnByPuIBdItaMWf+XqlVdw2
 2M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q4iTHSBorxk55Li2+GvTNnYqx3kRUnXXkY6aAFMYM/s=;
 b=L7GmZS+C3H3uvPVYQimvOMHe3ftMEf+yW26QcMxW8Re+jAWjdpAxurPAM+NM0r2aSJ
 D3wLvy9Fs5KCeQ9MVhl2jOLj9mqi8ZPup9A+l3Kj7HHndGNgR9GXlRbl5UsQvoXR9rhF
 KiXip53aks1ipXoOAzlPgZ54G4UaKr8GMoECBSV2c+tx7xhjNBWhTtUu7uilIhcXgONU
 fiCMrrMQ6TGVPmKUHFjBRuuMkLRPxX+kCYgxlrfCXBhV0XOgu7Ou0WLlDctpC8F2cfQy
 kQwBx6GYgaVPdoP5KheEAcaDds+6cGrfZrIkvljAAxYDlFu/r3t5Jve+gZNbMOQZyh41
 GgvA==
X-Gm-Message-State: AOAM5328RgF1ZSOQ0qiI5cE1/GyCEYCJ6ddaUnZs5ysUvIyL+8rN3T7q
 BEMAULICouFmKfUzf/UhsDDoYA==
X-Google-Smtp-Source: ABdhPJyhV2HYYzu/SbmGq+HXq0mlohFIVNFo6iMDNOdcQsYjpYH/oS8OWnIeoRhAoMBBlvixP+sFWw==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr4353786wrq.297.1601038751867; 
 Fri, 25 Sep 2020 05:59:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x67sm2411242wmb.25.2020.09.25.05.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 74C251FF9C;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 13/19] tools/vhost-user-rpmb: implement the PROGRAM_KEY
 handshake
Date: Fri, 25 Sep 2020 13:51:41 +0100
Message-Id: <20200925125147.26943-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implements the first handshake of the device initialisation which
is the programming of the device key. This can only be done once
per-device.

Currently there is no persistence for the device key and other
metadata such as the write count. This will be added later.

[TODO: clarify the spec if we should respond immediately or on request]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c | 299 +++++++++++++++++++++++++++++++++--
 1 file changed, 286 insertions(+), 13 deletions(-)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index 64bd7e79f573..9c98f6916f6f 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -22,10 +22,14 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <unistd.h>
+#include <endian.h>
+#include <assert.h>
 
 #include "contrib/libvhost-user/libvhost-user-glib.h"
 #include "contrib/libvhost-user/libvhost-user.h"
 
+#include "hmac_sha256.h"
+
 #ifndef container_of
 #define container_of(ptr, type, member) ({                      \
         const typeof(((type *) 0)->member) *__mptr = (ptr);     \
@@ -57,6 +61,31 @@ enum {
 /* These structures are defined in the specification */
 #define KiB     (1UL << 10)
 #define MAX_RPMB_SIZE (KiB * 128 * 256)
+#define RPMB_KEY_MAC_SIZE 32
+
+/* RPMB Request Types */
+#define VIRTIO_RPMB_REQ_PROGRAM_KEY        0x0001
+#define VIRTIO_RPMB_REQ_GET_WRITE_COUNTER  0x0002
+#define VIRTIO_RPMB_REQ_DATA_WRITE         0x0003
+#define VIRTIO_RPMB_REQ_DATA_READ          0x0004
+#define VIRTIO_RPMB_REQ_RESULT_READ        0x0005
+
+/* RPMB Response Types */
+#define VIRTIO_RPMB_RESP_PROGRAM_KEY       0x0100
+#define VIRTIO_RPMB_RESP_GET_COUNTER       0x0200
+#define VIRTIO_RPMB_RESP_DATA_WRITE        0x0300
+#define VIRTIO_RPMB_RESP_DATA_READ         0x0400
+
+/* RPMB Operation Results */
+#define VIRTIO_RPMB_RES_OK                     0x0000
+#define VIRTIO_RPMB_RES_GENERAL_FAILURE        0x0001
+#define VIRTIO_RPMB_RES_AUTH_FAILURE           0x0002
+#define VIRTIO_RPMB_RES_COUNT_FAILURE          0x0003
+#define VIRTIO_RPMB_RES_ADDR_FAILURE           0x0004
+#define VIRTIO_RPMB_RES_WRITE_FAILURE          0x0005
+#define VIRTIO_RPMB_RES_READ_FAILURE           0x0006
+#define VIRTIO_RPMB_RES_NO_AUTH_KEY            0x0007
+#define VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED  0x0080
 
 struct virtio_rpmb_config {
     uint8_t capacity;
@@ -64,9 +93,13 @@ struct virtio_rpmb_config {
     uint8_t max_rd_cnt;
 };
 
+/*
+ * This is based on the JDEC standard and not the currently not
+ * up-streamed NVME standard.
+ */
 struct virtio_rpmb_frame {
     uint8_t stuff[196];
-    uint8_t key_mac[32];
+    uint8_t key_mac[RPMB_KEY_MAC_SIZE];
     uint8_t data[256];
     uint8_t nonce[16];
     /* remaining fields are big-endian */
@@ -75,7 +108,7 @@ struct virtio_rpmb_frame {
     uint16_t block_count;
     uint16_t result;
     uint16_t req_resp;
-};
+} __attribute__((packed));
 
 /*
  * Structure to track internal state of RPMB Device
@@ -87,15 +120,63 @@ typedef struct VuRpmb {
     GMainLoop *loop;
     int flash_fd;
     void *flash_map;
+    uint8_t *key;
+    uint16_t last_result;
+    uint16_t last_reqresp;
 } VuRpmb;
 
-struct virtio_rpmb_ctrl_command {
-    VuVirtqElement elem;
-    VuVirtq *vq;
-    struct virtio_rpmb_frame frame;
-    uint32_t error;
-    bool finished;
-};
+/* refer to util/iov.c */
+static size_t vrpmb_iov_size(const struct iovec *iov,
+                             const unsigned int iov_cnt)
+{
+    size_t len;
+    unsigned int i;
+
+    len = 0;
+    for (i = 0; i < iov_cnt; i++) {
+        len += iov[i].iov_len;
+    }
+    return len;
+}
+
+
+static size_t vrpmb_iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
+                               size_t offset, void *buf, size_t bytes)
+{
+    size_t done;
+    unsigned int i;
+    for (i = 0, done = 0; (offset || done < bytes) && i < iov_cnt; i++) {
+        if (offset < iov[i].iov_len) {
+            size_t len = MIN(iov[i].iov_len - offset, bytes - done);
+            memcpy(buf + done, iov[i].iov_base + offset, len);
+            done += len;
+            offset = 0;
+        } else {
+            offset -= iov[i].iov_len;
+        }
+    }
+    assert(offset == 0);
+    return done;
+}
+
+static size_t vrpmb_iov_from_buf(const struct iovec *iov, unsigned int iov_cnt,
+                                 size_t offset, const void *buf, size_t bytes)
+{
+    size_t done;
+    unsigned int i;
+    for (i = 0, done = 0; (offset || done < bytes) && i < iov_cnt; i++) {
+        if (offset < iov[i].iov_len) {
+            size_t len = MIN(iov[i].iov_len - offset, bytes - done);
+            memcpy(iov[i].iov_base + offset, buf + done, len);
+            done += len;
+            offset = 0;
+        } else {
+            offset -= iov[i].iov_len;
+        }
+    }
+    assert(offset == 0);
+    return done;
+}
 
 static void vrpmb_panic(VuDev *dev, const char *msg)
 {
@@ -142,19 +223,211 @@ vrpmb_set_config(VuDev *dev, const uint8_t *data,
     return 0;
 }
 
+/*
+ * vrpmb_update_mac_in_frame:
+ *
+ * From the spec:
+ *   The MAC is calculated using HMAC SHA-256. It takes
+ *   as input a key and a message. The key used for the MAC calculation
+ *   is always the 256-bit RPMB authentication key. The message used as
+ *   input to the MAC calculation is the concatenation of the fields in
+ *   the RPMB frames excluding stuff bytes and the MAC itself.
+ *
+ * The code to do this has been lifted from the optee supplicant code
+ * which itself uses a 3 clause BSD chunk of code.
+ */
+
+static void vrpmb_update_mac_in_frame(VuRpmb *r, struct virtio_rpmb_frame *frm)
+{
+    hmac_sha256_ctx ctx;
+    static const int dlen = (sizeof(struct virtio_rpmb_frame) -
+                             offsetof(struct virtio_rpmb_frame, data));
+
+    hmac_sha256_init(&ctx, r->key, RPMB_KEY_MAC_SIZE);
+    hmac_sha256_update(&ctx, frm->data, dlen);
+    hmac_sha256_final(&ctx, &frm->key_mac[0], 32);
+}
+
+/*
+ * Handlers for individual control messages
+ */
+
+/*
+ * vrpmb_handle_program_key:
+ *
+ * Program the device with our key. The spec is a little hazzy on if
+ * we respond straight away or we wait for the user to send a
+ * VIRTIO_RPMB_REQ_RESULT_READ request.
+ */
+static void vrpmb_handle_program_key(VuDev *dev, struct virtio_rpmb_frame *frame)
+{
+    VuRpmb *r = container_of(dev, VuRpmb, dev.parent);
+
+    /*
+     * Run the checks from:
+     * 5.12.6.1.1 Device Requirements: Device Operation: Program Key
+     */
+    r->last_reqresp = VIRTIO_RPMB_RESP_PROGRAM_KEY;
+
+    /* Fail if already programmed */
+    if (r->key) {
+        g_debug("key already programmed");
+        r->last_result = VIRTIO_RPMB_RES_WRITE_FAILURE;
+    } else if (be16toh(frame->block_count) != 1) {
+        g_debug("weird block counts (%d)", frame->block_count);
+        r->last_result = VIRTIO_RPMB_RES_GENERAL_FAILURE;
+    } else {
+        r->key = g_memdup(&frame->key_mac[0], RPMB_KEY_MAC_SIZE);
+        r->last_result = VIRTIO_RPMB_RES_OK;
+    }
+
+    g_info("%s: req_resp = %x, result = %x", __func__,
+           r->last_reqresp, r->last_result);
+    return;
+}
+
+/*
+ * Return the result of the last message. This is only valid if the
+ * previous message was VIRTIO_RPMB_REQ_PROGRAM_KEY or
+ * VIRTIO_RPMB_REQ_DATA_WRITE.
+ *
+ * The frame should be freed once sent.
+ */
+static struct virtio_rpmb_frame * vrpmb_handle_result_read(VuDev *dev)
+{
+    VuRpmb *r = container_of(dev, VuRpmb, dev.parent);
+    struct virtio_rpmb_frame *resp = g_new0(struct virtio_rpmb_frame, 1);
+
+    if (r->last_reqresp == VIRTIO_RPMB_RESP_PROGRAM_KEY ||
+        r->last_reqresp == VIRTIO_RPMB_REQ_DATA_WRITE) {
+        resp->result = htobe16(r->last_result);
+        resp->req_resp = htobe16(r->last_reqresp);
+    } else {
+        resp->result = htobe16(VIRTIO_RPMB_RES_GENERAL_FAILURE);
+    }
+
+    /* calculate HMAC */
+    if (!r->key) {
+        resp->result = htobe16(VIRTIO_RPMB_RES_GENERAL_FAILURE);
+    } else {
+        vrpmb_update_mac_in_frame(r, resp);
+    }
+
+    g_info("%s: result = %x req_resp = %x", __func__,
+           be16toh(resp->result),
+           be16toh(resp->req_resp));
+    return resp;
+}
+
+static void fmt_bytes(GString *s, uint8_t *bytes, int len)
+{
+    int i;
+    for (i = 0; i < len; i++) {
+        if (i % 16 == 0) {
+            g_string_append_c(s, '\n');
+        }
+        g_string_append_printf(s, "%x ", bytes[i]);
+    }
+}
+
+static void vrpmb_dump_frame(struct virtio_rpmb_frame *frame)
+{
+    g_autoptr(GString) s = g_string_new("frame: ");
+
+    g_string_append_printf(s, " %p\n", frame);
+    g_string_append_printf(s, "key_mac:");
+    fmt_bytes(s, (uint8_t *) &frame->key_mac[0], 32);
+    g_string_append_printf(s, "\ndata:");
+    fmt_bytes(s, (uint8_t *) &frame->data, 256);
+    g_string_append_printf(s, "\nnonce:");
+    fmt_bytes(s, (uint8_t *) &frame->nonce, 16);
+    g_string_append_printf(s, "\nwrite_counter: %d\n",
+                           be32toh(frame->write_counter));
+    g_string_append_printf(s, "address: %#04x\n", be16toh(frame->address));
+    g_string_append_printf(s, "block_count: %d\n", be16toh(frame->block_count));
+    g_string_append_printf(s, "result: %d\n", be16toh(frame->result));
+    g_string_append_printf(s, "req_resp: %d\n", be16toh(frame->req_resp));
+
+    g_debug("%s: %s\n", __func__, s->str);
+}
+
 static void
 vrpmb_handle_ctrl(VuDev *dev, int qidx)
 {
     VuVirtq *vq = vu_get_queue(dev, qidx);
-    struct virtio_rpmb_ctrl_command *cmd = NULL;
+    struct virtio_rpmb_frame *frames = NULL;
 
     for (;;) {
-        cmd = vu_queue_pop(dev, vq, sizeof(struct virtio_rpmb_ctrl_command));
-        if (!cmd) {
+        VuVirtqElement *elem;
+        size_t len, frame_sz = sizeof(struct virtio_rpmb_frame);
+        int n;
+
+        elem = vu_queue_pop(dev, vq, sizeof(VuVirtqElement));
+        if (!elem) {
             break;
         }
+        g_debug("%s: got queue (in %d, out %d)", __func__,
+                elem->in_num, elem->out_num);
 
-        g_debug("un-handled cmd: %p", cmd);
+        len = vrpmb_iov_size(elem->out_sg, elem->out_num);
+        frames = g_realloc(frames, len);
+        vrpmb_iov_to_buf(elem->out_sg, elem->out_num, 0, frames, len);
+
+        if (len % frame_sz != 0) {
+            g_warning("%s: incomplete frames %zu/%zu != 0\n",
+                      __func__, len, frame_sz);
+        }
+
+        for (n = 0; n < len / frame_sz; n++) {
+            struct virtio_rpmb_frame *f = &frames[n];
+            struct virtio_rpmb_frame *resp = NULL;
+            uint16_t req_resp = be16toh(f->req_resp);
+            bool responded = false;
+
+            if (debug) {
+                g_info("req_resp=%x", req_resp);
+                vrpmb_dump_frame(f);
+            }
+
+            switch (req_resp) {
+            case VIRTIO_RPMB_REQ_PROGRAM_KEY:
+                vrpmb_handle_program_key(dev, f);
+                break;
+            case VIRTIO_RPMB_REQ_RESULT_READ:
+                if (!responded) {
+                    resp = vrpmb_handle_result_read(dev);
+                } else {
+                    g_warning("%s: already sent a response in this set of frames",
+                              __func__);
+                }
+                break;
+            default:
+                g_debug("un-handled request: %x", f->req_resp);
+                break;
+            }
+
+            /*
+             * Do we have a frame to send back?
+             */
+            if (resp) {
+                g_debug("sending response frame: %p", resp);
+                if (debug) {
+                    vrpmb_dump_frame(resp);
+                }
+                len = vrpmb_iov_from_buf(elem->in_sg,
+                                         elem->in_num, 0, resp, sizeof(*resp));
+                if (len != sizeof(*resp)) {
+                    g_critical("%s: response size incorrect %zu vs %zu",
+                               __func__, len, sizeof(*resp));
+                } else {
+                    vu_queue_push(dev, vq, elem, len);
+                    vu_queue_notify(dev, vq);
+                    responded = true;
+                }
+
+                g_free(resp);
+            }
+        }
     }
 }
 
-- 
2.20.1


