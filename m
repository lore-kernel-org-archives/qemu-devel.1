Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 23:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD35206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 23:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD35206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jky59-0007Vq-Ou
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 18:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe.slater@windriver.com>)
 id 1jky4a-00075b-FI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 18:59:24 -0400
Received: from mail5.windriver.com ([192.103.53.11]:40468 helo=mail5.wrs.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe.slater@windriver.com>)
 id 1jky4X-0005Ej-N6
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 18:59:23 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
 [147.11.189.41])
 by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 05FMwupR006435
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 15:59:06 -0700
Received: from ala-lpggp3.wrs.com (147.11.105.124) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 15 Jun 2020 15:58:27 -0700
From: Joe Slater <joe.slater@windriver.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/1] os_find_datadir:  search as in version 4.2
Date: Mon, 15 Jun 2020 15:58:27 -0700
Message-ID: <20200615225827.183062-1-joe.slater@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=192.103.53.11;
 envelope-from=joe.slater@windriver.com; helo=mail5.wrs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 18:59:17
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: joe.slater@windriver.com, randy.macleod@windriver.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Always look for ../share/qemu then ../pc-bios when looking for datadir.

Signed-off-by: Joe Slater <joe.slater@windriver.com>
---
 os-posix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/os-posix.c b/os-posix.c
index 3cd52e1e70..f77da94bf6 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -82,8 +82,9 @@ void os_setup_signal_handling(void)
 
 /*
  * Find a likely location for support files using the location of the binary.
+ * Typically, this would be "$bindir/../share/qemu".
  * When running from the build tree this will be "$bindir/../pc-bios".
- * Otherwise, this is CONFIG_QEMU_DATADIR.
+ * Otherwise, this is CONFIG_QEMU_DATADIR as constructed by configure.
  */
 char *os_find_datadir(void)
 {
@@ -93,6 +94,12 @@ char *os_find_datadir(void)
     exec_dir = qemu_get_exec_dir();
     g_return_val_if_fail(exec_dir != NULL, NULL);
 
+    dir = g_build_filename(exec_dir, "..", "share", "qemu", NULL);
+    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
+        return g_steal_pointer(&dir);
+    }
+    g_free(dir);  /* no autofree this time */
+
     dir = g_build_filename(exec_dir, "..", "pc-bios", NULL);
     if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
         return g_steal_pointer(&dir);
-- 
2.17.1


