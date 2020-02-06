Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AABFC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97C720661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffnts1uE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97C720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVsm-00076a-UB
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo1-00007d-I7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo0-0001ar-GH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:09 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo0-0001Y7-9J; Wed, 05 Feb 2020 20:18:08 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so5061860wma.1;
 Wed, 05 Feb 2020 17:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i+qx0RUWdCwdD1mrdUasvrUyqSxfDdWxzzEP/v8L4ms=;
 b=ffnts1uEq5g7Lf+uRsN26sMj2pItEHhMPXIa39PB2ZjoAt2rBwdeX3m7CKclXl+EQk
 8OpYTIqAJX1F5J7F1GzxTxr/6SMiR7TZr9YndkrkEsKF5SZN19gtynRTsSpoYm7BIPB3
 izK5t3kLx8v6ufj/QD0cQtwiq0na5hwPXP1+UonuG5YZOHOhoIn5D43kjCv/IcDPS9p8
 gy5ZNEHwwU648OK1xXXOm4R2NwLhmjrkeOqpUK7n6WsLShMOYmq5SAdd7XjQKCIB7voI
 UGCSahPoXzkzdVKcKhch4A2fMXJZTkw2aB7BJNTC8+Pw3Lua/7QeGVshsEIr5cmBJAr5
 bhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=i+qx0RUWdCwdD1mrdUasvrUyqSxfDdWxzzEP/v8L4ms=;
 b=GwSLe6uvpAzkVd61QoVQH6wz5cu3IOSGHEZE5WiFV0gUmJdVsoi2gGmmUoc414VdXZ
 21erM09IGYnIHCcBqCrLZXwCuC3s3Qfv/zzD5BZZYMZjpcMpLnD8lvItIVMQk9ybyp/x
 PnvMxAduEx7gEhWwtcxKqGqO21ACXaYYNjYm9GPlw+Fx69stXlmUDJ4yBL8hJnjtRiHV
 Yxj5THwLNn/JruRz4DRgVWLhNm3geSPAmlbXdnbgP5MrliIV2KAFcv8Bb9rMmpq4u6Sm
 LFuAaw0HTRw1coyrFDK4/wRf13FCwoXgq5NPnMB0HtLrLi4dDL1QQuRC9f3yrkZb0H/h
 YDdg==
X-Gm-Message-State: APjAAAWWWAvMySOjLKmWLm1094Fy7LynyHydZbYzl2XIH/2R7nT6H8n7
 z9j1yLkLtdZUErLCbgso336si7ip
X-Google-Smtp-Source: APXvYqyP0z6zgJnEv3eLuJkObFRBy2wzYHeycTDLHMhN15O+U/RUX+tzaB3XABhCHElNcmfCNd8bQA==
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr650354wml.182.1580951886969; 
 Wed, 05 Feb 2020 17:18:06 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/30] hw/arm/raspi: Extract the version from the board
 revision
Date: Thu,  6 Feb 2020 02:17:29 +0100
Message-Id: <20200206011756.2413-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The board revision encode the board version. Add a helper
to extract the version, and use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Alistair Francis <alistair@alistair23.me>

 hw/arm/raspi.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3b892bb509..13d41dfce6 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/arm/bcm2836.h"
+#include "hw/registerfields.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
@@ -36,6 +37,28 @@ typedef struct RasPiState {
     MemoryRegion ram;
 } RasPiState;
 
+/*
+ * Board revision codes:
+ * www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/
+ */
+FIELD(REV_CODE, REVISION,           0, 4);
+FIELD(REV_CODE, TYPE,               4, 8);
+FIELD(REV_CODE, PROCESSOR,         12, 4);
+FIELD(REV_CODE, MANUFACTURER,      16, 4);
+FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
+FIELD(REV_CODE, STYLE,             23, 1);
+
+static int board_processor_id(uint32_t board_rev)
+{
+    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
+    return FIELD_EX32(board_rev, REV_CODE, PROCESSOR);
+}
+
+static int board_version(uint32_t board_rev)
+{
+    return board_processor_id(board_rev) + 1;
+}
+
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const uint32_t smpboot[] = {
@@ -163,9 +186,10 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
 }
 
-static void raspi_init(MachineState *machine, int version)
+static void raspi_init(MachineState *machine, uint32_t board_rev)
 {
     RasPiState *s = g_new0(RasPiState, 1);
+    int version = board_version(board_rev);
     uint32_t vcram_size;
     DriveInfo *di;
     BlockBackend *blk;
@@ -191,7 +215,6 @@ static void raspi_init(MachineState *machine, int version)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
-    int board_rev = version == 3 ? 0xa02082 : 0xa21041;
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
                             &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abort);
@@ -215,7 +238,7 @@ static void raspi_init(MachineState *machine, int version)
 
 static void raspi2_init(MachineState *machine)
 {
-    raspi_init(machine, 2);
+    raspi_init(machine, 0xa21041);
 }
 
 static void raspi2_machine_init(MachineClass *mc)
@@ -237,7 +260,7 @@ DEFINE_MACHINE("raspi2", raspi2_machine_init)
 #ifdef TARGET_AARCH64
 static void raspi3_init(MachineState *machine)
 {
-    raspi_init(machine, 3);
+    raspi_init(machine, 0xa02082);
 }
 
 static void raspi3_machine_init(MachineClass *mc)
-- 
2.21.1


