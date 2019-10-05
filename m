Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715BEC47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 15:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5E320867
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 15:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBDk0Ma8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5E320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57231 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGlbJ-0003DI-CZ
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 11:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGlaZ-0002ek-5h
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGlaY-000391-3o
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:03:19 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGlaX-00038k-Sd; Sat, 05 Oct 2019 11:03:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id r19so8462058wmh.2;
 Sat, 05 Oct 2019 08:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9xIPwHoZQTBX/1rMkGn54r/An4esCo8ilJZSXHXy5A0=;
 b=fBDk0Ma8hTiGyGbx1RWIt64e75s+884OVPL2ObCPDkCDuKBji0D4civ3FohpWfC7E6
 f1bfpTmeTJFRfLQANGaO/0evGpjdXZV50UgIEs6yVEZ8Az9d0cVY+vh9H4ENgpLwCvd0
 5QOqt/LQOJIvX9WzvOSs3gx+H27KmGPPQFsNpXo14pDd0XUv91i4Yn8fHqCyhdXLTcZX
 Ozb9rc2EqM49ACXCzjQy1SNzalYI3Gi8NPysMCHu8ekhoi1ZAN2LTEwymysF5y3u0xPd
 ZWCQ/icIGQHvhWP4xlJSr7k3R1xKTt/z5VoVS9aXZYGL71dCOQUp+6L2LF45e4PR0FcU
 VRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9xIPwHoZQTBX/1rMkGn54r/An4esCo8ilJZSXHXy5A0=;
 b=DMxOKzgFR6Tm0HbETBtz+2CV+utpsHWImn4Qr1XWncZfdjtpumbypJuFbLKawFxr+d
 1mB2w75w1lwuLDunCCQBmptMsUKOocWE0LlmX/dUpw7rbEdanVyyrcBl0zzIrUZRb1pY
 5ifUK2yW71Yd9mJQMYM3KagIxudObhjOgNiKHXyMP574znxxWslVCCbPZUw1b0oZIn8c
 z5+lZx7wmwFwMnl5mcENjxTaxL6ASxbPQlZ7K0EmEuWjgLPmrzXObQKd/RKx0tmjSxMe
 3aPsuOWJBCwAu4UIF8dwLgF2zReJHv6S77wrX1bCO8niUY0vKE3iQxlkTqaDeWwmfgZa
 hCYA==
X-Gm-Message-State: APjAAAXULCCC0Wi/tZVteOD8csLG6oWU95YYHGYbJqfTC7rV9Imgml/+
 heMdmaWMkw+Aqd9eSjU9WpuI7o04dek=
X-Google-Smtp-Source: APXvYqyecaDJtufDTKp8+GoulfvrGCIUXE/C1SutNMkkPZiLVWzkEFImnvdw9NRsKfiHlbUOk1OCWQ==
X-Received: by 2002:a1c:1c7:: with SMTP id 190mr13524469wmb.23.1570287795336; 
 Sat, 05 Oct 2019 08:03:15 -0700 (PDT)
Received: from localhost.localdomain (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id 79sm14190268wmb.7.2019.10.05.08.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 08:03:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/dma/etraxfs_dma: Simplify using MemoryRegionOps::impl
 access_size
Date: Sat,  5 Oct 2019 17:03:11 +0200
Message-Id: <20191005150311.16373-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-trivial@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This device implementation is clearly restricted to 32-bit
accesses. Set the MemoryRegionOps::impl min/max access_size
fields to simplify the code, and remove the hw_error() call.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/dma/etraxfs_dma.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index 47e1c6df12..dcb2286bd9 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/main-loop.h"
 #include "sysemu/runstate.h"
@@ -577,12 +576,6 @@ static inline int channel_in_run(struct fs_dma_ctrl *ctrl, int c)
 		return 0;
 }
 
-static uint32_t dma_rinvalid (void *opaque, hwaddr addr)
-{
-        hw_error("Unsupported short raccess. reg=" TARGET_FMT_plx "\n", addr);
-        return 0;
-}
-
 static uint64_t
 dma_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -590,10 +583,6 @@ dma_read(void *opaque, hwaddr addr, unsigned int size)
 	int c;
 	uint32_t r = 0;
 
-	if (size != 4) {
-		dma_rinvalid(opaque, addr);
-	}
-
 	/* Make addr relative to this channel and bounded to nr regs.  */
 	c = fs_channel(addr);
 	addr &= 0xff;
@@ -615,12 +604,6 @@ dma_read(void *opaque, hwaddr addr, unsigned int size)
 	return r;
 }
 
-static void
-dma_winvalid (void *opaque, hwaddr addr, uint32_t value)
-{
-        hw_error("Unsupported short waccess. reg=" TARGET_FMT_plx "\n", addr);
-}
-
 static void
 dma_update_state(struct fs_dma_ctrl *ctrl, int c)
 {
@@ -638,10 +621,6 @@ dma_write(void *opaque, hwaddr addr,
 	uint32_t value = val64;
 	int c;
 
-	if (size != 4) {
-		dma_winvalid(opaque, addr, value);
-	}
-
         /* Make addr relative to this channel and bounded to nr regs.  */
 	c = fs_channel(addr);
         addr &= 0xff;
@@ -701,6 +680,10 @@ static const MemoryRegionOps dma_ops = {
 	.read = dma_read,
 	.write = dma_write,
 	.endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
 	.valid = {
 		.min_access_size = 1,
 		.max_access_size = 4
-- 
2.20.1


