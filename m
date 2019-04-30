Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3336C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3B12075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQcQoJhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3B12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLW7v-0000X1-Hf
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:01:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW29-000491-1N
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzo-0000o9-Pw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzo-0000mL-Ey
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id y197so4621897wmd.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=KPUoL/ay0e2SJqohczUkcHocY2V7awtfIEMnqwffsYQ=;
	b=gQcQoJhyaHYBerW5yXbcE7IAZnl2E5lWGZYmzPTpwtMjT5fu7OO6dA/YpLayJhTv6a
	pifS8QtX3QTNPpQEh3x4wzKyk75GxjGPKfXZ8paXrUNcsT8a6OQACLINd30pGsKjmjjv
	FCmZC0/hZJC9wfI7ZgVwf3K4faqlrmUCbtxFAikiZon4vgVTfKFN6MgtBDAGNSX7tmNr
	YJH/MlJiLErwKZwElpicNpMF2ZhAKsXjBKcBW/DKbNEPK6KOqZVDVV4c4dMpt1Zj7/0K
	bAKd7A1yET5oJC2wXf/5wCvW6BQ89f2ESrhgP7kBK1HYzd2jSv8xk/t2pe4m5RAchZhE
	xmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=KPUoL/ay0e2SJqohczUkcHocY2V7awtfIEMnqwffsYQ=;
	b=QYEq2L2IHdmAMiiIibK8Dzhbv4wrfr2a8ppfVuEPLN5P4RiI48FiFhrzYh9dGwaFqa
	/AL/T0YdUYKsZ93u/uzM2Aia16zfryMZTp5D7DDDZye0t1/EZnTAq8urEnsBenJEgNVF
	UmQs9EJBQuQotokSWGcwmCwPyinbwBR4PojLkcZEuuIoRJgwBtin8UZQEoj6YPN8tLJR
	GhHKtZw7ia4inKTgeiWsWKuzfll4NCgl0chV81i8gwdKS8xZGMI5h0s2j3IOpFBHYTeK
	F8lrfVPplW63Jc2Q1uMk/Ft4+2IuwRkGt2y+09NRx5X3ojJZ/zHYeviZGQtzC6xgb9C4
	bPIw==
X-Gm-Message-State: APjAAAUBwHAKgjW2yPbBE+Xpy5xHXyuS+HmGSg9SRtndOLgtdbGcDRFv
	v5vZdk3lAkNqa1M9fqd9/sD52w==
X-Google-Smtp-Source: APXvYqxwlYOcHpT+iOsdnMzr8w4D6lnnpj6uxNqtpY3KiPwKdkWayO+7xWdWiZTtECaTZMe6cqcKAw==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr4002978wmh.74.1556643163427; 
	Tue, 30 Apr 2019 09:52:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	x84sm3879195wmg.13.2019.04.30.09.52.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:52:38 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 0F7DC1FF9B;
	Tue, 30 Apr 2019 17:52:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:30 +0100
Message-Id: <20190430165234.32272-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v5 11/15] cputlb: Do unaligned load recursion
 to outermost function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165230.Yz4JMIklFMX38kF2_hBet3E0QIxsXDvQQ2NhD2UOzB8@z>

From: Richard Henderson <richard.henderson@linaro.org>

If we attempt to recurse from load_helper back to load_helper,
even via intermediary, we do not get all of the constants
expanded away as desired.

But if we recurse back to the original helper (or a shim that
has a consistent function signature), the operands are folded
away as desired.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 117 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 97 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ccbb47d8d1..e4d0c94301 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1157,10 +1157,13 @@ static inline uint64_t handle_bswap(uint64_t val, int size, bool big_endian)
  * is disassembled. It shouldn't be called directly by guest code.
  */
 
-static uint64_t load_helper(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr,
-                            size_t size, bool big_endian,
-                            bool code_read)
+typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
+                                TCGMemOpIdx oi, uintptr_t retaddr);
+
+static inline uint64_t __attribute__((always_inline))
+load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+            uintptr_t retaddr, size_t size, bool big_endian, bool code_read,
+            FullLoadHelper *full_load)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1233,8 +1236,8 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
     do_unaligned_access:
         addr1 = addr & ~(size - 1);
         addr2 = addr1 + size;
-        r1 = load_helper(env, addr1, oi, retaddr, size, big_endian, code_read);
-        r2 = load_helper(env, addr2, oi, retaddr, size, big_endian, code_read);
+        r1 = full_load(env, addr1, oi, retaddr);
+        r2 = full_load(env, addr2, oi, retaddr);
         shift = (addr & (size - 1)) * 8;
 
         if (big_endian) {
@@ -1291,46 +1294,83 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
  * We don't bother with this widened value for SOFTMMU_CODE_ACCESS.
  */
 
+static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
+                              TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 1, false, false,
+                       full_ldub_mmu);
+}
+
 tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
                                      TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 1, false, false);
+    return full_ldub_mmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_le_lduw_mmu(CPUArchState *env, target_ulong addr,
+                                 TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, false, false,
+                       full_le_lduw_mmu);
 }
 
 tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
                                     TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, false, false);
+    return full_le_lduw_mmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_be_lduw_mmu(CPUArchState *env, target_ulong addr,
+                                 TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, true, false,
+                       full_be_lduw_mmu);
 }
 
 tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
                                     TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, true, false);
+    return full_be_lduw_mmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_le_ldul_mmu(CPUArchState *env, target_ulong addr,
+                                 TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, false, false,
+                       full_le_ldul_mmu);
 }
 
 tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
                                     TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, false, false);
+    return full_le_ldul_mmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_be_ldul_mmu(CPUArchState *env, target_ulong addr,
+                                 TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, true, false,
+                       full_be_ldul_mmu);
 }
 
 tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
                                     TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, true, false);
+    return full_be_ldul_mmu(env, addr, oi, retaddr);
 }
 
 uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, false, false);
+    return load_helper(env, addr, oi, retaddr, 8, false, false,
+                       helper_le_ldq_mmu);
 }
 
 uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, true, false);
+    return load_helper(env, addr, oi, retaddr, 8, true, false,
+                       helper_be_ldq_mmu);
 }
 
 /*
@@ -1613,44 +1653,81 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 
 /* Code access functions.  */
 
+static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
+                               TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 1, false, true,
+                       full_ldub_cmmu);
+}
+
 uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 1, false, true);
+    return full_ldub_cmmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
+                                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, false, true,
+                       full_le_lduw_cmmu);
 }
 
 uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, false, true);
+    return full_le_lduw_cmmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
+                                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, true, true,
+                       full_be_lduw_cmmu);
 }
 
 uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, true, true);
+    return full_be_lduw_cmmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
+                                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, false, true,
+                       full_le_ldul_cmmu);
 }
 
 uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, false, true);
+    return full_le_ldul_cmmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
+                                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, true, true,
+                       full_be_ldul_cmmu);
 }
 
 uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, true, true);
+    return full_be_ldul_cmmu(env, addr, oi, retaddr);
 }
 
 uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, false, true);
+    return load_helper(env, addr, oi, retaddr, 8, false, true,
+                       helper_le_ldq_cmmu);
 }
 
 uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, true, true);
+    return load_helper(env, addr, oi, retaddr, 8, true, true,
+                       helper_be_ldq_cmmu);
 }
-- 
2.20.1


