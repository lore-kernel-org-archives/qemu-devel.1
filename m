Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A45C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827DC2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="INroFdEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827DC2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGAR-0001XH-KZ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 07:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jiG8q-0008A0-N5
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:40:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jiG8o-0003cp-2P
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:40:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id x14so17035828wrp.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 04:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SqEHPj5/7yKmZbglnKx9kFc1Hk0EXHLh/szKX1ymrZA=;
 b=INroFdEcYSUiR+dSMOLntZ8DopUYVrXYTxuQE+FcN2BIhZgqb05AT2fSp6XiSHPdr9
 GynAPqOJj8L2DgsVGaSST4WYF5XzuyD38hvnJ7aVQd6qrUF29E8h1lOwgdk/FYyrCdxS
 6PuIsoXJJ55ShroWq2gHIVZuQcHtOJ9w6YrTcN2nPZYNNE1cHnd4KVdXkEj7X2p0TpST
 LpqnIK5XxeSsITXOSOBx1rx+tywnNSa2Jp8+PEMzEbRMT8W7tt8NtyMrRENXSnjqBgyf
 VV8T77J26P3D8bhkThD4Imy8fsZRZ6JdcynuAcE/6TWETiM010/bZNbtGCOmpHWGiQio
 rG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SqEHPj5/7yKmZbglnKx9kFc1Hk0EXHLh/szKX1ymrZA=;
 b=lC+4te841sXh+iF9AcI9WP3IkR5EYacRTKhMWFSRB4mRQM/Jd2AMWAp0Fr8imeUXyo
 qDtW6ORib4jb8QZRX4U5aup+T0lo3q7NC2cPJPyKirxRURC1KQ/McjEvBz4QaGFN5aYw
 qCFlYGOBSytNp7AOEy7J82zGz3YhmpaVc7Whzpluwxr/jp1Rw0ZyZWdUdrAF8BqW+q13
 1kdffYdFyJK6ZCVSn+ZpSpeGVzrSUFJ3efIALHyr9MjX6NlcFMBRMAS/qLmbUWhFbIMp
 XOBfkOTeM1+Uh4hWHWA50L6w7Osiu9m4+5TTNd6yoh5eOfipQt9zz12gKUxI/rP+Q65M
 JHrQ==
X-Gm-Message-State: AOAM530qoocB3I9M0yYHYWI7VbDSSppjbv3ADsVtjXyWg7sjh/rso3eK
 ffRMPd+vseymt62wzKi+fgSNms4zinROXadPZNyuA/yBz3ZdHtQ6ml/nD4ioKWkhMXoXuZ/ykQ2
 2ufcvtxwuTimVpxtakbdo/hnAtGtZYet5AOtXUJUBhgrqW4CG1Gb8URYZeptgzkUy
X-Google-Smtp-Source: ABdhPJxqRpqtIh+E2hxCOptwRaOcE3opQgJr1WxGGeNxJ8B3EeVZd/YcE+5edkmwCFyd+sHvlCoqtA==
X-Received: by 2002:adf:fd4f:: with SMTP id h15mr22724826wrs.397.1591616432096; 
 Mon, 08 Jun 2020 04:40:32 -0700 (PDT)
Received: from vanye.hemma.eciton.net
 (cpc92302-cmbg19-2-0-cust304.5-4.cable.virginm.net. [82.1.209.49])
 by smtp.gmail.com with ESMTPSA id y5sm24225932wrs.63.2020.06.08.04.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 04:40:31 -0700 (PDT)
From: Leif Lindholm <leif@nuviainc.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [RFC PATCH 2/3] target/arm: move cpu64 cortex processor common init
 settings to function
Date: Mon,  8 Jun 2020 12:40:27 +0100
Message-Id: <20200608114028.25345-3-leif@nuviainc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608114028.25345-1-leif@nuviainc.com>
References: <20200608114028.25345-1-leif@nuviainc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the id register initializations identical between the platforms in
this file into a standalone helper function, and change the cpu-specific

The value of mmfr0 set for a57 and a53 violates the ARM architecture
reference manual, but matches the values set in actual hardware r1p0 a57
and r0p4 a53. The function sets the architectually correct value, and the
a57/a53 init functions override it after the fact.

Signed-off-by: Leif Lindholm <leif@nuviainc.com>
---
 target/arm/cpu64.c | 107 ++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 73 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 79786e034f..9927c1f75d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -88,6 +88,35 @@ static const ARMCPRegInfo cortex_a72_a57_a53_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static void cortex_a72_a57_a53_common_init(ARMCPU *cpu)
