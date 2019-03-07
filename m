Received: from eggs.gnu.org ([209.51.188.92]:39778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr4-0003Wk-Mf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqz-0008HU-MB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:50 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:37345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqx-0008EE-M1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:43 -0500
Received: by mail-wr1-x42e.google.com with SMTP id w6so18400328wrs.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:38 +0100
Message-Id: <1551979804-6060-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/57] tests/qgraph: remove virtio-balloon-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lviver@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

The tests/virtio-balloon-test is covered by generic virtio tests,
so remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include      |  3 ---
 tests/virtio-balloon-test.c | 33 ---------------------------------
 2 files changed, 36 deletions(-)
 delete mode 100644 tests/virtio-balloon-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 53794cd..f53b718 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -154,7 +154,6 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 
 check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
-check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
@@ -308,7 +307,6 @@ check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 check-qtest-s390x-y += tests/device-plug-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
-check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
 check-qtest-s390x-y += tests/migration-test$(EXESUF)
 
@@ -811,7 +809,6 @@ tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
 tests/ne2000-test$(EXESUF): tests/ne2000-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
-tests/virtio-balloon-test$(EXESUF): tests/virtio-balloon-test.o $(libqos-virtio-obj-y)
 tests/virtio-blk-test$(EXESUF): tests/virtio-blk-test.o $(libqos-virtio-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
 tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
diff --git a/tests/virtio-balloon-test.c b/tests/virtio-balloon-test.c
deleted file mode 100644
index 5a1d0cc..0000000
--- a/tests/virtio-balloon-test.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * QTest testcase for VirtIO Balloon
- *
- * Copyright (c) 2014 SUSE LINUX Products GmbH
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "libqtest.h"
-#include "libqos/virtio.h"
-
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void balloon_nop(void)
-{
-}
-
-int main(int argc, char **argv)
-{
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/balloon/nop", balloon_nop);
-
-    global_qtest = qtest_initf("-device virtio-balloon-%s",
-                               qvirtio_get_dev_type());
-    ret = g_test_run();
-
-    qtest_end();
-
-    return ret;
-}
-- 
1.8.3.1
