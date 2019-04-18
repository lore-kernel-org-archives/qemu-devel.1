Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36E1C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A44920869
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A44920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47325 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHEEW-000867-Ne
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 17:06:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0V-00056T-LV
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0T-0005EL-TZ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0T-0005Cv-FD
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC86F3003737
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FA385C206
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 93D7D1132724; Thu, 18 Apr 2019 22:51:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:51:17 +0200
Message-Id: <20190418205135.6686-19-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 18/36] char-pty: Print "char device
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
Message-ID: <20190418205117.Tk7FpfMf8p6dNgTPF7ICpfJTsCvoQiXAbounp_3_gds@z>

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
Message-Id: <20190417190641.26814-15-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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


