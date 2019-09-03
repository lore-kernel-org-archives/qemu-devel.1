Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA412168B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jnntvJFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA412168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Ffk-0004Ik-EX
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZf-00076r-9H
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZd-0008Vx-18
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZc-0008V5-P1
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXsN8053671;
 Tue, 3 Sep 2019 20:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=rIL8ld0p1Muqus2FHhkSfd2XH6KMqVn3unJf3ylmkjk=;
 b=jnntvJFUlZ7OHO1whaaCossJSB2zJN1sj1tEqMeiVDDftc/1OQZPQb0o5wY5NRbBsVsj
 wn6eov1v4PYKUTfh+KX8O6C33VkD8XPVSfy77oTDyrydXKiHxyWXouTnucYluRTttbgh
 gAn2euu9isjUHUnb5kAgWSP20Z49icixsPD/MjdUaCMTS03kla4BfRJ+OjT/spYkTVq0
 5e8FZt7VUtoAfY3HbmEBrQgvZQcGLc6UolpbdhLFXeqwQoDt6fQJAksWWZVFWLAI/xjG
 gdOb7Tc+eAH3bdpWU24LzDCkhU/T3VRNTYDxjmjSmTczLWLKiG9LAAqeKHfw2ZycBjnl +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2usy6n01xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcAHc025510;
 Tue, 3 Sep 2019 20:38:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2us5pha00d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:37 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KcYH1017392;
 Tue, 3 Sep 2019 20:38:34 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:33 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:33 -0400
Message-Id: <51220007b0f8a34cc72ff2847f5deb1f85c9c0e4.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC v3 PATCH 07/45] multi-process: define proxy-link
 object
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Defines proxy-link object which forms the communication link between
QEMU & emulation program.
Adds functions to configure members of proxy-link object instance.
Adds functions to send and receive messages over the communication
channel.
Adds GMainLoop to handle events received on the communication channel.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v1 -> v2:
   - Use default context for main loop instead of a new context

 v2 -> v3:
   - Enabled multi-channel support in the communication link

 include/glib-compat.h   |   4 +
 include/io/proxy-link.h | 147 ++++++++++++++++++++++++
 io/Makefile.objs        |   2 +
 io/proxy-link.c         | 292 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 445 insertions(+)
 create mode 100644 include/io/proxy-link.h
 create mode 100644 io/proxy-link.c

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 1291628..6189b9a 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -19,12 +19,16 @@
 /* Ask for warnings for anything that was marked deprecated in
  * the defined version, or before. It is a candidate for rewrite.
  */
+#ifndef GLIB_VERSION_MIN_REQUIRED
 #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
+#endif
 
 /* Ask for warnings if code tries to use function that did not
  * exist in the defined version. These risk breaking builds
  */
+#ifndef GLIB_VERSION_MAX_ALLOWED
 #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40
+#endif
 
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
new file mode 100644
index 0000000..ee78cdd
--- /dev/null
+++ b/include/io/proxy-link.h
@@ -0,0 +1,147 @@
+/*
+ * Communication channel between QEMU and remote device process
+ *
+ * Copyright 2019, Oracle and/or its affiliates.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef PROXY_LINK_H
+#define PROXY_LINK_H
+
+#include <stddef.h>
+#include <stdint.h>
+#include <glib.h>
+#include <pthread.h>
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "qemu/thread.h"
+
+typedef struct ProxyLinkState ProxyLinkState;
+
+#define TYPE_PROXY_LINK "proxy-link"
+#define PROXY_LINK(obj) \
+    OBJECT_CHECK(ProxyLinkState, (obj), TYPE_PROXY_LINK)
+
+#define REMOTE_MAX_FDS 8
+
+#define PROC_HDR_SIZE offsetof(ProcMsg, data1.u64)
+
+/*
+ * proc_cmd_t enum type to specify the command to be executed on the remote
+ * device
+ *
+ * Following commands are supported:
+ * CONF_READ        PCI config. space read
+ * CONF_WRITE       PCI config. space write
+ *
+ */
+typedef enum {
+    INIT = 0,
+    CONF_READ,
+    CONF_WRITE,
+    MAX,
+} proc_cmd_t;
+
+/*
+ * ProcMsg Format of the message sent to the remote device from QEMU
+ *
+ * cmd         The remote command
+ * bytestream  Indicates if the data to be shared is structured (data1)
+ *             or unstructured (data2)
+ * size        Size of the data to be shared
+ * data1       Structured data
+ * fds         File descriptors to be shared with remote device
+ * data2       Unstructured data
+ *
+ */
+typedef struct {
+    proc_cmd_t cmd;
+    int bytestream;
+    size_t size;
+
+    union {
+        uint64_t u64;
+    } data1;
+
+    int fds[REMOTE_MAX_FDS];
+    int num_fds;
+
+    uint8_t *data2;
+} ProcMsg;
+
+struct conf_data_msg {
+    uint32_t addr;
+    uint32_t val;
+    int l;
+};
+
+/*
+ * ProcChannel defines the channel that make up the communication link
+ * between QEMU and remote process
+ *
+ * gsrc       GSource object to be used by loop
+ * gpfd       GPollFD object containing the socket & events to monitor
+ * sock       Socket to send/receive communication, same as the one in gpfd
+ * lock       Mutex to synchronize access to the channel
+ */
+
+typedef struct ProcChannel {
+    GSource gsrc;
+    GPollFD gpfd;
+    int sock;
+    QemuMutex lock;
+} ProcChannel;
+
+typedef void (*proxy_link_callback)(GIOCondition cond, ProcChannel *chan);
+
+/*
+ * ProxyLinkState Instance info. of the communication
+ * link between QEMU and remote process. The Link could
+ * be made up of multiple channels.
+ *
+ * ctx        GMainContext to be used for communication
+ * loop       Main loop that would be used to poll for incoming data
+ * com        Communication channel to transport control messages
+ *
+ */
+struct ProxyLinkState {
+    Object obj;
+
+    GMainContext *ctx;
+    GMainLoop *loop;
+
+    ProcChannel *com;
+
+    proxy_link_callback callback;
+};
+
+ProxyLinkState *proxy_link_create(void);
+void proxy_link_finalize(ProxyLinkState *s);
+
+void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan);
+int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan);
+
+void proxy_link_init_channel(ProxyLinkState *s, ProcChannel **chan, int fd);
+void proxy_link_destroy_channel(ProcChannel *chan);
+void proxy_link_set_callback(ProxyLinkState *s, proxy_link_callback callback);
+void start_handler(ProxyLinkState *s);
+
+#endif
diff --git a/io/Makefile.objs b/io/Makefile.objs
index 9a20fce..ff88b46 100644
--- a/io/Makefile.objs
+++ b/io/Makefile.objs
@@ -10,3 +10,5 @@ io-obj-y += channel-util.o
 io-obj-y += dns-resolver.o
 io-obj-y += net-listener.o
 io-obj-y += task.o
