Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A36C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13F121835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4cxdSXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13F121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inUTw-0000Z7-RD
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 16:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1inURV-0005Yz-PK
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1inURU-0004L8-Oi
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:13 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1inURU-0004HY-Hw
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:12 -0500
Received: by mail-pl1-x644.google.com with SMTP id c23so19466600plz.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 13:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=v5KPKRZAR7txzi3dtQ0M2sC1CnUsf9tIOlY4B9oV1g8=;
 b=d4cxdSXakwl8gu5aoAbEDrQslebPkBRfyvScF7etxqt5M/IC5EUgjF2F7lpgOJc0fe
 rali1GqndHWZoAEcQnd7gXAzFsT3ccp8baeGn14IdcYZIw4QM27roUZCwl4NL1xeZ8Y5
 aVqybggqawR9dc5F9OFGm+jnaTXFjNjGNXDF2ZzJOQxxCoCN/mbk4APSllW1H2TmxM1s
 L1yWMGlTk3esva8lWwn/68eyqMS2KTfU3vFLKeF+Ws7x3qb3JM3TXabEFLJZFDhHCeAj
 kCybrmQmHwDF8kv2ExAC10SHiQOucfGp0U1aG/Ur2hvX9y8vFYi7oIs2s2SmGss8lzh3
 ivWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v5KPKRZAR7txzi3dtQ0M2sC1CnUsf9tIOlY4B9oV1g8=;
 b=R+EI80qtdnEakDLxfqipiX1bGXVFW+AKtYpIZ5Hdpw0T5IcAx+0+H1MTDHrd5D43KV
 BAN5LqjZZU+37wq0b7ZshEWjtRhm1KQpBPLacNLyIceODjN0llVnobh8PJ5jq2FcP5nI
 MbUVEokokich+qr/ARPkgSZbe0fYy7sWevgFos2+I/UB9plSd11S84CkLtTD6OSL1bVn
 hUu3XelK6u2l8Gorg2zcgQhcaMs5ffwy5JbJfHPxDah7HsaxvndRZ3lNtw8ydBWBLHXp
 Cc8DBbGcLfzvle1+rHhQAaA9IkJNC6xFOPR30DRgnsNPmXiujHjtdhV6yJdKpVExPVZ6
 b7sw==
X-Gm-Message-State: APjAAAUx21NDNTf063E8euvmkM1QWanVcOBOVKN2/OtWeXyVkB56RY5a
 axR8hVIDj0yaatZG5UhDqWupNWLpu159sg==
X-Google-Smtp-Source: APXvYqwjsTJ8GVGsHrIfxCsM+4DW1Bt7FbPyfTmdo2GcTV042L/Dnj+xRgQQIKs7rxAHPFrUmeg4Og==
X-Received: by 2002:a17:902:934a:: with SMTP id
 g10mr69132583plp.99.1578086711266; 
 Fri, 03 Jan 2020 13:25:11 -0800 (PST)
Received: from localhost.localdomain
 (59-100-211-22.bri.static-ipl.aapt.com.au. [59.100.211.22])
 by smtp.gmail.com with ESMTPSA id c15sm16668907pja.30.2020.01.03.13.25.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 13:25:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] capstone: Enable disassembly for s390x
Date: Sat,  4 Jan 2020 07:24:59 +1000
Message-Id: <20200103212500.14384-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103212500.14384-1-richard.henderson@linaro.org>
References: <20200103212500.14384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

Enable s390x, aka SYSZ, in the git submodule build.
Set the capstone parameters for both s390x host and guest.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile           | 1 +
 disas.c            | 3 +++
 target/s390x/cpu.c | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 12e129ac9d..df1c692ccd 100644
--- a/Makefile
+++ b/Makefile
@@ -504,6 +504,7 @@ CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
 CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
+CAP_CFLAGS += -DCAPSTONE_HAS_SYSZ
 CAP_CFLAGS += -DCAPSTONE_HAS_X86
 
 .PHONY: capstone/all
diff --git a/disas.c b/disas.c
index 3937da6157..845c40fca8 100644
--- a/disas.c
+++ b/disas.c
@@ -660,6 +660,9 @@ void disas(FILE *out, void *code, unsigned long size)
     print_insn = print_insn_m68k;
 #elif defined(__s390__)
     print_insn = print_insn_s390;
+    s.info.cap_arch = CS_ARCH_SYSZ;
+    s.info.cap_insn_unit = 2;
+    s.info.cap_insn_split = 6;
 #elif defined(__hppa__)
     print_insn = print_insn_hppa;
 #endif
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 625daeedd1..1734ad9c3a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -43,6 +43,7 @@
 #include "sysemu/tcg.h"
 #endif
 #include "fpu/softfloat-helpers.h"
+#include "disas/capstone.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -162,6 +163,9 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->print_insn = print_insn_s390;
+    info->cap_arch = CS_ARCH_SYSZ;
+    info->cap_insn_unit = 2;
+    info->cap_insn_split = 6;
 }
 
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.20.1


