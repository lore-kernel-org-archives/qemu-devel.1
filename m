Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D57C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF1720684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF1720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7Mv-0001jl-AA
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 07:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1ic7JN-00083w-Ov
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1ic7JL-0003hS-Bf
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:29:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40896 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1ic7JD-0003QC-Rb; Tue, 03 Dec 2019 07:29:40 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6F224D2CDBA246A38D2B;
 Tue,  3 Dec 2019 20:29:31 +0800 (CST)
Received: from HGHY4Z004218071.china.huawei.com (10.133.224.57) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Dec 2019 20:29:24 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: <peter.maydell@linaro.org>, <thuth@redhat.com>, <lvivier@redhat.com>
Subject: [PATCH 3/5] tests: fw_cfg: Use virt as default machine in
 fw_cfg-test.c
Date: Tue, 3 Dec 2019 20:27:51 +0800
Message-ID: <20191203122753.19792-4-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
In-Reply-To: <20191203122753.19792-1-zhengxiang9@huawei.com>
References: <20191203122753.19792-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: lersek@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kraxel@redhat.com, wanghaibin.wang@huawei.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default machine type on aarch64 is not set which causes error in
qtest_init(). Here we use the "virt" machine as the default machine
type on aarch64.

Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 tests/fw_cfg-test.c | 65 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 5a5342fa9d..a3a67d1099 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -23,13 +23,28 @@ static uint16_t max_cpus = 1;
 static uint64_t nb_nodes = 0;
 static uint16_t boot_menu = 0;
 
+static char *make_extra_args(const char *args)
+{
+    const char *arch = qtest_get_arch();
+    const char *machine_arg = NULL;
+
+    if (strcmp(arch, "aarch64") == 0) {
+        machine_arg = "-machine virt";
+    } else {
+        machine_arg = "";
+    }
+
+    return g_strdup_printf("%s %s", machine_arg, args);
+}
+
 static void test_fw_cfg_signature(void)
 {
     QFWCFG *fw_cfg;
     QTestState *s;
     char buf[5];
+    char *cli = make_extra_args("");
 
-    s = qtest_init("");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     qfw_cfg_get(fw_cfg, FW_CFG_SIGNATURE, buf, 4);
@@ -38,6 +53,7 @@ static void test_fw_cfg_signature(void)
     g_assert_cmpstr(buf, ==, "QEMU");
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 static void test_fw_cfg_id(void)
@@ -45,8 +61,9 @@ static void test_fw_cfg_id(void)
     QFWCFG *fw_cfg;
     QTestState *s;
     uint32_t id;
+    char *cli = make_extra_args("");
 
-    s = qtest_init("");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
@@ -54,6 +71,7 @@ static void test_fw_cfg_id(void)
              (id == 3));
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 static void test_fw_cfg_uuid(void)
@@ -66,8 +84,9 @@ static void test_fw_cfg_uuid(void)
         0x46, 0x00, 0xcb, 0x32, 0x38, 0xec, 0x4b, 0x2f,
         0x8a, 0xcb, 0x81, 0xc6, 0xea, 0x54, 0xf2, 0xd8,
     };
+    char *cli = make_extra_args("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
 
-    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);
@@ -75,62 +94,70 @@ static void test_fw_cfg_uuid(void)
 
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
-
+    g_free(cli);
 }
 
 static void test_fw_cfg_ram_size(void)
 {
     QFWCFG *fw_cfg;
     QTestState *s;
+    char *cli = make_extra_args("");
 
-    s = qtest_init("");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), ==, ram_size);
 
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 static void test_fw_cfg_nographic(void)
 {
     QFWCFG *fw_cfg;
     QTestState *s;
+    char *cli = make_extra_args("");
 
-    s = qtest_init("");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), ==, 0);
 
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 static void test_fw_cfg_nb_cpus(void)
 {
     QFWCFG *fw_cfg;
     QTestState *s;
+    char *cli = make_extra_args("");
 
-    s = qtest_init("");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), ==, nb_cpus);
 
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 static void test_fw_cfg_max_cpus(void)
 {
     QFWCFG *fw_cfg;
     QTestState *s;
+    char *cli = make_extra_args("");
 
-    s = qtest_init("");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), ==, max_cpus);
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 static void test_fw_cfg_numa(void)
@@ -139,8 +166,9 @@ static void test_fw_cfg_numa(void)
     QTestState *s;
     uint64_t *cpu_mask;
     uint64_t *node_mask;
+    char *cli = make_extra_args("");
 
-    s = qtest_init("");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), ==, nb_nodes);
@@ -160,19 +188,22 @@ static void test_fw_cfg_numa(void)
     g_free(cpu_mask);
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 static void test_fw_cfg_boot_menu(void)
 {
     QFWCFG *fw_cfg;
     QTestState *s;
+    char *cli = make_extra_args("");
 
-    s = qtest_init("");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), ==, boot_menu);
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 static void test_fw_cfg_reboot_timeout(void)
@@ -181,8 +212,9 @@ static void test_fw_cfg_reboot_timeout(void)
     QTestState *s;
     uint32_t reboot_timeout = 0;
     size_t filesize;
+    char *cli = make_extra_args("-boot reboot-timeout=15");
 
-    s = qtest_init("-boot reboot-timeout=15");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
@@ -192,6 +224,7 @@ static void test_fw_cfg_reboot_timeout(void)
     g_assert_cmpint(reboot_timeout, ==, 15);
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 static void test_fw_cfg_no_reboot_timeout(void)
@@ -200,9 +233,10 @@ static void test_fw_cfg_no_reboot_timeout(void)
     QTestState *s;
     uint32_t reboot_timeout = 0;
     size_t filesize;
-
     /* Special value -1 means "don't reboot" */
-    s = qtest_init("-boot reboot-timeout=-1");
+    char *cli = make_extra_args("-boot reboot-timeout=-1");
+
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
@@ -212,6 +246,7 @@ static void test_fw_cfg_no_reboot_timeout(void)
     g_assert_cmpint(reboot_timeout, ==, UINT32_MAX);
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 static void test_fw_cfg_splash_time(void)
@@ -220,8 +255,9 @@ static void test_fw_cfg_splash_time(void)
     QTestState *s;
     uint16_t splash_time = 0;
     size_t filesize;
+    char *cli = make_extra_args("-boot splash-time=12");
 
-    s = qtest_init("-boot splash-time=12");
+    s = qtest_init(cli);
     fw_cfg = fw_cfg_init(s);
 
     filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-menu-wait",
@@ -231,6 +267,7 @@ static void test_fw_cfg_splash_time(void)
     g_assert_cmpint(splash_time, ==, 12);
     fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
+    g_free(cli);
 }
 
 int main(int argc, char **argv)
-- 
2.19.1



