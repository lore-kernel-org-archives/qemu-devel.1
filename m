Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924A4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7DC21897
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fjrSjClN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7DC21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5G3M-0000ua-1J
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaK-0007w5-LX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaI-0000l6-HL
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaI-0000jS-Ad
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXfoH053264;
 Tue, 3 Sep 2019 20:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=+GqUQTP3syTnZL0HKNUj9XLZIiMtRF+GrHU4Fhq+gWg=;
 b=fjrSjClN4InS8TTreo+jjt3nG9ZLxKi/Oc1asSz/XPL+LGHhX/kum7NRSwLcGo2dDIOX
 2JoAZDRgEwfAryfmLhPER88OlVGeiUcZDpeI/fJOuwJTmwGVc0T5JbZMrCPh8UwEW8Q8
 x3gAtQJmsg50P8geydrdq24FjPpKiBkEISw5n39xptB9NBYi8Qqdxfjk+vsULturVYb9
 ttTPoi7RkEIA/xH9C9ZyetZIFyk2ZupuCBwOLUh1EXDH23QBjG4wec6du2Hni/90UQb5
 icaIVUOb+jKv3rF7E8hUUb4P66KgfdMiUaSo9y43iIotHBy9TUOqXce0yS3JWyoz5yMk Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2usy6n021r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcHVF094690;
 Tue, 3 Sep 2019 20:39:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2usu51u25x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83KdFgp024737;
 Tue, 3 Sep 2019 20:39:15 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:15 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:59 -0400
Message-Id: <b23b3242d95ab04919af4e2e7012577b1142ab9b.1567534653.git.jag.raman@oracle.com>
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
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC v3 PATCH 33/45] multi-process: add support for
 multiple devices
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

Add suport for multiple devices in one remote process.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 New patch in v3

 remote/remote-main.c | 140 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 115 insertions(+), 25 deletions(-)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index 416b8a1..5552712 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -67,19 +67,83 @@
 #include "remote-opts.h"
 
 static ProxyLinkState *proxy_link;
-PCIDevice *remote_pci_dev;
-bool create_done;
 
-static void process_config_write(ProcMsg *msg)
+typedef struct remote_pci_devs {
+    char *id;
+    DeviceState *ds;
+    unsigned int created;
+    QLIST_ENTRY(remote_pci_devs) next;
+} remote_pci_devs;
+typedef struct pci_devs_listhead pci_devs_listhead;
+
+QLIST_HEAD(pci_devs_listhead, remote_pci_devs) pci_devs_head;
+/* This is needed to distinguish between different devices being initialized. */
+
+QemuMutex remote_ds_lock;
+static bool done_init;
+
+
+static remote_pci_devs *get_ds_from_list(const char *id, unsigned int size_id)
+{
+    remote_pci_devs *d;
+
+    qemu_mutex_lock(&remote_ds_lock);
+    QLIST_FOREACH(d, &pci_devs_head, next) {
+        if (id && d->id) {
+            if (strncmp(id, d->id, size_id) == 0) {
+                qemu_mutex_unlock(&remote_ds_lock);
+                return d;
+            }
+       }
+    }
+    qemu_mutex_unlock(&remote_ds_lock);
+
+    return NULL;
+}
+
+static void add_to_pci_devs_list(DeviceState *dev)
+{
+   remote_pci_devs *d;
+
+   if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        d = g_malloc(sizeof(remote_pci_devs));
+        d->ds = dev;
+        d->id = g_strdup(dev->id);
+        if (!d->id) {
+            return;
+        }
+        qemu_mutex_lock(&remote_ds_lock);
+        QLIST_INSERT_HEAD(&pci_devs_head, d, next);
+        qemu_mutex_unlock(&remote_ds_lock);
+
+    }
+}
+
+static void del_from_pci_devs_list(const char *id)
+{
+    remote_pci_devs *d;
+
+    d = get_ds_from_list((char *)id, strlen((char *)id));
+    if (!d) {
+        return;
+    }
+    g_free(d->id);
+    qemu_mutex_lock(&remote_ds_lock);
+    QLIST_REMOVE(d, next);
+    qemu_mutex_unlock(&remote_ds_lock);
+    g_free(d);
+}
+
+static void process_config_write(ProcMsg *msg, DeviceState *ds)
 {
     struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
 
     qemu_mutex_lock_iothread();
-    pci_default_write_config(remote_pci_dev, conf->addr, conf->val, conf->l);
+    pci_default_write_config(PCI_DEVICE(ds), conf->addr, conf->val, conf->l);
     qemu_mutex_unlock_iothread();
 }
 
