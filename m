Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBC2C47420
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38E920780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJm5QYdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38E920780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO02d-00034H-Bj
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzse-0005EW-Qf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsc-0002zr-S3
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so6113675wrw.11
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cvsmXOGHcKXV23YMgllN9zrk0dtzY5vA/uGDuKWBck8=;
 b=TJm5QYdNe3lXkg6MpbgWYTioDHbyP06pyn8G1twFFoBqi2d0jXjwRKeMTuTqc5oZdO
 tabtPc/vSqEnDkuuMgEevfXJdgLjwoQWbJdc1VnikwIZXO2jlGPVzTsQb4zHazbQe6HQ
 WUMrnPn2kGLXBcMAfDK7O5KceU3RmvFCBIqEU3ukBvZa0xNsaU10Kv0rNto4o/hJ9gTe
 PxUVgR4gynmYnivdF9HsdZblOry5UjjiHIrJk+jyqWJk/Pa6uyeEVIGGJ9+sr/FyX4Ii
 G2jyXNAUFFR7kf3Pgntc4W3+3d8jL6lyYN+fnFP7MaU2VcqB8JcEOgBuivwv9t+RaJCp
 Bt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cvsmXOGHcKXV23YMgllN9zrk0dtzY5vA/uGDuKWBck8=;
 b=jiCNrOrugtAJL3iw4vCv/ZS7p0cMgyKaZuVR0sBw/r7lBOwUxg1GOtYFgdcVz0pjfd
 byEadiBOAZUgV/l86kJuiBq43xS8s/wuSqdJlAWpSChd2PChDlFhB3dV0JgsAXL5h9tT
 jgz/OktylwcwoRKmvWcfB+P8RDu15f9Bgm4uNa9mymPZUqYtM0z1/LYMiUMM1+ajqnMv
 hnKgRLP47IVGaF6lm77in6AA884+VIGdzpp44ttwWeQgRIZPaKfeMHyDR6SBLs/DKiIF
 YSevYMCeg0rQzrKJvkIBfLZVdznL5sdUm1bEucahq3NCnK2NwrNW6uUnjE14qQ9fT7lQ
 1KUQ==
X-Gm-Message-State: AOAM532MhlKUmmlwzvtNJmL3ubCQ5/pwH1tWSVhRq0lQIuJlr1uc4qGA
 1ENNNJuumI7QqFsZ1Q25F3/8LW1DNvzZSh4h
X-Google-Smtp-Source: ABdhPJwVMoKJ1IVjhoDzyTolI04T8O66N3oMED+KNcJD381YwcRYGZDbWeNq8N0B+gIAktS1Fgbs0w==
X-Received: by 2002:adf:dcc7:: with SMTP id x7mr9599452wrm.203.1601563701171; 
 Thu, 01 Oct 2020 07:48:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] hw/arm/raspi: Avoid using TypeInfo::class_data pointer
Date: Thu,  1 Oct 2020 15:47:55 +0100
Message-Id: <20201001144759.5964-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Message-id: 20200924111808.77168-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.20.1


