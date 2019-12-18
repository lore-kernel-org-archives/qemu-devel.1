Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F8EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4227B2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtZvfvZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4227B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYaA-0003ih-UT
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3T-0006jX-0T
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3R-0001hN-Ct
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:50 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3R-0001d7-42
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:49 -0500
Received: by mail-wm1-x343.google.com with SMTP id b19so1553742wmj.4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SpgbQ9V34H0m21+BzAIwX/uz5DHNKZyNJLeHPTNtum0=;
 b=NtZvfvZzg9ibENMM4u+shcQ3U3atavXI01VQj+VRzZFrF3h9Jo5nVM5g0NDOvND3PX
 2bfSvliOi0pTiweUl1rVZcDbF/5VsEkXzmCfVJcUVxxT29a3f0e0+6opv0P+LIehXB53
 lhBTklIuOPNPm6Nnd1nISrFC3qprD7zPXcf4tExTpA/J6KSO+WjxOn4S4/NostQc0xmF
 9Iywipn/xC9Q5tpGh4FRT03oGcz/EBsxjFq9J/LrOaXW96T1nm7CT1ZXEJ0sI2duBSYy
 mTBhoORyacQ8IsF/IaJwm81+2wo/HJktXuA6rq35lXAaXMun07TMjtmF8JhzBw3jmfFV
 np/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SpgbQ9V34H0m21+BzAIwX/uz5DHNKZyNJLeHPTNtum0=;
 b=Ne3VZ3YFoxlWqDMDGK/Lq1NcjgEiBIj6I2PJwS0fgE9F19Q9n102yGnwz9nfRa7QoZ
 AaNTL7Tm4wEPrlunAMotGcPkxQSekVA0EM0mHUYaLTnRac8Ypq7A6yy3HlczEzyYbXrA
 fxfcHMgCWZMp0WhWnYd7lZJT9QvmJPHsOSgnHpC4OvCdtAvlFNvfGWrVnCIcagOVfaP7
 KFij7mRJR/G7oJ24YBhzfDof9eSHSHY7EHf3pxmpDz7DP2KQLDcb9/o3Fygzn4B/AP3Z
 AfpgsJTdPKgWO6u9vEMEL1SuLBB9PTo5iqIKDXNB3XdLNQdieovjiOSGwTVXPCCuI70C
 /jzQ==
X-Gm-Message-State: APjAAAV/RXzXh2wgD6AnnPlCAivKCJwYZPvauCCAq5b8f9pzwHKEoZ4o
 bi21fk9juu8vV0USlIY9r2k50cRz
X-Google-Smtp-Source: APXvYqyOsjh/wHvrdvKCK6bZqBiNvRPJtoXxQTJnSjUMFI6Fn8WW/juP/4mLLYxhsg6bE8ISvTzxNQ==
X-Received: by 2002:a1c:e91a:: with SMTP id q26mr2847284wmc.59.1576670627578; 
 Wed, 18 Dec 2019 04:03:47 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/87] hw/i386/pc: Convert DPRINTF() to trace events
Date: Wed, 18 Dec 2019 13:02:15 +0100
Message-Id: <1576670573-48048-50-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Convert the deprecated DPRINTF() macro to trace events.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c         | 19 +++++--------------
 hw/i386/trace-events |  6 ++++++
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e330a91..d3075e7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -91,16 +91,7 @@
 #include "config-devices.h"
 #include "e820_memory_layout.h"
 #include "fw_cfg.h"
-
-/* debug PC/ISA interrupts */
-//#define DEBUG_IRQ
-
-#ifdef DEBUG_IRQ
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("CPUIRQ: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 GlobalProperty pc_compat_4_2[] = {};
 const size_t pc_compat_4_2_len = G_N_ELEMENTS(pc_compat_4_2);
@@ -350,7 +341,7 @@ void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s = opaque;
 
-    DPRINTF("pc: %s GSI %d\n", level ? "raising" : "lowering", n);
+    trace_pc_gsi_interrupt(n, level);
     if (n < ISA_NUM_IRQS) {
         qemu_set_irq(s->i8259_irq[n], level);
     }
@@ -428,7 +419,7 @@ static void pic_irq_request(void *opaque, int irq, int level)
     CPUState *cs = first_cpu;
     X86CPU *cpu = X86_CPU(cs);
 
-    DPRINTF("pic_irqs: %s irq %d\n", level? "raise" : "lower", irq);
+    trace_pc_pic_interrupt(irq, level);
     if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
         CPU_FOREACH(cs) {
             cpu = X86_CPU(cs);
@@ -762,7 +753,7 @@ static void port92_write(void *opaque, hwaddr addr, uint64_t val,
     Port92State *s = opaque;
     int oldval = s->outport;
 
-    DPRINTF("port92: write 0x%02" PRIx64 "\n", val);
+    trace_port92_write(val);
     s->outport = val;
     qemu_set_irq(s->a20_out, (val >> 1) & 1);
     if ((val & 1) && !(oldval & 1)) {
@@ -777,7 +768,7 @@ static uint64_t port92_read(void *opaque, hwaddr addr,
     uint32_t ret;
 
     ret = s->outport;
-    DPRINTF("port92: read 0x%02x\n", ret);
+    trace_port92_read(ret);
     return ret;
 }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index c8bc464..43f33cf 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -111,3 +111,9 @@ amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"PRIx64" lo 0x%"PRIx64
 # vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
 vmport_command(unsigned char command) "command: 0x%02x"
+
+# pc.c
+pc_gsi_interrupt(int irqn, int level) "GSI interrupt #%d level:%d"
+pc_pic_interrupt(int irqn, int level) "PIC interrupt #%d level:%d"
+port92_read(uint8_t val) "port92: read 0x%02x"
+port92_write(uint8_t val) "port92: write 0x%02x"
-- 
1.8.3.1



