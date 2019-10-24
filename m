Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1423FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB83205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="llIZWlyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB83205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZOd-0006Lu-KG
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9R-0007yt-3t
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9P-0004ek-Ha
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ9P-0004eD-8r
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94MsZ094853;
 Thu, 24 Oct 2019 09:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=l66KlTAWkx0rgCkIPA/MorNRjDtMjhAx90rI/SU9Rmw=;
 b=llIZWlyMiAoZv8TkzRvloRF3RBx3ujdDXKugadF0v+IiCVnJSwyao9pmTJhDG9eyhsGi
 sKEcjKvBA7B0TMLdv4UFBzcgf3u9ezk4nwIBa+fWQp8NqwuatBnztHFF11sLu7oYsvFZ
 UK8WdESP4it3TVIZ4oaA58cNGMdAUDdOwPmtrrxn1nOZ18I2oGwdqKw3AQ1KL/FiBQql
 N3oe3cYWF1ivBKraVuYNb37HVUVDLRz4xV8FPt0o7zcIryo+lQMTvLfpwGRAnqHhb4hZ
 kGL1GX4dSC6Scra0VDgoM7w38ljcxHuFIqGw0rxKxo5s4Y9sG66gpbcZTu/0dDc3aWvC SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2vqu4r24r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98mPR076184;
 Thu, 24 Oct 2019 09:11:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2vtjkj2ymu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:15 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9BDZr012107;
 Thu, 24 Oct 2019 09:11:13 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:13 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 32/49] multi-process: Use separate MMIO communication
 channel
Date: Thu, 24 Oct 2019 05:09:13 -0400
Message-Id: <b2594fdefb278f890762d12639524c4db7667393.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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

Using a separate communication channel for MMIO helps
with improving Performance

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 New patch in v3

 hw/proxy/qemu-proxy.c         | 39 +++++++++++++++++++++++++++------------
 include/hw/proxy/qemu-proxy.h |  1 +
 include/io/mpqemu-link.h      |  7 +++++++
 io/mpqemu-link.c              |  2 ++
 qdev-monitor.c                |  1 +
 remote/remote-main.c          | 18 +++++++++++++-----
 6 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 691b991..74aecd3 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -201,20 +201,22 @@ static int make_argv(char *command_str, char **argv, int argc)
 int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
 {
     pid_t rpid;
-    int fd[2] = {-1, -1};
+    int fd[2], mmio[2];
     Error *local_error = NULL;
     char *argv[64];
     int argc = 0, _argc;
     char *sfd;
     char *exec_dir;
     int rc = -EINVAL;
+    struct timeval timeout = {.tv_sec = 10, .tv_usec = 0};
 
     if (pdev->managed) {
         /* Child is forked by external program (such as libvirt). */
         return rc;
     }
 
-    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd) ||
+        socketpair(AF_UNIX, SOCK_STREAM, 0, mmio)) {
         error_setg(errp, "Unable to create unix socket.");
         return rc;
     }
@@ -222,6 +224,8 @@ int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
     argc = add_argv(exec_dir, argv, argc);
     sfd = g_strdup_printf("%d", fd[1]);
     argc = add_argv(sfd, argv, argc);
+    sfd = g_strdup_printf("%d", mmio[1]);
+    argc = add_argv(sfd, argv, argc);
     _argc = argc;
     argc = make_argv((char *)command, argv, argc);
 
@@ -231,22 +235,32 @@ int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
     if (rpid == -1) {
         error_setg(errp, "Unable to spawn emulation program.");
         close(fd[0]);
+        close(mmio[0]);
         goto fail;
     }
 
     if (rpid == 0) {
         close(fd[0]);
+        close(mmio[0]);
         execvp(argv[0], (char *const *)argv);
         exit(1);
     }
     pdev->remote_pid = rpid;
     pdev->rsocket = fd[1];
     pdev->socket = fd[0];
+    pdev->mmio_sock = mmio[0];
+
+    if (setsockopt(mmio[0], SOL_SOCKET, SO_RCVTIMEO, (char *)&timeout,
+                   sizeof(timeout)) < 0) {
+        error_setg(errp, "Unable to set timeout for socket");
+        goto fail;
+    }
 
     rc = 0;
 
 fail:
     close(fd[1]);
+    close(mmio[1]);
 
     for (int i = 0; i < _argc; i++) {
         g_free(argv[i]);
@@ -443,6 +457,9 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
     mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
                         pdev->socket);
 
+    mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->mmio,
+                        pdev->mmio_sock);
+
     configure_memory_sync(pdev->sync, pdev->mpqemu_link);
 }
 
