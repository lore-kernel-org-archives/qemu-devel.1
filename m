Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF316C35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A002C2082E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVleue/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A002C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0TRD-0007ox-OJ
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 11:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPq-0005e1-0F
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPo-0001hD-Sy
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:09 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPo-0001gL-Mq; Sat, 08 Feb 2020 11:57:08 -0500
Received: by mail-wm1-x342.google.com with SMTP id f129so6031299wmf.2;
 Sat, 08 Feb 2020 08:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QqQIuN2OLiJlB7XbZ3pYMKM/Y6DyvpJ28zihmZMMx2E=;
 b=bVleue/eaJXkPO9gkwrE1uIMz0Tyvixkd0/jHPht3vKgSODnZEURqdeTVKhC8CtOOu
 QVnRBuT7hjEFNnui4StPFvzmpyOAgv6u89XEMJUeQKdo8oWrG6x5QrvcUvhIsUFAuOYd
 vMrAQ8ShgNLR672DPa9HzPEzT7+48J8DkeQqPjTrzwqODPQXw+jCfiOokGybg7N7CR26
 ljtZpCZ39qAVzWl9/e2ITFcwApKHYqxAzqIkVZ8Qh/5DgfJg6DDWaUiGudGwXTEIeyg+
 tQIp9K3EG8WEqJbYdSSixGFA5yLsEGVA91jTDI5fSfzW6apHLM629b2g3kC+C/2ryWDz
 lV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QqQIuN2OLiJlB7XbZ3pYMKM/Y6DyvpJ28zihmZMMx2E=;
 b=p7QtTMWVflfeL6e8JfVBIzRkUocxcJV+tCI4doJ2/75guiWYIkrLIxvyYo8Uwjhn1Q
 VWng5FiA+dSiQE+dP1YDjJTFMj0axB0VBwPbBlrLOvRtyJFKs4AkRCuYM9mqQ1jpXs1F
 Yh+gXiJRJnmm0k7U2leAbZcwaUm26uLxH9zOwG+zU5SHVw135wSNy3i5ZWoGZeEpPyQV
 ZRyRp6OrU3cgod/uouEF6fX3OEwBZ5J56C13zoe2BaKh70EIVCx9XI+8z6TM8BIyyW/f
 Qemiu7FcdsIIb9YCYRUqtCB8V86hXwEAfvhm0KzQj2W+KF+aiTTvamjqKk2KQ1ocDtW3
 conw==
X-Gm-Message-State: APjAAAWtyNRLhNcDk089YjFLZCFsSVy82qjqFRnay6iB6ZqXwNzvSVNb
 7KlozduZGmL/NSeOtS4G9SKamdbA
X-Google-Smtp-Source: APXvYqyTgJaL/wdGXRAeG+D4A7nUE0LmTRxaYqmyoufj1aoLpSa/d4FehiDMHtIjztI2VObx5TNWkA==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr4848283wmi.37.1581181027534; 
 Sat, 08 Feb 2020 08:57:07 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm7872763wmb.37.2020.02.08.08.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:57:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/13] hw/arm/raspi: Extract the RAM size from the board
 revision
Date: Sat,  8 Feb 2020 17:56:36 +0100
Message-Id: <20200208165645.15657-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208165645.15657-1-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The board revision encode the amount of RAM. Add a helper
to extract the RAM size, and use it.
Since the amount of RAM is fixed (it is impossible to physically
modify to have more or less RAM), do not allow sizes different
than the one anounced by the manufacturer.

Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Try to make error message clearer (Zoltan)
I used the same string as "ppc/ppc405_boards: add RAM size checks"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675801.html
---
 hw/arm/raspi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index f285e2988f..dcd8d2d6d3 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/arm/bcm2836.h"
@@ -49,6 +50,12 @@ FIELD(REV_CODE, MANUFACTURER,      16, 4);
 FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
 FIELD(REV_CODE, STYLE,             23, 1);
 
+static uint64_t board_ram_size(uint32_t board_rev)
+{
+    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
+    return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
+}
+
 static int board_processor_id(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
@@ -191,15 +198,17 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
 {
     RasPiState *s = g_new0(RasPiState, 1);
     int version = board_version(board_rev);
+    uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_size;
     DriveInfo *di;
     BlockBackend *blk;
     BusState *bus;
     DeviceState *carddev;
 
-    if (machine->ram_size > 1 * GiB) {
-        error_report("Requested ram size is too large for this machine: "
-                     "maximum is 1GB");
+    if (machine->ram_size != ram_size) {
+        char *size_str = size_to_str(ram_size);
+        error_report("Invalid RAM size, should be %s", size_str);
+        g_free(size_str);
         exit(1);
     }
 
-- 
2.21.1


