Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAB2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AA721883
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F/FqvYnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AA721883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fqp-0007K4-6t
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZk-0007DP-0G
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZi-0000Ad-MR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZi-0000A0-EN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXeWR066085;
 Tue, 3 Sep 2019 20:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=GeV5ssJ4jjBW2Dn4aWTPWs+tYCKrZ+I98ssnh1cdZMo=;
 b=F/FqvYnw+FGDr8+Cca2MonpSr/ymk7CrinQ4MNIEIwT7YYnEpyjRfnj8fwSuni1UOrGX
 ZnpMvM+totep2RepkP6MyeHe2n2vmoTyT4TbEjxmtBsfVXJr5bQIIO1EXzeLSL6Vv+Lc
 ynCF3KpjoJpUZEJS2Qbxg1MrXm+w1Z83FWjz2DTV/gR1Ww0OFh9nOsfPHbC1XtQYHbV9
 H68uvS/+w6Kow8HbMg71TAOCSOechP5n1y9Oowplmu7JeZKrEcw6jAlcSDgUjk+SSi+A
 vtb4U+ODsTNePaU8HzxqsZKvaqA5iiQmqoeF9jxJixY8hYFmaYwMDg+0zwr2Svdukf8+ 2w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2usy4u82yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcInq094718;
 Tue, 3 Sep 2019 20:38:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2usu51u1pw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:43 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KcgDQ017439;
 Tue, 3 Sep 2019 20:38:42 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:41 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:38 -0400
Message-Id: <7fd01deff75662e371e48c5eec677e79e9096967.1567534653.git.jag.raman@oracle.com>
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
Subject: [Qemu-devel] [RFC v3 PATCH 12/45] multi-process: remote process
 initialization
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

Adds the handler to process message from QEMU,
Initialize remote process main loop, handles SYNC_SYSMEM
message by updating its "system_memory" container using
shared file descriptors received from QEMU.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 v1 -> v2:
   - Separate thread for message processing is removed

 v2 -> v3:
   - Added multi-channel support in the remote end

 remote/remote-main.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index 97dd832..72866ec 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -23,6 +23,8 @@
  */
 
 #include <stdio.h>
+#include <glib.h>
+#include <unistd.h>
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
@@ -31,12 +33,91 @@
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "qemu/main-loop.h"
+#include "remote/memory.h"
+#include "io/proxy-link.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "qemu-common.h"
+#include "hw/pci/pci.h"
+#include "qemu/thread.h"
+#include "qemu/main-loop.h"
+#include "qemu/config-file.h"
+#include "sysemu/sysemu.h"
+#include "block/block.h"
+
+static ProxyLinkState *proxy_link;
+PCIDevice *remote_pci_dev;
+
+static void process_msg(GIOCondition cond, ProcChannel *chan)
+{
+    ProcMsg *msg = NULL;
+    Error *err = NULL;
+
+    if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
+        error_setg(&err, "socket closed, cond is %d", cond);
+        goto finalize_loop;
+    }
+
+    msg = g_malloc0(sizeof(ProcMsg));
+
+    if (proxy_proc_recv(proxy_link, msg, chan) < 0) {
+        error_setg(&err, "Failed to receive message");
+        goto finalize_loop;
+    }
+
+    switch (msg->cmd) {
+    case INIT:
+        break;
+    case CONF_WRITE:
+        break;
+    case CONF_READ:
+        break;
+    default:
+        error_setg(&err, "Unknown command");
+        goto finalize_loop;
+    }
+
+    g_free(msg);
+
+    return;
+
+finalize_loop:
+    error_report_err(err);
+    g_free(msg);
+    proxy_link_finalize(proxy_link);
+    proxy_link = NULL;
+}
 
 int main(int argc, char *argv[])
 {
+    Error *err = NULL;
+
     module_call_init(MODULE_INIT_QOM);
 
+    bdrv_init_with_whitelist();
+
+    if (qemu_init_main_loop(&err)) {
+        error_report_err(err);
+        return -EBUSY;
+    }
+
+    qemu_init_cpu_loop();
+
+    page_size_init();
+
     current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
 
+    proxy_link = proxy_link_create();
+    if (!proxy_link) {
+        printf("Could not create proxy link\n");
+        return -1;
+    }
+
+    proxy_link_init_channel(proxy_link, &proxy_link->com, STDIN_FILENO);
+    proxy_link_set_callback(proxy_link, process_msg);
+
+    start_handler(proxy_link);
+
     return 0;
 }
-- 
1.8.3.1


