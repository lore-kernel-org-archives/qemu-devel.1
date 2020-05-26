Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C87C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E912084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6HXb2MK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E912084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXC8-0006pO-HN
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7V-0006vp-SJ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:43 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:45921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7V-00029c-5T
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:41 -0400
Received: by mail-ed1-x541.google.com with SMTP id s19so17217495edt.12
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mBHAYQ31sriu1PFVXi6ty+G9pR4qR9G0hm00u+LnXSk=;
 b=Y6HXb2MK8a9wU8HPeiJZdV7H0dKz0uu815z7ts0shf0XujR5nSIl/zEaunm99PKTu2
 IWhxHbTD/5MslA65cYR1P+NGUHCGHeOx7RPSdye42B1rmV70k02Id60kP+2LxXe776D2
 4gSkjo2StrLeRhuU9/B7QQzpNAHl3QTav3tewd8FvzrabunKsnk/okyBnoNXh80dK9JW
 8HxiCwfXX+Uc+djullQN3sotCWpR3ZzSrKwWcyr0Xcb7w7xz18ECxeF7AnHWXJR5q0ng
 ZJGAm+A9wiQBjOBER3GR+R7S6zp0ATkfVw9OYOtO7IO6+mMvoeJR1uT3gqglZqv++kuJ
 obcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mBHAYQ31sriu1PFVXi6ty+G9pR4qR9G0hm00u+LnXSk=;
 b=pnloNZdHJqKZaGOuZmPW2lK7XmpcrH13eyA8y6NgnPsyIlf7puT2ipX8bPerInr2GP
 AatwKEgE3f+kD4vSHiHcTNsKkwqtdoOgwvQLC5Vint7cgxqXWrWXdZSxFJWxfICok0EG
 yCP6aoc7pROOB4vGApUksF9EeLKzrEUXgpc2RK7+CxeFuD3NmTJLXO0NfwufUHSCUJM2
 te4Rs+iA84En2JwmQpuO2MD/O6MzbY2ObGiFNEyU91Ywc+ZWu4wbMLny7mIk5med+ycJ
 2mPFqCdAnMkitfEKJeTDVxj64F45AUfO9kxX73dv7p001SQ1LsRZfVSdgLIBKaPCEPAs
 HVYQ==
X-Gm-Message-State: AOAM53190jq/uCAh4o3f9lGEOljzsOABuPHOVwcRS/eVESlXRRgMj2Nk
 jhwMtfJ1868NJZ56zdivVR+LW6aVd+c=
X-Google-Smtp-Source: ABdhPJx7A+aavnv8UeQ4jpnozPyWIgFVnM/s5spYdycN2n/BTeZlrr2nQOg/S3Ha68qtTyHrtE932w==
X-Received: by 2002:a50:bb07:: with SMTP id y7mr18652600ede.176.1590490059616; 
 Tue, 26 May 2020 03:47:39 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm3342597ejd.19.2020.05.26.03.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:47:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/14] hw/pci-host/bonito: Set the Config register reset value
 with FIELD_DP32
Date: Tue, 26 May 2020 12:47:20 +0200
Message-Id: <20200526104726.11273-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526104726.11273-1-f4bug@amsat.org>
References: <20200526104726.11273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
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