-static void process_config_read(ProcMsg *msg)
+static void process_config_read(ProcMsg *msg, DeviceState *ds)
 {
     struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
     uint32_t val;
@@ -88,7 +152,7 @@ static void process_config_read(ProcMsg *msg)
     wait = msg->fds[0];
 
     qemu_mutex_lock_iothread();
-    val = pci_default_read_config(remote_pci_dev, conf->addr, conf->l);
+    val = pci_default_read_config(PCI_DEVICE(ds), conf->addr, conf->l);
     qemu_mutex_unlock_iothread();
 
     notify_proxy(wait, val);
@@ -233,6 +297,8 @@ fail:
     notify_proxy(wait, 1);
 
     PUT_REMOTE_WAIT(wait);
+
+    del_from_pci_devs_list((const char *)msg->id);
 }
 
 static int init_drive(QDict *rqdict, Error **errp)
@@ -313,7 +379,7 @@ static int setup_device(ProcMsg *msg, Error **errp)
     qstr = qstring_from_str((char *)msg->data2);
     obj = qobject_from_json(qstring_get_str(qstr), &local_error);
     if (!obj) {
-        error_setg(errp, "Could not get object!");
+        error_setg(errp, "Could not get object");
         return rc;
     }
 
@@ -338,13 +404,12 @@ static int setup_device(ProcMsg *msg, Error **errp)
 
     dev = qdev_device_add(opts, &local_error);
     if (!dev) {
-        error_setg(errp, "Could not add device %s.",
+        error_setg(errp, "Could not add device %s",
                    qstring_get_str(qobject_to_json(QOBJECT(qdict))));
         return rc;
     }
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        remote_pci_dev = PCI_DEVICE(dev);
-    }
+
+    add_to_pci_devs_list(dev);
     qemu_opts_del(opts);
 
     return 0;
@@ -354,10 +419,13 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
 {
     ProcMsg *msg = NULL;
     Error *err = NULL;
+    remote_pci_devs *r = NULL;
 
     if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
         error_setg(&err, "socket closed, cond is %d", cond);
-        goto finalize_loop;
+        proxy_link_finalize(proxy_link);
+        proxy_link = NULL;
+        return;
     }
 
     msg = g_malloc0(sizeof(ProcMsg));
@@ -367,23 +435,32 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
         goto finalize_loop;
     }
 
+    if (msg->cmd != DEV_OPTS && msg->cmd != DRIVE_OPTS &&
+        msg->cmd != SYNC_SYSMEM) {
+        r = get_ds_from_list((const char *)msg->id, msg->size_id);
+        if (!r) {
+            error_setg(&err, "Message was received for unknown device");
+            goto exit_loop;
+        }
+    }
+
     switch (msg->cmd) {
     case INIT:
         break;
     case CONF_WRITE:
-        if (create_done) {
-            process_config_write(msg);
+        if (r->created) {
+            process_config_write(msg, r->ds);
         }
 
         break;
     case CONF_READ:
-        if (create_done) {
-            process_config_read(msg);
+        if (r->created) {
+            process_config_read(msg, r->ds);
         }
 
         break;
     case BAR_WRITE:
-        if (create_done) {
+        if (r->created) {
             process_bar_write(msg, &err);
             if (err) {
                 error_report_err(err);
@@ -391,7 +468,7 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
         }
         break;
     case BAR_READ:
-        if (create_done) {
+        if (r->created) {
             process_bar_read(msg, &err);
             if (err) {
                 error_report_err(err);
@@ -410,12 +487,15 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
         }
         break;
     case SET_IRQFD:
-        process_set_irqfd_msg(remote_pci_dev, msg);
-        qdev_machine_creation_done();
-        qemu_mutex_lock_iothread();
-        qemu_run_machine_init_done_notifiers();
-        qemu_mutex_unlock_iothread();
-        create_done = true;
+        process_set_irqfd_msg(PCI_DEVICE(r->ds), msg);
+        r->created = true;
+        if (!done_init) {
+            qdev_machine_creation_done();
+            qemu_mutex_lock_iothread();
+            qemu_run_machine_init_done_notifiers();
+            qemu_mutex_unlock_iothread();
+            done_init = true;
+        }
         break;
     case DRIVE_OPTS:
         if (setup_drive(msg, &err)) {
@@ -438,18 +518,26 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
         goto finalize_loop;
     }
 
+exit_loop:
+    if (msg->id) {
+        free(msg->id);
+    }
     g_free(msg);
 
     return;
 
 finalize_loop:
     error_report_err(err);
+    if (msg->id) {
+        free(msg->id);
+    }
     g_free(msg);
+
     proxy_link_finalize(proxy_link);
     proxy_link = NULL;
 }
 
-int main(int argc, char *argv[])
+int main(int argc, char *argv[], char **envp)
 {
     Error *err = NULL;
     int fd = -1;
@@ -491,6 +579,8 @@ int main(int argc, char *argv[])
     proxy_link_init_channel(proxy_link, &proxy_link->com, fd);
 
     parse_cmdline(argc - 2, argv + 2, NULL);
+    qemu_mutex_init(&remote_ds_lock);
+    QLIST_INIT(&pci_devs_head);
 
     proxy_link_set_callback(proxy_link, process_msg);
 
-- 
1.8.3.1


