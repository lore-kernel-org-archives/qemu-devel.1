Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5657DC35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2568F2082E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc2ySjDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2568F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0TSl-0002f7-7A
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 12:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPz-0005yI-JX
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPy-0001o9-Dt
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:19 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPy-0001mz-5r; Sat, 08 Feb 2020 11:57:18 -0500
Received: by mail-wm1-x341.google.com with SMTP id g1so5544203wmh.4;
 Sat, 08 Feb 2020 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x0O3At1xgu1nSLiUV3BtfZN0wWsQrHjMzXGKZfUYX9Q=;
 b=nc2ySjDJ+uA1SNTopZ4ALRt5BvecIYLNlflYDfCA+4/qWOEnAWhD5VJAqn5htRbOVN
 3wxDCB+wMzip8/s/NWAIiNXoM0/fZvrMc3PhyyEOBuKK5/votB/RpOHzGtrjV1m5+IrJ
 C1Bml/kyK3WXEGzMJYYdi0sgUd+MPFKuHr0v18jZeWL1nA6UOPS2Q0Ge7lKIIJ/eDMK6
 BIokUVGa1e9/aozlC2rJtHN0JsXuBc5dnQzJB15LuDUrXc8M0UA263ZKWKf7NgANLeRu
 K8UXrSROfJL6nFlUoWMj/ww/PqcUeSPlobMN6Kt5+rjN0hUkss24tWZtwiZihRgwJ6U3
 fznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=x0O3At1xgu1nSLiUV3BtfZN0wWsQrHjMzXGKZfUYX9Q=;
 b=qbRti2FLkaFbFyyosMTLTXT6lRQOHKJxXSrUy4UATI49v/o0GibIwn6tC881q/qcgy
 nGC8OIgH2IIEjfJQpghd/QRGun59tLaioYUuZRffL0wv2AfJuKyoGNOZ615wtej73Qzt
 gnFFWVcWvNY5p98NlYw+arYZgzu0GjwP6VdIs9Js1oXK0BDmXOiwcIxFOi5cE4U9DvP6
 goRED9pJd2fEy+PKAm7H5HrPywyIhfR4KOSTLuseS6FfXBYRO2cIsnUxGDhOJX4Mo2dp
 8w3GcEKL/sA1xNuygvESD7rA7cTmM2s2VCYeJXytoUOl3WT9UOWSQsZVlVixxu+jCpjV
 nwcg==
X-Gm-Message-State: APjAAAWRoPDfRgkd86Qjnf5zU7SQBii0OnwBEPqcPZ4PlnAV3pRl7Xe2
 e7TS3zYaAb/UbUOq81HG0PGn7RRF
X-Google-Smtp-Source: APXvYqz7Q1lUNVPuHRq8rwE4mIN7o95ee0ZlVKqRtwyS5U8yJePJEjyMahC2HcawRiqcYJMFUF5CCw==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr5374564wmj.117.1581181035247; 
 Sat, 08 Feb 2020 08:57:15 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm7872763wmb.37.2020.02.08.08.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:57:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/13] hw/arm/raspi: Make board_rev a field of
 RaspiMachineClass
Date: Sat,  8 Feb 2020 17:56:40 +0100
Message-Id: <20200208165645.15657-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208165645.15657-1-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
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
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to have a common class_init(). The only value that
matters (and changes) is the board revision.
Pass the board_rev as class_data to class_init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 62b8df3c2e..fbfcd29732 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -46,6 +46,7 @@ typedef struct RaspiMachineClass {
     /*< private >*/
     MachineClass parent_obj;
     /*< public >*/
+    uint32_t board_rev;
 } RaspiMachineClass;
 
 #define TYPE_RASPI_MACHINE       MACHINE_TYPE_NAME("raspi-common")
@@ -227,9 +228,11 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
 }
 
-static void raspi_init(MachineState *machine, uint32_t board_rev)
+static void raspi_init(MachineState *machine)
 {
+    RaspiMachineClass *mc = RASPI_MACHINE_GET_CLASS(machine);
     RaspiMachineState *s = RASPI_MACHINE(machine);
+    uint32_t board_rev = mc->board_rev;
     int version = board_version(board_rev);
     uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_size;
@@ -279,13 +282,16 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
 
 static void raspi2_init(MachineState *machine)
 {
-    raspi_init(machine, 0xa21041);
+    raspi_init(machine);
 }
 
 static void raspi2_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    uint32_t board_rev = (uint32_t)(uintptr_t)data;
 
+    rmc->board_rev = board_rev;
     mc->desc = "Raspberry Pi 2B";
     mc->init = raspi2_init;
     mc->block_default_type = IF_SD;
@@ -302,13 +308,16 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
 #ifdef TARGET_AARCH64
 static void raspi3_init(MachineState *machine)
 {
-    raspi_init(machine, 0xa02082);
+    raspi_init(machine);
 }
 
 static void raspi3_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    uint32_t board_rev = (uint32_t)(uintptr_t)data;
 
+    rmc->board_rev = board_rev;
     mc->desc = "Raspberry Pi 3B";
     mc->init = raspi3_init;
     mc->block_default_type = IF_SD;
@@ -327,11 +336,13 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi2"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2_machine_class_init,
+        .class_data     = (void *)0xa21041,
 #ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3_machine_class_init,
+        .class_data     = (void *)0xa02082,
 #endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
-- 
2.21.1


