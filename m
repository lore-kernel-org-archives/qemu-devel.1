Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35EC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5533E20879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="nBONkk3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5533E20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58970 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDbRZ-00012g-KT
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 17:04:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKK-0003nV-FL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKJ-0007l8-8x
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:12 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30]:39622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKI-0007j8-U1
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:11 -0400
Received: by mail-io1-xd30.google.com with SMTP id e13so12308786ioq.6
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=MZgKEJ+z/L8ac+rBoKnnkI/sVMPkJ2BdSV9ze7qlzFg=;
	b=nBONkk3pJDztS1WLYsAxe9etjpvofdEpFBBALHMNXS7H1YAuvwsuCOO6vwPy2Er4oh
	mBq+h4sGxW+/yQ95FGIrsM3wtRfyomEMTO4mcczVxx2hQdRknmWI8jiBTmDhPjus6St9
	ltYvqKQoDxXBPgUlTsBv0mCqbNVbjtA6Md2SHzVSD+4h5rUx3kG1e5JvQJ1CBO+jvc4m
	9/M6MkcDwizVNRuMGZ57YuDPlNqNWm+Mp8ywJsJPRt7/ywYdTjmiwLmKAyzRztS9yytN
	hPSe/alhzp+yuTR/qfawFGdn7RlrE7iFN2TW4cqp2FcHUW1E1DS5JehhDVSdqRS58lVu
	6oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=MZgKEJ+z/L8ac+rBoKnnkI/sVMPkJ2BdSV9ze7qlzFg=;
	b=TDrX9zUa53OYSop/YCkG0soYpWTflPI1/E7RjuDu0MuYQ6kURdzS9JFhFuwno3LtJj
	L6jJoOx2NihIVCncD4u5y/+FHaE6vwAZJ0tOoMu7aK+Wst0MqHqa6HTgfVCfuBHUPOz6
	sC5QqD9+1CnR/Gfs4TycPOblJbH9h8asBgCRYpk7+uaeHxNrS887Qbt9pf8J6z1V8Hu5
	nY1i5FSqnCpRVFA0uAnLJSDXjVmkMs/sKE4Dr8kTNftydAuG+QcU3Bs/ZSDlREP0C46m
	bX85Nl89GQhwzdL8XQaLpoX3sCfMLzxgh8TZqwYK1S6ZxEyfaq48Rp2iD9iCSCJ/BWgV
	gP8A==
X-Gm-Message-State: APjAAAUoyTE9kK4igB+5BOVp9khZMuKYkaMheWLwEhwDYaBqOTdPVw+F
	g4Km2XvXBa8mwMngvjsG/22R/FBRvxUSpL1v
X-Google-Smtp-Source: APXvYqxObpEtfMiwewhbiBg8IJnLQjZrAwC1EznaubLlINM5w426csyrgRctq68e4qg6mq3+ljRBuA==
X-Received: by 2002:a5d:9252:: with SMTP id e18mr553591iol.97.1554757030165;
	Mon, 08 Apr 2019 13:57:10 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	h133sm5969313itb.34.2019.04.08.13.57.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 13:57:09 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 16:55:46 -0400
Message-Id:
 <4662c1009d2d6f4d5ba0f19be1bed1880c7502a0.1554755001.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d30
Subject: [Qemu-devel] [PATCH 03/10] block/pflash_cfi02: Fix command address
 comparison
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stephen Checkoway <s@pahtak.org>,
	Thomas Huth <thuth@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
	Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408205546.nEoMK09ShFpR5waXMITg_tB7SIy_XpCSU4-bsMST8xY@z>

From: Stephen Checkoway <s@pahtak.org>

Most AMD commands only examine 11 bits of the address. This masks the
addresses used in the comparison to 11 bits. The exceptions are word or
sector addresses which use offset directly rather than the shifted
offset, boff.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c   |  8 +++++++-
 tests/pflash-cfi02-test.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 53db3fd09f..cb102739d6 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -296,11 +296,13 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
 
     DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d\n", __func__,
             offset, value, width);
-    boff = offset & (pfl->sector_len - 1);
+    boff = offset;
     if (pfl->width == 2)
         boff = boff >> 1;
     else if (pfl->width == 4)
         boff = boff >> 2;
+    /* Only the least-significant 11 bits are used in most cases. */
+    boff &= 0x7FF;
     switch (pfl->wcycle) {
     case 0:
         /* Set the device in I/O access mode if required */
@@ -519,6 +521,10 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Only 11 bits are used in the comparison. */
+    pfl->unlock_addr0 &= 0x7FF;
+    pfl->unlock_addr1 &= 0x7FF;
+
     chip_len = pfl->sector_len * pfl->nb_blocs;
 
     memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index d349b2cc22..57484c1585 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -23,8 +23,8 @@
 
 #define FLASH_WIDTH 2
 #define CFI_ADDR (FLASH_WIDTH*0x55)
-#define UNLOCK0_ADDR (FLASH_WIDTH*0x5555)
-#define UNLOCK1_ADDR (FLASH_WIDTH*0x2AAA)
+#define UNLOCK0_ADDR (FLASH_WIDTH*0x555)
+#define UNLOCK1_ADDR (FLASH_WIDTH*0x2AA)
 
 #define CFI_CMD 0x98
 #define UNLOCK0_CMD 0xAA
@@ -191,6 +191,14 @@ static void test_flash(void)
     g_assert_cmpint(flash_read(6), ==, 0xCDEF);
     g_assert_cmpint(flash_read(8), ==, 0xFFFF);
 
+    /* Test ignored high order bits of address. */
+    flash_write(FLASH_WIDTH*0x5555, UNLOCK0_CMD);
+    flash_write(FLASH_WIDTH*0x2AAA, UNLOCK1_CMD);
+    flash_write(FLASH_WIDTH*0x5555, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_read(FLASH_WIDTH*0x0000), ==, 0x00BF);
+    g_assert_cmpint(flash_read(FLASH_WIDTH*0x0001), ==, 0x236D);
+    reset();
+
     qtest_quit(global_qtest);
 }
 
-- 
2.20.1 (Apple Git-117)


