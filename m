Received: from eggs.gnu.org ([2001:4830:134:3::10]:38716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ehIgK-0003mf-Nj
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ehIgJ-0005rz-RR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:29:52 -0500
From: Wei Huang <wei@redhat.com>
Date: Thu,  1 Feb 2018 12:28:10 -0500
Message-Id: <1517506091-10396-3-git-send-email-wei@redhat.com>
In-Reply-To: <1517506091-10396-1-git-send-email-wei@redhat.com>
References: <1517506091-10396-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] tests: Enable drive_del-test on arm/aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, drjones@redhat.com

Signed-off-by: Wei Huang <wei@redhat.com>
---
 tests/Makefile.include | 2 ++
 tests/drive_del-test.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ebdb151..e28277c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -365,9 +365,11 @@ gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
+check-qtest-arm-y += tests/drive_del-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
+check-qtest-aarch64-y += tests/drive_del-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index c9ac997..2e39442 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -123,7 +123,8 @@ int main(int argc, char **argv)
     /* TODO I guess any arch with a hot-pluggable virtio bus would do */
     if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64") ||
         !strcmp(arch, "ppc") || !strcmp(arch, "ppc64") ||
-        !strcmp(arch, "s390x")) {
+        !strcmp(arch, "s390x") || !strcmp(arch, "arm") ||
+        !strcmp(arch, "aarch64")) {
         qtest_add_func("/drive_del/after_failed_device_add",
                        test_after_failed_device_add);
         qtest_add_func("/blockdev/drive_del_device_del",
-- 
1.8.3.1
