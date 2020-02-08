Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31061C35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0001320733
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI1/+nQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0001320733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Taw-00088O-72
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 12:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPz-0005zO-Uy
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPy-0001o3-Da
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:19 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPy-0001lF-5s; Sat, 08 Feb 2020 11:57:18 -0500
Received: by mail-wm1-x344.google.com with SMTP id c84so6017198wme.4;
 Sat, 08 Feb 2020 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XKrCXiHYgBlF7Xk6qT4KBfeJlAD7eZV3fE6ujyh1Fos=;
 b=FI1/+nQyKlmRbUKQ+curPIFS8LWxK9K0zAEysyGfv/tVRJnCbQ6yftK7ghRXvabCE6
 P0+MPVetRmr8hD0BVd0wGHN7K6n3bOWPH+gbNms+a0/6wOHvh2TL4DncuIHxcPIdVcJ0
 i/KssddA2RJwkGSUicYh6F2u0bKZFb2sx4Dj9f0YGrOKQ2hexTyFAug4kOEOg9xdO58Q
 GuWb9Ogr7AuwKFSIrVhGZBzA5RbQQvW48LGFa0l9Hm2Oudf4ydud13LsbxQvpL76eRI5
 wJUBHULjHMWo1OSmkEeei48NGi6/cg4mL4phowRB92Z53kU3/6u8uoGnPJK8hy3QaZsp
 7eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XKrCXiHYgBlF7Xk6qT4KBfeJlAD7eZV3fE6ujyh1Fos=;
 b=fPiznSqd0PLRIFoVxzougqgJYLWwrUHH/ChSHhBx7nbUkY0K9dnq47NiH2tc6FJfHM
 J/+YWXiub3TN46LNv3wuZW4ghDAQFFKUckD1DzuiNB/fthyPTvTnX3fqoxD23xfghUk7
 FJxXteKHnRfVsbJhUa7NHc5Jbt8ojPuJ3v5hz+9W8NnMvWQPk6iG4UzhY71clJwa5h7+
 xm9vAbxkZkfy9/kC5Dl7T5o2feV6SLYTv3zMpovaqVOpzvEv95JaTj+hBS4W38guRRER
 zrrDsFRidhabnAthIlgvvqBFAKLS3BpaV1fbnUvIzQrXpNqmN+6KSSGcRmuraHNQBi6l
 BL9w==
X-Gm-Message-State: APjAAAWvredCxu2tkOAt4r/zvx3KaEljJ+B95VRMx8PI+etG3pqXCIfN
 qtGfTFKv38ChR4LQKwc2R+eecUTg
X-Google-Smtp-Source: APXvYqyg4RIo2CXO2frR0v3N3DGavd1YSeOUJE/U2akP1HAVfRxgfK4bDH6Y8+i1RlTUTLnor8cFjA==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr5367498wmc.185.1581181033301; 
 Sat, 08 Feb 2020 08:57:13 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm7872763wmb.37.2020.02.08.08.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:57:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/13] hw/arm/raspi: Make machines children of abstract
 RaspiMachineClass
Date: Sat,  8 Feb 2020 17:56:39 +0100
Message-Id: <20200208165645.15657-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208165645.15657-1-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

QOM'ify RaspiMachineState. Now machines inherit of RaspiMachineClass.

Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Fixed typo in description (Zoltán)
---
 hw/arm/raspi.c | 56 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index b3e6f72b55..62b8df3c2e 100644
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
2.21.1


