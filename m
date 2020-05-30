Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AEBC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 17:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D6E20721
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 17:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSy2KZbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D6E20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jf58z-0001SF-5m
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 13:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jf54h-0006bJ-Rs
 for qemu-devel@nongnu.org; Sat, 30 May 2020 13:15:13 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jf54f-00038c-M5
 for qemu-devel@nongnu.org; Sat, 30 May 2020 13:15:11 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ci21so2962360pjb.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YS0xSiN7FvtOVbWW6xaNeobLBzRi77FjVCw9ZlD4+KA=;
 b=ZSy2KZbAcGWcgPl0UCSDG61z54PvQ7eWxCleeu+vE+yzlTjSw5PUa3VzMS3Hy2xyZM
 S0e0P6sMoyKhB8SOe5QYRiWBBZA8RdkUt07yZ70gVJ9HGoUzFuww8oAXuM0z/2rGx4bu
 1ERDD8QFtp1hSheByVFXkYpKFxNIJOFWwN9LsSJlV61WSvqkohe6jU2KuZmCWSPQrdjP
 PQdqqEWO4Y3o/+j69bl/CF16exAarPaRV9B4a/gUJJ+IXZVJSvTxen4p1OhPf8ila3OI
 OfyJz/i7Iu4uu/3j6SGNyjjwoMNBlr+M4xc1peajDAQpJZ6qhudpdy80byjQYuwXpCYA
 zzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YS0xSiN7FvtOVbWW6xaNeobLBzRi77FjVCw9ZlD4+KA=;
 b=WTiwLm07kFCGrUl0VbLuS/yrPrx13ZmRqt//P+XuALABeqt92qGBNC5MATjESpS1P8
 B/yD999EGpffzP9tIal7eW3tr4nzRpCOcC6/96FS7tJ2AU8ij1FhaS7sIpPWXK4KXzam
 smKRYDniQpTGs0Lvbe994lsUgtA5J6K2d7Ul/8+e6CGFq6BZa6hFlWbGLPFPzfQvXCrU
 ra/Ss6oZY4abejUp7Ej727Y1kce18F/6WgLavIrJXqNMHcImkxVS/gVqzT+aUzehiuwb
 l+q8Y6XTYnknWPc2+H6fkl2PrLL4Hz8Q/4ODc2/nOwp8d2wUeQCgdzf09fZ7pJA1AH0V
 /5/g==
X-Gm-Message-State: AOAM531jM2gATI7XOB5EKssF/Iu8erOfhBYIpg8IYUXfpDtQBmD+xwxE
 NSsj7RjG46RCHC5e6BF3JuGxId+fe4I6qA==
X-Google-Smtp-Source: ABdhPJxn4EgMwtmztp46w6/zRkt8Baolx3zO97qFXi5GkCnIvxHGG/zPjsI1lEzUzbObaUJos9JFhg==
X-Received: by 2002:a17:902:a704:: with SMTP id
 w4mr13478063plq.208.1590858907915; 
 Sat, 30 May 2020 10:15:07 -0700 (PDT)
Received: from localhost.localdomain
 (tunnel570486-pt.tunnel.tserv25.sin1.ipv6.he.net. [2001:470:35:3d5::2])
 by smtp.googlemail.com with ESMTPSA id 191sm1229731pfy.161.2020.05.30.10.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 10:15:07 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/4] generic vhost user server
Date: Sun, 31 May 2020 01:14:39 +0800
Message-Id: <20200530171441.660814-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530171441.660814-1-coiby.xu@gmail.com>
References: <20200530171441.660814-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1043.google.com
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, Coiby Xu <coiby.xu@gmail.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sharing QEMU devices via vhost-user protocol.

Only one vhost-user client can connect to the server one time.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 util/Makefile.objs       |   1 +
 util/vhost-user-server.c | 404 +++++++++++++++++++++++++++++++++++++++
 util/vhost-user-server.h |  59 ++++++
 3 files changed, 464 insertions(+)
 create mode 100644 util/vhost-user-server.c
 create mode 100644 util/vhost-user-server.h

