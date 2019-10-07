Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80414C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44601205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44601205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHUuM-0000J6-7e
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHUoB-00039Z-8b
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHUo8-00008Z-1s
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:20:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHUo6-00006t-4I
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:20:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D40AC859FC;
 Mon,  7 Oct 2019 15:20:16 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 827CC19C5B;
 Mon,  7 Oct 2019 15:20:01 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] tests/libqos/fw_cfg: Pass QTestState as argument
Date: Mon,  7 Oct 2019 17:19:03 +0200
Message-Id: <20191007151905.32766-6-philmd@redhat.com>
In-Reply-To: <20191007151905.32766-1-philmd@redhat.com>
References: <20191007151905.32766-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 07 Oct 2019 15:20:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since a QFWCFG object is not tied to a particular test, we can
call *_fw_cfg_init() once before creating QTests and use the same
for all the tests, then release the object with g_free() once all
the tests are run.

Refactor the qfw_cfg* API to take QTestState as argument.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/boot-order-test.c  | 12 ++++----
 tests/fw_cfg-test.c      | 49 ++++++++++++++++----------------
 tests/libqos/fw_cfg.c    | 61 ++++++++++++++++++++--------------------
 tests/libqos/fw_cfg.h    | 31 +++++++++-----------
 tests/libqos/malloc-pc.c |  4 +--
 5 files changed, 78 insertions(+), 79 deletions(-)

diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index a725bce729..e2d1b7940f 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -134,9 +134,9 @@ static void test_prep_boot_order(void)
=20
 static uint64_t read_boot_order_pmac(QTestState *qts)
 {
-    QFWCFG *fw_cfg =3D mm_fw_cfg_init(qts, 0xf0000510);
+    QFWCFG *fw_cfg =3D mm_fw_cfg_init(0xf0000510);
=20
-    return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
+    return qfw_cfg_get_u16(qts, fw_cfg, FW_CFG_BOOT_DEVICE);
 }
=20
 static const boot_order_test test_cases_fw_cfg[] =3D {
@@ -159,9 +159,9 @@ static void test_pmac_newworld_boot_order(void)
=20
 static uint64_t read_boot_order_sun4m(QTestState *qts)
 {
-    QFWCFG *fw_cfg =3D mm_fw_cfg_init(qts, 0xd00000510ULL);
+    QFWCFG *fw_cfg =3D mm_fw_cfg_init(0xd00000510ULL);
=20
-    return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
+    return qfw_cfg_get_u16(qts, fw_cfg, FW_CFG_BOOT_DEVICE);
 }
=20
 static void test_sun4m_boot_order(void)
@@ -171,9 +171,9 @@ static void test_sun4m_boot_order(void)
=20
 static uint64_t read_boot_order_sun4u(QTestState *qts)
 {
-    QFWCFG *fw_cfg =3D io_fw_cfg_init(qts, 0x510);
+    QFWCFG *fw_cfg =3D io_fw_cfg_init(0x510);
=20
-    return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
+    return qfw_cfg_get_u16(qts, fw_cfg, FW_CFG_BOOT_DEVICE);
 }
=20
 static void test_sun4u_boot_order(void)
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 65785bca73..dda9a9fb07 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -35,9 +35,9 @@ static void test_fw_cfg_signature(const void *opaque)
     char buf[5];
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    qfw_cfg_get(fw_cfg, FW_CFG_SIGNATURE, buf, 4);
+    qfw_cfg_get(s, fw_cfg, FW_CFG_SIGNATURE, buf, 4);
     buf[4] =3D 0;
=20
     g_assert_cmpstr(buf, =3D=3D, "QEMU");
@@ -53,9 +53,9 @@ static void test_fw_cfg_id(const void *opaque)
     uint32_t id;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
+    id =3D qfw_cfg_get_u32(s, fw_cfg, FW_CFG_ID);
     g_assert((id =3D=3D 1) ||
              (id =3D=3D 3));
     g_free(fw_cfg);
@@ -76,9 +76,9 @@ static void test_fw_cfg_uuid(const void *opaque)
=20
     s =3D qtest_initf("-M %s -uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8"=
,
                     ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);
+    qfw_cfg_get(s, fw_cfg, FW_CFG_UUID, buf, 16);
     g_assert(memcmp(buf, uuid, sizeof(buf)) =3D=3D 0);
=20
     g_free(fw_cfg);
@@ -93,9 +93,9 @@ static void test_fw_cfg_ram_size(const void *opaque)
     QTestState *s;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), =3D=3D, ra=
