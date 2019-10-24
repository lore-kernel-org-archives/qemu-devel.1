Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1103CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B832920856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lo4AQ553"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B832920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZgz-0002xe-3g
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZAX-000286-SU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZAW-0005MP-My
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZAW-0005Jw-Ee
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94M1Y099578;
 Thu, 24 Oct 2019 09:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=Xh2odBnS5dKeeUhdClD/GLP4LQ+P8oTji3dSDPB7dIU=;
 b=Lo4AQ553ozsyLt95cFbKUOwZtQzdfqMu6X6asCC3EaFS7Qh5JG2vFMgTYWo3oGZmSZP0
 rhua3whqy50M8LBJzb02LUvaZXwTHhKth//WcBsqHlHcj8+bBH76XLLVZUR5NTFmt0Qb
 YxAf5MuV3SXZA7TdWhzPCFeBDCTaMA8p4Z5XGtiroC5BNkZcRKDDSi0mTZtAEBbc042h
 CUCa3IznYtIBSkz/7l76WX/9DpFtUe2vwCmIhtNDLcx26eVueKqeqbXoz85canJTldBs
 R2ihhMhV7Z8TBse+rQ6rajPmuLANhSa7RpOi/31ZZgP9xAtx0a7l/J29R4IYYNeEtOZl aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2vqteq2ant-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:12:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98LDH047145;
 Thu, 24 Oct 2019 09:10:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2vu0fnu6r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:22 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9AKa7009131;
 Thu, 24 Oct 2019 09:10:20 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:10:19 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 12/49] multi-process: remote process initialization
Date: Thu, 24 Oct 2019 05:08:53 -0400
Message-Id: <a0550c5a6df8f294528393cfe3c031e194ba2188.1571905346.git.jag.raman@oracle.com>
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

 remote/remote-main.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index bf44310..7689b57 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -26,6 +26,7 @@
 #include "qemu-common.h"
 
 #include <stdio.h>
+#include <unistd.h>
 
 #include "qemu/module.h"
 #include "remote/pcihost.h"
@@ -33,12 +34,91 @@
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "qemu/main-loop.h"
+#include "remote/memory.h"
+#include "io/mpqemu-link.h"
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
+static MPQemuLinkState *mpqemu_link;
+PCIDevice *remote_pci_dev;
+
+static void process_msg(GIOCondition cond, MPQemuChannel *chan)
+{
+    MPQemuMsg *msg = NULL;
+    Error *err = NULL;
+
+    if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
+        error_setg(&err, "socket closed, cond is %d", cond);
+        goto finalize_loop;
+    }
+
+    msg = g_malloc0(sizeof(MPQemuMsg));
+
+    if (mpqemu_msg_recv(mpqemu_link, msg, chan) < 0) {
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
+    mpqemu_link_finalize(mpqemu_link);
+    mpqemu_link = NULL;
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
 
+    mpqemu_link = mpqemu_link_create();
+    if (!mpqemu_link) {
+        printf("Could not create MPQemu link\n");
+        return -1;
+    }
+
+    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO);
+    mpqemu_link_set_callback(mpqemu_link, process_msg);
+
+    mpqemu_start_coms(mpqemu_link);
+
     return 0;
 }
-- 
1.8.3.1


