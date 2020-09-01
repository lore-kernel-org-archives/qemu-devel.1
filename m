Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07578C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B804F20E65
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lyss1A1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B804F20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8MS-0003gm-RR
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD84E-0001D9-2B
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:26 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD84C-0006Lr-Av
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:25 -0400
Received: by mail-wr1-x435.google.com with SMTP id z4so1989387wrr.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=w9WWr4DaMcJi1WIoWjnLx6cQ5ALbnh/d9Soopg+D+eo=;
 b=Lyss1A1GUzEi2po8KOyB5oGRxRx7qLsjUkznSxEuZ+8HUoMCVBVJ0FLswdU1Xe5N7f
 3SO1k7cRIZj96WcZtQDrfjC+PJWLo2dlxyY7VBHGOtHkkO0dspivTGqeJUj0F8jGo0jn
 Oju+b8QwTcq42MdjW4TnC23DIn4eV+Qg4RKfcCVFMiNfkAMhb5+tVRECnaIow+G6rGTG
 qvijXjYsCcoBDxfqeu0je/X+k19n4SzdEUFUKNC2OZPDe7z80aHFV74IhPa3XXx3zMut
 qbV9UmOtKXRogc9NADlFn4WU4cvAMTi4JXoCDhguLiyiullttEXPjgk0q72kdltFL64U
 WJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w9WWr4DaMcJi1WIoWjnLx6cQ5ALbnh/d9Soopg+D+eo=;
 b=cHQ2G3AMnkDd63i4f/FIh0yGBCFChqhA6TnUQrIUojuGDZdqs5D3Yr1Lewz9S9d0Ss
 ffYlT1Fjxi4l+USDgd5v2DfjrXNvm/AFE+xx0bMXm3FU2OmXhQ4JeQSRcJ9qodWZXJgL
 6swuaBkuFCVgjXGMgGvTNBu1A/z8HZVcRV3/1x2+Xtq7lLpo01b/th9VHuo+9TBenPiJ
 jcERnI30R3+m1BjZ5G3Iqn/F0eIp+8WrgnnuQbc3xdf+qpOzTbCpL7eDwEXdMOb8zVeY
 Zq0UFIvd33WT9991sfsa28cwqKl2EeG4kJhcH59e7dOpaU1MTfAK+cmmdu09TBKzlXze
 AyuA==
X-Gm-Message-State: AOAM531ugO00AWHHmyTBxXST4HZPFAQqUX3g2Ic0zEhLNYbewLVwjlta
 O64chyWOGWbpjGkGvOGqpZGq4+53m7gXwu7m
X-Google-Smtp-Source: ABdhPJxlrrHxGUvmkzQ7PMUbu1NAZNRCZSbFjqZxoBl+lZ5PJiy6b/YZbZqPhqNGcv+xiK3d6V/5Sw==
X-Received: by 2002:adf:e504:: with SMTP id j4mr2499332wrm.205.1598973562776; 
 Tue, 01 Sep 2020 08:19:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/47] hw/arm/sbsa-ref : Add embedded controller in secure
 memory
Date: Tue,  1 Sep 2020 16:18:23 +0100
Message-Id: <20200901151823.29785-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Graeme Gregory <graeme@nuviainc.com>

Add the previously created sbsa-ec device to the sbsa-ref machine in
secure memory so the PSCI implementation in ARM-TF can access it, but
not expose it to non secure firmware or OS except by via ARM-TF.

Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
Reviewed-by: Leif Lindholm <leif@nuviainc.com>
Tested-by: Leif Lindholm <leif@nuviainc.com>
Message-id: 20200826141952.136164-3-graeme@nuviainc.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 7475aac0dfa..47b5286d46c 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -62,6 +62,7 @@ enum {
     SBSA_CPUPERIPHS,
     SBSA_GIC_DIST,
     SBSA_GIC_REDIST,
+    SBSA_SECURE_EC,
     SBSA_SMMU,
     SBSA_UART,
     SBSA_RTC,
@@ -107,6 +108,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_CPUPERIPHS] =         { 0x40000000, 0x00040000 },
     [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
     [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
+    [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
     [SBSA_UART] =               { 0x60000000, 0x00001000 },
     [SBSA_RTC] =                { 0x60010000, 0x00001000 },
     [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
@@ -608,6 +610,16 @@ static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
     return board->fdt;
 }
 
+static void create_secure_ec(MemoryRegion *mem)
+{
+    hwaddr base = sbsa_ref_memmap[SBSA_SECURE_EC].base;
+    DeviceState *dev = qdev_new("sbsa-ec");
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+
+    memory_region_add_subregion(mem, base,
+                                sysbus_mmio_get_region(s, 0));
+}
+
 static void sbsa_ref_init(MachineState *machine)
 {
     unsigned int smp_cpus = machine->smp.cpus;
@@ -731,6 +743,8 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_pcie(sms);
 
+    create_secure_ec(secure_sysmem);
+
     sms->bootinfo.ram_size = machine->ram_size;
     sms->bootinfo.nb_cpus = smp_cpus;
     sms->bootinfo.board_id = -1;
-- 
2.20.1


