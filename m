Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3019C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B345722D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B345722D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Ug8-0004Wk-Ok
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPW-0006eM-GX
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPV-0005E4-5f
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPU-0005Ct-TD
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F6F630833A1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:36 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A0E260F9F;
 Wed, 21 Aug 2019 17:28:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:13 +0200
Message-Id: <1566408501-48680-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 21 Aug 2019 17:28:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/13] tests: add module loading test
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This test will simply check that modules can be loaded, and no symbols
are missing.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qtest.c                |  9 +++++++
 tests/Makefile.include |  1 +
 tests/libqtest.c       |  6 +++++
 tests/libqtest.h       |  2 ++
 tests/modules-test.c   | 71 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 5 files changed, 89 insertions(+)
 create mode 100644 tests/modules-test.c

diff --git a/qtest.c b/qtest.c
index d8b4857..8b50e27 100644
--- a/qtest.c
+++ b/qtest.c
@@ -661,6 +661,15 @@ static void qtest_process_command(CharBackend *chr, =
gchar **words)
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %"PRIi64"\n",
                     (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+    } else if (strcmp(words[0], "module_load") =3D=3D 0) {
+        g_assert(words[1] && words[2]);
+
+        qtest_send_prefix(chr);
+        if (module_load_one(words[1], words[2])) {
+            qtest_sendf(chr, "OK\n");
+        } else {
+            qtest_sendf(chr, "FAIL\n");
+        }
     } else if (qtest_enabled() && strcmp(words[0], "clock_set") =3D=3D 0=
) {
         int64_t ns;
         int ret;
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6f02dfc..39bed75 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -149,6 +149,7 @@ check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFT=
MMU)) +=3D tests/check-block.
=20
 check-qtest-generic-y +=3D tests/qmp-test$(EXESUF)
 check-qtest-generic-y +=3D tests/qmp-cmd-test$(EXESUF)
+check-qtest-generic-$(CONFIG_MODULES) +=3D tests/modules-test$(EXESUF)
=20
 check-qtest-generic-y +=3D tests/device-introspect-test$(EXESUF)
 check-qtest-generic-y +=3D tests/cdrom-test$(EXESUF)
diff --git a/tests/libqtest.c b/tests/libqtest.c
index eb971d0..2713b86 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -811,6 +811,12 @@ bool qtest_get_irq(QTestState *s, int num)
     return s->irq_level[num];
 }
=20
+void qtest_module_load(QTestState *s, const char *prefix, const char *li=
bname)
+{
+    qtest_sendf(s, "module_load %s %s\n", prefix, libname);
+    qtest_rsp(s, 0);
+}
+
 static int64_t qtest_clock_rsp(QTestState *s)
 {
     gchar **words;
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 7833148..07ea358 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -262,6 +262,8 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) =
GCC_FMT_ATTR(2, 3);
 char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
=20
+void qtest_module_load(QTestState *s, const char *prefix, const char *li=
bname);
+
 /**
  * qtest_get_irq:
  * @s: #QTestState instance to operate on.
diff --git a/tests/modules-test.c b/tests/modules-test.c
new file mode 100644
index 0000000..3aef0e5
--- /dev/null
+++ b/tests/modules-test.c
@@ -0,0 +1,71 @@
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+static void test_modules_load(const void *data)
+{
+    QTestState *qts;
+    const char **args =3D data;
+
+    qts =3D qtest_init(NULL);
+    qtest_module_load(qts, args[0], args[1]);
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    const char *modules[] =3D {
+#ifdef CONFIG_CURL
+        "block-", "curl",
+#endif
+#ifdef CONFIG_GLUSTERFS
+        "block-", "gluster",
+#endif
+#ifdef CONFIG_LIBISCSI
+        "block-", "iscsi",
+#endif
+#ifdef CONFIG_LIBNFS
+        "block-", "nfs",
+#endif
+#ifdef CONFIG_LIBSSH
+        "block-", "ssh",
+#endif
+#ifdef CONFIG_RBD
+        "block-", "rbd",
+#endif
+#ifdef CONFIG_AUDIO_ALSA
+        "audio-", "alsa",
+#endif
+#ifdef CONFIG_AUDIO_OSS
+        "audio-", "oss",
+#endif
+#ifdef CONFIG_AUDIO_PA
+        "audio-", "pa",
+#endif
+#ifdef CONFIG_AUDIO_SDL
+        "audio-", "sdl",
+#endif
+#ifdef CONFIG_CURSES
+        "ui-", "curses",
+#endif
+#if defined(CONFIG_GTK) && defined(CONFIG_VTE)
+        "ui-", "gtk",
+#endif
+#ifdef CONFIG_SDL
+        "ui-", "sdl",
+#endif
+#if defined(CONFIG_SPICE) && defined(CONFIG_GIO)
+        "ui-", "spice-app",
+#endif
+    };
+    int i;
+
+    g_test_init(&argc, &argv, NULL);
+
+    for (i =3D 0; i < G_N_ELEMENTS(modules); i +=3D 2) {
+        char *testname =3D g_strdup_printf("/module/load/%s", modules[i =
+ 1]);
+        qtest_add_data_func(testname, modules + i, test_modules_load);
+        g_free(testname);
+    }
+
+    return g_test_run();
+}
--=20
1.8.3.1



