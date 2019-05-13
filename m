Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEDCC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FA820989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FA820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6GP-0001Kb-LI
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 04:24:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQ6Ab-0004eF-LI
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQ6Aa-0007cm-DK
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:18:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQ6Aa-0007c8-6Z
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:18:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F10787627
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 08:18:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D08763BA4
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 08:18:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id CFFF6113861C; Mon, 13 May 2019 10:18:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 10:18:37 +0200
Message-Id: <20190513081844.26699-3-armbru@redhat.com>
In-Reply-To: <20190513081844.26699-1-armbru@redhat.com>
References: <20190513081844.26699-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 13 May 2019 08:18:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/9] Use #include "..." for our own headers,
 <...> for others
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also delete a few redundant #include.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190315145123.28030-2-armbru@redhat.com>
---
 contrib/rdmacm-mux/main.c       | 18 +++++++++---------
 contrib/rdmacm-mux/rdmacm-mux.h |  6 +++---
 hw/rdma/rdma_utils.h            |  1 -
 target/i386/whp-dispatch.h      |  2 +-
 target/i386/whpx-all.c          |  1 -
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index 21cc804367..30c7052651 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -14,16 +14,16 @@
  */
 
 #include "qemu/osdep.h"
-#include "sys/poll.h"
-#include "sys/ioctl.h"
-#include "pthread.h"
-#include "syslog.h"
+#include <sys/poll.h>
+#include <sys/ioctl.h>
+#include <pthread.h>
+#include <syslog.h>
 
-#include "infiniband/verbs.h"
-#include "infiniband/umad.h"
-#include "infiniband/umad_types.h"
-#include "infiniband/umad_sa.h"
-#include "infiniband/umad_cm.h"
+#include <infiniband/verbs.h>
+#include <infiniband/umad.h>
+#include <infiniband/umad_types.h>
+#include <infiniband/umad_sa.h>
+#include <infiniband/umad_cm.h>
 
 #include "rdmacm-mux.h"
 
diff --git a/contrib/rdmacm-mux/rdmacm-mux.h b/contrib/rdmacm-mux/rdmacm-mux.h
index 942a802c47..07a4722913 100644
--- a/contrib/rdmacm-mux/rdmacm-mux.h
+++ b/contrib/rdmacm-mux/rdmacm-mux.h
@@ -17,9 +17,9 @@
 #define RDMACM_MUX_H
 
 #include "linux/if.h"
-#include "infiniband/verbs.h"
-#include "infiniband/umad.h"
-#include "rdma/rdma_user_cm.h"
+#include <infiniband/verbs.h>
+#include <infiniband/umad.h>
+#include <rdma/rdma_user_cm.h>
 
 typedef enum RdmaCmMuxMsgType {
     RDMACM_MUX_MSG_TYPE_REQ   = 0,
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index 2d42249691..e7babe96cb 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -20,7 +20,6 @@
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
-#include "stdio.h"
 
 #define rdma_error_report(fmt, ...) \
     error_report("%s: " fmt, "rdma", ## __VA_ARGS__)
diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index 4ae3cc8fa5..a23fb33a29 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -1,4 +1,4 @@
-#include "windows.h"
+#include <windows.h>
 
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 57e53e1f1f..31d47320e4 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -13,7 +13,6 @@
 #include "exec/address-spaces.h"
 #include "exec/ioport.h"
 #include "qemu-common.h"
-#include "strings.h"
 #include "sysemu/accel.h"
 #include "sysemu/whpx.h"
 #include "sysemu/sysemu.h"
-- 
2.17.2


