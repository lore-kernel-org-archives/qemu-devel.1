Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C31C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82792070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="smX5M6Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82792070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2cd-0007ur-Hz
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Jg-0005ku-Eb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Je-0004Oo-TX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:32 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:43710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Je-0004O5-NW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:30 -0500
Received: by mail-pg1-x52a.google.com with SMTP id k197so858875pga.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D8hKczSKbWr4VDH3O7NTZ9vbM3X/bEg8unP2mqvKXWg=;
 b=smX5M6UyI1U/KS9LnQSYel/Gtajfol9WNGjMy2NXUcT8FXOkKHAhel5GiDCI8HhtIu
 TtlbV9Pb8ZE5Rst5Y38UMhRbmSHDcbYdKkM5stgFUqSPYi47BnrmHumpeACpBQk1GQPX
 HDWw9qW0hpkwGR338B4lCy4KlXoyoRToOy60joMBZRPuuZ+2SeXGKoP+5oKp4iUx4jIz
 TMi/hYIn/hgt1NdMIXKCqsa3o/N1A0/T1jzGNPqbx2VjnEK6PMfX0hBtPPuaeyjpo8Ps
 BHjTA6ek/CvLVIS1IkDwsWtj7Ov8c+a7VIfXVptFfteSqQ2dKFxSSDa4zA0HkzvMzF4Y
 xP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D8hKczSKbWr4VDH3O7NTZ9vbM3X/bEg8unP2mqvKXWg=;
 b=gFaBRMNEtHlG6tbUIUDKUXiprB7W9/V1dZIxzKO8ZuAGHN/M6Z0cgfe5uaQixfBRb3
 05PVlnZHtZ6GU5u6wbTYUq8CH3SQd1tQPQSE0FSZvUDCCQrNXn/Hr01hNjaXywrqN1eC
 3YPa667NujUrr3cEeg3tBKxAeB3fmdlN4GptsuM/i6GsGJBaavxNDxxQA0DWCMhoIc2m
 pz1/etSea9dgPTz/n3y/y7EB8Dzp62qIa8V4HynQOsAoYnORl7+saRe+LApc2Ik/ZPgS
 ipoth+zmUFFIwrO0fJnr7MbQDxngmec08HFgFWVa8zoTSJVA3xTm6hwj/xUNjQOPYHSX
 JaLg==
X-Gm-Message-State: APjAAAXcde1Jo5zD8L9F7uZK/k2AvFBg/+xHmFAqWJF97uq/MaLC9JIO
 OtBsajB72unZBk/3XDhU0Bl9ZNDKpv/onw==
X-Google-Smtp-Source: APXvYqyIfoStfxH3fFQXeVDw9uFcxlOtstgeRfM5TwubMtrbDohHLY5Qk1sNaU1EHkpt8S8u0lPNgg==
X-Received: by 2002:a63:1e47:: with SMTP id p7mr3006810pgm.339.1578455249366; 
 Tue, 07 Jan 2020 19:47:29 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:47:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/41] tcg: Search includes in the parent source directory
Date: Wed,  8 Jan 2020 14:45:20 +1100
Message-Id: <20200108034523.17349-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
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
Cc: peter.maydell@linaro.org, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

All the *.inc.c files included by tcg/$TARGET/tcg-target.inc.c
are in tcg/, their parent directory. To simplify the preprocessor
search path, include the relative parent path: '..'.

Patch created mechanically by running:

  $ for x in tcg-pool.inc.c tcg-ldst.inc.c; do \
    sed -i "s,#include \"$x\",#include \"../$x\"," \
      $(git grep -l "#include \"$x\""); \
    done

Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc parts)
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200101112303.20724-3-philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 4 ++--
 tcg/arm/tcg-target.inc.c     | 4 ++--
 tcg/i386/tcg-target.inc.c    | 4 ++--
 tcg/mips/tcg-target.inc.c    | 2 +-
 tcg/ppc/tcg-target.inc.c     | 4 ++--
 tcg/riscv/tcg-target.inc.c   | 4 ++--
 tcg/s390/tcg-target.inc.c    | 4 ++--
 tcg/sparc/tcg-target.inc.c   | 2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 3f921015d3..843fd0ca69 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -10,7 +10,7 @@
  * See the COPYING file in the top-level directory for details.
  */
 
