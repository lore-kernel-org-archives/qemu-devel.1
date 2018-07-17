Received: from eggs.gnu.org ([2001:4830:134:3::10]:54969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiX-0005gC-Ik
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiU-0007Ln-8S
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiU-0007Ko-4h
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C13C87D84D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:08 +0200
Message-Id: <20180717120414.5852-9-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 08/14] check: Only test nvdim_acpi when it is
 compiled in
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/bios-tables-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index fd59c7f9a2..1de6e3d58c 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -825,6 +825,7 @@ static void test_acpi_piix4_tcg_numamem(void)
     free_test_data(&data);
 }
 
+#ifdef CONFIG_NVDIM_ACPI
 static void test_acpi_tcg_dimm_pxm(const char *machine)
 {
     test_data data;
@@ -860,6 +861,7 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
 {
     test_acpi_tcg_dimm_pxm(MACHINE_PC);
 }
+#endif
 
 int main(int argc, char *argv[])
 {
@@ -887,8 +889,10 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
         qtest_add_func("acpi/piix4/numamem", test_acpi_piix4_tcg_numamem);
         qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
+#ifdef CONFIG_NVDIM_ACPI
         qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
         qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
+#endif
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.17.1
