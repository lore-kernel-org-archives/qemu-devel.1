Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E12CC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8AB20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZU2e6MQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8AB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyX4k-0003Ir-Hl
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 03:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX3s-0002CO-TT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX3q-0000zj-Kb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:26:28 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX3q-0000ye-E2; Mon, 03 Feb 2020 03:26:26 -0500
Received: by mail-wm1-x342.google.com with SMTP id m10so13745357wmc.0;
 Mon, 03 Feb 2020 00:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fH7Pr46rmz5zfbrhebu4o/OiNogYj/7gAgBrUxWpkLo=;
 b=tZU2e6MQrFAdoCSswO188XhNoZnhzsdTfMcXFl5qLNMbckVT4KJ7mMxkyNI5uMZLXB
 o+bcTC5CUmyqslqESlHRacNGD/vXBOuQZodvy69AAzOTttHqOd5LvntEHC8XwudG+TKk
 AOpP6N6hbjBhRFRSYiX4OsqOGybK8Y2KL8yBYEZTuAfatgCCpo1QokI5yur20O3aiC2o
 wz5NQ/dHiu2Q02ASpu3WxKLlTxAnFBnwh2hPYXQETBz5TulwdWbURjITdoF/bPuw2Vs/
 FVeRSPlHADDDVejdHoCyw6wLGtP6+LuU7LZzrSkdOwefw/FcsW9gAxejKNF9MdqOyxjW
 68Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fH7Pr46rmz5zfbrhebu4o/OiNogYj/7gAgBrUxWpkLo=;
 b=JrLDAcnU2eubOE8DhYUPXGzSbbYDuBS4id41v68FocAoTG72zoxurw25dompfQF3KM
 Kujis2vvSr7I6qJMOF373A7Y4UojRZv5dZ5y1kCbEynlM91UAiJyyb5B30H1jbXk3Fvl
 Pcpts+fvYfaXbvMlS/gSQv+aP6jTW5WskGWsIOqQ7rwQdHsNVRh//g+7Xajcrtp9AYQg
 U6a5z+Rf+rlTkpb95rDSRo3hs6u3uLaZcmZDbgtUoleQlRNNxeW2/S4XMzpQ7J1N1uce
 yJ1ToP0viXwrPF4c9hmh8W1Je2azzwuacALTv1AeIF9P+y9tZ/Da05rVIX+xoMDjl5dP
 2ZCg==
X-Gm-Message-State: APjAAAW8IW1YmzlbpTXs9ThYQPP89LLOlmcc+k1fm8nPMduih2HvbGlD
 AabH5uv9gnqt1ogpQTBhY879Nu43
X-Google-Smtp-Source: APXvYqwM5YhbYRWsW7fFCiDkDhq6m6Eksj9GE04oNvw9Ovg/s/COQ+W0c77BcnEYAxfKkh9TLkB7IQ==
X-Received: by 2002:a1c:3b87:: with SMTP id
 i129mr27019922wma.142.1580718385052; 
 Mon, 03 Feb 2020 00:26:25 -0800 (PST)
Received: from localhost.localdomain (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id w20sm22396778wmk.34.2020.02.03.00.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 00:26:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] hw/arm/raspi: Get board version from board revision code
Date: Mon,  3 Feb 2020 09:26:15 +0100
Message-Id: <20200203082619.7426-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200203082619.7426-1-f4bug@amsat.org>
References: <20200203082619.7426-1-f4bug@amsat.org>
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
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The chip ID is encoded in the board revision, and the board version
is simply 'chip_id + 1'.
We want to support more boards which follow the same scheme.
Introduce a new RaspiBoardInfo structure which we'll extend in the
following commits.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index ef76a27f33..eaa8c49009 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -36,6 +36,39 @@ typedef struct RasPiState {
     MemoryRegion ram;
 } RasPiState;
 
+typedef struct RaspiBoardInfo {
+    /*
+     * Board revision codes:
+     * www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/
+     */
+    uint32_t board_rev;
+} RaspiBoardInfo;
+
+enum { BOARD_PI2, BOARD_PI3 };
+
+static const RaspiBoardInfo raspi_boards[] = {
+    [BOARD_PI2] =
+    {
+        .board_rev = 0xa21041,
+    },
+#ifdef TARGET_AARCH64
+    [BOARD_PI3] =
+    {
+        .board_rev = 0xa02082,
+    },
+#endif
+};
+
+static int board_chip_id(const RaspiBoardInfo *config)
+{
+    return extract32(config->board_rev, 12, 4);
+}
+
+static int board_version(const RaspiBoardInfo *config)
+{
+    return board_chip_id(config) + 1;
+}
+
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const uint32_t smpboot[] = {
@@ -163,9 +196,10 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
 }
 
-static void raspi_init(MachineState *machine, int version)
+static void raspi_init(MachineState *machine, const RaspiBoardInfo *config)
 {
     RasPiState *s = g_new0(RasPiState, 1);
+    int version = board_version(config);
     uint32_t vcram_size;
     DriveInfo *di;
     BlockBackend *blk;
@@ -191,9 +225,8 @@ static void raspi_init(MachineState *machine, int version)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
-    int board_rev = version == 3 ? 0xa02082 : 0xa21041;
-    object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
-                            &error_abort);
+    object_property_set_int(OBJECT(&s->soc), config->board_rev,
+                            "board-rev", &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abort);
 
     /* Create and plug in the SD cards */
@@ -215,7 +248,7 @@ static void raspi_init(MachineState *machine, int version)
 
 static void raspi2_init(MachineState *machine)
 {
-    raspi_init(machine, 2);
+    raspi_init(machine, &raspi_boards[BOARD_PI2]);
 }
 
 static void raspi2_machine_init(MachineClass *mc)
@@ -237,7 +270,7 @@ DEFINE_MACHINE("raspi2", raspi2_machine_init)
 #ifdef TARGET_AARCH64
 static void raspi3_init(MachineState *machine)
 {
-    raspi_init(machine, 3);
+    raspi_init(machine, &raspi_boards[BOARD_PI3]);
 }
 
 static void raspi3_machine_init(MachineClass *mc)
-- 
2.21.1