@@ -503,8 +520,7 @@ static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
                                 unsigned size, bool memory)
 {
     MPQemuLinkState *mpqemu_link = dev->mpqemu_link;
-    MPQemuMsg msg;
-    int wait;
+    MPQemuMsg msg, ret;
 
     memset(&msg, 0, sizeof(MPQemuMsg));
 
@@ -518,19 +534,18 @@ static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
         msg.cmd = BAR_WRITE;
         msg.data1.bar_access.val = *val;
     } else {
-        wait = GET_REMOTE_WAIT;
-
         msg.cmd = BAR_READ;
-        msg.num_fds = 1;
-        msg.fds[0] = wait;
     }
 
-    mpqemu_msg_send(mpqemu_link, &msg, mpqemu_link->com);
+    mpqemu_msg_send(mpqemu_link, &msg, mpqemu_link->mmio);
 
-    if (!write) {
-        *val = wait_for_remote(wait);
-        PUT_REMOTE_WAIT(wait);
+    if (write) {
+        return;
     }
+
+    mpqemu_msg_recv(mpqemu_link, &ret, mpqemu_link->mmio);
+
+    *val = ret.data1.mmio_ret.val;
 }
 
 void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index ac61a9b..5e858cc 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -71,6 +71,7 @@ struct PCIProxyDev {
     pid_t remote_pid;
     int rsocket;
     int socket;
+    int mmio_sock;
 
     char *rid;
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 16a913b..4911eea 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -73,6 +73,7 @@ typedef enum {
     DEVICE_ADD,
     DEVICE_DEL,
     PROXY_PING,
+    MMIO_RETURN,
     MAX,
 } mpqemu_cmd_t;
 
@@ -107,6 +108,10 @@ typedef struct {
 } set_irqfd_msg_t;
 
 typedef struct {
+    uint64_t val;
+} mmio_ret_msg_t;
+
+typedef struct {
     mpqemu_cmd_t cmd;
     int bytestream;
     size_t size;
@@ -116,6 +121,7 @@ typedef struct {
         sync_sysmem_msg_t sync_sysmem;
         bar_access_msg_t bar_access;
         set_irqfd_msg_t set_irqfd;
+        mmio_ret_msg_t mmio_ret;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
@@ -170,6 +176,7 @@ typedef struct MPQemuLinkState {
     GMainLoop *loop;
 
     MPQemuChannel *com;
+    MPQemuChannel *mmio;
 
     mpqemu_link_callback callback;
 } MPQemuLinkState;
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 696aeb1..d91936e 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -77,6 +77,7 @@ void mpqemu_link_finalize(MPQemuLinkState *s)
     g_main_loop_quit(s->loop);
 
     mpqemu_destroy_channel(s->com);
+    mpqemu_destroy_channel(s->mmio);
 
     object_unref(OBJECT(s));
 }
@@ -344,6 +345,7 @@ void mpqemu_start_coms(MPQemuLinkState *s)
 {
 
     g_assert(g_source_attach(&s->com->gsrc, s->ctx));
+    g_assert(g_source_attach(&s->mmio->gsrc, s->ctx));
 
     g_main_loop_run(s->loop);
 }
diff --git a/qdev-monitor.c b/qdev-monitor.c
index e1d05e4..f38849e 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -711,6 +711,7 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
     if (old_pdev) {
         pdev->rsocket = old_pdev->rsocket;
         pdev->socket = old_pdev->socket;
+        pdev->mmio_sock = old_pdev->mmio_sock;
         pdev->remote_pid = old_pdev->remote_pid;
     } else {
         pdev->rsocket = managed ? rsocket : -1;
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 27e4492..0a1326d 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -117,8 +117,8 @@ static void process_bar_write(MPQemuMsg *msg, Error **errp)
 static void process_bar_read(MPQemuMsg *msg, Error **errp)
 {
     bar_access_msg_t *bar_access = &msg->data1.bar_access;
+    MPQemuMsg ret = { 0 };
     AddressSpace *as;
-    int wait = msg->fds[0];
     MemTxResult res;
     uint64_t val = 0;
 
@@ -152,9 +152,10 @@ static void process_bar_read(MPQemuMsg *msg, Error **errp)
     }
 
 fail:
-    notify_proxy(wait, val);
-
-    PUT_REMOTE_WAIT(wait);
+    ret.cmd = MMIO_RETURN;
+    ret.data1.mmio_ret.val = val;
+    ret.size = sizeof(ret.data1);
+    mpqemu_msg_send(mpqemu_link, &ret, mpqemu_link->mmio);
 }
 
 static void process_device_add_msg(MPQemuMsg *msg)
@@ -497,7 +498,14 @@ int main(int argc, char *argv[])
 
     mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, fd);
 
-    parse_cmdline(argc - 2, argv + 2, NULL);
+    fd = qemu_parse_fd(argv[2]);
+    if (fd == -1) {
+        printf("Failed to parse fd for remote process.\n");
+        return -EINVAL;
+    }
+    mpqemu_init_channel(mpqemu_link, &mpqemu_link->mmio, fd);
+
+    parse_cmdline(argc - 3, argv + 3, NULL);
 
     mpqemu_link_set_callback(mpqemu_link, process_msg);
 
-- 
1.8.3.1


