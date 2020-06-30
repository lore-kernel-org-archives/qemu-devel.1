Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3204C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DEF20656
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuOdhOlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DEF20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMQd-0003eE-Vj
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqMNq-0008HK-Gp; Tue, 30 Jun 2020 15:57:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqMNo-000454-Tg; Tue, 30 Jun 2020 15:57:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id a6so21339531wrm.4;
 Tue, 30 Jun 2020 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lGgsVeM7xoHM5WlT4+jBVtk67mhg6dUQrt0VXLrUTZc=;
 b=KuOdhOlSzpdz+8R7fTn/jjj5b3nIMecaYResNGEaEOqYaSzQtALmDdwllASsDVATxi
 l3H4y39wFNfJBtFjWlx1n6VjOq91YcCZ+yRbELRaCGI7pamKAKIn0eg8yB8wQRPMYQtV
 ut/ABmVo1dTLuaXFA/EV79ZlzgdYLgeVkE99hoVFQSBGmxVIsIVhDlP6jneCPzGhYEIf
 ObYYgmj7jvDKmvebl2iwVwNR0tW1zDhGAvHuU2jUc9flzEVBCp6TB2LlUUmmaq2rxh71
 kSWnrpw3ZBL6TRA7Aaq/kJhpCNK+Xb/fBYqxE/4UXB+cC+RwIdE/GqfgG9cr4H1eDCv8
 ccmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lGgsVeM7xoHM5WlT4+jBVtk67mhg6dUQrt0VXLrUTZc=;
 b=ROny5cgFjeD0m0NbwBka39BXNpgwujJmNnKSc3FxC7j93gdtPrvan3np95Znb7oRA4
 3IoJpGsOvC+LQTDfo0rQgNypQF+SsbmuE64pAqjxIWvnSc0/CAhGeupRNtoTZH+NUxET
 g9x/nqqth1SKsBQf5Lh5B8Q48TnMoRIl5aZpitVDc614f8gbcm5KnGKILregw6DK83dK
 jXn0wR+Uaw3zTOTnbz4A//QwzfoOtZPU/Mw9fLCx229Bk5Yn+hB9eURXQxzG3Q5DKCvz
 Htb8VRkIuLsnwPjkSEcW5P50E9LKLZsrxeOVV5HMZTN12Dy5bfEpKE9myVp+oyd3ASw8
 S4qQ==
X-Gm-Message-State: AOAM5302hjJS1ZTN2wKIWBpVeooC7+yyvULLcJD/SzpJFDr+ljUMCD/j
 HLM06UNVj5CZu7fUGOsLyTIEK1Hjg3E=
X-Google-Smtp-Source: ABdhPJwbWdNuJ/eygtiCiSvlcovQYHtvYLu1uBvKsSQYPFhmUIxz+gJPdOAkuD7o1aKETkSpSObRzA==
X-Received: by 2002:adf:a111:: with SMTP id o17mr22820045wro.257.1593547049065; 
 Tue, 30 Jun 2020 12:57:29 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k11sm5172979wrd.23.2020.06.30.12.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:57:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Yunqiang Su <ysu@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v3 3/5] hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
Date: Tue, 30 Jun 2020 21:57:21 +0200
Message-Id: <20200630195723.1359-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630195723.1359-1-f4bug@amsat.org>
References: <20200630195723.1359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The maximum RAM size is tied to the machine. First add the
MaltaMachineClass, and add 'max_ramsize' to it. Set it to
the current value of 2 GB, and adapt the code checking for
the requested RAM is usable by the machine.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 2c363fe099..fd4964e8b0 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -56,6 +56,7 @@
 #include "sysemu/kvm.h"
 #include "hw/semihosting/semihost.h"
 #include "hw/mips/cps.h"
+#include "qemu/cutils.h"
 
 #define ENVP_ADDR           0x80002000l
 #define ENVP_NB_ENTRIES     16
@@ -71,6 +72,17 @@
 #define MAX_IDE_BUS         2
 
 #define TYPE_MALTA_MACHINE       MACHINE_TYPE_NAME("malta-base")
+#define MALTA_MACHINE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(MaltaMachineClass, (klass), TYPE_MALTA_MACHINE)
+#define MALTA_MACHINE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(MaltaMachineClass, (obj), TYPE_MALTA_MACHINE)
+
+typedef struct MaltaMachineClass {
+    /* Private */
+    MachineClass parent_obj;
+    /* Public */
+    ram_addr_t max_ramsize;
+} MaltaMachineClass;
 
 typedef struct {
     MemoryRegion iomem;
@@ -1232,7 +1244,7 @@ void mips_malta_init(MachineState *machine)
     DriveInfo *dinfo;
     int fl_idx = 0;
     int be;
-
+    MaltaMachineClass *mmc = MALTA_MACHINE_GET_CLASS(machine);
     DeviceState *dev = qdev_new(TYPE_MIPS_MALTA);
     MaltaState *s = MIPS_MALTA(dev);
 
@@ -1248,10 +1260,16 @@ void mips_malta_init(MachineState *machine)
     /* create CPU */
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
 
-    /* allocate RAM */
-    if (ram_size > 2 * GiB) {
-        error_report("Too much memory for this machine: %" PRId64 "MB,"
-                     " maximum 2048MB", ram_size / MiB);
+    /*
+     * The GT-64120A north bridge accepts at most 256 MiB per SCS for
+     * address decoding, so we have a maximum of 1 GiB. We deliberately
+     * ignore this physical limitation.
+     */
+    if (ram_size > mmc->max_ramsize) {
+        char *maxsize_str = size_to_str(mmc->max_ramsize);
+        error_report("Too much memory for this machine: %" PRId64 " MiB,"
+                     " maximum %s", ram_size / MiB, maxsize_str);
+        g_free(maxsize_str);
         exit(1);
     }
 
@@ -1446,6 +1464,7 @@ static void malta_machine_common_class_init(ObjectClass *oc, void *data)
 static void malta_machine_default_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    MaltaMachineClass *mmc = MALTA_MACHINE_CLASS(oc);
 
     mc->desc = "MIPS Malta Core LV";
     mc->block_default_type = IF_IDE;
@@ -1456,6 +1475,7 @@ static void malta_machine_default_class_init(ObjectClass *oc, void *data)
 #else
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
+    mmc->max_ramsize = 2 * GiB;
 }
 
 static const TypeInfo malta_machine_types[] = {
@@ -1468,6 +1488,7 @@ static const TypeInfo malta_machine_types[] = {
         .name          = TYPE_MALTA_MACHINE,
         .parent        = TYPE_MACHINE,
         .class_init    = malta_machine_common_class_init,
+        .class_size    = sizeof(MaltaMachineClass),
         .abstract      = true,
     }
 };
-- 
2.21.3


