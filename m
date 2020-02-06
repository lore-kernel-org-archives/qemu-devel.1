Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8238C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9477920838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfwqIART"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9477920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVyW-0006iO-Pv
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoI-0000bw-5j
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoE-0002hc-1h
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:26 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoD-0002bv-Rb; Wed, 05 Feb 2020 20:18:21 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so5118155wrw.8;
 Wed, 05 Feb 2020 17:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZQ7H/VBhBbZJ296rEwB4ccWCzYWB0TCAGh2KT8v1BXA=;
 b=PfwqIARTtpneD4rrFiXDXY96Eob+ltk9t0V/RdthzIrKRXrZZ20Z/2gD8aL0Nkd1Q8
 SDXVzWAP+IitWq3RwmV9+DQv3NU8b3hiNGoeBoAj0FHMKsyzZkQVU5X2v7kX8wDV4AxK
 wBnDLrUg2ADf74Tm5pVtWEAvmsp1mYWNWVgvrK3YVypYFXtv1U7eKMZN5dS/lpEW6hh9
 iDF4iOCUIMY4mDMcbGwEpgH2xifi7WDaY1DK62tHER0J+3oMB5fJboZRHTIteZ95HtVy
 6KX3ZOt9BaLvQHnJym8Om3kCfI4lEE7VDbNYu1Est0yULHrSFeHZfd6RP6DGZ0sDsFuo
 nSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZQ7H/VBhBbZJ296rEwB4ccWCzYWB0TCAGh2KT8v1BXA=;
 b=JrPExzwaHKiygeOB6F1QIp+kJWOThMNtZ/AYM2/k/6fXOnbqpsd6BCqD9sB/4Tn2eQ
 LAYBkMDEIGdFxxyfwxwJPAfJRLHdOK87FLUfYFYwZ9hXM8R5vVrErV8htLSzJYqZPr8b
 ZnCtrQuTHjrmnQL47EeOdvoeiLHaZ9LoB/6Gi0fTR7Qs8CMuIVCj55nhX44LM5nX1B+z
 glMLF8Dln5V+7fKhOjvQFzrtlat8YUWA1UXVBWnlS68U+Wf00mK0JUNwJRVfqpPcksM4
 Lw11BCQBlzu1NKjABJ1gbpuEdAnPPu2p3iQ/AemlgejvnrnleFqxAbzqpDBsh+Of2y4p
 Vv8w==
X-Gm-Message-State: APjAAAWzBjAjuDrb0tmX4GH6p5RaKGIgSNqQ1XldYcL4P7LsNmhZ3pJz
 9MQxSSnfcdTcZCaNTDSWKUBBhiHc
X-Google-Smtp-Source: APXvYqz0cUqAqKv+uWdZutGn7xjYP2Lz8TV0bvurgKzLJ2Ep630iaNoXOQGaY/+OiAaOGkSD4puTtg==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr319541wrj.261.1580951899561; 
 Wed, 05 Feb 2020 17:18:19 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/30] hw/arm/raspi: Let class_init() directly call
 raspi_machine_init()
Date: Thu,  6 Feb 2020 02:17:35 +0100
Message-Id: <20200206011756.2413-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

raspi_machine_init() access to board_rev via RaspiMachineClass.
raspi2_init() and raspi3_init() do nothing. Call raspi_machine_init
directly.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Squash with previous?
---
 hw/arm/raspi.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 885abced57..651585ebfb 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -227,7 +227,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
 }
 
-static void raspi_init(MachineState *machine)
+static void raspi_machine_init(MachineState *machine)
 {
     RaspiMachineClass *mc = RASPI_MACHINE_GET_CLASS(machine);
     RaspiMachineState *s = RASPI_MACHINE(machine);
@@ -279,11 +279,6 @@ static void raspi_init(MachineState *machine)
     setup_boot(machine, version, machine->ram_size - vcram_size);
 }
 
-static void raspi2_init(MachineState *machine)
-{
-    raspi_init(machine);
-}
-
 static void raspi2_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -292,7 +287,7 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
 
     rmc->board_rev = board_rev;
     mc->desc = "Raspberry Pi 2B";
-    mc->init = raspi2_init;
+    mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
     mc->no_floppy = 1;
@@ -305,11 +300,6 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
 };
 
 #ifdef TARGET_AARCH64
-static void raspi3_init(MachineState *machine)
-{
-    raspi_init(machine);
-}
-
 static void raspi3_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -318,7 +308,7 @@ static void raspi3_machine_class_init(ObjectClass *oc, void *data)
 
     rmc->board_rev = board_rev;
     mc->desc = "Raspberry Pi 3B";
-    mc->init = raspi3_init;
+    mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
     mc->no_floppy = 1;
-- 
2.21.1


