Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E27CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B4F20657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYMTQHav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B4F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacys-0006M7-7S
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacy5-0005us-84
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:25:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacy4-0000r8-CH
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:25:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id l17so11192850wrr.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T60dzz1iJ37QtgjSGPbMqPJWV4r36t32vvRLMJg4DWQ=;
 b=ZYMTQHav73G4nLCFdOpTNfm1MRvsjfFmgMOX6JZRJfmVjIMyVlookTlhlm/EOKZatt
 lftskhFsPopVEUHqq7YdHT/hOzdQjY30KZNY9I3a3Xt/rQtaoWjXU7XAdqRoh6qGBCIN
 KGJyOI50K677QAK838KYWHNNzU8CCQgdKVIasFC9H4te36FLNE8uAQhO7Y3J5bFTiCwU
 kYF5263rRBde/v1liKNQ7sEa3rtVXTIo4DqlagE7ErQKw0+0L8hGjHl1aikNB6CA5ubj
 Kni6xW6oDWZWYqc3GWruxGfVr08du02UIGF2b8lF2YqouDutucrpFw89WiPSpMZqNrps
 dBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=T60dzz1iJ37QtgjSGPbMqPJWV4r36t32vvRLMJg4DWQ=;
 b=oMchLx2+LkiOC6UYq6OEr8+4rsbd7ZaXcVd3lw/aipWDIFiUDflLoQsJJCjgjxBXK7
 ilHU9hfxVF2+VuX+BDP/84AGKUakSec/Sf94eBy2mxZRmQlyKjSLafdqTTXQLpcEllYj
 jFwNriWgZYV7VPxkv3YxHpzmCyiNYvtPIK0pOhVIUYUxtd1ITUQyLEejihVfuVtZQKGf
 fro0OpxTSbjBDJjlAk6zrqgFX6ihI/VtFW+UTY3PhthVLBcmOA1VhNJ/VZd7RVitkNiF
 fbAjL3XwsXdGmBV0/CX/AXGHHzNihSFf5voxAOp8wU1uDlFrOWXIAjIbYXW7Vwjy1hQD
 759A==
X-Gm-Message-State: AOAM531QGHQ9DkqPduNvJ2qDDhoHZFmA1qKX1sLb0CfDe2j9BpKZWPBV
 YTRWqWvg3xwR7OJG0+/JnB81J2lBZLE=
X-Google-Smtp-Source: ABdhPJwZzbLHyNna6nHpNGV8uznzZYimDl5p9KslDVtEp2Wp/7vzWMwv0fZVg9egIDtJMdYILs9XSQ==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr18805997wrc.367.1589797554301; 
 Mon, 18 May 2020 03:25:54 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z12sm10314018wrq.7.2020.05.18.03.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 03:25:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] hw/i386/vmport: Allow QTest use without crashing
Date: Mon, 18 May 2020 12:25:51 +0200
Message-Id: <20200518102551.8516-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Trying libFuzzer on the vmport device, we get:

  AddressSanitizer:DEADLYSIGNAL
  =================================================================
  ==29476==ERROR: AddressSanitizer: SEGV on unknown address 0x000000008840 (pc 0x56448bec4d79 bp 0x7ffeec9741b0 sp 0x7ffeec9740e0 T0)
  ==29476==The signal is caused by a READ memory access.
    #0 0x56448bec4d78 in vmport_ioport_read (qemu-fuzz-i386+0x1260d78)
    #1 0x56448bb5f175 in memory_region_read_accessor (qemu-fuzz-i386+0xefb175)
    #2 0x56448bb30c13 in access_with_adjusted_size (qemu-fuzz-i386+0xeccc13)
    #3 0x56448bb2ea27 in memory_region_dispatch_read1 (qemu-fuzz-i386+0xecaa27)
    #4 0x56448bb2e443 in memory_region_dispatch_read (qemu-fuzz-i386+0xeca443)
    #5 0x56448b961ab1 in flatview_read_continue (qemu-fuzz-i386+0xcfdab1)
    #6 0x56448b96336d in flatview_read (qemu-fuzz-i386+0xcff36d)
    #7 0x56448b962ec4 in address_space_read_full (qemu-fuzz-i386+0xcfeec4)