-#include "tcg-pool.inc.c"
+#include "../tcg-pool.inc.c"
 #include "qemu/bitops.h"
 
 /* We're going to re-use TCGType in setting of the SF bit, which controls
@@ -1541,7 +1541,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
 }
 
 #ifdef CONFIG_SOFTMMU
-#include "tcg-ldst.inc.c"
+#include "../tcg-ldst.inc.c"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     TCGMemOpIdx oi, uintptr_t ra)
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 94d80d79d1..fffb6611e2 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -23,7 +23,7 @@
  */
 
 #include "elf.h"
-#include "tcg-pool.inc.c"
+#include "../tcg-pool.inc.c"
 
 int arm_arch = __ARM_ARCH;
 
@@ -1131,7 +1131,7 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
 }
 
 #ifdef CONFIG_SOFTMMU
-#include "tcg-ldst.inc.c"
+#include "../tcg-ldst.inc.c"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     int mmu_idx, uintptr_t ra)
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 9d8ed974e0..cdedcb2b25 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 
-#include "tcg-pool.inc.c"
+#include "../tcg-pool.inc.c"
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
@@ -1647,7 +1647,7 @@ static void tcg_out_nopn(TCGContext *s, int n)
 }
 
 #if defined(CONFIG_SOFTMMU)
-#include "tcg-ldst.inc.c"
+#include "../tcg-ldst.inc.c"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     int mmu_idx, uintptr_t ra)
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 5442167045..1da663ce84 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1107,7 +1107,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
 }
 
 #if defined(CONFIG_SOFTMMU)
-#include "tcg-ldst.inc.c"
+#include "../tcg-ldst.inc.c"
 
 static void * const qemu_ld_helpers[16] = {
     [MO_UB]   = helper_ret_ldub_mmu,
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index d308d69aba..ee1f9227c1 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -23,7 +23,7 @@
  */
 
 #include "elf.h"
-#include "tcg-pool.inc.c"
+#include "../tcg-pool.inc.c"
 
 #if defined _CALL_DARWIN || defined __APPLE__
 #define TCG_TARGET_CALL_DARWIN
@@ -1845,7 +1845,7 @@ static const uint32_t qemu_exts_opc[4] = {
 };
 
 #if defined (CONFIG_SOFTMMU)
-#include "tcg-ldst.inc.c"
+#include "../tcg-ldst.inc.c"
 
 /* helper signature: helper_ld_mmu(CPUState *env, target_ulong addr,
  *                                 int mmu_idx, uintptr_t ra)
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 7018509693..2bc0ba71f2 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -27,7 +27,7 @@
  * THE SOFTWARE.
  */
 
-#include "tcg-pool.inc.c"
+#include "../tcg-pool.inc.c"
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
@@ -921,7 +921,7 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
  */
 
 #if defined(CONFIG_SOFTMMU)
-#include "tcg-ldst.inc.c"
+#include "../tcg-ldst.inc.c"
 
 /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
  *                                     TCGMemOpIdx oi, uintptr_t ra)
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 8aaa4cebe8..b07e9ff7d6 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -29,7 +29,7 @@
 #error "unsupported code generation mode"
 #endif
 
-#include "tcg-pool.inc.c"
+#include "../tcg-pool.inc.c"
 #include "elf.h"
 
 /* ??? The translation blocks produced by TCG are generally small enough to
@@ -1536,7 +1536,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg data,
 }
 
 #if defined(CONFIG_SOFTMMU)
-#include "tcg-ldst.inc.c"
+#include "../tcg-ldst.inc.c"
 
 /* We're expecting to use a 20-bit negative offset on the tlb memory ops.  */
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index d7986cda5c..65fddb310d 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 
-#include "tcg-pool.inc.c"
+#include "../tcg-pool.inc.c"
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
-- 
2.20.1


