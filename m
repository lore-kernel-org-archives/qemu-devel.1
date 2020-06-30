Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3942C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDD72073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiBY/4q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDD72073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHfk-0006F2-Pn
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHcr-0000OS-1K
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:45 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:40473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHcp-0002Te-BY
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:44 -0400
Received: by mail-ej1-x644.google.com with SMTP id o18so16511394eje.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+XdB10fDCEobjO8hrSk/rJBQM+FoznsNt4hVzvCyAVM=;
 b=QiBY/4q7Uim+d5m45BVnCiTEvXbOiIjEmKdeycrBxhooK1xxKAyjVuyC8FN+ITBZIC
 9OtmUi0sbBUEoZb8ezRY16U+LG5o5v9xac5EXXkK0evYUwFU7MhzTl9NyFvOCRf6VOLm
 atKhErnIobBtv3BdGHWMrzJY5ycpPKArbscYQPZFedTd/WatzCnhLCjCmxXXF1ApJrhE
 ad4ICft4kXdrTUvvTgbIdbwu6T6y9D4mLQi9SDwUpxs8nqqUM/JkY38wi9nWfSxtboML
 bzhhfk+8Rh18xXLcqiEFv2CTWrhAtfRuwppQKvS77S7TIfFgnVCZOGywNjmkZkLJeSv6
 M1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+XdB10fDCEobjO8hrSk/rJBQM+FoznsNt4hVzvCyAVM=;
 b=i+7RVp21itzyOjP0hZNI3Nnfz4EIId7snQZTPWwE3dX7qQeX6xr+V6yQAwC6ihBPpb
 S1gtNz0as1gobImHzb59KaZdAAar0ebYzln9hNGav6MGIJQ86NC/d4gRpN/1yBHMIDTr
 u3dlfDhQf8dALPZn1gcX4AvS+F/qeN7s27PqXhMvqs9mU2RgdBAdiWmJwvAFEQxm86Yg
 IQ+EkMC2i4TjX1//bDWhtPJZZpH+A7Wv3wSv3QryKDZ2tIw+lX6fAgm3xXkXXRiJ7tpd
 zGbwCJXqnHrdaOh9kK1KRxNJ7hHFdpSVplEEhaUx+LL01jr8WUBZd1yGiGmptIBNvN+K
 4BGg==
X-Gm-Message-State: AOAM533OU+hGDj1r5UKPfEpmPG16ST0V0VG3JVToNmaUoRENzgHWeX+k
 3ud9ULZV5K9+GVL5DgvOUlg=
X-Google-Smtp-Source: ABdhPJwahDqyF3BAbfem5FAVU+Z28XZQo0AETSsrmu7CH/QhbMD6e7H3Xk6sZ5sFDGCNqOSPEodR3A==
X-Received: by 2002:a17:906:b0d:: with SMTP id
 u13mr17135404ejg.342.1593528762160; 
 Tue, 30 Jun 2020 07:52:42 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p9sm2144569ejd.50.2020.06.30.07.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 07:52:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Aurelien Jarno <aurelien@aurel32.net>, Yunqiang Su <ysu@wavecomp.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
Date: Tue, 30 Jun 2020 16:52:33 +0200
Message-Id: <20200630145236.27529-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630145236.27529-1-f4bug@amsat.org>
References: <20200630145236.27529-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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
 hw/mips/malta.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 2c363fe099..17a1c0d1c4 100644
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
-- 
2.21.3


