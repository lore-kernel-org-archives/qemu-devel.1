Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638FFC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305F320873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEwmqp4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305F320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G6P-00044u-Dv
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhR-0004un-QB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhN-0002Qm-Vi
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:39 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:39883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhN-0002Kf-Nm
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id c84so7037006wme.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CaRzl7ZaIw/QJE2nH8zomPZAGDGMc4RBqRpezvr0Ta4=;
 b=HEwmqp4rkQ7RPazRYgzciwLU8ZZyEf5gSKODunIguhvhc44Hb7uAHOrO8hi4Qbvo/+
 Beet30RVCQpy2+/lHwMVfiUAuwwa17+3aK78zie0zs5JJXgPJdJvWRrcsyrCUXvnBxk4
 5PtW92cDGL1HbFwoSv9aq2CxogfzRtCDQX44iGfzkQxA7vr8RGtIL5CHK/l0LWA525I1
 fzMgVnCFBEOoA8Kmg0hwzcChiQP8aYpEUnWoHspxLPmikNN8GUdYXdWaDrNpWTJFkGXx
 lBgJv7JrBW0vHu8wUPMmf0/pai4YjcA7WLjlb7VGjyBcdFIpdrk/9n2r0IJSO433ZYkh
 kVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CaRzl7ZaIw/QJE2nH8zomPZAGDGMc4RBqRpezvr0Ta4=;
 b=QxWhOTppaM1FDBjKln3vqZ+WvoMipxXHYFEUFUewt45B6cOZNdiWfPocu9YCBuRZrx
 MH7d2S0NUCYNPZ1FX50KjMy79j/tbbdXT0HBywcvwZSLsUB9KuP+ZVlJZ4eW2lFX7RIG
 p3+JCLHsRmQ+fA33nkK/pbfAfAuW4JS8V87JVhpVdDbM82ogs9iKklz06T9VfNAjAPIo
 biS05zcA7WyHhf6gzJs9jeIQZE+B1jlRTdyuN1HTIzsdYeyteR42URl59w5N7azNL4ru
 g/WoN++vtvi4tv6jyw1uAaKqmsN3dlFmhSKJXcmb8k83hz3XsDnaSvByeLN5kCRc0oYl
 PFUQ==
X-Gm-Message-State: APjAAAXMUOcbQdaJgrGEf+lkqzo4xo3rBC7fBy4d3q29Yk+fppJiDcY4
 9J8CxUHzIjvRSZSqcjpNOAfvy0ksNuQ=
X-Google-Smtp-Source: APXvYqw2xhSpGfpRHiabBfDDIcam74TSK+CWTLw+trvuwMPH9yFvIvemjTTzWIxAhkZ2xXAVvnTqpA==
X-Received: by 2002:a1c:6645:: with SMTP id a66mr6536962wmc.121.1581604951434; 
 Thu, 13 Feb 2020 06:42:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/46] hw/arm/raspi: Make machines children of abstract
 RaspiMachineClass
Date: Thu, 13 Feb 2020 14:41:38 +0000
Message-Id: <20200213144145.818-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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

QOM'ify RaspiMachineState. Now machines inherit of RaspiMachineClass.

Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20200208165645.15657-8-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 56 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index b3e6f72b55a..62b8df3c2e7 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -34,10 +34,28 @@
 /* Registered machine type (matches RPi Foundation bootloader and U-Boot) */
 #define MACH_TYPE_BCM2708   3138
 
-typedef struct RasPiState {
+typedef struct RaspiMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+    /*< public >*/
     BCM283XState soc;
     MemoryRegion ram;
-} RasPiState;
+} RaspiMachineState;
+
+typedef struct RaspiMachineClass {
+    /*< private >*/
+    MachineClass parent_obj;
+    /*< public >*/
+} RaspiMachineClass;
+
+#define TYPE_RASPI_MACHINE       MACHINE_TYPE_NAME("raspi-common")
+#define RASPI_MACHINE(obj) \
+    OBJECT_CHECK(RaspiMachineState, (obj), TYPE_RASPI_MACHINE)
+
+#define RASPI_MACHINE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(RaspiMachineClass, (klass), TYPE_RASPI_MACHINE)
+#define RASPI_MACHINE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(RaspiMachineClass, (obj), TYPE_RASPI_MACHINE)
 
 /*
  * Board revision codes:
@@ -211,7 +229,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
 
 static void raspi_init(MachineState *machine, uint32_t board_rev)
 {
-    RasPiState *s = g_new0(RasPiState, 1);
+    RaspiMachineState *s = RASPI_MACHINE(machine);
     int version = board_version(board_rev);
     uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_size;
@@ -264,8 +282,10 @@ static void raspi2_init(MachineState *machine)
     raspi_init(machine, 0xa21041);
 }
 
-static void raspi2_machine_init(MachineClass *mc)
+static void raspi2_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Raspberry Pi 2B";
     mc->init = raspi2_init;
     mc->block_default_type = IF_SD;
@@ -278,7 +298,6 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->default_ram_size = 1 * GiB;
     mc->ignore_memory_transaction_failures = true;
 };
-DEFINE_MACHINE("raspi2", raspi2_machine_init)
 
 #ifdef TARGET_AARCH64
 static void raspi3_init(MachineState *machine)
@@ -286,8 +305,10 @@ static void raspi3_init(MachineState *machine)
     raspi_init(machine, 0xa02082);
 }
 
-static void raspi3_machine_init(MachineClass *mc)
+static void raspi3_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Raspberry Pi 3B";
     mc->init = raspi3_init;
     mc->block_default_type = IF_SD;
@@ -299,5 +320,26 @@ static void raspi3_machine_init(MachineClass *mc)
     mc->default_cpus = BCM283X_NCPUS;
     mc->default_ram_size = 1 * GiB;
 }
-DEFINE_MACHINE("raspi3", raspi3_machine_init)
 #endif
+
+static const TypeInfo raspi_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("raspi2"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi2_machine_class_init,
+#ifdef TARGET_AARCH64
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi3"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi3_machine_class_init,
+#endif
+    }, {
+        .name           = TYPE_RASPI_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(RaspiMachineState),
+        .class_size     = sizeof(RaspiMachineClass),
+        .abstract       = true,
+    }
+};
+
+DEFINE_TYPES(raspi_machine_types)
-- 
2.20.1


