Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FE9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A731E20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7sGX8hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A731E20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBR8-0005Jz-Oy
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOW-0001OT-Vd
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:32 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOV-0003Ba-B3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:32 -0400
Received: by mail-ed1-x544.google.com with SMTP id by13so5435958edb.11
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ezmv4JiTpP7X7OxAfnbPCLJGrwpvkIrxmTp8C42vD8c=;
 b=E7sGX8hYaQWGWAbiiJHIameMhsNpWt4kQo4fWH9YLKfqwzat64USe8HUGabBeeKI0o
 TGpJuX6da+FVHYOrGoSUXlm81/0q1/EkhwXc2EhmIWGizoyVc4a3JqDh7tT5ckZ7eUZM
 hgTYNhwcR/EB4HCuLFpFn/oscKzlCWm0LKHJ3Yc+CWHIQIVUh0akyRrIW6PWlx5UdXmn
 B0ac6DTSKStrj40Fee6GNnn16XVfUV30SAf3GOkNl/SJWUwse/i1PtZKdKOP8l50khd7
 bTeoYyFUtP034TbAHMBruhW349Fl/Vob9JFNyek9G5nfc99snVZksQ2abDsUbqbsQnPq
 kCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ezmv4JiTpP7X7OxAfnbPCLJGrwpvkIrxmTp8C42vD8c=;
 b=BTqhUEgWd3Spfid1siWLmMVN7yhnQdxK+U0VAMP704mWzicKJbdCwxJqFEkDVnH4L/
 ml3adPH1RveISiaF1E86PkptE/LKH4R9t6O7xvpvdWCBAEBaP1yeMi+10UMhLq0z3KVl
 VjL2NrrypGMncANODQU7mpNUrzConDjoCwgdUUi3Fr44gdKtwW5u/OVl5mVS4j5tozqz
 UJqlTjlgEFCnyFTSWnPeT9ByH8LBnw1xExxbJNPxPNKWuf1beP5+T1CyR0qIPg657f6A
 jfIrXgr6ecGPQtRXk+nKdu1MYgpHiGoH8wkjEFFSnLCc7AIbzo63EiVgj5WNxl9h9Ew1
 4McA==
X-Gm-Message-State: AOAM531BAiRNErlLwePiD70qOK741IkqMyLnV6b5FqJsn4VRHn1J/5Gw
 Bhf9x4N0+nCignvlBASYiZc=
X-Google-Smtp-Source: ABdhPJyHW9qIoDvNlErfWDN4rFRmEyLXCvyHQ8SFGSPUdARbnJwgyXjNRaiI7VHvMVCxpAtNE8y2ag==
X-Received: by 2002:a05:6402:3138:: with SMTP id
 dd24mr22094497edb.118.1593504809516; 
 Tue, 30 Jun 2020 01:13:29 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z1sm1425948ejb.41.2020.06.30.01.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 01:13:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Yunqiang Su <ysu@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
Date: Tue, 30 Jun 2020 10:13:19 +0200
Message-Id: <20200630081322.19146-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630081322.19146-1-f4bug@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
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
index f8fc567532..1ca41b44db 100644
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
 
 #define TYPE_MALTA_MACHINE       MACHINE_TYPE_NAME("malta")
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
 
@@ -1446,6 +1464,7 @@ static void malta_machine_class_init(ObjectClass *oc, void *data)
 static void malta_machine_virt_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    MaltaMachineClass *mmc = MALTA_MACHINE_CLASS(oc);
 
     mc->desc = "MIPS Malta Core LV (no physical limitations)";
     mc->alias = "malta";
@@ -1457,6 +1476,7 @@ static void malta_machine_virt_class_init(ObjectClass *oc, void *data)
 #else
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
+    mmc->max_ramsize = 2 * GiB;
 }
 
 static const TypeInfo malta_machine_types[] = {
@@ -1467,6 +1487,7 @@ static const TypeInfo malta_machine_types[] = {
     }, {
         .name          = TYPE_MALTA_MACHINE,
         .parent        = TYPE_MACHINE,
+        .class_size    = sizeof(MaltaMachineClass),
         .class_init    = malta_machine_class_init,
         .abstract      = true,
     }
-- 
2.21.3


