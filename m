Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAEBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB12E206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1W3HXEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB12E206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwS7k-000386-7q
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwS6p-0002UD-Da; Fri, 17 Jul 2020 11:17:11 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:36771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwS6n-0004ct-OJ; Fri, 17 Jul 2020 11:17:11 -0400
Received: by mail-ej1-x642.google.com with SMTP id n22so8310477ejy.3;
 Fri, 17 Jul 2020 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=V0SBtegwoepW2Ol9ZHfRH+KRDlOa0UwLbC81CuHQzwQ=;
 b=R1W3HXECambyd8+peLQKOgcqE89oMKN2qjL+H1VEIdKwPqeq9ROjRkSDFOykMJfdeR
 Jr+5GNRbTgDzy59/tYtyzdGUJCb3xR0+7CzBrQz3EYkh1H+zSE+MjZ01oRuq2h/e4hRD
 kTfaWf2GGBzjwtIEUb8i55CjaIWk2Z3XpsSt/U6aFk9TznGpy8Ck4/rljqBSW5WMccSd
 ZQyI7j+HL5VqtOYDjVpKE/xZTzgqLS/W9B8lvZv9AFYL2D8F+Kc8mi8PfVXQKlON3Fh9
 BByxXEcMnP/NOD6/OevzEB66rK5JUVDNzCz6yl38at0cQLlof0RYXfnRe/weeGNfDnGD
 rNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=V0SBtegwoepW2Ol9ZHfRH+KRDlOa0UwLbC81CuHQzwQ=;
 b=HW6oYGC7lWFagCh5iuHMZcCCtGyNQGnt+Rn95PUaSbGpWmwATIXGLGPEaSKQ7/s/5b
 AI2JMvG+WdXFYX8DeQDq/s4Ga72okCqxBG6XlWuBqffLa4QUNbSZdBSEVHABRkbVAg67
 gl8zNF7kXrW7A5tX6h+APYPeJvQKX8mExLAiX6GyiQUeKX0VyQqqCGnSGRnh3MiUE0E5
 ezK5wCny10RE3yjSoWxjPwfB25+HqlgcKwwnI9oOqAhHRyo1Le6Hq3b5f/5/0+eaoNRQ
 Yi9Xn/Tcq+vIdlLsuVzLh9GQ1jB1qxeGqpTvGwfCeaHFa9wVe1O26L/4rRj3ZquvvZ8y
 LvNA==
X-Gm-Message-State: AOAM531rd297XynrKeeILAxDohICV+c833LZt5nYkzmh3ASI0lwmAyIP
 5h3tGvKx/rRE5rpkG67pj6MIYCaFbno=
X-Google-Smtp-Source: ABdhPJxxaIYUqzMJ4H00+8mywMnRRl2/JdwkR1X0IXS2GDh/5slM5UpeGXcgMbbY3MO3i1gn/SvmqA==
X-Received: by 2002:a17:906:4a94:: with SMTP id
 x20mr9453046eju.539.1594999027523; 
 Fri, 17 Jul 2020 08:17:07 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id o21sm8165318eja.37.2020.07.17.08.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 08:17:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1] hw/isa/lpc_ich9: Ignore reserved/invalid SCI IRQ
Date: Fri, 17 Jul 2020 17:17:05 +0200
Message-Id: <20200717151705.18611-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libFuzzer triggered the following assertion:

  cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
    -nographic -monitor none -serial none \
    -qtest stdio -d guest_errors -trace pci\*
  outl 0xcf8 0x8400f841
  outl 0xcfc 0xebed205d
  outl 0x5d02 0xedf82049
  EOF
  pci_cfg_write ICH9-LPC 31:0 @0x41 <- 0xebed205d
  hw/pci/pci.c:268: int pci_bus_get_irq_level(PCIBus *, int): Assertion `irq_num < bus->nirq' failed.

This is because ich9_lpc_sci_irq() returns -1 for reserved
(illegal) values, but ich9_lpc_pmbase_sci_update() considers
it valid and store it in a 8-bit unsigned type. Then the 255
value is used as GSI IRQ, resulting in a PIRQ value of 247,
more than ICH9_LPC_NB_PIRQS (8).

Fix by simply ignoring the invalid access (and reporting it):

  pci_cfg_write ICH9-LPC 31:0 @0x41 <- 0xebed205d
  ICH9 LPC: SCI IRQ SEL #3 is reserved
  pci_cfg_read mch 00:0 @0x0 -> 0x8086
  pci_cfg_read mch 00:0 @0x0 -> 0x29c08086
  ...

Cc: qemu-stable@nongnu.org
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: 8f242cb724 ("ich9: implement SCI_IRQ_SEL register")
BugLink: https://bugs.launchpad.net/qemu/+bug/1878642
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because I have no idea how to report the error. The LPC is on
Device 31 Function 0. Should it trigger some error to the PCI bridge?
I can't find that info in the ICH9 datasheet.
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i386/ich9.h |  1 +
 hw/isa/lpc_ich9.c      | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index a98d10b252..60483b16cd 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -144,6 +144,7 @@ typedef struct ICH9LPCState {
 #define ICH9_LPC_PMBASE_BASE_ADDRESS_MASK       Q35_MASK(32, 15, 7)
 #define ICH9_LPC_PMBASE_RTE                     0x1
 #define ICH9_LPC_PMBASE_DEFAULT                 0x1
+
 #define ICH9_LPC_ACPI_CTRL                      0x44
 #define ICH9_LPC_ACPI_CTRL_ACPI_EN              0x80
 #define ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK     Q35_MASK(8, 2, 0)
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index cd6e169d47..5ed28a726c 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "qapi/visitor.h"
 #include "qemu/range.h"
@@ -312,10 +313,12 @@ void ich9_generate_smi(void)
     cpu_interrupt(first_cpu, CPU_INTERRUPT_SMI);
 }
 
+/* Returns -1 on error, IRQ number on success */
 static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
 {
-    switch (lpc->d.config[ICH9_LPC_ACPI_CTRL] &
-            ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK) {
+    uint8_t sel = lpc->d.config[ICH9_LPC_ACPI_CTRL] &
+                  ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK;
+    switch (sel) {
     case ICH9_LPC_ACPI_CTRL_9:
         return 9;
     case ICH9_LPC_ACPI_CTRL_10:
@@ -328,6 +331,8 @@ static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
         return 21;
     default:
         /* reserved */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ICH9 LPC: SCI IRQ SEL #%u is reserved\n", sel);
         break;
     }
     return -1;
@@ -450,7 +455,7 @@ ich9_lpc_pmbase_sci_update(ICH9LPCState *lpc)
 {
     uint32_t pm_io_base = pci_get_long(lpc->d.config + ICH9_LPC_PMBASE);
     uint8_t acpi_cntl = pci_get_long(lpc->d.config + ICH9_LPC_ACPI_CTRL);
-    uint8_t new_gsi;
+    int new_gsi;
 
     if (acpi_cntl & ICH9_LPC_ACPI_CTRL_ACPI_EN) {
         pm_io_base &= ICH9_LPC_PMBASE_BASE_ADDRESS_MASK;
@@ -461,6 +466,9 @@ ich9_lpc_pmbase_sci_update(ICH9LPCState *lpc)
     ich9_pm_iospace_update(&lpc->pm, pm_io_base);
 
     new_gsi = ich9_lpc_sci_irq(lpc);
+    if (new_gsi == -1) {
+        return;
+    }
     if (lpc->sci_level && new_gsi != lpc->sci_gsi) {
         qemu_set_irq(lpc->pm.irq, 0);
         lpc->sci_gsi = new_gsi;
-- 
2.21.3


