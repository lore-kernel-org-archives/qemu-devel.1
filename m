Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7ED20684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7ED20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7NA-00028B-Ko
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 07:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1ic7JV-00084P-AS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1ic7JN-0003jE-MH
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:29:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40890 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1ic7JD-0003QB-PK; Tue, 03 Dec 2019 07:29:41 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7C2628850E3415A8B2D3;
 Tue,  3 Dec 2019 20:29:31 +0800 (CST)
Received: from HGHY4Z004218071.china.huawei.com (10.133.224.57) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Dec 2019 20:29:22 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: <peter.maydell@linaro.org>, <thuth@redhat.com>, <lvivier@redhat.com>
Subject: [PATCH 1/5] tests: fw_cfg: Rename pc_fw_cfg_* to fw_cfg_*
Date: Tue, 3 Dec 2019 20:27:49 +0800
Message-ID: <20191203122753.19792-2-zhengxiang9@huawei.com>
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

Rename pc_fw_cfg_* to fw_cfg_* to make them common for other
architectures so that we can run fw_cfg tests on aarch64.

Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 tests/fw_cfg-test.c      | 48 ++++++++++++++++++++--------------------
 tests/hd-geo-test.c      |  6 ++---
 tests/libqos/fw_cfg.h    | 20 +++++++++++++----
 tests/libqos/malloc-pc.c |  4 ++--
 4 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 5dc807ba23..5a5342fa9d 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -30,13 +30,13 @@ static void test_fw_cfg_signature(void)
     char buf[5];
 
     s = qtest_init("");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     qfw_cfg_get(fw_cfg, FW_CFG_SIGNATURE, buf, 4);
     buf[4] = 0;
 
     g_assert_cmpstr(buf, ==, "QEMU");
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
@@ -47,12 +47,12 @@ static void test_fw_cfg_id(void)
     uint32_t id;
 
     s = qtest_init("");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
     g_assert((id == 1) ||
              (id == 3));
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
@@ -68,12 +68,12 @@ static void test_fw_cfg_uuid(void)
     };
 
     s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);
     g_assert(memcmp(buf, uuid, sizeof(buf)) == 0);
 
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 
 }
@@ -84,11 +84,11 @@ static void test_fw_cfg_ram_size(void)
     QTestState *s;
 
     s = qtest_init("");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), ==, ram_size);
 
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
@@ -98,11 +98,11 @@ static void test_fw_cfg_nographic(void)
     QTestState *s;
 
     s = qtest_init("");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), ==, 0);
 
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
@@ -112,11 +112,11 @@ static void test_fw_cfg_nb_cpus(void)
     QTestState *s;
 
     s = qtest_init("");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), ==, nb_cpus);
 
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
@@ -126,10 +126,10 @@ static void test_fw_cfg_max_cpus(void)
     QTestState *s;
 
     s = qtest_init("");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), ==, max_cpus);
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
@@ -141,7 +141,7 @@ static void test_fw_cfg_numa(void)
     uint64_t *node_mask;
 
     s = qtest_init("");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), ==, nb_nodes);
 
@@ -158,7 +158,7 @@ static void test_fw_cfg_numa(void)
 
     g_free(node_mask);
     g_free(cpu_mask);
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
@@ -168,10 +168,10 @@ static void test_fw_cfg_boot_menu(void)
     QTestState *s;
 
     s = qtest_init("");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), ==, boot_menu);
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
@@ -183,14 +183,14 @@ static void test_fw_cfg_reboot_timeout(void)
     size_t filesize;
 
     s = qtest_init("-boot reboot-timeout=15");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
                                 &reboot_timeout, sizeof(reboot_timeout));
     g_assert_cmpint(filesize, ==, sizeof(reboot_timeout));
     reboot_timeout = le32_to_cpu(reboot_timeout);
     g_assert_cmpint(reboot_timeout, ==, 15);
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
@@ -203,14 +203,14 @@ static void test_fw_cfg_no_reboot_timeout(void)
 
     /* Special value -1 means "don't reboot" */
     s = qtest_init("-boot reboot-timeout=-1");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
                                 &reboot_timeout, sizeof(reboot_timeout));
     g_assert_cmpint(filesize, ==, sizeof(reboot_timeout));
     reboot_timeout = le32_to_cpu(reboot_timeout);
     g_assert_cmpint(reboot_timeout, ==, UINT32_MAX);
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
@@ -222,14 +222,14 @@ static void test_fw_cfg_splash_time(void)
     size_t filesize;
 
     s = qtest_init("-boot splash-time=12");
