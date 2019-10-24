Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3A4CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AE7205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gtjgqDVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AE7205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZHI-0002yd-EZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8b-00064V-6H
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8Z-00043T-66
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ8Y-00041Y-TU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94LIG094836;
 Thu, 24 Oct 2019 09:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=qYoZC9x0tbqOjuZQfNS9Uj1BU8a5ImRmaM0qKlTS+cI=;
 b=gtjgqDVl2cocU7a1jAKvQFpaDx3AedyCGc9nGISXyU54njc5N3VvFOXsylgflMhnDunN
 xQMHmpfIVH/YGynu1re1nWdfWB2tA6BupFRBlQY1MMi1yQbl2wFpcHM9+GQnZAiINBtR
 avSXmOd8VYLuT4CpxOdtTXo/W15mV6BWUhJMWJ6q3vskDLxLKvapJYRh1TmdN6X69scR
 HeneNbqL5VE2DbJhHGpvSdp7NEKsU9Yd5gamcLQV2Jg1KOaJni7cgaWouAivIb5cfhst
 kXYtknnF5iZe2ifscNgWw4Xy9PhKWg1/Bd5IBmdiUfMVLi/Vh6Yl3kzIAT1cDDhym3Pe Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2vqu4r24mv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98L4f047087;
 Thu, 24 Oct 2019 09:10:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2vu0fnu6sv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:24 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9AOsS002027;
 Thu, 24 Oct 2019 09:10:24 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:10:23 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 13/49] multi-process: introduce proxy object
Date: Thu, 24 Oct 2019 05:08:54 -0400
Message-Id: <64276bb78fce32a6ddf4356bf29632af1ef2c785.1571905346.git.jag.raman@oracle.com>
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Defines a PCI Device proxy object as a parent of TYPE_PCI_DEVICE.
PCI Proxy Object is responsible for registering PCI BARs,i
MemoryRegionOps to handle access to the BARs and forwarding those
to the remote device.
PCI Proxy object intercepts config space reads and writes. In case
of pci config write it forwards it to the remote device using
communication channel set by proxy-link object.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/Makefile.objs              |   2 +
 hw/proxy/Makefile.objs        |   1 +
 hw/proxy/qemu-proxy.c         | 247 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  81 ++++++++++++++
 remote/remote-main.c          |  28 +++++
 5 files changed, 359 insertions(+)
 create mode 100644 hw/proxy/Makefile.objs
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/qemu-proxy.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 4e28053..e016100 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -44,6 +44,8 @@ endif
 common-obj-y += $(devices-dirs-y)
 obj-y += $(devices-dirs-y)
 
+common-obj-$(CONFIG_MPQEMU) += proxy/
+
 remote-pci-obj-$(CONFIG_MPQEMU) += core/
 remote-pci-obj-$(CONFIG_MPQEMU) += block/
 remote-pci-obj-$(CONFIG_MPQEMU) += pci/
diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
new file mode 100644
index 0000000..eb81624
--- /dev/null
+++ b/hw/proxy/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_MPQEMU) += qemu-proxy.o
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
new file mode 100644
index 0000000..baba4da
--- /dev/null
+++ b/hw/proxy/qemu-proxy.c
@@ -0,0 +1,247 @@
+/*
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <unistd.h>
+#include <assert.h>
+#include <string.h>
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "io/mpqemu-link.h"
+#include "exec/memory.h"
+#include "exec/cpu-common.h"
+#include "exec/address-spaces.h"
+#include "qemu/int128.h"
+#include "qemu/range.h"
+#include "hw/pci/pci.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
+#include "sysemu/sysemu.h"
+#include "hw/proxy/qemu-proxy.h"
+
+static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
+
+int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
+{
+    char *args[3];
+    pid_t rpid;
+    int fd[2] = {-1, -1};
+    Error *local_error = NULL;
+
+    if (pdev->managed) {
+        /* Child is forked by external program (such as libvirt). */
+        return -1;
+    }
+
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
+        error_setg(errp, "Unable to create unix socket.");
+        return -1;
+    }
+    /* TODO: Restrict the forked process' permissions and capabilities. */
+    rpid = qemu_fork(&local_error);
+
+    if (rpid == -1) {
+        error_setg(errp, "Unable to spawn emulation program.");
+        close(fd[0]);
+        close(fd[1]);
+        return -1;
+    }
+
+    if (rpid == 0) {
+        close(fd[0]);
+
+        args[0] = g_strdup(command);
+        args[1] = g_strdup_printf("%d", fd[1]);
+        args[2] = NULL;
+        execvp(args[0], (char *const *)args);
+        exit(1);
+    }
+    pdev->remote_pid = rpid;
+    pdev->rsocket = fd[0];
+
+    close(fd[1]);
+
+    return 0;
+}
+
+static int get_proxy_sock(PCIDevice *dev)
+{
+    PCIProxyDev *pdev;
+
+    pdev = PCI_PROXY_DEV(dev);
+
+    return pdev->rsocket;
+}
+
+static void set_proxy_sock(PCIDevice *dev, int socket)
+{
+    PCIProxyDev *pdev;
+
+    pdev = PCI_PROXY_DEV(dev);
+
+    pdev->rsocket = socket;
+    pdev->managed = true;
+
+}
+
+static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
+                          unsigned int op)
+{
+    MPQemuMsg msg;
+    struct conf_data_msg conf_data;
+    int wait;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+    conf_data.addr = addr;
+    conf_data.val = (op == CONF_WRITE) ? *val : 0;
+    conf_data.l = l;
+
+    msg.data2 = (uint8_t *)malloc(sizeof(conf_data));
+    if (!msg.data2) {
+        return -ENOMEM;
+    }
+
+    memcpy(msg.data2, (const uint8_t *)&conf_data, sizeof(conf_data));
+    msg.size = sizeof(conf_data);
+    msg.cmd = op;
+    msg.bytestream = 1;
+
+    if (op == CONF_WRITE) {
+        msg.num_fds = 0;
+    } else {
+        wait = GET_REMOTE_WAIT;
+        msg.num_fds = 1;
+        msg.fds[0] = wait;
+    }
+
+    mpqemu_msg_send(dev->mpqemu_link, &msg, dev->mpqemu_link->com);
+
+    if (op == CONF_READ) {
+        *val = (uint32_t)wait_for_remote(wait);
+        PUT_REMOTE_WAIT(wait);
+    }
+
+    free(msg.data2);
+
+    return 0;
+}
+
+static uint32_t pci_proxy_read_config(PCIDevice *d, uint32_t addr, int len)
+{
+    uint32_t val;
+
+    (void)pci_default_read_config(d, addr, len);
+
+    config_op_send(PCI_PROXY_DEV(d), addr, &val, len, CONF_READ);
+
+    return val;
+}
+
+static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
+                                   int l)
+{
+    pci_default_write_config(d, addr, val, l);
+
+    config_op_send(PCI_PROXY_DEV(d), addr, &val, l, CONF_WRITE);
+}
+
+static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = pci_proxy_dev_realize;
+    k->config_read = pci_proxy_read_config;
+    k->config_write = pci_proxy_write_config;
+}
+
+static const TypeInfo pci_proxy_dev_type_info = {
+    .name          = TYPE_PCI_PROXY_DEV,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIProxyDev),
+    .abstract      = true,
+    .class_size    = sizeof(PCIProxyDevClass),
+    .class_init    = pci_proxy_dev_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void pci_proxy_dev_register_types(void)
+{
+    type_register_static(&pci_proxy_dev_type_info);
+}
+
+type_init(pci_proxy_dev_register_types)
+
+static void init_proxy(PCIDevice *dev, char *command, Error **errp)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    Error *local_error = NULL;
+
+    if (!pdev->managed) {
+        if (command) {
+            remote_spawn(pdev, command, &local_error);
+        } else {
+            return;
+        }
+    } else {
+        pdev->remote_pid = atoi(pdev->rid);
+        if (pdev->remote_pid == -1) {
+            error_setg(errp, "Remote PID is -1");
+            return;
+        }
+    }
+
+    pdev->mpqemu_link = mpqemu_link_create();
+
+    if (!pdev->mpqemu_link) {
+        error_setg(errp, "Failed to create proxy link");
+        return;
+    }
+
+    mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
+                        pdev->socket);
+}
+
+static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(device);
+    PCIProxyDevClass *k = PCI_PROXY_DEV_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    if (k->realize) {
+        k->realize(dev, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+        }
+    }
+
+    dev->set_proxy_sock = set_proxy_sock;
+    dev->get_proxy_sock = get_proxy_sock;
+    dev->init_proxy = init_proxy;
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
new file mode 100644
index 0000000..3648a77
--- /dev/null
+++ b/include/hw/proxy/qemu-proxy.h
@@ -0,0 +1,81 @@
+/*
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
+#ifndef QEMU_PROXY_H
+#define QEMU_PROXY_H
+
+#include "io/mpqemu-link.h"
+
+#define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
+
+#define PCI_PROXY_DEV(obj) \
+            OBJECT_CHECK(PCIProxyDev, (obj), TYPE_PCI_PROXY_DEV)
+
+#define PCI_PROXY_DEV_CLASS(klass) \
+            OBJECT_CLASS_CHECK(PCIProxyDevClass, (klass), TYPE_PCI_PROXY_DEV)
+
+#define PCI_PROXY_DEV_GET_CLASS(obj) \
+            OBJECT_GET_CLASS(PCIProxyDevClass, (obj), TYPE_PCI_PROXY_DEV)
+
+typedef struct PCIProxyDev {
+    PCIDevice parent_dev;
+
+    int n_mr_sections;
+    MemoryRegionSection *mr_sections;
+
+    MPQemuLinkState *mpqemu_link;
+
+    EventNotifier intr;
+    EventNotifier resample;
+
+    pid_t remote_pid;
+    int rsocket;
+    int socket;
+
+    char *rid;
+
+    bool managed;
+    char *dev_id;
+
+    QLIST_ENTRY(PCIProxyDev) next;
+
+    void (*set_proxy_sock) (PCIDevice *dev, int socket);
+    int (*get_proxy_sock) (PCIDevice *dev);
+
+    void (*set_remote_opts) (PCIDevice *dev, QDict *qdict, unsigned int cmd);
+    void (*proxy_ready) (PCIDevice *dev);
+    void (*init_proxy) (PCIDevice *pdev, char *command, Error **errp);
+
+} PCIProxyDev;
+
+typedef struct PCIProxyDevClass {
+    PCIDeviceClass parent_class;
+
+    void (*realize)(PCIProxyDev *dev, Error **errp);
+
+    char *command;
+} PCIProxyDevClass;
+
+int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp);
+
+
+#endif /* QEMU_PROXY_H */
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 7689b57..6c2eb91 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -50,6 +50,32 @@
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
 
+static void process_config_write(MPQemuMsg *msg)
+{
+    struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
+
+    qemu_mutex_lock_iothread();
+    pci_default_write_config(remote_pci_dev, conf->addr, conf->val, conf->l);
+    qemu_mutex_unlock_iothread();
+}
+
+static void process_config_read(MPQemuMsg *msg)
+{
+    struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
+    uint32_t val;
+    int wait;
+
+    wait = msg->fds[0];
+
+    qemu_mutex_lock_iothread();
+    val = pci_default_read_config(remote_pci_dev, conf->addr, conf->l);
+    qemu_mutex_unlock_iothread();
+
+    notify_proxy(wait, val);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static void process_msg(GIOCondition cond, MPQemuChannel *chan)
 {
     MPQemuMsg *msg = NULL;
@@ -71,8 +97,10 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
     case INIT:
         break;
     case CONF_WRITE:
+        process_config_write(msg);
         break;
     case CONF_READ:
+        process_config_read(msg);
         break;
     default:
         error_setg(&err, "Unknown command");
-- 
1.8.3.1


