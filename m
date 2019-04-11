Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADAAC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CEC2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CEC2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50329 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbEh-0004Km-GD
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:03:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4n-0003WH-4o
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4l-0000sa-3G
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hEb4d-0000mI-3a; Thu, 11 Apr 2019 10:53:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 412FB307CB40;
	Thu, 11 Apr 2019 14:53:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 098825D9C8;
	Thu, 11 Apr 2019 14:53:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id F00ED113292F; Thu, 11 Apr 2019 16:52:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 16:52:54 +0200
Message-Id: <20190411145256.8614-14-armbru@redhat.com>
In-Reply-To: <20190411145256.8614-1-armbru@redhat.com>
References: <20190411145256.8614-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 11 Apr 2019 14:53:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 13/15] blockdev: Make -drive format=help
 print to stdout
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
Message-ID: <20190411145254.unJk-v7Gof3Y-H5r4mZjKdij7hDOSlUxVLhWWKcqu_4@z>

Command line help explicitly requested by the user should be printed
to stdout, not stderr.  We do elsewhere.  Adjust -drive to match: use
qemu_printf() instead of error_printf().  Plain printf() would be
wrong because we need to print to the current monitor for "drive_add
... format=3Dhelp".

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
=20
 static void bdrv_format_print(void *opaque, const char *name)
 {
-    error_printf(" %s", name);
+    qemu_printf(" %s", name);
 }
=20
 typedef struct {
@@ -530,11 +531,11 @@ static BlockBackend *blockdev_init(const char *file=
, QDict *bs_opts,
=20
     if ((buf =3D qemu_opt_get(opts, "format")) !=3D NULL) {
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
=20
--=20
2.17.2