+{
+    cpu->revidr = 0x00000000;
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x12111111;
+    cpu->isar.mvfr2 = 0x00000043;
+    cpu->reset_sctlr = 0x00c50838;
+    cpu->id_pfr0 = 0x00000131;
+    cpu->id_pfr1 = 0x00011011;
+    cpu->isar.id_dfr0 = 0x03010066;
+    cpu->id_afr0 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x10201105;
+    cpu->isar.id_mmfr1 = 0x40000000;
+    cpu->isar.id_mmfr2 = 0x01260000;
+    cpu->isar.id_mmfr3 = 0x02102211;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232042;
+    cpu->isar.id_isar3 = 0x01112131;
+    cpu->isar.id_isar4 = 0x00011142;
+    cpu->isar.id_isar5 = 0x00011121;
+    cpu->isar.id_isar6 = 0;
+    cpu->isar.id_aa64pfr0 = 0x00002222;
+    cpu->isar.id_aa64dfr0 = 0x10305106;
+    cpu->isar.id_aa64isar0 = 0x00011120;
+    cpu->isar.id_aa64mmfr0 = 0x00001124;
+    cpu->isar.dbgdidr = 0x3516d000;
+}
+
 void aarch64_cpu_common_init(Object *obj, uint8_t impl, uint16_t part,
                              uint8_t var, uint8_t rev)
 {
@@ -116,36 +145,13 @@ static void aarch64_a57_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     aarch64_cpu_common_init(obj, MIDR_IMPLEMENTER_ARM, 0xd07, 1, 0);
+    cortex_a72_a57_a53_common_init(cpu);
 
     cpu->dtb_compatible = "arm,cortex-a57";
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
-    cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
-    cpu->isar.mvfr0 = 0x10110222;
-    cpu->isar.mvfr1 = 0x12111111;
-    cpu->isar.mvfr2 = 0x00000043;
     cpu->ctr = 0x8444c004;
-    cpu->reset_sctlr = 0x00c50838;
-    cpu->id_pfr0 = 0x00000131;
-    cpu->id_pfr1 = 0x00011011;
-    cpu->isar.id_dfr0 = 0x03010066;
-    cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_isar6 = 0;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64isar0 = 0x00011120;
-    cpu->isar.id_aa64mmfr0 = 0x00001124;
-    cpu->isar.dbgdidr = 0x3516d000;
+    cpu->isar.id_mmfr0 = 0x10101105; /* Match documented value for r1p0 */
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
@@ -162,36 +168,14 @@ static void aarch64_a53_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     aarch64_cpu_common_init(obj, MIDR_IMPLEMENTER_ARM, 0xd03, 0, 4);
+    cortex_a72_a57_a53_common_init(cpu);
 
     cpu->dtb_compatible = "arm,cortex-a53";
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
-    cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
-    cpu->isar.mvfr0 = 0x10110222;
-    cpu->isar.mvfr1 = 0x12111111;
-    cpu->isar.mvfr2 = 0x00000043;
     cpu->ctr = 0x84448004; /* L1Ip = VIPT */
-    cpu->reset_sctlr = 0x00c50838;
-    cpu->id_pfr0 = 0x00000131;
-    cpu->id_pfr1 = 0x00011011;
-    cpu->isar.id_dfr0 = 0x03010066;
-    cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_isar6 = 0;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64isar0 = 0x00011120;
+    cpu->isar.id_mmfr0 = 0x10101105; /* Match documented value for r0p4 */
     cpu->isar.id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
-    cpu->isar.dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
@@ -208,34 +192,11 @@ static void aarch64_a72_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     aarch64_cpu_common_init(obj, MIDR_IMPLEMENTER_ARM, 0xd08, 0, 3);
+    cortex_a72_a57_a53_common_init(cpu);
 
     cpu->dtb_compatible = "arm,cortex-a72";
-    cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034080;
-    cpu->isar.mvfr0 = 0x10110222;
-    cpu->isar.mvfr1 = 0x12111111;
-    cpu->isar.mvfr2 = 0x00000043;
     cpu->ctr = 0x8444c004;
-    cpu->reset_sctlr = 0x00c50838;
-    cpu->id_pfr0 = 0x00000131;
-    cpu->id_pfr1 = 0x00011011;
-    cpu->isar.id_dfr0 = 0x03010066;
-    cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64isar0 = 0x00011120;
-    cpu->isar.id_aa64mmfr0 = 0x00001124;
-    cpu->isar.dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
-- 
2.20.1


