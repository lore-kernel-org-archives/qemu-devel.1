Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2714FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8B4204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls9Nkytu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8B4204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZk9-0003IG-3I
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhY-0006WH-7m
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:04 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:38069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhX-0005pD-Ey
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:03 -0400
Received: by mail-ej1-x62a.google.com with SMTP id h21so23830850ejq.5
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mBHAYQ31sriu1PFVXi6ty+G9pR4qR9G0hm00u+LnXSk=;
 b=ls9NkytuxDCjnt560MkALAzIBLPxPudXqqYdA8GLnBsctjHR6onBR+fjHC8Exi6Hnq
 HiDGrWsQ8WUdQ/UJDWuIRuArOkahXHFjBRcWTk/8spkBI2b069wevvy0fe01Sk7YY6KE
 +JxapVUPWSOVT+j16sslZ+3QvltPHchp/OFVG4m4Pf9WTItZbVSLVoJ4JmImqBA6MwSl
 lGLikSeruglT+oiL789WxfHUN7zwTbahljkSgAQ8OhcmaK71Y2B38MjE07tyo4qNaNsl
 L9ozSWPwmOimrrwGvOvb4gwiG6yo1uo/tavp5tIEliLRjto2UBiR8EFGslVhqFxic8Rx
 yfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mBHAYQ31sriu1PFVXi6ty+G9pR4qR9G0hm00u+LnXSk=;
 b=WiLZ/CQg3xfQs6a34Qt/VcmVVXTr4PJFlrr1uKgjofBkPxpxEwVXo0aVrYvB542iQ3
 QaRyt1DvJgOzEOaRYjSRbkWrzV/S4PWfDNSLMSlAiY2iFsqhwk3bsLw4AkKsb8exzMHO
 nN2q8NCd0HRIQlzGN/YhGKkIVl91sMMIAaVC8cI1e2P3dshL0qK9Ufq2pIYht5qIKCs5
 Se7UlBHcGISD1PkKvW0yoIe/Q8PH+WXVXtr0WHhH47eLs3nm1uT1r05bPJD9LL0WjrkO
 aMHtNBsCIUvp7G8f8jp9d60Uv70+5zfwX+FNC3lK3c3phcTkNknGqsBRQPp36AuQEqKO
 qzog==
X-Gm-Message-State: AOAM533z8aaXqC6s6sm4DtbK3SW5IyUdnXnNhN9UyuvT1XBENjAVedDa
 yuY8TfJJBkImIMM1BwJMEjEqOJ7yejE=
X-Google-Smtp-Source: ABdhPJybldAC6vnDY3YrrHQfs46A6e72b/KGxAMMaVxfoZiliFeAqmoOvL16jHYuofFSbupHFeaBng==
X-Received: by 2002:a17:906:379a:: with SMTP id
 n26mr1100313ejc.513.1590499981758; 
 Tue, 26 May 2020 06:33:01 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:33:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/14] hw/pci-host/bonito: Set the Config register reset value
 with FIELD_DP32
Date: Tue, 26 May 2020 15:32:41 +0200
Message-Id: <20200526133247.13066-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62a.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Describe some bits of the Config registers fields with the
registerfields API. Use the FIELD_DP32() macro to set the
BONGENCFG register bits at reset.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-id: <20200510210128.18343-12-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 20f2797a73..d0201ce59e 100644
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