-    fw_cfg = pc_fw_cfg_init(s);
+    fw_cfg = fw_cfg_init(s);
 
     filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-menu-wait",
                                 &splash_time, sizeof(splash_time));
     g_assert_cmpint(filesize, ==, sizeof(splash_time));
     splash_time = le16_to_cpu(splash_time);
     g_assert_cmpint(splash_time, ==, 12);
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
     qtest_quit(s);
 }
 
diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 7e86c5416c..a9b8a07403 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -693,7 +693,7 @@ static void test_override(TestArgs *args, CHSResult expected[])
     joined_args = g_strjoinv(" ", args->argv);
 
     qts = qtest_init(joined_args);
-    fw_cfg = pc_fw_cfg_init(qts);
+    fw_cfg = fw_cfg_init(qts);
 
     read_bootdevices(fw_cfg, expected);
 
@@ -829,7 +829,7 @@ static void test_override_scsi_hot_unplug(void)
     joined_args = g_strjoinv(" ", args->argv);
 
     qts = qtest_init(joined_args);
-    fw_cfg = pc_fw_cfg_init(qts);
+    fw_cfg = fw_cfg_init(qts);
 
     read_bootdevices(fw_cfg, expected);
 
@@ -889,7 +889,7 @@ static void test_override_virtio_hot_unplug(void)
     joined_args = g_strjoinv(" ", args->argv);
 
     qts = qtest_init(joined_args);
-    fw_cfg = pc_fw_cfg_init(qts);
+    fw_cfg = fw_cfg_init(qts);
 
     read_bootdevices(fw_cfg, expected);
 
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
index 13325cc4ff..708aa922ed 100644
--- a/tests/libqos/fw_cfg.h
+++ b/tests/libqos/fw_cfg.h
@@ -39,14 +39,26 @@ void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
 QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
 void io_fw_cfg_uninit(QFWCFG *fw_cfg);
 
-static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
+static inline QFWCFG *fw_cfg_init(QTestState *qts)
 {
-    return io_fw_cfg_init(qts, 0x510);
+    const char *arch = qtest_get_arch();
+
+    if (!strcmp(arch, "aarch64")) {
+        return mm_fw_cfg_init(qts, 0x09020000);
+    } else {
+        return io_fw_cfg_init(qts, 0x510);
+    }
 }
 
-static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)
+static inline void fw_cfg_uninit(QFWCFG *fw_cfg)
 {
-    io_fw_cfg_uninit(fw_cfg);
+    const char *arch = qtest_get_arch();
+
+    if (!strcmp(arch, "aarch64")) {
+        mm_fw_cfg_uninit(fw_cfg);
+    } else {
+        io_fw_cfg_uninit(fw_cfg);
+    }
 }
 
 #endif
diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c
index 6f92ce4135..5c58bf6e88 100644
--- a/tests/libqos/malloc-pc.c
+++ b/tests/libqos/malloc-pc.c
@@ -23,11 +23,11 @@
 void pc_alloc_init(QGuestAllocator *s, QTestState *qts, QAllocOpts flags)
 {
     uint64_t ram_size;
-    QFWCFG *fw_cfg = pc_fw_cfg_init(qts);
+    QFWCFG *fw_cfg = fw_cfg_init(qts);
 
     ram_size = qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE);
     alloc_init(s, flags, 1 << 20, MIN(ram_size, 0xE0000000), PAGE_SIZE);
 
     /* clean-up */
-    pc_fw_cfg_uninit(fw_cfg);
+    fw_cfg_uninit(fw_cfg);
 }
-- 
2.19.1



