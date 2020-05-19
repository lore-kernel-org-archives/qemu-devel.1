Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4985B2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4985B2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxwq-0004Rb-HD
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jaxw5-0003oO-7G
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:49:17 -0400
Received: from michel.telenet-ops.be ([2a02:1800:110:4::f00:18]:42062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jaxw2-0003vT-2S
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:49:16 -0400
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:918e:b928:22c1:d715])
 by michel.telenet-ops.be with bizsmtp
 id gYp6220074CPMDc06Yp60y; Tue, 19 May 2020 10:49:07 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jaxvu-0002Fv-1l; Tue, 19 May 2020 10:49:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jaxvt-0000I0-Va; Tue, 19 May 2020 10:49:05 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/arm/virt: Fix PL061 node name and properties
Date: Tue, 19 May 2020 10:49:04 +0200
Message-Id: <20200519084904.1069-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2a02:1800:110:4::f00:18;
 envelope-from=geert@linux-m68k.org; helo=michel.telenet-ops.be
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the created node comply with the PL061 Device Tree bindings:
  - Use generic node name "gpio" instead of "pl061",
  - Add missing "#interrupt-cells" and "interrupt-controller"
    properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Split off from "[PATCH QEMU v2 2/5] ARM: PL061: Extract pl061_create_fdt()"
(https://lore.kernel.org/r/20200423090118.11199-3-geert+renesas@glider.be).
---
 hw/arm/virt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7dc96abf72cf2b9a..99593d7bce4d85cb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -818,13 +818,15 @@ static void create_gpio(const VirtMachineState *vms)
                                      qdev_get_gpio_in(vms->gic, irq));
 
     uint32_t phandle = qemu_fdt_alloc_phandle(vms->fdt);
-    nodename = g_strdup_printf("/pl061@%" PRIx64, base);
+    nodename = g_strdup_printf("/gpio@%" PRIx64, base);
     qemu_fdt_add_subnode(vms->fdt, nodename);
     qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                  2, base, 2, size);
     qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof(compat));
     qemu_fdt_setprop_cell(vms->fdt, nodename, "#gpio-cells", 2);
     qemu_fdt_setprop(vms->fdt, nodename, "gpio-controller", NULL, 0);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "#interrupt-cells", 2);
+    qemu_fdt_setprop(vms->fdt, nodename, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-- 
2.17.1