diff --git a/util/Makefile.objs b/util/Makefile.objs
index fe339c2636..f54a6c80ec 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -40,6 +40,7 @@ util-obj-y += readline.o
 util-obj-y += rcu.o
 util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
 util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
+util-obj-$(CONFIG_LINUX) += vhost-user-server.o
 util-obj-y += qemu-coroutine-sleep.o
 util-obj-y += qemu-co-shared-resource.o
 util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
new file mode 100644
index 0000000000..414d0d4e47
--- /dev/null
+++ b/util/vhost-user-server.c
@@ -0,0 +1,404 @@
+/*
+ * Sharing QEMU devices via vhost-user protocol
+ *
+ * Author: Coiby Xu <coiby.xu@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include <sys/eventfd.h>
+#include "qemu/main-loop.h"
+#include "vhost-user-server.h"
+
+static void vmsg_close_fds(VhostUserMsg *vmsg)
+{
+    int i;
+    for (i = 0; i < vmsg->fd_num; i++) {
+        close(vmsg->fds[i]);
+    }
+}
+
+static void vmsg_unblock_fds(VhostUserMsg *vmsg)
+{
+    int i;
+    for (i = 0; i < vmsg->fd_num; i++) {
+        qemu_set_nonblock(vmsg->fds[i]);
+    }
+}
+
+static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
+                      gpointer opaque);
+
+static void close_client(VuServer *server)
+{
+    vu_deinit(&server->vu_dev);
+    server->sioc = NULL;
+    object_unref(OBJECT(server->ioc));
+
+    server->sioc_slave = NULL;
+    object_unref(OBJECT(server->ioc_slave));
+    /*
+     * Set the callback function for network listener so another
+     * vhost-user client can connect to this server
+     */
+    qio_net_listener_set_client_func(server->listener,
+                                     vu_accept,
+                                     server,
+                                     NULL);
+}
+
+static void panic_cb(VuDev *vu_dev, const char *buf)
+{
+    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
+
+    if (buf) {
+        error_report("vu_panic: %s", buf);
+    }
+
+    if (server->sioc) {
+        close_client(server);
+    }
+
+    if (server->device_panic_notifier) {
+        server->device_panic_notifier(server);
+    }
+}
+
+static QIOChannel *slave_io_channel(VuServer *server, int fd,
+                                    Error **local_err)
+{
+    if (server->sioc_slave) {
+        if (fd == server->sioc_slave->fd) {
+            return server->ioc_slave;
+        }
+    } else {
+        server->sioc_slave = qio_channel_socket_new_fd(fd, local_err);
+        if (!*local_err) {
+            server->ioc_slave = QIO_CHANNEL(server->sioc_slave);
+            return server->ioc_slave;
+        }
+    }
+
+    return NULL;
+}
+
+static bool coroutine_fn
+vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    struct iovec iov = {
+        .iov_base = (char *)vmsg,
+        .iov_len = VHOST_USER_HDR_SIZE,
+    };
+    int rc, read_bytes = 0;
+    Error *local_err = NULL;
+    /*
+     * Store fds/nfds returned from qio_channel_readv_full into
+     * temporary variables.
+     *
+     * VhostUserMsg is a packed structure, gcc will complain about passing
+     * pointer to a packed structure member if we pass &VhostUserMsg.fd_num
+     * and &VhostUserMsg.fds directly when calling qio_channel_readv_full,
+     * thus two temporary variables nfds and fds are used here.
+     */
+    size_t nfds = 0, nfds_t = 0;
+    int *fds = NULL, *fds_t = NULL;
+    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
+    QIOChannel *ioc = NULL;
+
+    if (conn_fd == server->sioc->fd) {
+        ioc = server->ioc;
+    } else {
+        /* Slave communication will also use this function to read msg */
+        ioc = slave_io_channel(server, conn_fd, &local_err);
+    }
+
+    if (!ioc) {
+        error_report_err(local_err);
+        goto fail;
+    }
+
+    assert(qemu_in_coroutine());
+    do {
+        /*
+         * qio_channel_readv_full may have short reads, keeping calling it
+         * until getting VHOST_USER_HDR_SIZE or 0 bytes in total
+         */
+        rc = qio_channel_readv_full(ioc, &iov, 1, &fds_t, &nfds_t, &local_err);
+        if (rc < 0) {
+            if (rc == QIO_CHANNEL_ERR_BLOCK) {
+                qio_channel_yield(ioc, G_IO_IN);
+                continue;
+            } else {
+                error_report_err(local_err);
+                return false;
+            }
+        }
+        read_bytes += rc;
+        if (nfds_t > 0) {
+            fds = g_renew(int, fds_t, nfds + nfds_t);
+            memcpy(fds + nfds, fds_t, nfds_t);
+            nfds += nfds_t;
+            if (nfds > VHOST_MEMORY_MAX_NREGIONS) {
+                error_report("A maximum of %d fds are allowed, "
+                             "however got %lu fds now",
+                             VHOST_MEMORY_MAX_NREGIONS, nfds);
+                goto fail;
+            }
+        }
+        if (read_bytes == VHOST_USER_HDR_SIZE || rc == 0) {
+            break;
+        }
+        iov.iov_base = (char *)vmsg + read_bytes;
+        iov.iov_len = VHOST_USER_HDR_SIZE - read_bytes;
+    } while (true);
+
+    vmsg->fd_num = nfds;
+    if (nfds > 0) {
+        memcpy(vmsg->fds, fds, nfds * sizeof(int));
+    }
+    g_free(fds);
+    /* qio_channel_readv_full will make socket fds blocking, unblock them */
+    vmsg_unblock_fds(vmsg);
+    if (vmsg->size > sizeof(vmsg->payload)) {
+        error_report("Error: too big message request: %d, "
+                     "size: vmsg->size: %u, "
+                     "while sizeof(vmsg->payload) = %zu",
+                     vmsg->request, vmsg->size, sizeof(vmsg->payload));
+        goto fail;
+    }
+
+    struct iovec iov_payload = {
+        .iov_base = (char *)&vmsg->payload,
+        .iov_len = vmsg->size,
+    };
+    if (vmsg->size) {
+        rc = qio_channel_readv_all_eof(ioc, &iov_payload, 1, &local_err);
+        if (rc == -1) {
+            error_report_err(local_err);
+            goto fail;
+        }
+    }
+
+    return true;
+
+fail:
+    vmsg_close_fds(vmsg);
+
+    return false;
+}
+
+
+static void vu_client_start(VuServer *server);
+static coroutine_fn void vu_client_trip(void *opaque)
+{
+    VuServer *server = opaque;
+
+    while (!server->aio_context_changed && server->sioc) {
+        vu_dispatch(&server->vu_dev);
+    }
+
+    if (server->aio_context_changed && server->sioc) {
+        server->aio_context_changed = false;
+        vu_client_start(server);
+    }
+}
+
+static void vu_client_start(VuServer *server)
+{
+    server->co_trip = qemu_coroutine_create(vu_client_trip, server);
+    aio_co_enter(server->ctx, server->co_trip);
+}
+
+/*
+ * a wrapper for vu_kick_cb
+ *
+ * since aio_dispatch can only pass one user data pointer to the
+ * callback function, pack VuDev and pvt into a struct. Then unpack it
+ * and pass them to vu_kick_cb
+ */
+static void kick_handler(void *opaque)
+{
+    KickInfo *kick_info = opaque;
+    kick_info->cb(kick_info->vu_dev, 0, (void *) kick_info->index);
+}
+
+
+static void
+set_watch(VuDev *vu_dev, int fd, int vu_evt,
+          vu_watch_cb cb, void *pvt)
+{
+
+    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
+    g_assert(vu_dev);
+    g_assert(fd >= 0);
+    long index = (intptr_t) pvt;
+    g_assert(cb);
+    KickInfo *kick_info = &server->kick_info[index];
+    if (!kick_info->cb) {
+        kick_info->fd = fd;
+        kick_info->cb = cb;
+        qemu_set_nonblock(fd);
+        aio_set_fd_handler(server->ioc->ctx, fd, false, kick_handler,
+                           NULL, NULL, kick_info);
+        kick_info->vu_dev = vu_dev;
+    }
+}
+
+
+static void remove_watch(VuDev *vu_dev, int fd)
+{
+    VuServer *server;
+    int i;
+    int index = -1;
+    g_assert(vu_dev);
+    g_assert(fd >= 0);
+
+    server = container_of(vu_dev, VuServer, vu_dev);
+    for (i = 0; i < vu_dev->max_queues; i++) {
+        if (server->kick_info[i].fd == fd) {
+            index = i;
+            break;
+        }
+    }
+
+    if (index == -1) {
+        return;
+    }
+    server->kick_info[i].cb = NULL;
+    aio_set_fd_handler(server->ioc->ctx, fd, false, NULL, NULL, NULL, NULL);
+}
+
+
+static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
+                      gpointer opaque)
+{
+    VuServer *server = opaque;
+
+    if (server->sioc) {
+        warn_report("Only one vhost-user client is allowed to "
+                    "connect the server one time");
+        return;
+    }
+
+    if (!vu_init(&server->vu_dev, server->max_queues, sioc->fd, panic_cb,
+                 vu_message_read, set_watch, remove_watch, server->vu_iface)) {
+        error_report("Failed to initialized libvhost-user");
+        return;
+    }
+
+    /*
+     * Unset the callback function for network listener to make another
+     * vhost-user client keeping waiting until this client disconnects
+     */
+    qio_net_listener_set_client_func(server->listener,
+                                     NULL,
+                                     NULL,
+                                     NULL);
+    server->sioc = sioc;
+    server->kick_info = g_new0(KickInfo, server->max_queues);
+    /*
+     * Increase the object reference, so cioc will not freed by
+     * qio_net_listener_channel_func which will call object_unref(OBJECT(sioc))
+     */
+    object_ref(OBJECT(server->sioc));
+    qio_channel_set_name(QIO_CHANNEL(sioc), "vhost-user client");
+    server->ioc = QIO_CHANNEL(sioc);
+    object_ref(OBJECT(server->ioc));
+    object_ref(OBJECT(sioc));
+    qio_channel_attach_aio_context(server->ioc, server->ctx);
+    qio_channel_set_blocking(QIO_CHANNEL(server->sioc), false, NULL);
+    vu_client_start(server);
+}
+
+
+void vhost_user_server_stop(VuServer *server)
+{
+    if (!server) {
+        return;
+    }
+
+    if (server->sioc) {
+        close_client(server);
+    }
+
+    if (server->listener) {
+        qio_net_listener_disconnect(server->listener);
+        object_unref(OBJECT(server->listener));
+    }
+}
+
+static void detach_context(VuServer *server)
+{
+    int i;
+    AioContext *ctx = server->ioc->ctx;
+    qio_channel_detach_aio_context(server->ioc);
+    for (i = 0; i < server->vu_dev.max_queues; i++) {
+        if (server->kick_info[i].cb) {
+            aio_set_fd_handler(ctx, server->kick_info[i].fd, false, NULL,
+                               NULL, NULL, NULL);
+        }
+    }
+}
+
+static void attach_context(VuServer *server, AioContext *ctx)
+{
+    int i;
+    qio_channel_attach_aio_context(server->ioc, ctx);
+    server->aio_context_changed = true;
+    if (server->co_trip) {
+        aio_co_schedule(ctx, server->co_trip);
+    }
+    for (i = 0; i < server->vu_dev.max_queues; i++) {
+        if (server->kick_info[i].cb) {
+            aio_set_fd_handler(ctx, server->kick_info[i].fd, false,
+                               kick_handler, NULL, NULL,
+                               &server->kick_info[i]);
+        }
+    }
+}
+
+void vhost_user_server_set_aio_context(AioContext *ctx, VuServer *server)
+{
+    server->ctx = ctx ? ctx : qemu_get_aio_context();
+    if (!server->sioc) {
+        return;
+    }
+    if (ctx) {
+        attach_context(server, ctx);
+    } else {
+        detach_context(server);
+    }
+}
+
+
+bool vhost_user_server_start(uint16_t max_queues,
+                             SocketAddress *socket_addr,
+                             AioContext *ctx,
+                             VuServer *server,
+                             void *device_panic_notifier,
+                             const VuDevIface *vu_iface,
+                             Error **errp)
+{
+    server->listener = qio_net_listener_new();
+    if (qio_net_listener_open_sync(server->listener, socket_addr, 1,
+                                   errp) < 0) {
+        goto error;
+    }
+
+    qio_net_listener_set_name(server->listener, "vhost-user-backend-listener");
+
+    server->vu_iface = vu_iface;
+    server->max_queues = max_queues;
+    server->ctx = ctx;
+    server->device_panic_notifier = device_panic_notifier;
+    qio_net_listener_set_client_func(server->listener,
+                                     vu_accept,
+                                     server,
+                                     NULL);
+
+    return true;
+error:
+    g_free(server);
+    return false;
+}
diff --git a/util/vhost-user-server.h b/util/vhost-user-server.h
new file mode 100644
index 0000000000..4315556b66
--- /dev/null
+++ b/util/vhost-user-server.h
@@ -0,0 +1,59 @@
+/*
+ * Sharing QEMU devices via vhost-user protocol
+ *
+ * Author: Coiby Xu <coiby.xu@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef VHOST_USER_SERVER_H
+#define VHOST_USER_SERVER_H
+
+#include "contrib/libvhost-user/libvhost-user.h"
+#include "io/channel-socket.h"
+#include "io/channel-file.h"
+#include "io/net-listener.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "standard-headers/linux/virtio_blk.h"
+
+typedef struct KickInfo {
+    VuDev *vu_dev;
+    int fd; /*kick fd*/
+    long index; /*queue index*/
+    vu_watch_cb cb;
+} KickInfo;
+
+typedef struct VuServer {
+    QIONetListener *listener;
+    AioContext *ctx;
+    void (*device_panic_notifier)(struct VuServer *server) ;
+    int max_queues;
+    const VuDevIface *vu_iface;
+    VuDev vu_dev;
+    QIOChannel *ioc; /* The I/O channel with the client */
+    QIOChannelSocket *sioc; /* The underlying data channel with the client */
+    /* IOChannel for fd provided via VHOST_USER_SET_SLAVE_REQ_FD */
+    QIOChannel *ioc_slave;
+    QIOChannelSocket *sioc_slave;
+    Coroutine *co_trip; /* coroutine for processing VhostUserMsg */
+    KickInfo *kick_info; /* an array with the length of the queue number */
+    /* restart coroutine co_trip if AIOContext is changed */
+    bool aio_context_changed;
+} VuServer;
+
+
+bool vhost_user_server_start(uint16_t max_queues,
+                             SocketAddress *unix_socket,
+                             AioContext *ctx,
+                             VuServer *server,
+                             void *device_panic_notifier,
+                             const VuDevIface *vu_iface,
+                             Error **errp);
+
+void vhost_user_server_stop(VuServer *server);
+
+void vhost_user_server_set_aio_context(AioContext *ctx, VuServer *server);
+
+#endif /* VHOST_USER_SERVER_H */
-- 
2.26.2