m_size);
+    g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_RAM_SIZE), =3D=3D,=
 ram_size);
=20
     g_free(fw_cfg);
     qtest_quit(s);
@@ -108,9 +108,9 @@ static void test_fw_cfg_nographic(const void *opaque)
     QTestState *s;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D, 0=
);
+    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D=
, 0);
=20
     g_free(fw_cfg);
     qtest_quit(s);
@@ -123,9 +123,9 @@ static void test_fw_cfg_nb_cpus(const void *opaque)
     QTestState *s;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), =3D=3D, nb_=
cpus);
+    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NB_CPUS), =3D=3D, =
nb_cpus);
=20
     g_free(fw_cfg);
     qtest_quit(s);
@@ -138,9 +138,9 @@ static void test_fw_cfg_max_cpus(const void *opaque)
     QTestState *s;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), =3D=3D, ma=
x_cpus);
+    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_MAX_CPUS), =3D=3D,=
 max_cpus);
     g_free(fw_cfg);
     qtest_quit(s);
 }
@@ -154,15 +154,15 @@ static void test_fw_cfg_numa(const void *opaque)
     uint64_t *node_mask;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), =3D=3D, nb_nod=
es);
+    g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_NUMA), =3D=3D, nb_=
nodes);
=20
     cpu_mask =3D g_new0(uint64_t, max_cpus);
     node_mask =3D g_new0(uint64_t, nb_nodes);
=20
-    qfw_cfg_read_data(fw_cfg, cpu_mask, sizeof(uint64_t) * max_cpus);
-    qfw_cfg_read_data(fw_cfg, node_mask, sizeof(uint64_t) * nb_nodes);
+    qfw_cfg_read_data(s, fw_cfg, cpu_mask, sizeof(uint64_t) * max_cpus);
+    qfw_cfg_read_data(s, fw_cfg, node_mask, sizeof(uint64_t) * nb_nodes)=
;
=20
     if (nb_nodes) {
         g_assert(cpu_mask[0] & 0x01);
@@ -182,9 +182,10 @@ static void test_fw_cfg_boot_menu(const void *opaque=
)
     QTestState *s;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D, b=
oot_menu);
+    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_BOOT_MENU),
+                    =3D=3D, boot_menu);
     g_free(fw_cfg);
     qtest_quit(s);
 }
@@ -198,9 +199,9 @@ static void test_fw_cfg_reboot_timeout(const void *op=
aque)
     size_t filesize;
=20
     s =3D qtest_initf("-M %s -boot reboot-timeout=3D15", ctx->machine_na=
me);
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
+    filesize =3D qfw_cfg_get_file(s, fw_cfg, "etc/boot-fail-wait",
                                 &reboot_timeout, sizeof(reboot_timeout))=
;
     g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
     reboot_timeout =3D le32_to_cpu(reboot_timeout);
@@ -218,9 +219,9 @@ static void test_fw_cfg_splash_time(const void *opaqu=
e)
     size_t filesize;
=20
     s =3D qtest_initf("-M %s -boot splash-time=3D12", ctx->machine_name)=
;
-    fw_cfg =3D pc_fw_cfg_init(s);
+    fw_cfg =3D pc_fw_cfg_init();
=20
-    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-menu-wait",
+    filesize =3D qfw_cfg_get_file(s, fw_cfg, "etc/boot-menu-wait",
                                 &splash_time, sizeof(splash_time));
     g_assert_cmpint(filesize, =3D=3D, sizeof(splash_time));
     splash_time =3D le16_to_cpu(splash_time);
diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
index ddeec821db..d25a367194 100644
--- a/tests/libqos/fw_cfg.c
+++ b/tests/libqos/fw_cfg.c
@@ -18,46 +18,47 @@
 #include "qemu/bswap.h"
 #include "hw/nvram/fw_cfg.h"
=20
-void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
+void qfw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)
 {
-    fw_cfg->select(fw_cfg, key);
+    fw_cfg->select(qts, fw_cfg, key);
 }
=20
-void qfw_cfg_read_data(QFWCFG *fw_cfg, void *data, size_t len)
+void qfw_cfg_read_data(QTestState *qts, QFWCFG *fw_cfg, void *data, size=
_t len)
 {
-    fw_cfg->read(fw_cfg, data, len);
+    fw_cfg->read(qts, fw_cfg, data, len);
 }
