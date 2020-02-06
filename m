Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586FCC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234B420661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMd09c25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234B420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVtA-0007ex-9Y
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoB-0000Pz-DC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo9-0002Na-4t
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:19 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo8-0002K0-US; Wed, 05 Feb 2020 20:18:17 -0500
Received: by mail-wr1-x434.google.com with SMTP id c9so5118036wrw.8;
 Wed, 05 Feb 2020 17:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WLnZ45NIm/vPLcZBLPmTGbE9FGNbyG4Wr/Aibf/Pthg=;
 b=cMd09c25kNyj9L9Ib6uWicSoFvPXeuWv8aK2aJeM81vZzLKv7GrQ/EFPIdNdvQJ1A9
 i1cehYNFWZZ94C0MT5OqVMtOHSp5FRN4CwOny6x7zQf++mOSM5NYGOO4HV8lzPQu5k6k
 6h6QqLE5OkVrNHN2nwxLzNzgxjK9P1mYl0Vj5TMDOtmYren5d2pRcc/UNmV7DzCFt3UQ
 gSFKNOl338uUGKFvg8Ezt89wcSacD2t/7/h6j6TiXZ+LKYrQtCGg3zqJZN74Sz4bZOia
 Rp0Hv6mPhDcoqeph2eQhrVWxEpEqRmF3tuGcDW6jSmMiFF1dDWc793of5e8HMELcH2s2
 lf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WLnZ45NIm/vPLcZBLPmTGbE9FGNbyG4Wr/Aibf/Pthg=;
 b=ZXrRlXGOaNWj2DSjtABQsj4Vsl1PVBSXdrUqiOBg6LitI8Am0roi/Vup48KXpnJcHQ
 drlJw7vmGtRRkPTfp1MFo7JEWxbxLmkTLqeEgTt0LG9RK6Xda2utFdxxc1jpJsfKBZkJ
 vHWdp4gPzN8jipoZ2xMjwr6ZG/wL12bP9+4Y6U+ZkYLOAobFbPKU7hUjTnR83fhuckah
 1cKuLvdulinCNB8+VmJn+wr/x2UBVlKneGydvz2SmDV059KRa8fe2+ZeOOIRFq+cpau9
 X1nXwglKNpJ69i+MkPh1gEpfQ4ulwvH7BCGODDu99ZGRBCzROKWdXGc3RNAybj0HKVzm
 ceTQ==
X-Gm-Message-State: APjAAAUdSqoYPv9Czb804lrNOU+93vIsxWYug80kjTMsHCimznTFhChe
 ZXOK0faOdPMS03DKjNY8RvHgeuW8
X-Google-Smtp-Source: APXvYqxJAW+XTTbwotJW2sYkWd+73SETZesHIyOsprmTE3tLlRvipwJUE/AF7Qrd34/8dklytqRNZg==
X-Received: by 2002:adf:f7c6:: with SMTP id a6mr402781wrq.164.1580951895652;
 Wed, 05 Feb 2020 17:18:15 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/30] hw/arm/raspi: Make machines children of abstract
 RaspiMachineClass
Date: Thu,  6 Feb 2020 02:17:33 +0100
Message-Id: <20200206011756.2413-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QOM'ify RaspiMachineState. Now machines inherite of RaspiMachineClass.

Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 56 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fab361939c..edf3e1c0d5 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -33,10 +33,28 @@
 
 #define MACH_TYPE_BCM2708   3138 /* Linux board IDs */
 
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
@@ -210,7 +228,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
 
 static void raspi_init(MachineState *machine, uint32_t board_rev)
 {
-    RasPiState *s = g_new0(RasPiState, 1);
+    RaspiMachineState *s = RASPI_MACHINE(machine);
     int version = board_version(board_rev);
     uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_size;
@@ -263,8 +281,10 @@ static void raspi2_init(MachineState *machine)
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
@@ -277,7 +297,6 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->default_ram_size = 1 * GiB;
     mc->ignore_memory_transaction_failures = true;
 };
-DEFINE_MACHINE("raspi2", raspi2_machine_init)
 
 #ifdef TARGET_AARCH64
 static void raspi3_init(MachineState *machine)
@@ -285,8 +304,10 @@ static void raspi3_init(MachineState *machine)
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
@@ -298,5 +319,26 @@ static void raspi3_machine_init(MachineClass *mc)
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


