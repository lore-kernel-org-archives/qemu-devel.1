Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C19C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1EC20674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKEi8l4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1EC20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55121 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXZk-0002L2-FQ
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSP-0004Bx-MN
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSO-0005Ow-5b
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:01 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSN-0005NI-SP
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id x15so829669wmj.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dutpFDVMpS+BeonIxVWBTDXWqsqJ8Tyi/t5MVWPpXKY=;
 b=QKEi8l4kIr2ObtABOD1ZIE74YpSdn0pJPP/tE0BO3FcytFamUo8VjIG/gMWCaMlV+L
 voaaPNLOqbbXpotXfi1GKP9rABAT0HDCzDYwIAMgT8cKc660BSKYXrBFGQNSYajC/15U
 cGRcs76J+2WxYj7PkvociNDTmOoZqPSZ46uNaMtZUHJK+5R4Vvr38YTEvN9oGk0Cn4VM
 OSrxIRvUEOzYGKVDRf6lACogJbPMiIfnhvh18awQbQagfwpSKYApU4ufmln9l5Q6lUTR
 v+Oh+Ety7ZE/vtur1ZeMCH/45t9As9NTQDYnS7vivklb1NiRzqufa7d/xBxgsE9Ek/7F
 90xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dutpFDVMpS+BeonIxVWBTDXWqsqJ8Tyi/t5MVWPpXKY=;
 b=s8BtDhG2TL9+w0B5HnW5F7PgrgaRyMpsG91uSqftubqOCfhDfbQCqqhUPMV+9y4iGv
 hmU0rPtsdMkcWVV2t9C1kdCZFETGVjrxDvXnQiV2N7Wk01KOZ6dPpIonFc5wOO0Ri8hL
 5sLyLieSmicKwot8lkflMXBgafvkPYtd4G0RAOpivAtgmiYt+Nucu6webnAPOh4pKDCY
 wBbsRdHSQN/WpTJdihpSAxAmCGKutZjl18uMaPHtjuSCto76gL8BDIiM4Z/uwZulNG4r
 42qr50DrgB/OBeK9dF114YmOfxGPRsjGYpflLxjuudsUyHweo7nnix7RS08eK2ZNZy5Y
 9CtQ==
X-Gm-Message-State: APjAAAUHIeZ4QBibm8e77cqqqLzu9hgiWyAavnXUz6VNK8EVvHCmr1F6
 UYZR4j23I9DmzF2UvFbPDNw17a9A
X-Google-Smtp-Source: APXvYqxAJ3wff9BPORMRJIt1T391LX8v/bFTHEbTk4+7Leeg4gvaJzB2CaKYOsnSnmf0hRPaANSIGg==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr16826731wmj.43.1561415338112; 
 Mon, 24 Jun 2019 15:28:58 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l1sm646781wmg.13.2019.06.24.15.28.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:28:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:28:43 +0200
Message-Id: <20190624222844.26584-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624222844.26584-1-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 09/10] hw/mips/gt64xxx_pci: Move it to
 hw/pci-host/
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GT-64120 is a north-bridge, and it is not MIPS specific.
Move it with the other north-bridge devices.

We move this device in the common-obj, and compile it once for
the 4 different MIPS targets.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/{mips/gt64xxx_pci.c => pci-host/gt64120.c} | 0
 MAINTAINERS                                   | 2 +-
 hw/mips/Makefile.objs                         | 2 +-
 hw/mips/trace-events                          | 4 ----
 hw/pci-host/Makefile.objs                     | 2 +-
 hw/pci-host/trace-events                      | 5 +++++
 6 files changed, 8 insertions(+), 7 deletions(-)
 rename hw/{mips/gt64xxx_pci.c => pci-host/gt64120.c} (100%)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/pci-host/gt64120.c
similarity index 100%
rename from hw/mips/gt64xxx_pci.c
rename to hw/pci-host/gt64120.c
diff --git a/MAINTAINERS b/MAINTAINERS
index abef4a1cfc..da348e1af1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -928,7 +928,7 @@ M: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_malta.c
-F: hw/mips/gt64xxx_pci.c
+F: hw/pci-host/gt64120.c
 F: tests/acceptance/linux_ssh_mips_malta.py
 
 Mipssim
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 525809af07..da65e19c20 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -1,6 +1,6 @@
 obj-y += addr.o mips_int.o
 obj-$(CONFIG_R4K) += mips_r4k.o
-obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
+obj-$(CONFIG_MALTA) += mips_malta.o
 obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
 obj-$(CONFIG_JAZZ) += mips_jazz.o
 obj-$(CONFIG_FULONG) += mips_fulong2e.o
diff --git a/hw/mips/trace-events b/hw/mips/trace-events
index 75d4c73f2e..e69de29bb2 100644
--- a/hw/mips/trace-events
+++ b/hw/mips/trace-events
@@ -1,4 +0,0 @@
-# gt64xxx.c
-gt64120_read(const char *regname, int width, uint64_t value) "gt64120 read %s value:0x%0*" PRIx64
-gt64120_write(const char *regname, int width, uint64_t value) "gt64120 write %s value:0x%0*" PRIx64
-gt64120_isd_remap(uint64_t from_length, uint64_t from_addr, uint64_t to_length, uint64_t to_addr) "ISD: 0x%08" PRIx64 "@0x%08" PRIx64 " -> 0x%08" PRIx64 "@0x%08" PRIx64
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index a9cd3e022d..3e1657774d 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -17,5 +17,5 @@ common-obj-$(CONFIG_PCI_PIIX) += piix.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) += gpex.o
 common-obj-$(CONFIG_PCI_EXPRESS_XILINX) += xilinx-pcie.o
-
+common-obj-$(CONFIG_MALTA) += gt64120.o
 common-obj-$(CONFIG_PCI_EXPRESS_DESIGNWARE) += designware.o
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index d19ca9aef6..eecc233670 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -20,3 +20,8 @@ unin_data_write(uint64_t addr, unsigned len, uint64_t val) "write addr 0x%"PRIx6
 unin_data_read(uint64_t addr, unsigned len, uint64_t val) "read addr 0x%"PRIx64 " len %d val 0x%"PRIx64
 unin_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 unin_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
+
+# gt64120.c
+gt64120_read(const char *regname, int width, uint64_t value) "gt64120 read %s value:0x%0*" PRIx64
+gt64120_write(const char *regname, int width, uint64_t value) "gt64120 write %s value:0x%0*" PRIx64
+gt64120_isd_remap(uint64_t from_length, uint64_t from_addr, uint64_t to_length, uint64_t to_addr) "ISD: 0x%08" PRIx64 "@0x%08" PRIx64 " -> 0x%08" PRIx64 "@0x%08" PRIx64
-- 
2.19.1


