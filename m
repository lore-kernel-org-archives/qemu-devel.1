Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D5BC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 22:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B9C217FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 22:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="AsZy8kiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B9C217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60293 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGsfW-0008OF-HI
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 18:04:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGsdT-00074N-NY
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGsdS-0004Yr-7g
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:31 -0400
Received: from mail-it1-x12e.google.com ([2607:f8b0:4864:20::12e]:37508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hGsdS-0004Y6-22
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:30 -0400
Received: by mail-it1-x12e.google.com with SMTP id u65so280165itc.2
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+uQP3FusTFtdndIWC1OK9UEmQ+MTbJh4vYeH0M5YAu4=;
	b=AsZy8kiBdKkIy+APPNDVI5E7j3Tg22fVu3RleWMQFZ/odbT/i/YJDvP9IK59ZdEjU7
	0TupJTZ83M0b+y7USVFHLqmehvmeTAGm3xLskJa3vWcBcRSvxsDPxPMnLX1JGfEVVJKX
	sIxbUSjwodus29rqQXj7v/vUR3ZcDpIo83R8Lks4FYmklM61/DXxTG0o6gSNFJPdodgz
	SOhlmECQ69E5wboroEqWRnemgHcmvjn8XpKxLmVmDwAgRoRUVIFn6A6SVFOJGaVU76rj
	00X1VAFxADnLdvO9H3Drg9W/PI+zwcjCkgMXY8ukG9CFk6TyqVJEx+TlJlS4/DdgA5w7
	REuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+uQP3FusTFtdndIWC1OK9UEmQ+MTbJh4vYeH0M5YAu4=;
	b=rQoSCkTX1/pMBd+DVk9UDmxkIMGFapjatlm88ELX1qTPxLKdvzWxYGddovF4E/cTUl
	Xbtbj7avy1387t5eeuk842nqn6CXVcbAO/tDfhkmkeBFeRq+2YNghijHTqJRzpMdMB7s
	cG40daB2LYT5/IHNCrtOypi52hU/7Cu5qY9eUJOYNRIoyggJXOm7to49ffCHSYmE718S
	KH5sz3pMAgtmDZRcfsUZS7Rzjd6SjFkIazkIAXAoemqzADy1cn6rbhH57bCNHNPDxVnr
	HlxNiv3iuy5yRPGqPgdlaUMq6SGaAWX00q81H4y4AmPLYBoukGQvMjUXrbnswUiYuAie
	eKgQ==
X-Gm-Message-State: APjAAAX3JQJYO8Iq0Wet8wdnoUDTUnavCpHscqxouR9gPXudgPN8khas
	O1skV3qBK6LJnfHKbwWvfGgh0tCU4YgDHYJZ
X-Google-Smtp-Source: APXvYqysD/Q++zZobiXTcHeVnTPWYk0VD884phFZo/4TPPVM8OL6ByC03HQasu8V3izq7eov+G22iQ==
X-Received: by 2002:a24:6987:: with SMTP id e129mr762125itc.28.1555538549329; 
	Wed, 17 Apr 2019 15:02:29 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93])
	by smtp.gmail.com with ESMTPSA id e81sm147874itc.3.2019.04.17.15.02.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 17 Apr 2019 15:02:28 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2019 18:01:43 -0400
Message-Id: <20190417220147.67648-7-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::12e
Subject: [Qemu-devel] [PATCH v3 06/10] block/pflash_cfi02: Fix CFI in
 autoselect mode
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417220143.mPkrhUBgCqbnItB5ntGGDNiMZs_0aUlPQe868L17FNk@z>

After a flash device enters CFI mode from autoselect mode, the reset
command returns the device to autoselect mode. An additional reset
command is necessary to return to read array mode.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c   | 21 +++++++++++++++++----
 tests/pflash-cfi02-test.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c4efbe8cdf..be10036886 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -61,8 +61,9 @@ do {                                                       \
  */
 #define PFLASH_MAX_ERASE_REGIONS 4
 
-/* Special write cycle for CFI queries. */
+/* Special write cycles for CFI queries. */
 #define WCYCLE_CFI 7
+#define WCYCLE_AUTOSELECT_CFI 8
 
 struct PFlashCFI02 {
     /*< private >*/
@@ -325,6 +326,12 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         }
 
         if (cmd == 0xF0) {
+            if (pfl->wcycle == WCYCLE_AUTOSELECT_CFI) {
+                /* Return to autoselect mode. */
+                pfl->wcycle = 3;
+                pfl->cmd = 0x90;
+                return;
+            }
             goto reset_flash;
         }
     }
@@ -350,7 +357,6 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         /* We're in read mode */
     check_unlock0:
         if (masked_addr == 0x55 && cmd == 0x98) {
-        enter_CFI_mode:
             /* Enter CFI query mode */
             pfl->wcycle = WCYCLE_CFI;
             pfl->cmd = 0x98;
@@ -427,9 +433,15 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                 /* Unlock bypass reset */
                 goto reset_flash;
             }
-            /* We can enter CFI query mode from autoselect mode */
+            /*
+             * We can enter CFI query mode from autoselect mode, but we must
+             * return to autoselect mode after a reset.
+             */
             if (masked_addr == 0x55 && cmd == 0x98) {
-                goto enter_CFI_mode;
+                /* Enter autoselect CFI query mode */
+                pfl->wcycle = WCYCLE_AUTOSELECT_CFI;
+                pfl->cmd = 0x98;
+                return;
             }
             /* No break here */
         default:
@@ -510,6 +522,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case WCYCLE_CFI: /* Special value for CFI queries */
+    case WCYCLE_AUTOSELECT_CFI:
         DPRINTF("%s: invalid write in CFI query mode\n", __func__);
         goto reset_flash;
     default:
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index 82bc5695e1..4039647604 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -480,6 +480,42 @@ static void test_geometry(const void *opaque)
     qtest_quit(qtest);
 }
 
+/*
+ * Test that
+ * 1. enter autoselect mode;
+ * 2. enter CFI mode; and then
+ * 3. exit CFI mode
+ * leaves the flash device in autoselect mode.
+ */
+static void test_cfi_in_autoselect(const void *opaque)
+{
+    const FlashConfig *config = opaque;
+    QTestState *qtest = qtest_initf("-M musicpal,accel=qtest"
+                                    " -drive if=pflash,file=%s,format=raw,"
+                                    "copy-on-read",
+                                    image_path);
+    FlashConfig explicit_config = expand_config_defaults(config);
+    explicit_config.qtest = qtest;
+    const FlashConfig *c = &explicit_config;
+
+    /* 1. Enter autoselect. */
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+
+    /* 2. Enter CFI. */
+    flash_cmd(c, CFI_ADDR, CFI_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x10)), ==, replicate(c, 'Q'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x11)), ==, replicate(c, 'R'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x12)), ==, replicate(c, 'Y'));
+
+    /* 3. Exit CFI. */
+    reset(c);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+
+    qtest_quit(qtest);
+}
+
 static void cleanup(void *opaque)
 {
     unlink(image_path);
@@ -605,6 +641,9 @@ int main(int argc, char **argv)
         qtest_add_data_func(path, config, test_geometry);
         g_free(path);
     }
+
+    qtest_add_data_func("pflash-cfi02/cfi-in-autoselect", &configuration[0],
+                        test_cfi_in_autoselect);
     int result = g_test_run();
     cleanup(NULL);
     return result;
-- 
2.20.1 (Apple Git-117)


