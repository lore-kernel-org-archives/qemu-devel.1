Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B19C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9EE20675
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="athGMK9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9EE20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39442 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHmtF-0002SA-Vu
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 06:06:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmrN-000119-BH
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoC-00057s-OV
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:21 -0400
Received: from m12-14.163.com ([220.181.12.14]:59446)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoC-000567-5q
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=sCb8YXqnwMWDwlRe9R
	QnvuJNlooEDF6qc4SA035rRd4=; b=athGMK9X21oIAEwkWLaeyRFiChqWxTwTA6
	z8SBfGpuI34BBf56vb5yjzNYaSC9MIbAmxZSUXipuoklWrRSOrp0kdl7gagYQh7N
	uEZSw3g2/45F3n2875Q8PpZZlnQO8HEQ6mCNg65/yKG/BHHhMtO4IdVeW7l92H2J
	SJt7o7kuw=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp10 (Coremail) with SMTP id DsCowACHzxnk7bpcMStGBQ--.39886S4;
	Sat, 20 Apr 2019 18:01:14 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
	philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Date: Sat, 20 Apr 2019 03:00:54 -0700
Message-Id: <20190420100056.116305-3-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420100056.116305-1-liq3ea@163.com>
References: <20190420100056.116305-1-liq3ea@163.com>
X-CM-TRANSID: DsCowACHzxnk7bpcMStGBQ--.39886S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4kZF45Xr4DtF4DCFWUXFb_yoW5ArWkpF
	ZxAF13trZ3G3WfKrnxJw13JF1a9rykXr1UG3y3ZFWFyw17Arn8tF42k34F9ryUXrW8ZF45
	A3yq9Fyak3Z7XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOjjgUUUUU=
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFB2cbVaD0T3+BQABs7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.14
Subject: [Qemu-devel] [PATCH 2/4] tests: fw_cfg: add a function to get the
 fw_cfg file
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420100054._gpVQ687xZNm3JKQMCBn1TqPWFHKSDW6i-aZN4Hg3Cg@z>

This is useful to write qtest about fw_cfg file entry.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/libqos/fw_cfg.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 tests/libqos/fw_cfg.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
index c6839c53c8..1f46258f96 100644
--- a/tests/libqos/fw_cfg.c
+++ b/tests/libqos/fw_cfg.c
@@ -16,6 +16,7 @@
 #include "libqos/fw_cfg.h"
 #include "libqtest.h"
 #include "qemu/bswap.h"
+#include "hw/nvram/fw_cfg.h"
 
 void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
@@ -59,6 +60,50 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
+/*
+ * The caller need check the return value. When the return value is
+ * nonzero, it means that some bytes have been transferred.
+ *
+ * If the fw_cfg file in question is smaller than the allocated & passed-in
+ * buffer, then the buffer has been populated only in part.
+ *
+ * If the fw_cfg file in question is larger than the passed-in
+ * buffer, then the return value explains how much room would have been
+ * necessary in total. And, while the caller's buffer has been fully
+ * populated, it has received only a starting slice of the fw_cfg file.
+ */
+size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
+                      void *data, size_t buflen)
+{
+    uint32_t count;
+    uint32_t i;
+    unsigned char *filesbuf = NULL;
+    size_t dsize;
+    FWCfgFile *pdir_entry;
+    size_t filesize = 0;
+
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
+    count = be32_to_cpu(count);
+    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
+    filesbuf = g_malloc(dsize);
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
+    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
+    for (i = 0; i < count; ++i, ++pdir_entry) {
+        if (!strcmp(pdir_entry->name, filename)) {
+            uint32_t len = be32_to_cpu(pdir_entry->size);
+            uint16_t sel = be16_to_cpu(pdir_entry->select);
+            filesize = len;
+            if (len > buflen) {
+                len = buflen;
+            }
+            qfw_cfg_get(fw_cfg, sel, data, len);
+            break;
+        }
+    }
+    g_free(filesbuf);
+    return filesize;
+}
+
 static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
 {
     uint8_t *ptr = data;
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
index 60de81e863..13325cc4ff 100644
--- a/tests/libqos/fw_cfg.h
+++ b/tests/libqos/fw_cfg.h
@@ -31,6 +31,8 @@ void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *data, size_t len);
 uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);
 uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
 uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
+size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
+                        void *data, size_t buflen);
 
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
 void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
-- 
2.17.1



