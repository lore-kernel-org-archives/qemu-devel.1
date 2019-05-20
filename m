Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA4C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235992081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235992081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42306 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSq3B-0005yy-BR
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:42:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSpyH-00020v-Tr
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSpyF-0003sb-Po
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:37:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSpyF-0003rB-Hz
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:37:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FA40C130704;
	Mon, 20 May 2019 21:37:21 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 016C75D704;
	Mon, 20 May 2019 21:37:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 23:36:57 +0200
Message-Id: <20190520213700.12620-5-philmd@redhat.com>
In-Reply-To: <20190520213700.12620-1-philmd@redhat.com>
References: <20190520213700.12620-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 20 May 2019 21:37:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/7] tests: fw_cfg: add a function to get
 the fw_cfg file
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, Li Qiang <liq3ea@163.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

This is useful to write qtest about fw_cfg file entry.

Signed-off-by: Li Qiang <liq3ea@163.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190424140643.62457-3-liq3ea@163.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/libqos/fw_cfg.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 tests/libqos/fw_cfg.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
index c6839c53c80..1f46258f96b 100644
--- a/tests/libqos/fw_cfg.c
+++ b/tests/libqos/fw_cfg.c
@@ -16,6 +16,7 @@
 #include "libqos/fw_cfg.h"
 #include "libqtest.h"
 #include "qemu/bswap.h"
+#include "hw/nvram/fw_cfg.h"
=20
 void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
@@ -59,6 +60,50 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t =
key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
=20
+/*
+ * The caller need check the return value. When the return value is
+ * nonzero, it means that some bytes have been transferred.
+ *
+ * If the fw_cfg file in question is smaller than the allocated & passed=
-in
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
+    unsigned char *filesbuf =3D NULL;
+    size_t dsize;
+    FWCfgFile *pdir_entry;
+    size_t filesize =3D 0;
+
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
+    count =3D be32_to_cpu(count);
+    dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
+    filesbuf =3D g_malloc(dsize);
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
+    pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t));
+    for (i =3D 0; i < count; ++i, ++pdir_entry) {
+        if (!strcmp(pdir_entry->name, filename)) {
+            uint32_t len =3D be32_to_cpu(pdir_entry->size);
+            uint16_t sel =3D be16_to_cpu(pdir_entry->select);
+            filesize =3D len;
+            if (len > buflen) {
+                len =3D buflen;
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
     uint8_t *ptr =3D data;
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
index 60de81e8633..13325cc4ffe 100644
--- a/tests/libqos/fw_cfg.h
+++ b/tests/libqos/fw_cfg.h
@@ -31,6 +31,8 @@ void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *da=
ta, size_t len);
 uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);
 uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
 uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
+size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
+                        void *data, size_t buflen);
=20
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
 void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
--=20
2.20.1


