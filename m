Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C11C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 22:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE0520693
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 22:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="XgBbK3Iu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE0520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60385 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGskb-0004R2-Q8
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 18:09:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGsdQ-00071V-2r
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGsdO-0004RU-Q3
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:28 -0400
Received: from mail-it1-x135.google.com ([2607:f8b0:4864:20::135]:40113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hGsdO-0004QI-Cr
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:26 -0400
Received: by mail-it1-x135.google.com with SMTP id k64so251926itb.5
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=JK1jenobNkp2h3wHQtfPIyfKfvzIb1aDxQY+2ztH4do=;
	b=XgBbK3IuXWLpWA9GvyzPJHytQa7v5+Reyb+TjXwLBZVUKLCInfM1/Teyui8mZOE4Ng
	LDmo7hpl3I6b3zz04vsYHzNMMk5HSETLaTvgEp2lzRGzuXtB3iD8kQ6thuRgGoeQq4Kf
	Lp+HeX5ZIi57v5SPj/EraH5bUjzxvwk4kp2UjRy+M6QE6r9KXs6k8YbgTR2H9jWHsRFC
	oX5+ZkC1oxHH/uN0+h121WKJG6G7+YNLSIFl2pj7jYCL2fgrvic9QOYFJnsay5124rm4
	5HYr3GiLtbTeiwODpjOpMDeULyMq/IhunPuldet7PL9EdTaVlgbEkA/3HV/y9vTuC/DV
	HoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=JK1jenobNkp2h3wHQtfPIyfKfvzIb1aDxQY+2ztH4do=;
	b=pYw4tm0EXpeSji5m4KiUmy3kU/C3uzdlOnkakN1mvMX/mEVrs3GcVKAUfscU03ThX8
	9L69Q0kUOAzWl+hHZrjtuoRJm/UsZpnCO/uHscRYTC8lwrbYiKqv38DNln7ZSeIf0+Lk
	Z2YUBvtup5LFS/UXCd9+LkohxOH3uw1r5KqbDa6obtWG2l7vA8YYEKFNGN64M8Wl55Ip
	Quy7cTNa6MvPIN0cXzjQKosQAGtLbOHyy47Wvpww+Ck4Jin0saRltllrTohu3jfIj2oa
	9/Qf12ll1ZSqZvP+9mHO/HpyDqda8/Ar/ZxbeFj+5gjsj0HOI9h9/wMgd/A9FJKxhUco
	GuJQ==
X-Gm-Message-State: APjAAAWxhUnSFUqLER0O601qZxkuQt/7ea7mgBLI86bJVCHbWDSXkUw/
	Zou+xaKJ9J578P73HrDqAQbZSDujg5HJ7hiO
X-Google-Smtp-Source: APXvYqzh73grEGYLYWOiq3gXD3PKnAEORe2S+GIG3n5b1AdzKGL6/3GhR5ZWpAT2sE2y4yk/sjXnyQ==
X-Received: by 2002:a24:7c9:: with SMTP id f192mr730927itf.97.1555538545662;
	Wed, 17 Apr 2019 15:02:25 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93])
	by smtp.gmail.com with ESMTPSA id e81sm147874itc.3.2019.04.17.15.02.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 17 Apr 2019 15:02:25 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2019 18:01:40 -0400
Message-Id: <20190417220147.67648-4-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::135
Subject: [Qemu-devel] [PATCH v3 03/10] block/pflash_cfi02: Fix command
 address comparison
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
Message-ID: <20190417220140.g36FSjUpsgM2ZIx7Q--zD-26z4IiP0wpCfBP01JUf3Y@z>

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
index 4b7af71806..e4bff0c8f8 100644
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
index b113fca5af..b91bb66a79 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -23,8 +23,8 @@
 
 #define FLASH_WIDTH 2
 #define CFI_ADDR (FLASH_WIDTH * 0x55)
-#define UNLOCK0_ADDR (FLASH_WIDTH * 0x5555)
-#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AAA)
+#define UNLOCK0_ADDR (FLASH_WIDTH * 0x555)
+#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AA)
 
 #define CFI_CMD 0x98
 #define UNLOCK0_CMD 0xAA
@@ -192,6 +192,14 @@ static void test_flash(void)
     g_assert_cmpint(flash_read(6), ==, 0xCDEF);
     g_assert_cmpint(flash_read(8), ==, 0xFFFF);
 
+    /* Test ignored high order bits of address. */
+    flash_write(FLASH_WIDTH * 0x5555, UNLOCK0_CMD);
+    flash_write(FLASH_WIDTH * 0x2AAA, UNLOCK1_CMD);
+    flash_write(FLASH_WIDTH * 0x5555, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0000), ==, 0x00BF);
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0001), ==, 0x236D);
+    reset();
+
     qtest_quit(global_qtest);
 }
 
-- 
2.20.1 (Apple Git-117)


