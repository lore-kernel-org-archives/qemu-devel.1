Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9DCC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A7E217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCSzlH+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A7E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49293 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPBjT-0003QC-6j
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:03:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhk-0002SD-KA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhi-0002V3-1a
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:16 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hPBhd-0002Ou-Pq
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id d12so9113947wrm.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=gaTltrKsl46/gR/ETi1cLz0ePXsyiO5Cm5Dxu2eiLII=;
	b=jCSzlH+wv2zlswKIDzjD5mxxuES3EnsN973gmFG9dzQcZWPZzIWAvf65BWmqWzH27r
	4Ldhnc2C79kFep+3XKb3Jjfv2+svwKGFvNImIp4t1/E723DCwF2As9B4RLV0MLNiVbuN
	nC7RBMmgmevxbdz9uPqeNDWxZY5GR/j2W3xUF4V/A0jdUIq2iJfbgLxFNHfiLCGxqBaG
	EwcXp/x+mqfeUocnurbOcrrt3Prh1nhdx7W62KP9P8X2FiTiRgVlaA2kEOrIzqcvyFAt
	TlVq/rGAj902lh5sUbdH+FGr8CtfK5pdkDFn0YGgrYdazybPDDHfwopAw1/kdPSWkdk7
	kLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gaTltrKsl46/gR/ETi1cLz0ePXsyiO5Cm5Dxu2eiLII=;
	b=gT2uf4etZBOSlukKKWUX3/muFJuMeskBnomuDc+tBbo7qJbdQpYYKEIASl2Sdtg+aE
	WigC1WRVBCK1kk8gjit5an59HJzwO3IjzEBOb0F95w/DMt+uovff6ClpP8WO0WM2FOyz
	SdHXmV7UfDb9o1pwNIzf5ra7eRTEkMQS4GzItpfN0oXpf7Fm7VmwwxH8xRtp1zmKcGmD
	o1Qmb6SVejnRutWKJvWidOWfJUX5MaWxgZvpifqWXENNynbykCytOTCRKg+PzcvdH9rY
	EFLF4gz7UJPUGffSlUBNeSoWWvQum0wh++HZVNEbWAqUvMcqbzdPr91+V9qISYFlyoOh
	t95g==
X-Gm-Message-State: APjAAAU6v77/+/BHaUK2rccRPnMmFOo3fcwtEdgh2xR+DTQXmveM6xfa
	5cFBEj4p35r5G/0GTk6xCM7G7g==
X-Google-Smtp-Source: APXvYqyvAdsGAsoP4PiNbW74Y8Fw7L9ElkNahYvfYIu6unghhTSFN3d0FlC3jkgknSyFLVqf7LgO2g==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr9519576wru.142.1557518465502; 
	Fri, 10 May 2019 13:01:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	l16sm4980963wrb.40.2019.05.10.13.01.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 13:01:03 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2DC311FF91;
	Fri, 10 May 2019 21:01:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 10 May 2019 21:01:00 +0100
Message-Id: <20190510200101.31096-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510200101.31096-1-alex.bennee@linaro.org>
References: <20190510200101.31096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 4/5] cputlb: Do unaligned load recursion to
 outermost function
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

If we attempt to recurse from load_helper back to load_helper,
even via intermediary, we do not get all of the constants
expanded away as desired.

But if we recurse back to the original helper (or a shim that
has a consistent function signature), the operands are folded
away as desired.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ccbb47d8d1c..e4d0c943011 100644
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


