Received: from eggs.gnu.org ([209.51.188.92]:33938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR26-0001hN-Kv
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR25-0006WA-Mg
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjR24-0006TO-0C
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:41 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 Jan 2019 16:41:01 +0100
Message-Id: <1547566866-129386-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 09/14] tests: acpi: move boot_sector_init()
 into x86 tests branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

boot_sector_init() won't be used by arm/virt board, so move it from
global scope to x86 branch that uses it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d290dd2..d9efe59 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -799,13 +799,13 @@ int main(int argc, char *argv[])
     const char *arch = qtest_get_arch();
     int ret;
 
-    ret = boot_sector_init(disk);
-    if(ret)
-        return ret;
-
     g_test_init(&argc, &argv, NULL);
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        ret = boot_sector_init(disk);
+        if(ret)
+           return ret;
+
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
-- 
2.7.4
