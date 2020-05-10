Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A202AC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B50F20801
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sylXiCRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B50F20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXtEj-0004Zn-IS
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt5B-0007fP-3G
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:57 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt59-00017R-Eu
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:55 -0400
Received: by mail-ej1-x641.google.com with SMTP id a2so6200865ejx.5
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ayYsOE2ekE5zXVDs2oP9hlJpdQM4y7RMHn3xiibRt4E=;
 b=sylXiCRa4NluLp9RptVwUNHWKqcEojov0WI71qgh0bHeSPwrm9Ef3+AS6D7kjthYKs
 UL+a5VY8SBujp9GY7TQfOjoDReY0K6gX8i8nPp4M8cXZax9sKKp+yCQEm/SzTk3GrqRU
 ncN3Jw+ULmatyfypyUwBwRJu4QZC//TzhMM5W5yvskhHGpMfhf3CSWV51u45GyM1SYjh
 4TxkQrHXEBPW2raqBHV8jRqGfzrf6M0Dt7ScH8SZchD2N211L7m1io8+ez+54ARKAs1q
 IyUrwXzjfy08gU/FiSs+dIRa7DT1Vwb+8Yff6jtIWOO40NrUL9iW0o4On7O4KSll9uOh
 86Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ayYsOE2ekE5zXVDs2oP9hlJpdQM4y7RMHn3xiibRt4E=;
 b=JRTagMUs62cpul9bQgM8NbohXMy11nIDXXuC1uloOFtWM94D+zAYeJ2hFdMP/fU6m5
 MVbnFmrMm94VDbl/vMmpR0Tompy9/+PkOe7J8r13L39G7/6lJH8DVVntFh4q+w5dFrBh
 was2VT4ootkvr6Hr05akl0BtTvLTyMVNWbRPRtjfFXwWasS3Lz/fOZMFRGkld3np89cy
 csH3OJ3ai8uA64slpBvNfiTnJ7ScQdNiQ0vjp6Q3X2a2btyS2ohNsuLEGscnPWYGnXqm
 /jnvbLMnGVMG3/n3EiRWezVq5bmFy8RIpPj6uBoR4JGOoL6QJ+CsBdN4gthtZS/bSM7K
 U/IA==
X-Gm-Message-State: AGi0PuYTuMnPMXgkAu6wUk5YAsltEl6M8iFt7Zs0unYzg+Msk/6F1pgQ
 5ybuhayc7VSbuuPXooZQxBwo0gRO4x4=
X-Google-Smtp-Source: APiQypKnETHJa0KI2o/OOQ2J86zPQr7AH3gg3oq8xZwaso8MXX+FP7p7G56cEbwg64D0jbfPJgbTIA==
X-Received: by 2002:a17:906:17c1:: with SMTP id
 u1mr10929661eje.47.1589144513942; 
 Sun, 10 May 2020 14:01:53 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/12] hw/pci-host/bonito: Set the Config register reset value
 with FIELD_DP32
Date: Sun, 10 May 2020 23:01:27 +0200
Message-Id: <20200510210128.18343-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Describe some Config registers fields with the registerfields
API. Use the FIELD_DP32() macro to set the BONGENCFG register
bits at reset.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 335c7787eb..86aceb333a 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -50,6 +50,7 @@
 #include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
 #include "hw/misc/unimp.h"
+#include "hw/registerfields.h"
 
 /* #define DEBUG_BONITO */
 
@@ -112,8 +113,19 @@
 /* Power on register */
 
 #define BONITO_BONPONCFG        (0x00 >> 2)      /* 0x100 */
+
+/* PCI configuration register */
 #define BONITO_BONGENCFG_OFFSET 0x4
 #define BONITO_BONGENCFG        (BONITO_BONGENCFG_OFFSET >> 2)   /*0x104 */
+REG32(BONGENCFG,        0x104)
+FIELD(BONGENCFG, DEBUGMODE,      0, 1)
+FIELD(BONGENCFG, SNOOP,          1, 1)
+FIELD(BONGENCFG, CPUSELFRESET,   2, 1)
+FIELD(BONGENCFG, BYTESWAP,       6, 1)
+FIELD(BONGENCFG, UNCACHED,       7, 1)
+FIELD(BONGENCFG, PREFETCH,       8, 1)
+FIELD(BONGENCFG, WRITEBEHIND,    9, 1)
+FIELD(BONGENCFG, PCIQUEUE,      12, 1)
 
 /* 2. IO & IDE configuration */
 #define BONITO_IODEVCFG         (0x08 >> 2)      /* 0x108 */
@@ -577,11 +589,18 @@ static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
 static void bonito_reset(void *opaque)
 {
     PCIBonitoState *s = opaque;
+    uint32_t val = 0;
 
     /* set the default value of north bridge registers */
 
     s->regs[BONITO_BONPONCFG] = 0xc40;
-    s->regs[BONITO_BONGENCFG] = 0x1384;
+    val = FIELD_DP32(val, BONGENCFG, PCIQUEUE, 1);
+    val = FIELD_DP32(val, BONGENCFG, WRITEBEHIND, 1);
+    val = FIELD_DP32(val, BONGENCFG, PREFETCH, 1);
+    val = FIELD_DP32(val, BONGENCFG, UNCACHED, 1);
+    val = FIELD_DP32(val, BONGENCFG, CPUSELFRESET, 1);
+    s->regs[BONITO_BONGENCFG] = val;
+
     s->regs[BONITO_IODEVCFG] = 0x2bff8010;
     s->regs[BONITO_SDCFG] = 0x255e0091;
 
-- 
2.21.3


