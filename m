Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD015C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5419520874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHXGAWZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5419520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGoX-0003Hx-8v
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgk-0004V9-Ar; Mon, 21 Sep 2020 03:56:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGge-0005u7-W0; Mon, 21 Sep 2020 03:56:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id e17so11141197wme.0;
 Mon, 21 Sep 2020 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4jv3gV83IdvS5OKXioOXbKRM8ceNFIHhtNFiZgXYFU8=;
 b=cHXGAWZjs1mtTUP9QmNplWdwi6b+Rs2EjtEhI6Zo/5ZsnErlZaZoLBlHof1qTAYpX5
 XOgWIjJg4+bInmCeLclSYc3xZROxL3KzJoCKsvf7HNeBXIclPj3N/LlQ3vkaYTxsXOr7
 BQp39Ys97LMGZcR+QV2DW2QGF4tXVYLn0XskzQoDCt8EFFrzg2G7Guuj5F1X3mMvpUH2
 rl5Kxk6Uw9nNPzLSVBMJwZwCIaeCcZRKfVqsUt9RAZ3QGOn5HqooNbwUrQbhchPM+/IK
 YXzfEuh76kGlo68VZnxc8pXKLBVspvDqfkjrC21PvJ5o5YSMM/b4o2Pd5kpyO5YXFjaE
 fLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4jv3gV83IdvS5OKXioOXbKRM8ceNFIHhtNFiZgXYFU8=;
 b=smu4gOxq/OxIdcIfmYygf802yrzsZEBTGDZx7ilvOOCedDlunOdbmiLgkttFRqT/ZT
 w+l69d45Clc1sYwHDH3IoG+efOH8cP0pT2wOBNqESGk8GqEx+YfOy38aI8Uwh93PnM/j
 quyfA7zrBX3jEm9tM0OMepEt/Sa0lWRkRLmnfc0iUfaE1Qfz/SpPTod9NjUXmjggCSxo
 /EpcKRAYpY3RkTYKwGtIzm3nrU7H4qvb4eedc2D+svMCnH5kcdj/bp4CHgvBFW6QsikB
 u80iWa8z9v8VXVQTjzJ7tjJYVzPNyWfbAmIy8Q4RefWqgjtb8Jw/gYqcBBS4a9OAuftH
 gTCA==
X-Gm-Message-State: AOAM531IzC7CS1QSD4MFJcOi64E5YC07JWGIN+9jY0/el7OL/kdSiVNp
 cGS2YQk4WuweOCglRmu5JQuApz8uLFg=
X-Google-Smtp-Source: ABdhPJww7xSU+20lcuogel/zC7bg9gL+mkcYm+dtCXKAOrt4i5Ys4AV7wKtMz7Rh1P6MBRUL5Kkihg==
X-Received: by 2002:a1c:1f42:: with SMTP id f63mr27866952wmf.1.1600674994992; 
 Mon, 21 Sep 2020 00:56:34 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o15sm17807538wmh.29.2020.09.21.00.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 00:56:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] hw/arm/raspi: Avoid using TypeInfo::class_data pointer
Date: Mon, 21 Sep 2020 09:56:24 +0200
Message-Id: <20200921075628.466506-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075628.466506-1-f4bug@amsat.org>
References: <20200921075628.466506-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using class_data pointer to create a MachineClass is not
the recommended way anymore. The correct way is to open-code
the MachineClass::fields in the class_init() method.

We can not use TYPE_RASPI_MACHINE::class_base_init() because
it is called *before* each machine class_init(), therefore the
board_rev field is not populated. We have to manually call
raspi_machine_class_common_init() for each machine.

This partly reverts commit a03bde3674e.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 16e6c83c925..3000e6d57e6 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -306,13 +306,9 @@ static void raspi_machine_init(MachineState *machine)
     setup_boot(machine, version, machine->ram_size - vcram_size);
 }
 
-static void raspi_machine_class_init(ObjectClass *oc, void *data)
+static void raspi_machine_class_common_init(MachineClass *mc,
+                                            uint32_t board_rev)
 {
-    MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
-    uint32_t board_rev = (uint32_t)(uintptr_t)data;
-
-    rmc->board_rev = board_rev;
     mc->desc = g_strdup_printf("Raspberry Pi %s (revision 1.%u)",
                                board_type(board_rev),
                                FIELD_EX32(board_rev, REV_CODE, REVISION));
@@ -326,18 +322,36 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "ram";
 };
 
+static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xa21041;
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+};
+
+#ifdef TARGET_AARCH64
+static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xa02082;
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+};
+#endif /* TARGET_AARCH64 */
+
 static const TypeInfo raspi_machine_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("raspi2"),
         .parent         = TYPE_RASPI_MACHINE,
-        .class_init     = raspi_machine_class_init,
-        .class_data     = (void *)0xa21041,
+        .class_init     = raspi2b_machine_class_init,
 #ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3"),
         .parent         = TYPE_RASPI_MACHINE,
-        .class_init     = raspi_machine_class_init,
-        .class_data     = (void *)0xa02082,
+        .class_init     = raspi3b_machine_class_init,
 #endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
-- 
2.26.2


