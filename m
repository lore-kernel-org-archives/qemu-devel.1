Received: from eggs.gnu.org ([2001:4830:134:3::10]:45066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLd-0003Bk-Kr
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLc-00022J-8q
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e8nLb-00021f-Vb
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0947E81240
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 13:09:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Sun, 29 Oct 2017 14:09:30 +0100
Message-Id: <20171029130934.4555-6-quintela@redhat.com>
In-Reply-To: <20171029130934.4555-1-quintela@redhat.com>
References: <20171029130934.4555-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] tests: rename postcopy-test to
 migration-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Instead of repeating the code, we are going to bo more tests on this file

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 MAINTAINERS                                 | 1 +
 tests/Makefile.include                      | 6 +++---
 tests/{postcopy-test.c => migration-test.c} | 8 +++-----
 3 files changed, 7 insertions(+), 8 deletions(-)
 rename tests/{postcopy-test.c => migration-test.c} (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2650063242..1fd7a6273c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1563,6 +1563,7 @@ F: include/migration/
 F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/vmstate-static-checker-data/
+F: tests/migration-test.c
 F: docs/devel/migration.txt
 F: qapi/migration.json
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 70dc711bca..434a2ce868 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -287,7 +287,7 @@ endif
 check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
-check-qtest-i386-y += tests/postcopy-test$(EXESUF)
+check-qtest-i386-y += tests/migration-test$(EXESUF)
 check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
@@ -315,7 +315,7 @@ check-qtest-ppc64-y += tests/boot-order-test$(EXESUF)
 check-qtest-ppc64-y += tests/prom-env-test$(EXESUF)
 check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y += tests/drive_del-test$(EXESUF)
-check-qtest-ppc64-y += tests/postcopy-test$(EXESUF)
+check-qtest-ppc64-y += tests/migration-test$(EXESUF)
 check-qtest-ppc64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
@@ -784,7 +784,7 @@ tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
 tests/pc-cpu-test$(EXESUF): tests/pc-cpu-test.o
-tests/postcopy-test$(EXESUF): tests/postcopy-test.o
+tests/migration-test$(EXESUF): tests/migration-test.o
 tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
 	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
 	$(chardev-obj-y)
diff --git a/tests/postcopy-test.c b/tests/migration-test.c
similarity index 98%
rename from tests/postcopy-test.c
rename to tests/migration-test.c
index 8142f2ab90..55c4aed719 100644
--- a/tests/postcopy-test.c
+++ b/tests/migration-test.c
@@ -1,5 +1,5 @@
 /*
- * QTest testcase for postcopy
+ * QTest testcase for migration
  *
  * Copyright (c) 2016 Red Hat, Inc. and/or its affiliates
  *   based on the vhost-user-test.c that is:
@@ -243,8 +243,6 @@ static QDict *return_or_event(QDict *response)
 /*
  * It's tricky to use qemu's migration event capability with qtest,
  * events suddenly appearing confuse the qmp()/hmp() responses.
- * so wait for a couple of passes to have happened before
- * going postcopy.
  */
 
 static uint64_t get_migration_pass(void)
@@ -504,7 +502,7 @@ static void test_migrate(void)
 
 int main(int argc, char **argv)
 {
-    char template[] = "/tmp/postcopy-test-XXXXXX";
+    char template[] = "/tmp/migration-test-XXXXXX";
     int ret;
 
     g_test_init(&argc, &argv, NULL);
@@ -521,7 +519,7 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
 
-    qtest_add_func("/postcopy", test_migrate);
+    qtest_add_func("/migration/postcopy/unix", test_migrate);
 
     ret = g_test_run();
 
-- 
2.13.6
