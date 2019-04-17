Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC19C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE92206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE92206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGpvR-0000Vi-Nu
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:08:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptP-0007eF-I2
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptO-0003Zt-JN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGptO-0003Yk-9a
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74DF930031AC
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:06:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 447FD60C64
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:06:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 4555911327DB; Wed, 17 Apr 2019 21:06:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:06:40 +0200
Message-Id: <20190417190641.26814-15-armbru@redhat.com>
In-Reply-To: <20190417190641.26814-1-armbru@redhat.com>
References: <20190417190641.26814-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 17 Apr 2019 19:06:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 14/15] char-pty: Print "char device
 redirected" message to stdout
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417190640.TVM8F9dF057Un2I8zC08kPNNBB8W7lqHZtth1S5n0_0@z>

char_pty_open() prints a "char device redirected to PTY_NAME (label
LABEL)" message to the current monitor or else to stderr.  This is not
an error, so it shouldn't go to stderr.  Print it to stdout instead.

Why is it even printed?  No other ChardevClass::open() prints anything
on success.  It's because you need to know PTY_NAME to actually use
this char device, e.g. like e.g. "socat STDIO,cfmakeraw FILE:PTY_NAME"
to use the monitor's readline interface.  You can get PTY_NAME with
"info chardev" (a.k.a. query-chardev for QMP), but only if you already
have a monitor.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char-pty.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index b034332edd..04759b0ef9 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -28,6 +28,7 @@
 #include "io/channel-file.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 
 #include "chardev/char-io.h"
 
@@ -211,8 +212,8 @@ static void char_pty_open(Chardev *chr,
     qemu_set_nonblock(master_fd);
 
     chr->filename = g_strdup_printf("pty:%s", pty_name);
-    error_printf("char device redirected to %s (label %s)\n",
-                 pty_name, chr->label);
+    qemu_printf("char device redirected to %s (label %s)\n",
+                pty_name, chr->label);
 
     s = PTY_CHARDEV(chr);
     s->ioc = QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
-- 
2.17.2


