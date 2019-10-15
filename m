Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BE6C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DCE20650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jE0orpGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DCE20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKRD0-0007p4-P3
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 14:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKQyy-0004x0-Ss
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKQyx-0003Qs-Ow
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:51:40 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKQyx-0003Pl-JL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:51:39 -0400
Received: by mail-pl1-x641.google.com with SMTP id t10so9936531plr.8
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=JPcXbUefVYp1/DZorpkAXAFcmm1X6SF54kxYkRBFIog=;
 b=jE0orpGFix6/Su5bS8NmnWMrRSuZHytmrxj+wzSa7qmgsoAmjutVGhK/6TUvJcAPu6
 GVGF30gwVg/sk3zPasO9WkUNlE/H0hvgsO/2OfCiVmXtfloUX+6Npr75yxO19YY6vgIV
 ZHo++387ZEeNPW2SEJ6AKFfA7d+EDDsCjTNeFdyQMaZS7E0M++8+Mm9KFTYFDnZIhEs4
 R2Hyx2cXdRiLqv6lPtei3/Xczq/NZIMYxM6N81UGuUKIL/i0DZGxjk9xQNv+L8GUeIWF
 yINR8dakDUa4I4ZKuwkDcg7V/2HAPTOzFU2aUHd1UNBqmt49koxLeMjs2qomDge3FxP+
 Zuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=JPcXbUefVYp1/DZorpkAXAFcmm1X6SF54kxYkRBFIog=;
 b=cWjBs+EFhSB/IrYTG7O8tR7HhHZg7k4xqnCnr0JAHC5xK72sOGo5RWnRglxs++RXsv
 Y3M6cXfWSP2qb5uJfXQ7OZCbKdqa1JIeg0/Kq3OjrEbDr1FNCG5BjhCrzDugtOSBb35Y
 dE1c9icHpML8KBNUZ5seaDaPWrxc7Ba2PRpomQiBypUoS3ArefxOSDd23Z9LLy6iqv5f
 8uYY71hN8USscYxWNgU/CRzHpckq1dT2kge77MesEVfWXJtRHEcervlkKw0izgGiDA5V
 wFzPfYXUK+vSHpMJJVfJzcQ82UYxDZY3CFaAEm0o0sV68qMeSH439f0wcZRpixgm1vUz
 FoVA==
X-Gm-Message-State: APjAAAV5eN01hvC8CIlAJ0CQknQv1ARlRdigVxhMhN1/kSVobHRVxKdS
 mqH0OreHI6bXTFfZIk60GoPt2jzo4I4=
X-Google-Smtp-Source: APXvYqyICd6CxgMYVAJwLi5ymD5diOSeJKovIa+1hGqfWXSS2vZ/MHLuX5aJcuqxDcac0nQG06rHlA==
X-Received: by 2002:a17:902:7e4e:: with SMTP id
 a14mr37242068pln.68.1571161898200; 
 Tue, 15 Oct 2019 10:51:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t68sm20867845pgt.61.2019.10.15.10.51.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 10:51:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] capstone: Enable disassembly for s390x
Date: Tue, 15 Oct 2019 10:51:32 -0700
Message-Id: <20191015175133.16598-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015175133.16598-1-richard.henderson@linaro.org>
References: <20191015175133.16598-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
index 8ce48e0342..97e34be162 100644
--- a/Makefile
+++ b/Makefile
@@ -503,6 +503,7 @@ CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
 CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
+CAP_CFLAGS += -DCAPSTONE_HAS_SYSZ
 CAP_CFLAGS += -DCAPSTONE_HAS_X86
 
 .PHONY: capstone/all
diff --git a/disas.c b/disas.c
index 3e2bfa572b..51c71534a3 100644
--- a/disas.c
+++ b/disas.c
@@ -550,6 +550,9 @@ void disas(FILE *out, void *code, unsigned long size)
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
index 3abe7e80fd..44f40f1f8c 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -43,6 +43,7 @@
 #include "sysemu/tcg.h"
 #endif
 #include "fpu/softfloat-helpers.h"
+#include "disas/capstone.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -180,6 +181,9 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->print_insn = print_insn_s390;
+    info->cap_arch = CS_ARCH_SYSZ;
+    info->cap_insn_unit = 2;
+    info->cap_insn_split = 6;
 }
 
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1


