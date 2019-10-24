Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695D4CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327172054F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WlXgIuAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327172054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZTB-00045d-Et
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9J-0007kH-MP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9I-0004ax-91
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ9I-0004aR-0Y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94PLv099615;
 Thu, 24 Oct 2019 09:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=ebV6oC/8fSrgf06J90TefQwjgoQsuTXaEyR97j528Es=;
 b=WlXgIuAsgj1b+ry0nmPCphS1aNslFh66yufRnFiaSDJBui7PuHsUh9NoHJcWOL5oXAhk
 zkM3yoL+1oHFUckZEADgR4O3ipRRFzzxwdI3ZAQmLLX4+3x0h8SPnCjEFZULdPnUefLH
 AADpj5jLWiB03v8AYw4pYaPozgWhi1laT7VubqE1R71RMarq4VMjP+BMXAhNHNTQKioX
 Nbz6nbrP6u0YoXGylhSGKO3n6r3ficeqChRS1HulITduTRDG6Mfn2RJeM9Xg0CzSlXpD
 Ko0QPHuyao+DLizR02l9SvuM2cyAhZTaKggovsgn0K2HAogldipcOtqplYgldn57YLCs Sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2vqteq2ahf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98MBg047206;
 Thu, 24 Oct 2019 09:11:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2vu0fnu7y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:09 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9B7lM012080;
 Thu, 24 Oct 2019 09:11:07 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:07 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 30/49] multi-process: send heartbeat messages to remote
Date: Thu, 24 Oct 2019 05:09:11 -0400
Message-Id: <14c33104778e77fcf2e7f0df2a1dd96fbcaf49d7.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=931
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
X-Received-From: 141.146.126.78
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

In order to detect remote processes which are hung, the
proxy periodically sends heartbeat messages to confirm if
the remote process is alive

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hw/proxy/qemu-proxy.c    | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 include/io/mpqemu-link.h |   1 +
 2 files changed, 102 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index fc1c731..691b991 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -53,14 +53,96 @@
 #include "hw/boards.h"
 #include "include/qemu/log.h"
 
+QEMUTimer *hb_timer;
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 static void setup_irqfd(PCIProxyDev *dev);
+static void pci_dev_exit(PCIDevice *dev);
+static void start_heartbeat_timer(void);
+static void stop_heartbeat_timer(void);
+static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx);
+static void broadcast_msg(MPQemuMsg *msg, bool need_reply);
+
+static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
+{
+    /* TODO: Add proper handler. */
+    printf("Child (pid %d) is dead? Signal is %d, Exit code is %d.\n",
+           siginfo->si_pid, siginfo->si_signo, siginfo->si_code);
+}
+
+static void broadcast_msg(MPQemuMsg *msg, bool need_reply)
+{
+    PCIProxyDev *entry;
+    unsigned int pid;
+    int wait;
+
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (need_reply) {
+            wait = eventfd(0, EFD_NONBLOCK);
+            msg->num_fds = 1;
+            msg->fds[0] = wait;
+        }
+
+        mpqemu_msg_send(entry->mpqemu_link, msg, entry->mpqemu_link->com);
+        if (need_reply) {
+            pid = (uint32_t)wait_for_remote(wait);
+            close(wait);
+            /* TODO: Add proper handling. */
+            if (pid) {
+                need_reply = 0;
+            }
+        }
+    }
+}
+
+#define NOP_INTERVAL 1000000
+
+static void remote_ping(void *opaque)
+{
+    MPQemuMsg msg;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+
+    msg.num_fds = 0;
+    msg.cmd = PROXY_PING;
+    msg.bytestream = 0;
+    msg.size = 0;
+
+    broadcast_msg(&msg, true);
+    timer_mod(hb_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+
+}
+
+void start_heartbeat_timer(void)
+{
+    hb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                            remote_ping,
+                                            &proxy_dev_list);
+    timer_mod(hb_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+
+}
+
+static void stop_heartbeat_timer(void)
+{
+    timer_del(hb_timer);
+    timer_free(hb_timer);
+}
+
+static void set_sigchld_handler(void)
+{
+    struct sigaction sa_sigterm;
+    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
+    sa_sigterm.sa_sigaction = childsig_handler;
+    sa_sigterm.sa_flags = SA_SIGINFO | SA_NOCLDWAIT | SA_NOCLDSTOP;
+    sigaction(SIGCHLD, &sa_sigterm, NULL);
+}
 
 static void proxy_ready(PCIDevice *dev)
 {
     PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
 
     setup_irqfd(pdev);
+    set_sigchld_handler();
+    start_heartbeat_timer();
 }
 
 static void set_remote_opts(PCIDevice *dev, QDict *qdict, unsigned int cmd)
@@ -259,6 +341,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
+    k->exit = pci_dev_exit;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
 }
@@ -397,6 +480,24 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->proxy_ready = proxy_ready;
 }
 
+static void pci_dev_exit(PCIDevice *pdev)
+{
+    PCIProxyDev *entry, *sentry;
+    PCIProxyDev *dev = PCI_PROXY_DEV(pdev);
+
+    stop_heartbeat_timer();
+
+    QLIST_FOREACH_SAFE(entry, &proxy_dev_list.devices, next, sentry) {
+        if (entry->remote_pid == dev->remote_pid) {
+            QLIST_REMOVE(entry, next);
+        }
+    }
+
+    if (!QLIST_EMPTY(&proxy_dev_list.devices)) {
+        start_heartbeat_timer();
+    }
+}
+
 static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
                                 bool write, hwaddr addr, uint64_t *val,
                                 unsigned size, bool memory)
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 3145b0e..16a913b 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -72,6 +72,7 @@ typedef enum {
     DRIVE_OPTS,
     DEVICE_ADD,
     DEVICE_DEL,
+    PROXY_PING,
     MAX,
 } mpqemu_cmd_t;
 
-- 
1.8.3.1


