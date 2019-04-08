Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB0EC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC4E20863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="hzaSIRze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC4E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58876 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDbMT-0005Ic-Lc
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 16:59:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKP-0003t0-Md
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKN-0007re-67
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:17 -0400
Received: from mail-it1-x133.google.com ([2607:f8b0:4864:20::133]:39530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKM-0007qo-W7
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:15 -0400
Received: by mail-it1-x133.google.com with SMTP id 139so1441664ita.4
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=3tEK2+PJw+6WFM4pZIhW7cs7LsovEQMQJBOABPDmMrk=;
	b=hzaSIRzeA58ysD8JgewGXDZsmXJ8lQXeNpgX7M0DFghMQ9NWqXXYnAb6n1/SLTyfRp
	wHTNgrn9qGg+IvXejahWTcZFuXKbDZfnCCGRxA3A5MU9lpumCZ+RM/FIV8lQT7VVhHVH
	bDYVoq77lbJhswSlOo5BwDkoTyiMYDZQ1/YheoI4iFz11AVO5ey/KaDxtVWwYsIjZhOQ
	osNg78AlzYpJnogb9vQOu+QBrxqPD//IFIJ/TyShcIXbrfffB8M/E9ACvUA0dzd/9Qq5
	QpCda8s1G89glXA/56fZWF3je5gwy5arEt94p2u7O9kn2t4N/MGPIhdEAlXbKT2AG0AS
	qeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3tEK2+PJw+6WFM4pZIhW7cs7LsovEQMQJBOABPDmMrk=;
	b=j8ZSsT8QLmFBKBhJLS2bzghIW3boIHp0ViGq3HfPIzRnF5netivVf65k8PKmLVL+Wc
	m43EcJlZhY7kfMX/5YuS2j1Cv/NEmFd2B0neBLmwLtM+kLup5uAYlWIt3poBDbj/aN9I
	2wRJSofZbBSByiqDDGAy3CgGDHWi09NeAskQpdapXknw49zmXSpMOGEFcRh8cerUQTCA
	eUadKkfKcqdrv/yolnacTi4Y5PZC5RKci16JL8lvthv5/yH6VosNcuvX+s0DMcFCDpMM
	uZgTnX741dxdXEXQu0xglHHcHiS8Q1SwL5bQVtiw+LU7WRjvzWoaU7T1GsKJOIP1zSfz
	Wdog==
X-Gm-Message-State: APjAAAV8a043q2m8GI97cAgNhZYquru0nScbTg7G3n/tqeFzhUCXCPmB
	a6RpW0ONM812couc7TuH/dlXsOzUPkYtXw==
X-Google-Smtp-Source: APXvYqxAogRVK8jGET7FPANFG7r9/XESdYfHQMZjeReIi0EQiamJeoJ1u23/T+dFvqC/5CF76/9RNw==
X-Received: by 2002:a02:1a89:: with SMTP id 131mr23128006jai.78.1554757034058; 
	Mon, 08 Apr 2019 13:57:14 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	h133sm5969313itb.34.2019.04.08.13.57.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 13:57:13 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 16:55:49 -0400
Message-Id:
 <32151d01f48ada4e0099f3adfd88229c5e5648c0.1554755001.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::133
Subject: [Qemu-devel] [PATCH 06/10] block/pflash_cfi02: Fix CFI in
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408205549.YkU_vo5pP7FpadbGmOP4MKFHTV8hw0C9Am66wHbM3DY@z>

After a flash device enters CFI mode from autoselect mode, the reset
command returns the device to autoselect mode. An additional reset
command is necessary to return to read array mode.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c   | 21 +++++++++++++++++----
 tests/pflash-cfi02-test.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 7c94c3adef..32aba9a771 100644
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
@@ -329,6 +330,12 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             DPRINTF("%s: flash reset asked (%02x %02x)\n",
                     __func__, pfl->cmd, cmd);
 #endif
+            if (pfl->wcycle == WCYCLE_AUTOSELECT_CFI) {
+                /* Return to autoselect mode. */
+                pfl->wcycle = 3;
+                pfl->cmd = 0x90;
+                return;
+            }
             goto reset_flash;
         }
     }
@@ -354,7 +361,6 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         /* We're in read mode */
     check_unlock0:
         if (masked_addr == 0x55 && cmd == 0x98) {
-        enter_CFI_mode:
             /* Enter CFI query mode */
             pfl->wcycle = WCYCLE_CFI;
             pfl->cmd = 0x98;
@@ -431,9 +437,15 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
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
@@ -514,6 +526,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case WCYCLE_CFI: /* Special value for CFI queries */
+    case WCYCLE_AUTOSELECT_CFI:
         DPRINTF("%s: invalid write in CFI query mode\n", __func__);
         goto reset_flash;
     default:
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index c16118e38b..c984295167 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -437,6 +437,39 @@ static void test_geometry(const void *opaque)
     qtest_quit(global_qtest);
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
+    const FlashConfig *c = opaque;
+    global_qtest = qtest_initf("-M musicpal,accel=qtest"
+                               " -drive if=pflash,file=%s,format=raw,"
+                               "copy-on-read",
+                               image_path);
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
+    qtest_quit(global_qtest);
+}
+
 static void cleanup(void *opaque)
 {
     unlink(image_path);
@@ -560,6 +593,9 @@ int main(int argc, char **argv)
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


