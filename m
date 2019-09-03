Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38074C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31E42087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HnimO1EZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31E42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fup-0002h5-TK
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaK-0007w7-LV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaI-0000kv-BX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaG-0000hN-AD
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KYEoK066594;
 Tue, 3 Sep 2019 20:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=VQ9r5agpFPvXZaIGif5pk3x4EE+3DdMUY+fVfpqcJ6s=;
 b=HnimO1EZrxUVtVAsN0RNGWek6HEny0kSgTOGvxFo6PIvvidcVhRMKhT+AXRn24Ck4hfD
 dDo5rCdHo0jpWOrbe5g3LGv1B85xGiCVlpR2/pXZTWLQ/bmecmL2uJskaOHa6FEq5x5H
 e6sfbbNoD7JqjaSvwLBcVEv7TT1j6+Y4MIXsdRfADQLZGSOCBFmwJWOXakVvdBIPBezQ
 3Nycpu7iF1SlEwZfiNA+5LSAcPwdmE0E+038rowP6oFWHaJqeMztwHHzTXd45rF0KhpE
 wADdBLO4twnNhfatmboBc35zVfg9vN4uyWsEme4aWjirH9R4FQSVhHpGiaboMScu3lK/ nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2usy4u8338-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83Kcb0T178493;
 Tue, 3 Sep 2019 20:39:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2us4wegr80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KdHpr012834;
 Tue, 3 Sep 2019 20:39:17 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:16 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:38:00 -0400
Message-Id: <65301af8f70273575a6757580e282ef5401b47af.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC v3 PATCH 34/45] multi-process: add heartbeat
 timer and signal handler
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

Add a signal handler for launched remote processes and set up
the heartbeat timer for remote processes.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c   | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/io/proxy-link.h |   1 +
 2 files changed, 102 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 61808c5..699a0b1 100644
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
+static void broadcast_msg(ProcMsg *msg, bool need_reply);
+
+static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
+{
+    /* TODO: Add proper handler. */
+    printf("Child (pid %d) is dead? Signal is %d, Exit code is %d.\n",
+           siginfo->si_pid, siginfo->si_signo, siginfo->si_code);
+}
+
+static void broadcast_msg(ProcMsg *msg, bool need_reply)
+{
+    PCIProxyDev *entry;
+    unsigned int pid;
+    int wait;
+
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (need_reply) {
+            wait = GET_REMOTE_WAIT;
+            msg->num_fds = 1;
+            msg->fds[0] = wait;
+        }
+
+        proxy_proc_send(entry->proxy_link, msg, entry->proxy_link->com);
+        if (need_reply) {
+            pid = (uint32_t)wait_for_remote(wait);
+            PUT_REMOTE_WAIT(wait);
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
+    ProcMsg msg;
+
+    memset(&msg, 0, sizeof(ProcMsg));
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
@@ -272,6 +354,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
+    k->exit = pci_dev_exit;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
 }
@@ -408,6 +491,24 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
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
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 13fb312..ae98eac 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -74,6 +74,7 @@ typedef enum {
     DRIVE_OPTS,
     DEVICE_ADD,
     DEVICE_DEL,
+    PROXY_PING,
     MAX,
 } proc_cmd_t;
 
-- 
1.8.3.1


