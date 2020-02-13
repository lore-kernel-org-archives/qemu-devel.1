Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FBC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3A72168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6phfntS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3A72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GAa-00025K-5f
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhO-0004nn-GY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhN-0002Od-13
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:38 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:36560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhM-0002Iq-QV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:36 -0500
Received: by mail-wm1-x32e.google.com with SMTP id p17so7027136wma.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2ouywPz5Xm2vWfWs0doQqLT+siGfCg7eInrXlduofqk=;
 b=e6phfntSqSlqeOfzxvNxo12Ke3kPc5u34git/3hWQvhuLF97rzSAUTKJrIsHovXefa
 lO7LB/H3H/YqLkQwbsqNUQ4m3vuAwynTpqZxkcvFd/DWrK0zXFBeGu14c2CAU6U2ZUJj
 4FcWCTKiZrGcmKmVQ1YsxnGMSv7ulpU76eY9Yuk8hdCEP2raZo86dUmZZj7MVLyhAnEA
 ik6JDFd6V5FarRMgBHpALcLhLLn6mYN6KlRZmIQxl4gYdUFQYiLCO4W+d1GYVMqG5NUH
 9hpWKiKZq1IZgCvpQCrbz1R+0dHXPoIQH4zSo2juVckMG3IgH66i+062r/gghfrwHZaV
 /9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ouywPz5Xm2vWfWs0doQqLT+siGfCg7eInrXlduofqk=;
 b=L+jtYEG4e1Nmsa606SxhsPGtRWAZXawATerevMtxPthDO3KMkjBIPapdPn6jx73ype
 0i0/H5ZaKonS9+22tPO8sv9QVOwTKGGcBO42Oj54Hl2KuE4mWaZkcqQwwv2wZlUs/DB5
 EFQet++GPYM5iEsAidIspdSys/NOkb+vMJHCKujExXaLWG+ectff9azarh1Q2UhmFIoN
 XBGBtjoieY3tHyOlyZ+JQzu7/yO4bt1l+i3i9YfwPiYl7xHAWL0H+BBRphJLsnH8nAaN
 8qZoCaXM69tMY+PzVTNDiHgbT/JsOPY4QwRdHL3vCkZ1tX6jXGVzzKKwivctmOEVzEGH
 IIjA==
X-Gm-Message-State: APjAAAV2gctg1qwsx35MeLAAyLNKbPRmMDT6SUAaTTD1aeAXh3wtJaAa
 1XIoCylqGXKSl/HLXcC3cTR+rEiFCqI=
X-Google-Smtp-Source: APXvYqzHW/bupdWQM8jtZXdqDe+1asyg1lZ/zgo47HC+Or6YfAmwB7l5NI1J3J15ZyaipzJ8XSR2wA==
X-Received: by 2002:a1c:1fc5:: with SMTP id f188mr6484394wmf.55.1581604947513; 
 Thu, 13 Feb 2020 06:42:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/46] hw/arm/raspi: Extract the version from the board revision
Date: Thu, 13 Feb 2020 14:41:34 +0000
Message-Id: <20200213144145.818-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The board revision encode the board version. Add a helper
to extract the version, and use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200208165645.15657-4-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 818146fdbb2..f285e2988fc 100644
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
@@ -37,6 +38,28 @@ typedef struct RasPiState {
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
@@ -164,9 +187,10 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
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
@@ -192,7 +216,6 @@ static void raspi_init(MachineState *machine, int version)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
-    int board_rev = version == 3 ? 0xa02082 : 0xa21041;
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
                             &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abort);
@@ -216,7 +239,7 @@ static void raspi_init(MachineState *machine, int version)
 
 static void raspi2_init(MachineState *machine)
 {
-    raspi_init(machine, 2);
+    raspi_init(machine, 0xa21041);
 }
 
 static void raspi2_machine_init(MachineClass *mc)
@@ -238,7 +261,7 @@ DEFINE_MACHINE("raspi2", raspi2_machine_init)
 #ifdef TARGET_AARCH64
 static void raspi3_init(MachineState *machine)
 {
-    raspi_init(machine, 3);
+    raspi_init(machine, 0xa02082);
 }
 
 static void raspi3_machine_init(MachineClass *mc)
-- 
2.20.1


