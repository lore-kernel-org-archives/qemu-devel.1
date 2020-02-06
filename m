Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9EBC352A1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4982082E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoPBEx5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4982082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVvK-0002Jw-FA
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoD-0000S9-4g
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoB-0002VN-2C
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:20 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoA-0002Q8-RF; Wed, 05 Feb 2020 20:18:18 -0500
Received: by mail-wr1-x441.google.com with SMTP id z9so5097592wrs.10;
 Wed, 05 Feb 2020 17:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FcTo9TN8PYsENDGEQjBiXZU3Vioo+Qv1b4+0maH8RB0=;
 b=RoPBEx5HmP/j2LP1WivPYfg+K+Aag+N5eFumOi2sePyI2e2KSvcJMkKWFYgaDXDIEx
 +m1zTPX8160CCy6FEcK50ToN4yQQ/3zsHnJTqllQVyjIMMFqKiJ0YiZl5bITqmu82wR1
 dUzCHZLq19NhxBuoztcjvrmLWTy3SfknJ5sCQY5yFgOP0LnOsYef2OEFAgJDg1XoujjG
 dNyWD/QrVDO68OhV5rYxSp3HZnZhDDmtqX7Zuk3mYuTVPTUADyCjD1dQbSSqJvORkvHW
 4L8ADR3UG8Sppeh05Vh4YmwahHe6bW/tTFCwF+Fq0wIFJlG+pJ7+b34AWMFAh1goHjVQ
 DeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FcTo9TN8PYsENDGEQjBiXZU3Vioo+Qv1b4+0maH8RB0=;
 b=UjV4D6EoekrifacV0fjouSTEAJVDJnlEmhrDHYja8hFbRrpC1JH/fVP8S1rjCjGMJ+
 dDYxa1E28FQ1n+KUsEfr9NloBQ1bWTMF5W5wW2t3oRAhshqkGIwVeakPNfYCOx4/2xRv
 QDD8jtiZZdRDSAZkMxX6wqX3lyqIrQvgVcbO7gS8oUCjGJOuIUNe3HBqVbXr2Qssyz8Y
 uNtTd7bejkoaGLSjuvoPPdPX5Wv+9YaVzXRZDXjKn6jv+i+FPu148x45PRGvWKFPSN+Q
 5aaiWLGo2bhXaRhEqdN0MggAzzcjW7ydYGJJLEN20o14VFgD0DpNTe8BVZJ0H1KgP5hY
 IGuw==
X-Gm-Message-State: APjAAAXG2SNb5YqzZhMlhqCDPM9Dht0UW3TRuPoKZmBD+ZxB9zTSvHcb
 ZOmbJMMtLQ/hR9hFau8YLrac4jZP
X-Google-Smtp-Source: APXvYqxgcyo0uaMIeZLPZzYLWsowWcDLUxgDtTzbQWmtVoG3hFwrTogVAhqTk7wXtjlifcl/cHYSmA==
X-Received: by 2002:adf:82ce:: with SMTP id 72mr397455wrc.14.1580951897636;
 Wed, 05 Feb 2020 17:18:17 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/30] hw/arm/raspi: Make board_rev a field of
 RaspiMachineClass
Date: Thu,  6 Feb 2020 02:17:34 +0100
Message-Id: <20200206011756.2413-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
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
index edf3e1c0d5..885abced57 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -45,6 +45,7 @@ typedef struct RaspiMachineClass {
     /*< private >*/
     MachineClass parent_obj;
     /*< public >*/
+    uint32_t board_rev;
 } RaspiMachineClass;
 
 #define TYPE_RASPI_MACHINE       MACHINE_TYPE_NAME("raspi-common")
@@ -226,9 +227,11 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
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
@@ -278,13 +281,16 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
 
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
@@ -301,13 +307,16 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
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
@@ -326,11 +335,13 @@ static const TypeInfo raspi_machine_types[] = {
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