=20
-void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *data, size_t len)
+void qfw_cfg_get(QTestState *qts, QFWCFG *fw_cfg, uint16_t key,
+                 void *data, size_t len)
 {
-    qfw_cfg_select(fw_cfg, key);
-    qfw_cfg_read_data(fw_cfg, data, len);
+    qfw_cfg_select(qts, fw_cfg, key);
+    qfw_cfg_read_data(qts, fw_cfg, data, len);
 }
=20
-uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key)
+uint16_t qfw_cfg_get_u16(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)
 {
     uint16_t value;
-    qfw_cfg_get(fw_cfg, key, &value, sizeof(value));
+    qfw_cfg_get(qts, fw_cfg, key, &value, sizeof(value));
     return le16_to_cpu(value);
 }
=20
-uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key)
+uint32_t qfw_cfg_get_u32(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)
 {
     uint32_t value;
-    qfw_cfg_get(fw_cfg, key, &value, sizeof(value));
+    qfw_cfg_get(qts, fw_cfg, key, &value, sizeof(value));
     return le32_to_cpu(value);
 }
=20
-uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)
+uint64_t qfw_cfg_get_u64(QTestState *qts, QFWCFG *fw_cfg, uint16_t key)
 {
     uint64_t value;
-    qfw_cfg_get(fw_cfg, key, &value, sizeof(value));
+    qfw_cfg_get(qts, fw_cfg, key, &value, sizeof(value));
     return le64_to_cpu(value);
 }
=20
-static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
+static void mm_fw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t k=
ey)
 {
-    qtest_writew(fw_cfg->qts, fw_cfg->base, key);
+    qtest_writew(qts, fw_cfg->base, key);
 }
=20
 /*
@@ -72,8 +73,8 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t k=
ey)
  * necessary in total. And, while the caller's buffer has been fully
  * populated, it has received only a starting slice of the fw_cfg file.
  */
-size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
-                      void *data, size_t buflen)
+size_t qfw_cfg_get_file(QTestState *qts, QFWCFG *fw_cfg, const char *fil=
ename,
+                        void *data, size_t buflen)
 {
     uint32_t count;
     uint32_t i;
@@ -82,11 +83,11 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *f=
ilename,
     FWCfgFile *pdir_entry;
     size_t filesize =3D 0;
=20
-    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
+    qfw_cfg_get(qts, fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
     count =3D be32_to_cpu(count);
     dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
     filesbuf =3D g_malloc(dsize);
-    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
+    qfw_cfg_get(qts, fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
     pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t));
     for (i =3D 0; i < count; ++i, ++pdir_entry) {
         if (!strcmp(pdir_entry->name, filename)) {
@@ -96,7 +97,7 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *fil=
ename,
             if (len > buflen) {
                 len =3D buflen;
             }
-            qfw_cfg_get(fw_cfg, sel, data, len);
+            qfw_cfg_get(qts, fw_cfg, sel, data, len);
             break;
         }
     }
@@ -104,49 +105,49 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char =
*filename,
     return filesize;
 }
=20
-static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
+static void mm_fw_cfg_read(QTestState *qts, QFWCFG *fw_cfg,
+                           void *data, size_t len)
 {
     uint8_t *ptr =3D data;
     int i;
=20
     for (i =3D 0; i < len; i++) {
-        ptr[i] =3D qtest_readb(fw_cfg->qts, fw_cfg->base + 2);
+        ptr[i] =3D qtest_readb(qts, fw_cfg->base + 2);
     }
 }
=20
-QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base)
+QFWCFG *mm_fw_cfg_init(uint64_t base)
 {
     QFWCFG *fw_cfg =3D g_malloc0(sizeof(*fw_cfg));
=20
     fw_cfg->base =3D base;
-    fw_cfg->qts =3D qts;
     fw_cfg->select =3D mm_fw_cfg_select;
     fw_cfg->read =3D mm_fw_cfg_read;
=20
     return fw_cfg;
 }
=20
-static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
+static void io_fw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t k=
ey)
 {
-    qtest_outw(fw_cfg->qts, fw_cfg->base, key);
+    qtest_outw(qts, fw_cfg->base, key);
 }
