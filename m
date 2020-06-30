Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFE2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A42920759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7G0VGd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A42920759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBPU-0002gD-5f
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOW-0001NA-4i
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:32 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:46229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOU-0003BK-FH
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:31 -0400
Received: by mail-ed1-x542.google.com with SMTP id dm19so9048795edb.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6TGC6x4rGeJCZbg2l3usQflOGN4Jj1erw/qpqdPPGOc=;
 b=Z7G0VGd3WnR82DHhhlog7nMomil0uuLUJ0hhT50uIi0JEtxliW/E3WW0VdXHc3uJRv
 qSCbVxtljkNnuk4bUUmCPd7hDxqiwxLok1L9U/YHGzAteUwoS9MfKeVEpzb9zsDxjS8F
 YIrS/X0B5RRwmNez5hxcR05BziuYTBhkIez+Yq1TQrEC8V9rDFiq1YSoZFOe+EdHNkG1
 eHSv4426Q0UUJSOWLbL+e1ry2+RRMg2OH5w7RBgk6i8V202DH/575I4RqkcPIFQw/MQA
 wYVNfbR2H+V1iaEge5PAXvmIW9IQGWQSaihaSGXGupqphUGH8nqvBRZ8rT05g6xyvpAP
 fy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6TGC6x4rGeJCZbg2l3usQflOGN4Jj1erw/qpqdPPGOc=;
 b=ZOxcNCISr8Z5RsO8c6lXElXn6MYMhYuU3sPs436OGuZafgSR9J/pS9Esarl5sJti1Y
 JdOB/qvpdD267jTEUMhddFPkZdhXfPSN5Z2F+tclQfoYkTpvXEqxpGvqMZAtlXTXDW+I
 wqQQIY6TrzK6PwNfjqO0/uGCyFXRsVXQEn5ECeTXstnZ+nvjav73FXXiQf2ZsKL3E/LM
 xzpcgHP/YncLcFEMI2kZWo9jL8qmsMFLIoIt+cSpx3QucNmRILY4vxoG+GH4fxpak7Jl
 y7nyDFXy7lWBQScZ2UgS36fsVJ2NTXKxuLxhg64Ob6PP2BO8AzcNgDUUGSLP1IWfL5SX
 F6yQ==
X-Gm-Message-State: AOAM530lFnjNMF8ihHF9HoDFvDmHvuJa0UNpWupMqNsxrGTZnW2xzh+b
 kz30aM4hVKxYMYFIGCoS//U=
X-Google-Smtp-Source: ABdhPJxomnc8SlCtZ0f6r73FRm9rLMimM7GAXPhKNn8F4nYBeQOZ/GmSUjseLMek251lXgjwTmd/Fg==
X-Received: by 2002:a05:6402:228d:: with SMTP id
 cw13mr21949025edb.343.1593504807146; 
 Tue, 30 Jun 2020 01:13:27 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z1sm1425948ejb.41.2020.06.30.01.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 01:13:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Yunqiang Su <ysu@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/7] hw/mips/malta: Register the machine as a TypeInfo
Date: Tue, 30 Jun 2020 10:13:17 +0200
Message-Id: <20200630081322.19146-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630081322.19146-1-f4bug@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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

We want to add more machines. First convert from the old
DEFINE_MACHINE() API to the more recent DEFINE_TYPES(TypeInfo[])
one.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 5b371c1e34..66172f0c82 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -70,6 +70,8 @@
 
 #define MAX_IDE_BUS         2
 
+#define TYPE_MALTA_MACHINE       MACHINE_TYPE_NAME("malta")
+
 typedef struct {
     MemoryRegion iomem;
     MemoryRegion iomem_lo; /* 0 - 0x900 */
@@ -1433,8 +1435,10 @@ static void mips_malta_register_types(void)
 
 type_init(mips_malta_register_types)
 
-static void mips_malta_machine_init(MachineClass *mc)
+static void malta_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "MIPS Malta Core LV";
     mc->init = mips_malta_init;
     mc->block_default_type = IF_IDE;
@@ -1448,4 +1452,16 @@ static void mips_malta_machine_init(MachineClass *mc)
     mc->default_ram_id = "mips_malta.ram";
 }
 
-DEFINE_MACHINE("malta", mips_malta_machine_init)
+static const TypeInfo malta_machine_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("malta"),
+        .parent        = TYPE_MALTA_MACHINE,
+    }, {
+        .name          = TYPE_MALTA_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .class_init    = malta_machine_class_init,
+        .abstract      = true,
+    }
+};
+
+DEFINE_TYPES(malta_machine_types)
-- 
2.21.3