This is easily reproducible using:

  $ echo inb 0x5658 | qemu-system-i386 -M isapc,accel=qtest -qtest stdio
  [I 1589796572.009763] OPENED
  [R +0.008069] inb 0x5658
  Segmentation fault (core dumped)

  $ coredumpctl gdb -q
  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  0x00005605b54d0f21 in vmport_ioport_read (opaque=0x5605b7531ce0, addr=0, size=4) at hw/i386/vmport.c:77
  77          eax = env->regs[R_EAX];
  (gdb) p cpu
  $1 = (X86CPU *) 0x0
  (gdb) bt
  #0  0x00005605b54d0f21 in vmport_ioport_read (opaque=0x5605b7531ce0, addr=0, size=4) at hw/i386/vmport.c:77
  #1  0x00005605b53db114 in memory_region_read_accessor (mr=0x5605b7531d80, addr=0, value=0x7ffc9d261a30, size=4, shift=0, mask=4294967295, attrs=...) at memory.c:434
  #2  0x00005605b53db5d4 in access_with_adjusted_size (addr=0, value=0x7ffc9d261a30, size=1, access_size_min=4, access_size_max=4, access_fn=
      0x5605b53db0d2 <memory_region_read_accessor>, mr=0x5605b7531d80, attrs=...) at memory.c:544
  #3  0x00005605b53de156 in memory_region_dispatch_read1 (mr=0x5605b7531d80, addr=0, pval=0x7ffc9d261a30, size=1, attrs=...) at memory.c:1396
  #4  0x00005605b53de228 in memory_region_dispatch_read (mr=0x5605b7531d80, addr=0, pval=0x7ffc9d261a30, op=MO_8, attrs=...) at memory.c:1424
  #5  0x00005605b537c80a in flatview_read_continue (fv=0x5605b7650290, addr=22104, attrs=..., ptr=0x7ffc9d261b4b, len=1, addr1=0, l=1, mr=0x5605b7531d80) at exec.c:3200
  #6  0x00005605b537c95d in flatview_read (fv=0x5605b7650290, addr=22104, attrs=..., buf=0x7ffc9d261b4b, len=1) at exec.c:3239
  #7  0x00005605b537c9e6 in address_space_read_full (as=0x5605b5f74ac0 <address_space_io>, addr=22104, attrs=..., buf=0x7ffc9d261b4b, len=1) at exec.c:3252
  #8  0x00005605b53d5a5d in address_space_read (len=1, buf=0x7ffc9d261b4b, attrs=..., addr=22104, as=0x5605b5f74ac0 <address_space_io>) at include/exec/memory.h:2401
  #9  0x00005605b53d5a5d in cpu_inb (addr=22104) at ioport.c:88

X86CPU is NULL because QTest accelerator does not use CPU.
Fix by returning default values when QTest accelerator is used.

Reported-by: Clang AddressSanitizer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/vmport.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 1aaaab691a..4ec95f8778 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/qtest.h"
 #include "qemu/log.h"
 #include "vmport.h"
 #include "cpu.h"
@@ -64,10 +65,14 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
     VMPortState *s = opaque;
     CPUState *cs = current_cpu;
     X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
+    CPUX86State *env;
     unsigned char command;
     uint32_t eax;
 
+    if (qtest_enabled()) {
+        return -1;
+    }
+    env = &cpu->env;
     cpu_synchronize_state(cs);
 
     eax = env->regs[R_EAX];
@@ -90,6 +95,9 @@ static void vmport_ioport_write(void *opaque, hwaddr addr,
 {
     X86CPU *cpu = X86_CPU(current_cpu);
 
+    if (qtest_enabled()) {
+        return;
+    }
     cpu->env.regs[R_EAX] = vmport_ioport_read(opaque, addr, 4);
 }
 
@@ -97,6 +105,9 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
 
+    if (qtest_enabled()) {
+        return -1;
+    }
     cpu->env.regs[R_EBX] = VMPORT_MAGIC;
     return 6;
 }
@@ -105,6 +116,9 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
 
+    if (qtest_enabled()) {
+        return -1;
+    }
     cpu->env.regs[R_EBX] = 0x1177;
     return ram_size;
 }
-- 
2.21.3