=20
-static void io_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
+static void io_fw_cfg_read(QTestState *qts, QFWCFG *fw_cfg,
+                           void *data, size_t len)
 {
     uint8_t *ptr =3D data;
     int i;
=20
     for (i =3D 0; i < len; i++) {
-        ptr[i] =3D qtest_inb(fw_cfg->qts, fw_cfg->base + 1);
+        ptr[i] =3D qtest_inb(qts, fw_cfg->base + 1);
     }
 }
=20
-QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base)
+QFWCFG *io_fw_cfg_init(uint16_t base)
 {
     QFWCFG *fw_cfg =3D g_malloc0(sizeof(*fw_cfg));
=20
     fw_cfg->base =3D base;
-    fw_cfg->qts =3D qts;
     fw_cfg->select =3D io_fw_cfg_select;
     fw_cfg->read =3D io_fw_cfg_read;
=20
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
index 6316f4c354..f9e69be450 100644
--- a/tests/libqos/fw_cfg.h
+++ b/tests/libqos/fw_cfg.h
@@ -20,52 +20,49 @@ typedef struct QFWCFG QFWCFG;
 struct QFWCFG
 {
     uint64_t base;
-    QTestState *qts;
-    void (*select)(QFWCFG *fw_cfg, uint16_t key);
-    void (*read)(QFWCFG *fw_cfg, void *data, size_t len);
+    void (*select)(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);
+    void (*read)(QTestState *qts, QFWCFG *fw_cfg, void *data, size_t len=
);
 };
=20
-void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key);
-void qfw_cfg_read_data(QFWCFG *fw_cfg, void *data, size_t len);
-void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *data, size_t len);
-uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);
-uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
-uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
-size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
+void qfw_cfg_select(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);
+void qfw_cfg_read_data(QTestState *qts, QFWCFG *fw_cfg, void *data, size=
_t len);
+void qfw_cfg_get(QTestState *qts, QFWCFG *fw_cfg, uint16_t key,
+                 void *data, size_t len);
+uint16_t qfw_cfg_get_u16(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);
+uint32_t qfw_cfg_get_u32(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);
+uint64_t qfw_cfg_get_u64(QTestState *qts, QFWCFG *fw_cfg, uint16_t key);
+size_t qfw_cfg_get_file(QTestState *qts, QFWCFG *fw_cfg, const char *fil=
ename,
                         void *data, size_t buflen);
=20
 /**
  * mm_fw_cfg_init():
- * @qts: The #QTestState that will be referred to by the QFWCFG object.
  * @base: The MMIO base address of the fw_cfg device in the guest.
  *
  * Returns a newly allocated QFWCFG object which must be released
  * with a call to g_free() when no longer required.
  */
-QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
+QFWCFG *mm_fw_cfg_init(uint64_t base);
=20
 /**
  * io_fw_cfg_init():
- * @qts: The #QTestState that will be referred to by the QFWCFG object.
  * @base: The I/O address of the fw_cfg device in the guest.
  *
  * Returns a newly allocated QFWCFG object which must be released
  * with a call to g_free() when no longer required.
  */
-QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
+QFWCFG *io_fw_cfg_init(uint16_t base);
=20
 /**
  * pc_fw_cfg_init():
- * @qts: The #QTestState that will be referred to by the QFWCFG object.
  *
  * This function is specific to the PC machine (X86).
  *
  * Returns a newly allocated QFWCFG object which must be released
  * with a call to g_free() when no longer required.
  */
-static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
+static inline QFWCFG *pc_fw_cfg_init(void)
 {
-    return io_fw_cfg_init(qts, 0x510);
+    return io_fw_cfg_init(0x510);
 }
=20
 #endif
diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c
index 949a99361d..4932ae092d 100644
--- a/tests/libqos/malloc-pc.c
+++ b/tests/libqos/malloc-pc.c
@@ -23,9 +23,9 @@
 void pc_alloc_init(QGuestAllocator *s, QTestState *qts, QAllocOpts flags=
)
 {
     uint64_t ram_size;
-    QFWCFG *fw_cfg =3D pc_fw_cfg_init(qts);
+    QFWCFG *fw_cfg =3D pc_fw_cfg_init();
=20
-    ram_size =3D qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE);
+    ram_size =3D qfw_cfg_get_u64(qts, fw_cfg, FW_CFG_RAM_SIZE);
     alloc_init(s, flags, 1 << 20, MIN(ram_size, 0xE0000000), PAGE_SIZE);
=20
     /* clean-up */
--=20
2.21.0


