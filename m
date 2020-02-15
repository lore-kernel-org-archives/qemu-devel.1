Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FBFC7114D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CF8206D6
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILhpMr0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CF8206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j32w2-0001dq-8Z
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32ut-0008EY-H9
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32us-0004Ej-GF
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:15:51 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32us-0004Do-AE; Sat, 15 Feb 2020 14:15:50 -0500
Received: by mail-wm1-x342.google.com with SMTP id c84so14379253wme.4;
 Sat, 15 Feb 2020 11:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0W7MkWQz+YxLQxe7rZ5JAUVHezRcUYqi0e+LBivqS2A=;
 b=ILhpMr0Ec5qamtt+exYp/0I9fMC0vp2JmeahADcArJbBMI5Zqh5mCav/qA6aUbDMSd
 9NnkHNvhVQxrz0zqNA/rT6SXBSgrA5weHKz2C0wW/7gnxyv6SgM9G5LV6cGkFZtXicVy
 6fD/LZsGPlr+4j2GaLk8yPD7R/sT0JQQ4G+cbl+6/mUSCRN4Jd6mFwTvd7ud/v/zm0pm
 pgdzedObYWjrggYKbF9PaYA/qSpoCEYROa0TUjV+WRC7uAEGPS4FBBzHS1ylLKhOiJJO
 JRzwJQ0O1ScPOEYmnTXHFq7NCS2tPHahmAHbKM55mdelwjGfYhlKSN8PMttnVNlb/uB5
 NHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0W7MkWQz+YxLQxe7rZ5JAUVHezRcUYqi0e+LBivqS2A=;
 b=Cl1Z+Uu+93mWWbaCrWuX9VgVFzjG5lCFk2Lkg8yxNgnGKuT77agbEnPNxSXtuakdQw
 k4vtC1jmd3PME5HHn/57076OyuqUbYTYY4pb7iOx1t8jKmV/k+eYSFE6tVBJNr4b5iFk
 eBUKyRcGag8EFr5hbUVjCch1IkWkj0Odxvbp4LC3S9p4I4LeDrblcyNQMxPxejx9FqC9
 jVvWNB5csV0x1EBKeEMg6gY2I6wWZnTV2ieZKP1W0vp4qLZsyfsSSO1TUFMe8PKk810w
 dUnNZ6fuiJ2ynx5bQFmzTEMBfQCty13+PMDdaZfUDI9labIquNOIyAlpv/5djL+WZDw4
 znPw==
X-Gm-Message-State: APjAAAWt2Luf9/jgs6F2nz5G9PHrMqpWNvEtiUW6VsypCcFDKrYLMUpd
 DXfVG8ZyWb3P17gC2tq2ufwdQ+KtvbM=
X-Google-Smtp-Source: APXvYqydP2FtH86dvP5G6zThsPdT9FgMQwakhM65MDf2guwE1a5r3PhblhSQHqJItTvaaVAp4XS30g==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr11519421wme.125.1581794149104; 
 Sat, 15 Feb 2020 11:15:49 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o9sm9678605wrw.20.2020.02.15.11.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:15:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/12] hw/arm/raspi: Avoid using TypeInfo::class_data pointer
Date: Sat, 15 Feb 2020 20:15:33 +0100
Message-Id: <20200215191543.3235-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215191543.3235-1-f4bug@amsat.org>
References: <20200215191543.3235-1-f4bug@amsat.org>
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using class_data pointer to create a MachineClass is not
the recommended way anymore. The correct way is to open-code
the MachineClass::fields in the class_init() method.

This partly reverts commit a03bde3674e.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 221356933e..81cc5824c4 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -309,13 +309,9 @@ static void raspi_machine_init(MachineState *machine)
     setup_boot(machine, version, machine->ram_size - vcram_size);
 }
 
-static void raspi_machine_class_init(ObjectClass *oc, void *data)
+static void raspi_machine_class_common_init(MachineClass *mc,
+                                            uint32_t board_rev)
 {
-    MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
-    uint32_t board_rev = (uint32_t)(uintptr_t)data;
-
-    rmc->board_rev = board_rev;
     mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
     mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
@@ -326,18 +322,34 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = board_ram_size(board_rev);
 };
 
+static void raspi2_machine_class_init(ObjectClass *oc, void *data)
+{
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xa21041;
+    raspi_machine_class_common_init(MACHINE_CLASS(oc), rmc->board_rev);
+};
+
+#ifdef TARGET_AARCH64
+static void raspi3_machine_class_init(ObjectClass *oc, void *data)
+{
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xa02082;
+    raspi_machine_class_common_init(MACHINE_CLASS(oc), rmc->board_rev);
+};
+#endif /* TARGET_AARCH64 */
+
 static const TypeInfo raspi_machine_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("raspi2"),
         .parent         = TYPE_RASPI_MACHINE,
-        .class_init     = raspi_machine_class_init,
-        .class_data     = (void *)0xa21041,
+        .class_init     = raspi2_machine_class_init,
 #ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3"),
         .parent         = TYPE_RASPI_MACHINE,
-        .class_init     = raspi_machine_class_init,
-        .class_data     = (void *)0xa02082,
+        .class_init     = raspi3_machine_class_init,
 #endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
-- 
2.21.1


