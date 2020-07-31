Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB064C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F00E208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E6go9cFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F00E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ZtV-0005NP-S3
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZgX-0004bX-Lw
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:23:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZgV-0005cp-JI
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:23:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIN38i119524;
 Fri, 31 Jul 2020 18:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=9l9pS4Sinj0utCiirwhSm+iEc4fU8TW4CMeiAbDwD2I=;
 b=E6go9cFL4DqMmpI4TYkXKYfCFN4ltAa8B/1ZV3EWPd8ycxsGOp9+yAROtkf7knvzvBoy
 8SUMS8le//dlzYU81zEfn7FwJl69Ik0tPzVQciB3QLdGP/4sgjjqtIlElLshtYNexQUl
 CMiEWdsU3NvMh68tThhmf9smInVXtft4Y8U8PkCk7P+QdBwu5PCYG2qylFQWHoRLP/bm
 9nzBtNJkGiwolavx1wracGh4LSBtHGerOA85k0f9gEbwWaFfKrf4EgbKfJ3IiG+Dwz9N
 87g9D7NApmuFZwc3cUegYdUOAyYyLBFuR1q7XM8uWUe6wtsTGOBT3MM1RUikYndVlE+g Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32hu1jtgbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:23:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIIcTL137654;
 Fri, 31 Jul 2020 18:21:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 32hu64r7jn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:21:02 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VIL11w023774;
 Fri, 31 Jul 2020 18:21:01 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:21:01 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 17/20] multi-process: heartbeat messages to remote
Date: Fri, 31 Jul 2020 14:20:24 -0400
Message-Id: <93b7566e5d565b9e5d8127849bb5be65057e25cc.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=3 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
Received-SPF: pass client-ip=156.151.31.86; envelope-from=jag.raman@oracle.com;
 helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:51:59
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

In order to detect remote processes which are hung, the
proxy periodically sends heartbeat messages to confirm if
the remote process is alive. The remote process responds
to this heartbeat message to confirm it is alive.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hw/i386/remote-msg.c     | 19 ++++++++++++++++++
 hw/pci/proxy.c           | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/proxy.h   |  2 ++
 include/io/mpqemu-link.h |  1 +
 io/mpqemu-link.c         |  8 ++++++++
 5 files changed, 82 insertions(+)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 756b710..2a4d7f1 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -26,6 +26,7 @@ static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
                                 MPQemuMsg *msg);
 static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
 static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
+static void process_proxy_ping_msg(QIOChannel *ioc, Error **errp);
 
 gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
                             gpointer opaque)
@@ -75,6 +76,9 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
     case SET_IRQFD:
         process_set_irqfd_msg(pci_dev, &msg);
         break;
+    case PROXY_PING:
+        process_proxy_ping_msg(ioc, &local_err);
+        break;
     default:
         error_setg(&local_err,
                    "Unknown command (%d) received for device %s (pid=%d)",
@@ -223,3 +227,18 @@ fail:
                    "in remote process pid=%d", getpid());
     }
 }
+
+static void process_proxy_ping_msg(QIOChannel *ioc, Error **errp)
+{
+    MPQemuMsg ret = { 0 };
+    Error *local_err = NULL;
+
+    ret.cmd = RET_MSG;
+    ret.size = sizeof(ret.data1);
+
+    mpqemu_msg_send(&ret, ioc, &local_err);
+    if (local_err) {
+        error_setg(errp, "Error while sending message to proxy "
+                   "in remote process pid=%d", getpid());
+    }
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 50a806c..490093c 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -24,6 +24,8 @@
 #include "util/event_notifier-posix.c"
 
 static void probe_pci_info(PCIDevice *dev, Error **errp);
+static void start_hb_timer(PCIProxyDev *dev);
+static void stop_hb_timer(PCIProxyDev *dev);
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -111,6 +113,8 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     setup_irqfd(dev);
 
     probe_pci_info(PCI_DEVICE(dev), errp);
+
+    start_hb_timer(dev);
 }
 
 static void pci_proxy_dev_exit(PCIDevice *pdev)
@@ -123,6 +127,8 @@ static void pci_proxy_dev_exit(PCIDevice *pdev)
 
     event_notifier_cleanup(&dev->intr);
     event_notifier_cleanup(&dev->resample);
+
+    stop_hb_timer(dev);
 }
 
 static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
@@ -343,3 +349,49 @@ static void probe_pci_info(PCIDevice *dev, Error **errp)
         }
     }
 }
+
+static void hb_msg(PCIProxyDev *dev)
+{
+    DeviceState *ds = DEVICE(dev);
+    Error *local_err = NULL;
+    MPQemuMsg msg = { 0 };
+
+    msg.cmd = PROXY_PING;
+    msg.bytestream = 0;
+    msg.size = 0;
+
+    (void)mpqemu_msg_send_and_await_reply(&msg, dev->ioc, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        qio_channel_close(dev->ioc, &local_err);
+        error_setg(&error_fatal, "Lost contact with device %s", ds->id);
+    }
+}
+
+#define NOP_INTERVAL 1000
+
+static void remote_ping(void *opaque)
+{
+    PCIProxyDev *dev = opaque;
+
+    hb_msg(dev);
+
+    timer_mod(dev->hb_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+}
+
+static void start_hb_timer(PCIProxyDev *dev)
+{
+    dev->hb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                 remote_ping,
+                                 dev);
+
+    timer_mod(dev->hb_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+}
+
+static void stop_hb_timer(PCIProxyDev *dev)
+{
+    timer_del(dev->hb_timer);
+    timer_free(dev->hb_timer);
+}
diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
index 15cc381..d784328 100644
--- a/include/hw/pci/proxy.h
+++ b/include/hw/pci/proxy.h
@@ -40,6 +40,8 @@ struct PCIProxyDev {
     EventNotifier intr;
     EventNotifier resample;
 
+    QEMUTimer *hb_timer;
+
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
 };
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index a3844e1..5f2913f 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -40,6 +40,7 @@ typedef enum {
     BAR_READ,
     SET_IRQFD,
     GET_PCI_INFO,
+    PROXY_PING,
     MAX = INT_MAX,
 } MPQemuCmd;
 
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 6fa4665..0222e81 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -280,6 +280,14 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case PROXY_PING:
+        if (msg->bytestream || msg->num_fds) {
+            return false;
+        }
+        if (msg->size) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
1.8.3.1


