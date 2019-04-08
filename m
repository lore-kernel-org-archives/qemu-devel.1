Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07B0C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A231520880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A231520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQ1w-0003we-0X
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 04:53:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPle-0008Eh-QW
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPld-0003ix-Tb
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hDPlb-0003fW-9x; Mon, 08 Apr 2019 04:36:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F0C8C057F3F;
	Mon,  8 Apr 2019 08:36:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E60A65C297;
	Mon,  8 Apr 2019 08:36:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 14F0C113292F; Mon,  8 Apr 2019 10:36:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 10:36:25 +0200
Message-Id: <20190408083627.7479-14-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-1-armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 08 Apr 2019 08:36:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 13/15] blockdev: Make -drive format=help print
 to stdout
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408083625.gN2pb1ZJpLQ9hFkfWhk1LBbxouit9LOVsEkfEIhnAos@z>

Command line help explicitly requested by the user should be printed
to stdout, not stderr.  We do elsewhere.  Adjust -drive to match: use
qemu_printf() instead of error_printf().  Plain printf() would be
wrong because we need to print to the current monitor for "drive_add
... format=help".

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 4775a07d93..79fbac8450 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -40,6 +40,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qemu/qemu-print.h"
 #include "qemu/config-file.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-transaction.h"
@@ -301,7 +302,7 @@ DriveInfo *drive_get_next(BlockInterfaceType type)
 
 static void bdrv_format_print(void *opaque, const char *name)
 {
-    error_printf(" %s", name);
+    qemu_printf(" %s", name);
 }
 
 typedef struct {
@@ -530,11 +531,11 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
 
     if ((buf = qemu_opt_get(opts, "format")) != NULL) {
         if (is_help_option(buf)) {
-            error_printf("Supported formats:");
+            qemu_printf("Supported formats:");
             bdrv_iterate_format(bdrv_format_print, NULL, false);
-            error_printf("\nSupported formats (read-only):");
+            qemu_printf("\nSupported formats (read-only):");
             bdrv_iterate_format(bdrv_format_print, NULL, true);
-            error_printf("\n");
+            qemu_printf("\n");
             goto early_err;
         }
 
-- 
2.17.2


