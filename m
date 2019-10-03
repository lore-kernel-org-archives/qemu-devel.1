Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A402C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D188E2086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D188E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGARE-0004nX-A9
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 19:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGA0o-0004Ae-T2
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGA0m-0008Si-7l
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:55:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGA0h-0008Pi-Nk
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:55:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B5E1308404E;
 Thu,  3 Oct 2019 22:55:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1725600C4;
 Thu,  3 Oct 2019 22:55:30 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] tests/fw_cfg: Declare one QFWCFG for all tests
Date: Fri,  4 Oct 2019 00:54:36 +0200
Message-Id: <20191003225437.16651-7-philmd@redhat.com>
In-Reply-To: <20191003225437.16651-1-philmd@redhat.com>
References: <20191003225437.16651-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 03 Oct 2019 22:55:37 +0000 (UTC)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is pointless to create/remove a QFWCFG object for each test.
Move it to the test context and create/remove it only once.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/fw_cfg-test.c | 74 +++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 47 deletions(-)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 6fb52a4d08..12dbaf4e67 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -25,47 +25,42 @@ static uint16_t boot_menu =3D 0;
=20
 typedef struct {
     const char *machine_name;
+    QFWCFG *fw_cfg;
 } QTestCtx;
=20
 static void test_fw_cfg_signature(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
     char buf[5];
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    qfw_cfg_get(s, fw_cfg, FW_CFG_SIGNATURE, buf, 4);
+    qfw_cfg_get(s, ctx->fw_cfg, FW_CFG_SIGNATURE, buf, 4);
     buf[4] =3D 0;
-
     g_assert_cmpstr(buf, =3D=3D, "QEMU");
-    g_free(fw_cfg);
+
     qtest_quit(s);
 }
=20
 static void test_fw_cfg_id(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
     uint32_t id;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    id =3D qfw_cfg_get_u32(s, fw_cfg, FW_CFG_ID);
+    id =3D qfw_cfg_get_u32(s, ctx->fw_cfg, FW_CFG_ID);
     g_assert((id =3D=3D 1) ||
              (id =3D=3D 3));
-    g_free(fw_cfg);
+
     qtest_quit(s);
 }
=20
 static void test_fw_cfg_uuid(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
=20
     uint8_t buf[16];
@@ -75,12 +70,10 @@ static void test_fw_cfg_uuid(const void *opaque)
     };
=20
     s =3D qtest_initf("-M %s -uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8"=
, ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    qfw_cfg_get(s, fw_cfg, FW_CFG_UUID, buf, 16);
+    qfw_cfg_get(s, ctx->fw_cfg, FW_CFG_UUID, buf, 16);
     g_assert(memcmp(buf, uuid, sizeof(buf)) =3D=3D 0);
=20
-    g_free(fw_cfg);
     qtest_quit(s);
=20
 }
@@ -88,80 +81,71 @@ static void test_fw_cfg_uuid(const void *opaque)
 static void test_fw_cfg_ram_size(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_RAM_SIZE), =3D=3D,=
 ram_size);
+    g_assert_cmpint(qfw_cfg_get_u64(s, ctx->fw_cfg, FW_CFG_RAM_SIZE),
+                    =3D=3D, ram_size);
=20
-    g_free(fw_cfg);
     qtest_quit(s);
 }
=20
 static void test_fw_cfg_nographic(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D=
, 0);
+    g_assert_cmpint(qfw_cfg_get_u16(s, ctx->fw_cfg, FW_CFG_NOGRAPHIC), =3D=
=3D, 0);
=20
-    g_free(fw_cfg);
     qtest_quit(s);
 }
=20
 static void test_fw_cfg_nb_cpus(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NB_CPUS), =3D=3D, =
nb_cpus);
+    g_assert_cmpint(qfw_cfg_get_u16(s, ctx->fw_cfg, FW_CFG_NB_CPUS),
+                    =3D=3D, nb_cpus);
=20
-    g_free(fw_cfg);
     qtest_quit(s);
 }
=20
 static void test_fw_cfg_max_cpus(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_MAX_CPUS), =3D=3D,=
 max_cpus);
-    g_free(fw_cfg);
+    g_assert_cmpint(qfw_cfg_get_u16(s, ctx->fw_cfg, FW_CFG_MAX_CPUS),
+                    =3D=3D, max_cpus);
+
     qtest_quit(s);
 }