+
+io-obj-$(CONFIG_MPQEMU) += proxy-link.o
diff --git a/io/proxy-link.c b/io/proxy-link.c
new file mode 100644
index 0000000..5eb9718
--- /dev/null
+++ b/io/proxy-link.c
@@ -0,0 +1,292 @@
+/*
+ * Communication channel between QEMU and remote device process
+ *
+ * Copyright 2019, Oracle and/or its affiliates.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#include "qemu/module.h"
+#include "io/proxy-link.h"
+#include "qemu/log.h"
+
+GSourceFuncs gsrc_funcs;
+
+static void proxy_link_inst_init(Object *obj)
+{
+    ProxyLinkState *s = PROXY_LINK(obj);
+
+    s->ctx = g_main_context_default();
+    s->loop = g_main_loop_new(s->ctx, FALSE);
+}
+
+static const TypeInfo proxy_link_info = {
+    .name = TYPE_PROXY_LINK,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(ProxyLinkState),
+    .instance_init = proxy_link_inst_init,
+};
+
+static void proxy_link_register_types(void)
+{
+    type_register_static(&proxy_link_info);
+}
+
+type_init(proxy_link_register_types)
+
+ProxyLinkState *proxy_link_create(void)
+{
+    return PROXY_LINK(object_new(TYPE_PROXY_LINK));
+}
+
+void proxy_link_finalize(ProxyLinkState *s)
+{
+    g_main_loop_unref(s->loop);
+    g_main_context_unref(s->ctx);
+    g_main_loop_quit(s->loop);
+
+    proxy_link_destroy_channel(s->com);
+
+    object_unref(OBJECT(s));
+}
+
+void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan)
+{
+    int rc;
+    uint8_t *data;
+    union {
+        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
+        struct cmsghdr align;
+    } u;
+    struct msghdr hdr;
+    struct cmsghdr *chdr;
+    int sock = chan->sock;
+    QemuMutex *lock = &chan->lock;
+
+    struct iovec iov = {
+        .iov_base = (char *) msg,
+        .iov_len = PROC_HDR_SIZE,
+    };
+
+    memset(&hdr, 0, sizeof(hdr));
+    memset(&u, 0, sizeof(u));
+
+    hdr.msg_iov = &iov;
+    hdr.msg_iovlen = 1;
+
+    if (msg->num_fds > REMOTE_MAX_FDS) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s: Max FDs exceeded\n", __func__);
+        return;
+    }
+
+    if (msg->num_fds > 0) {
+        size_t fdsize = msg->num_fds * sizeof(int);
+
+        hdr.msg_control = &u;
+        hdr.msg_controllen = sizeof(u);
+
+        chdr = CMSG_FIRSTHDR(&hdr);
+        chdr->cmsg_len = CMSG_LEN(fdsize);
+        chdr->cmsg_level = SOL_SOCKET;
+        chdr->cmsg_type = SCM_RIGHTS;
+        memcpy(CMSG_DATA(chdr), msg->fds, fdsize);
+        hdr.msg_controllen = CMSG_SPACE(fdsize);
+    }
+
+    qemu_mutex_lock(lock);
+
+    do {
+        rc = sendmsg(sock, &hdr, 0);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    if (rc < 0) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - sendmsg rc is %d, errno is %d,"
+                      " sock %d\n", __func__, rc, errno, sock);
+        qemu_mutex_unlock(lock);
+        return;
+    }
+
+    if (msg->bytestream) {
+        data = msg->data2;
+    } else {
+        data = (uint8_t *)msg + PROC_HDR_SIZE;
+    }
+
+    do {
+        rc = write(sock, data, msg->size);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    qemu_mutex_unlock(lock);
+}
+
+
+int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan)
+{
+    int rc;
+    uint8_t *data;
+    union {
+        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
+        struct cmsghdr align;
+    } u;
+    struct msghdr hdr;
+    struct cmsghdr *chdr;
+    size_t fdsize;
+    int sock = chan->sock;
+    QemuMutex *lock = &chan->lock;
+
+    struct iovec iov = {
+        .iov_base = (char *) msg,
+        .iov_len = PROC_HDR_SIZE,
+    };
+
+    memset(&hdr, 0, sizeof(hdr));
+    memset(&u, 0, sizeof(u));
+
+    hdr.msg_iov = &iov;
+    hdr.msg_iovlen = 1;
+    hdr.msg_control = &u;
+    hdr.msg_controllen = sizeof(u);
+
+    qemu_mutex_lock(lock);
+
+    do {
+        rc = recvmsg(sock, &hdr, 0);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    if (rc < 0) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - recvmsg rc is %d, errno is %d,"
+                      " sock %d\n", __func__, rc, errno, sock);
+        qemu_mutex_unlock(lock);
+        return rc;
+    }
+
+    msg->num_fds = 0;
+    for (chdr = CMSG_FIRSTHDR(&hdr); chdr != NULL;
+         chdr = CMSG_NXTHDR(&hdr, chdr)) {
+        if ((chdr->cmsg_level == SOL_SOCKET) &&
+            (chdr->cmsg_type == SCM_RIGHTS)) {
+            fdsize = chdr->cmsg_len - CMSG_LEN(0);
+            msg->num_fds = fdsize / sizeof(int);
+            memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
+            break;
+        }
+    }
+
+    if (msg->size && msg->bytestream) {
+        msg->data2 = calloc(1, msg->size);
+        data = msg->data2;
+    } else {
+        data = (uint8_t *)&msg->data1;
+    }
+
+    if (msg->size) {
+        do {
+            rc = read(sock, data, msg->size);
+        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+    }
+
+    qemu_mutex_unlock(lock);
+
+    return rc;
+}
+
+static gboolean proxy_link_handler_prepare(GSource *gsrc, gint *timeout)
+{
+    g_assert(timeout);
+
+    *timeout = -1;
+
+    return FALSE;
+}
+
+static gboolean proxy_link_handler_check(GSource *gsrc)
+{
+    ProcChannel *chan = (ProcChannel *)gsrc;
+
+    return chan->gpfd.events & chan->gpfd.revents;
+}
+
+static gboolean proxy_link_handler_dispatch(GSource *gsrc, GSourceFunc func,
+                                            gpointer data)
+{
+    ProxyLinkState *s = (ProxyLinkState *)data;
+    ProcChannel *chan = (ProcChannel *)gsrc;
+
+    s->callback(chan->gpfd.revents, chan);
+
+    if ((chan->gpfd.revents & G_IO_HUP) || (chan->gpfd.revents & G_IO_ERR)) {
+        return G_SOURCE_REMOVE;
+    }
+
+    return G_SOURCE_CONTINUE;
+}
+
+void proxy_link_set_callback(ProxyLinkState *s, proxy_link_callback callback)
+{
+    s->callback = callback;
+}
+
+void proxy_link_init_channel(ProxyLinkState *s, ProcChannel **chan, int fd)
+{
+    ProcChannel *src;
+
+    gsrc_funcs = (GSourceFuncs){
+        .prepare = proxy_link_handler_prepare,
+        .check = proxy_link_handler_check,
+        .dispatch = proxy_link_handler_dispatch,
+        .finalize = NULL,
+    };
+
+    src = (ProcChannel *)g_source_new(&gsrc_funcs, sizeof(ProcChannel));
+
+    src->sock = fd;
+    qemu_mutex_init(&src->lock);
+
+    g_source_set_callback(&src->gsrc, NULL, (gpointer)s, NULL);
+    src->gpfd.fd = fd;
+    src->gpfd.events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+    g_source_add_poll(&src->gsrc, &src->gpfd);
+
+    *chan = src;
+}
+
+void proxy_link_destroy_channel(ProcChannel *chan)
+{
+    g_source_unref(&chan->gsrc);
+    close(chan->sock);
+    qemu_mutex_destroy(&chan->lock);
+}
+
+void start_handler(ProxyLinkState *s)
+{
+
+    g_assert(g_source_attach(&s->com->gsrc, s->ctx));
+
+    g_main_loop_run(s->loop);
+}
-- 
1.8.3.1


