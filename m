Received: from eggs.gnu.org ([2001:4830:134:3::10]:37935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHLeX-0002Ww-Tt
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHLeT-0001oF-9n
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:29:16 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gHLeP-0001k6-1I
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:29:11 -0400
Received: by mail-pg1-x541.google.com with SMTP id f8-v6so4975248pgq.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 21:29:08 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Oct 2018 21:28:52 -0700
Message-Id: <1540873732-3503-3-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540873732-3503-1-git-send-email-liq3ea@gmail.com>
References: <1540873732-3503-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/2] tests: fw_cfg: add reboot_timeout test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 tests/fw_cfg-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 1c5103fe1c..aeabd17ec0 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -99,6 +99,15 @@ static void test_fw_cfg_boot_menu(void)
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), ==, boot_menu);
 }
 
+static void test_fw_cfg_reboot_timeout(void)
+{
+    uint32_t reboot_timeout;
+
+    qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
+                     &reboot_timeout, sizeof(reboot_timeout));
+    g_assert_cmpint(reboot_timeout, <=, 65535);
+}
+
 int main(int argc, char **argv)
 {
     QTestState *s;
@@ -125,6 +134,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
+    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
 
     ret = g_test_run();
 
-- 
2.11.0
