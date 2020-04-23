Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA97C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E1E20724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3np2N7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E1E20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiPI-0004B3-UD
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiN0-0007Xc-W2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiN0-0004rp-8A
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:22:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44488
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiMz-0004qt-RG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpPT5lIf6zF9LbEYpSRYY+8MZQS9JkDT9x3dN4aa87o=;
 b=N3np2N7skDwY0yVAzqLTPMegYqOllfBLu1+l+VeL+zKBDl51bTO5VkCWwhn9TtOlvwb+Rx
 2Eb1GEjX5+68AqpZxuUBEqjLg03j1nOfGtKU9pr5RWcauNoYvX25GqKs4x7pbn7PK7Tkp7
 cwlSdSHOYfjJoyZ52Xzsm5GJRq9Lxs4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-bq2d1Ty9O-ubaDZvI6SIqQ-1; Thu, 23 Apr 2020 16:22:47 -0400
X-MC-Unique: bq2d1Ty9O-ubaDZvI6SIqQ-1
Received: by mail-ed1-f72.google.com with SMTP id y6so2174671edo.18
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O4g/2sbaFjmdI3zEPcvvgzI0jd27H8+2xG/e85GYdg0=;
 b=iCvqtAbY6SsTtl2+qxg89uZWL4wy+y9yxtN0P7Ml0iVmfD1AcRciMgBUnUuPtjG7fa
 tat9Q4d13jV2PzX6tK/UfB3Q5syFiIiGwQWjI4CI3JqGUOq2HEXFbyJQAqlCZBr//K+H
 mFtQuF39rQz1XY2BOXMYdgQIEx56Pa3mv94CqhP27mov15rNIfGmRisrp0/8vL3lhlGO
 ni61jhIyNOEHmvGNV7baZUr3+FaqqrxqnFjkq0qqhA3rE0P/KNYPAa6ZigmTK5lyE5QY
 c4tAneiOROvGcBXsUkoY5+NJwA0b4yro3mODjF8LUYBQvDZBHZHKpvoVrXziYxxe2bg4
 Pokw==
X-Gm-Message-State: AGi0PuYkcc55qNDm5OAIisy2TLI7k//BdCHV4Njqkr2wETRtCENnLxCJ
 hIf/BrMsdVRN7IqYWti9hqvcDeV2zZgNa6AxB96JjusiaI8/9CXs1zxgx++evvu+/ow+4mr7s3s
 bsDPrlB7/HmzE/0A=
X-Received: by 2002:a17:906:c839:: with SMTP id
 dd25mr4141143ejb.164.1587673306036; 
 Thu, 23 Apr 2020 13:21:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypLGILeUrGeze+VvQL1M1zY20TcBmLlQafL6JtfodiPIPxXw6eiMzeaQ1ML/0P357kwWFH7UVQ==
X-Received: by 2002:a17:906:c839:: with SMTP id
 dd25mr4141118ejb.164.1587673305665; 
 Thu, 23 Apr 2020 13:21:45 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h2sm289026edw.63.2020.04.23.13.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 13:21:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] chardev: Extract system emulation specific code
Date: Thu, 23 Apr 2020 22:21:10 +0200
Message-Id: <20200423202112.644-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200423202112.644-1-philmd@redhat.com>
References: <20200423202112.644-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split out code only used during system emulation,
to reduce code pulled in user emulation and tools.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/chardev-internal.h |  3 ++
 chardev/char.c             | 35 +------------------
 chardev/chardev-sysemu.c   | 69 ++++++++++++++++++++++++++++++++++++++
 chardev/Makefile.objs      |  1 +
 4 files changed, 74 insertions(+), 34 deletions(-)
 create mode 100644 chardev/chardev-sysemu.c

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index e0264ac349..f4d0429763 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -26,6 +26,7 @@
=20
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
+#include "qom/object.h"
=20
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
@@ -59,4 +60,6 @@ typedef struct MuxChardev {
 void mux_set_focus(Chardev *chr, int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
=20
+Object *get_chardevs_root(void);
+
 #endif /* CHAR_MUX_H */
diff --git a/chardev/char.c b/chardev/char.c
index b672a41150..555bb0448e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -44,7 +44,7 @@
 /***********************************************************/
 /* character device */
=20
-static Object *get_chardevs_root(void)
+Object *get_chardevs_root(void)
 {
     return container_get(object_get_root(), "/chardevs");
 }
@@ -300,33 +300,6 @@ static const TypeInfo char_type_info =3D {
     .class_init =3D char_class_init,
 };
=20
-static int chardev_machine_done_notify_one(Object *child, void *opaque)
-{
-    Chardev *chr =3D (Chardev *)child;
-    ChardevClass *class =3D CHARDEV_GET_CLASS(chr);
-
-    if (class->chr_machine_done) {
-        return class->chr_machine_done(chr);
-    }
-
-    return 0;
-}
-
-static void chardev_machine_done_hook(Notifier *notifier, void *unused)
-{
-    int ret =3D object_child_foreach(get_chardevs_root(),
-                                   chardev_machine_done_notify_one, NULL);
-
-    if (ret) {
-        error_report("Failed to call chardev machine_done hooks");
-        exit(1);
-    }
-}
-
-static Notifier chardev_machine_done_notify =3D {
-    .notify =3D chardev_machine_done_hook,
-};
-
 static bool qemu_chr_is_busy(Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
@@ -1187,12 +1160,6 @@ void qemu_chr_cleanup(void)
 static void register_types(void)
 {
     type_register_static(&char_type_info);
-
-    /* this must be done after machine init, since we register FEs with mu=
xes
-     * as part of realize functions like serial_isa_realizefn when -nograp=
hic
-     * is specified
-     */
-    qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
 }
=20
 type_init(register_types);
diff --git a/chardev/chardev-sysemu.c b/chardev/chardev-sysemu.c
new file mode 100644
index 0000000000..eecdc615ee
--- /dev/null
+++ b/chardev/chardev-sysemu.c
@@ -0,0 +1,69 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+#include "chardev/char.h"
+#include "qemu/error-report.h"
+#include "chardev-internal.h"
+
+static int chardev_machine_done_notify_one(Object *child, void *opaque)
+{
+    Chardev *chr =3D (Chardev *)child;
+    ChardevClass *class =3D CHARDEV_GET_CLASS(chr);
+
+    if (class->chr_machine_done) {
+        return class->chr_machine_done(chr);
+    }
+
+    return 0;
+}
+
+static void chardev_machine_done_hook(Notifier *notifier, void *unused)
+{
+    int ret =3D object_child_foreach(get_chardevs_root(),
+                                   chardev_machine_done_notify_one, NULL);
+
+    if (ret) {
+        error_report("Failed to call chardev machine_done hooks");
+        exit(1);
+    }
+}
+
+
+static Notifier chardev_machine_done_notify =3D {
+    .notify =3D chardev_machine_done_hook,
+};
+
+static void register_types(void)
+{
+    /*
+     * This must be done after machine init, since we register FEs with mu=
xes
+     * as part of realize functions like serial_isa_realizefn when -nograp=
hic
+     * is specified.
+     */
+    qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
+}
+
+type_init(register_types);
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 15ee7f47da..a10acbc2b8 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,4 +1,5 @@
 chardev-obj-y +=3D char.o
+chardev-obj-$(CONFIG_SOFTMMU) +=3D chardev-sysemu.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-console.o
 chardev-obj-$(CONFIG_POSIX) +=3D char-fd.o
 chardev-obj-y +=3D char-fe.o
--=20
2.21.1


