Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C6AC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE9A20693
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE9A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58193 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGpya-0003DL-RU
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:12:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptR-0007g9-FN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptQ-0003cc-Dm
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGptQ-0003bA-58
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5052B3084212
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:06:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EEFC608C7;
	Wed, 17 Apr 2019 19:06:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3ED04113292F; Wed, 17 Apr 2019 21:06:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:06:39 +0200
Message-Id: <20190417190641.26814-14-armbru@redhat.com>
In-Reply-To: <20190417190641.26814-1-armbru@redhat.com>
References: <20190417190641.26814-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 17 Apr 2019 19:06:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 13/15] char: Make -chardev help print to
 stdout
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417190639.xZapNbopA5z7ohqh0qnn82kUw8bWptXv8oDL-IsJknM@z>

Command line help explicitly requested by the user should be printed
to stdout, not stderr.  We do elsewhere.  Adjust -chardev to match:
use qemu_printf() instead of error_printf().  Plain printf() would be
wrong because we need to print to the current monitor for "chardev-add
help".

Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 514cd6b0c3..54724a56b1 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "chardev/char.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
@@ -651,7 +652,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMain=
Context *context,
=20
         chardev_name_foreach(help_string_append, str);
=20
-        error_printf("Available chardev backend types: %s\n", str->str);
+        qemu_printf("Available chardev backend types: %s\n", str->str);
         g_string_free(str, true);
         return NULL;
     }
--=20
2.17.2


