Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37931C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 03:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB09920B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 03:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB09920B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huTgl-0007hZ-Me
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 23:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59751)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ning.bo9@zte.com.cn>) id 1huTgO-0007Ho-M4
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ning.bo9@zte.com.cn>) id 1huTgL-00010u-Co
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:29:12 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:56408 helo=mxct.zte.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ning.bo9@zte.com.cn>) id 1huTgL-0000oU-32
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:29:09 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id 636F42CFC92B58FF29D0;
 Mon,  5 Aug 2019 11:28:55 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse-fl2.zte.com.cn with ESMTP id x753Su4E003451;
 Mon, 5 Aug 2019 11:28:56 +0800 (GMT-8)
 (envelope-from ning.bo9@zte.com.cn)
Received: from kvm-146.localdomain ([10.74.120.146])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019080511284630-2753121 ;
 Mon, 5 Aug 2019 11:28:46 +0800 
From: Ning Bo <ning.bo9@zte.com.cn>
To: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com
Date: Mon, 5 Aug 2019 11:32:31 +0800
Message-Id: <1564975951-29263-1-git-send-email-ning.bo9@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-08-05 11:28:46,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-08-05 11:28:44, Serialize complete at 2019-08-05 11:28:44
X-MAIL: mse-fl2.zte.com.cn x753Su4E003451
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 202.103.147.169
Subject: [Qemu-devel] [PATCH v2] vhost-vsock: report QMP event when set
 running
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
Cc: Ning Bo <ning.bo9@zte.com.cn>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a program in host communicates with a vsock device in guest via
'vsock://', but the device is not ready, the 'connect' syscall will
block and then timeout after 2 second default.(the timeout is defined
in kernel: #define VSOCK_DEFAULT_CONNECT_TIMEOUT (2 * HZ)).
We can avoid this case if qemu reports an event when the vsock is
ready and the program waits the event before connecting.

Report vsock running event so that the upper application can
control boot sequence.
see https://github.com/kata-containers/runtime/pull/1918

Signed-off-by: Ning Bo <ning.bo9@zte.com.cn>
---
v2: fix typo
---
 hw/virtio/vhost-vsock.c |  3 +++
 qapi/char.json          | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 0371493..a5920fd 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -22,6 +22,7 @@
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "monitor/monitor.h"
+#include "qapi/qapi-events-char.h"
 
 enum {
     VHOST_VSOCK_SAVEVM_VERSION = 0,
@@ -68,6 +69,8 @@ static int vhost_vsock_set_running(VHostVSock *vsock, int start)
     if (ret < 0) {
         return -errno;
     }
+    qapi_event_send_vsock_running(vsock->conf.guest_cid, start != 0);
+
     return 0;
 }
 
diff --git a/qapi/char.json b/qapi/char.json
index a6e81ac..4cfbcf2 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -570,3 +570,25 @@
 { 'event': 'VSERPORT_CHANGE',
   'data': { 'id': 'str',
             'open': 'bool' } }
+
+##
+# @VSOCK_RUNNING:
+#
+# Emitted when the guest changes the vsock status.
+#
+# @cid: guest context ID
+#
+# @running: true if the vsock is running
+#
+# Since: 4.2
+#
+# Example:
+#
+# <- { "event": "VSOCK_RUNNING",
+#      "data": { "cid": "123456", "running": true },
+#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#
+##
+{ 'event': 'VSOCK_RUNNING',
+  'data': { 'cid': 'uint64',
+            'running': 'bool' } }
-- 
2.9.5