=20
 static void test_fw_cfg_numa(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
     uint64_t *cpu_mask;
     uint64_t *node_mask;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_NUMA), =3D=3D, nb_=
nodes);
+    g_assert_cmpint(qfw_cfg_get_u64(s, ctx->fw_cfg, FW_CFG_NUMA),
+                    =3D=3D, nb_nodes);
=20
     cpu_mask =3D g_new0(uint64_t, max_cpus);
     node_mask =3D g_new0(uint64_t, nb_nodes);
=20
-    qfw_cfg_read_data(s, fw_cfg, cpu_mask, sizeof(uint64_t) * max_cpus);
-    qfw_cfg_read_data(s, fw_cfg, node_mask, sizeof(uint64_t) * nb_nodes)=
;
+    qfw_cfg_read_data(s, ctx->fw_cfg, cpu_mask, sizeof(uint64_t) * max_c=
pus);
+    qfw_cfg_read_data(s, ctx->fw_cfg, node_mask, sizeof(uint64_t) * nb_n=
odes);
=20
     if (nb_nodes) {
         g_assert(cpu_mask[0] & 0x01);
@@ -170,62 +154,56 @@ static void test_fw_cfg_numa(const void *opaque)
=20
     g_free(node_mask);
     g_free(cpu_mask);
-    g_free(fw_cfg);
+
     qtest_quit(s);
 }
=20
 static void test_fw_cfg_boot_menu(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
=20
     s =3D qtest_initf("-M %s", ctx->machine_name);
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_BOOT_MENU),
+    g_assert_cmpint(qfw_cfg_get_u16(s, ctx->fw_cfg, FW_CFG_BOOT_MENU),
                     =3D=3D, boot_menu);
-    g_free(fw_cfg);
+
     qtest_quit(s);
 }
=20
 static void test_fw_cfg_reboot_timeout(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
     uint32_t reboot_timeout =3D 0;
     size_t filesize;
=20
     s =3D qtest_initf("-M %s -boot reboot-timeout=3D15", ctx->machine_na=
me);
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    filesize =3D qfw_cfg_get_file(s, fw_cfg, "etc/boot-fail-wait",
+    filesize =3D qfw_cfg_get_file(s, ctx->fw_cfg, "etc/boot-fail-wait",
                                 &reboot_timeout, sizeof(reboot_timeout))=
;
     g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
     reboot_timeout =3D le32_to_cpu(reboot_timeout);
     g_assert_cmpint(reboot_timeout, =3D=3D, 15);
-    g_free(fw_cfg);
+
     qtest_quit(s);
 }
=20
 static void test_fw_cfg_splash_time(const void *opaque)
 {
     QTestCtx *ctx =3D (QTestCtx *)opaque;
-    QFWCFG *fw_cfg;
     QTestState *s;
     uint16_t splash_time =3D 0;
     size_t filesize;
=20
     s =3D qtest_initf("-M %s -boot splash-time=3D12", ctx->machine_name)=
;
-    fw_cfg =3D pc_fw_cfg_init();
=20
-    filesize =3D qfw_cfg_get_file(s, fw_cfg, "etc/boot-menu-wait",
+    filesize =3D qfw_cfg_get_file(s, ctx->fw_cfg, "etc/boot-menu-wait",
                                 &splash_time, sizeof(splash_time));
     g_assert_cmpint(filesize, =3D=3D, sizeof(splash_time));
     splash_time =3D le16_to_cpu(splash_time);
     g_assert_cmpint(splash_time, =3D=3D, 12);
-    g_free(fw_cfg);
+
     qtest_quit(s);
 }
=20
@@ -237,6 +215,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
=20
     ctx->machine_name =3D "pc";
+    ctx->fw_cfg =3D pc_fw_cfg_init();
=20
     qtest_add_data_func("fw_cfg/signature", ctx, test_fw_cfg_signature);
     qtest_add_data_func("fw_cfg/id", ctx, test_fw_cfg_id);
@@ -259,6 +238,7 @@ int main(int argc, char **argv)
=20
     ret =3D g_test_run();
=20
+    g_free(ctx->fw_cfg);
     g_free(ctx);
=20
     return ret;
--=20
2.20.1


