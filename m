Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65530C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354202067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbSMcfur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354202067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutp4-0000QV-Gn
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutmG-0003cS-QM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:25:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutmF-0006lY-0V
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594628730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0oJ9UgpysMUgLti/JnzJeqywWH1bplR+eDieJj4a5Y=;
 b=LbSMcfur+JCymWk0ipJzzWlV8axhZPPgCzIBddjjBB7skB1BEsZmt2ME0TG4fZS5DLK6Jz
 w29k/eBvnJdwS5qmpRuqjnp4zBZb8BishQeroC8T3sbBhf8FyyOYDzBFJ84XXqMqNuhiMh
 HqcdgHhSXhZxBBUwyvn0M5R6g9tDkh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-C9Fpep6UMISy04PP070oLw-1; Mon, 13 Jul 2020 04:25:28 -0400
X-MC-Unique: C9Fpep6UMISy04PP070oLw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BAE9E91A
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:25:27 +0000 (UTC)
Received: from localhost (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF18459;
 Mon, 13 Jul 2020 08:25:23 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] chardev: Reduce "char-mux.h" scope,
 rename it "chardev-internal.h"
Date: Mon, 13 Jul 2020 12:24:23 +0400
Message-Id: <20200713082424.2947383-8-marcandre.lureau@redhat.com>
In-Reply-To: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
References: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

No file out of chardev/ requires access to this header,
restrict its scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200423202112.644-5-philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-mux.h => chardev/chardev-internal.h | 7 ++++---
 chardev/char-fe.c                                        | 2 +-
 chardev/char-mux.c                                       | 2 +-
 chardev/char.c                                           | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)
 rename include/chardev/char-mux.h => chardev/chardev-internal.h (96%)

diff --git a/include/chardev/char-mux.h b/chardev/chardev-internal.h
similarity index 96%
rename from include/chardev/char-mux.h
rename to chardev/chardev-internal.h
index 417fe32eedf..e0264ac3498 100644
--- a/include/chardev/char-mux.h
+++ b/chardev/chardev-internal.h
@@ -1,5 +1,5 @@
 /*
- * QEMU System Emulator
+ * QEMU Character device internals
  *
  * Copyright (c) 2003-2008 Fabrice Bellard
  *
@@ -21,8 +21,8 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
-#ifndef CHAR_MUX_H
-#define CHAR_MUX_H
+#ifndef CHARDEV_INTERNAL_H
+#define CHARDEV_INTERNAL_H
 
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
@@ -30,6 +30,7 @@
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
 #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
+
 typedef struct MuxChardev {
     Chardev parent;
     CharBackend *backends[MAX_MUX];
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f3530a90e63..474715c5a92 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -29,7 +29,7 @@
 
 #include "chardev/char-fe.h"
 #include "chardev/char-io.h"
-#include "chardev/char-mux.h"
+#include "chardev-internal.h"
 
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 46c44af67c4..6f980bb8364 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -29,7 +29,7 @@
 #include "chardev/char.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
-#include "chardev/char-mux.h"
+#include "chardev-internal.h"
 
 /* MUX driver for serial I/O splitting */
 
diff --git a/chardev/char.c b/chardev/char.c
index a0626d04d50..807be52300e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -40,7 +40,7 @@
 #include "qemu/id.h"
 #include "qemu/coroutine.h"
 
-#include "chardev/char-mux.h"
+#include "chardev-internal.h"
 
 /***********************************************************/
 /* character device */
-- 
2.27.0.221.ga08a83db2b


