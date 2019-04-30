Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73EAC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2C120644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIEKJpeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2C120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50349 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWDt-0005qg-PZ
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:07:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2D-0004E1-1Y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzn-0000lZ-6l
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzm-0000jB-U6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id n25so4588770wmk.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=kdE7tNIM4QnjfnkeRvliaIVYu9qjQMZSsX2l5cVNhzA=;
	b=MIEKJpeqt5iqFFaTIwHpFL8HJG5ogtmg+0stp5A/llvBLYwzcIlLZt5RbAo2EpaxRB
	l8Kym/Oo2pfbohBxChDuwowl4RcBLeGLVXo6ryc9HKwAMie0UOC/aWiyaTuZbGiLucqI
	+hp+vFuk9STdQnDqrtrVuJXbzSXjHsn6fyemupoUKrs3CrGivggcCS8JdRhvALgS32y6
	qYmUX4VU+en6BJIBNY6vzPvky+c3JG1D16yYDJuXhuMHQdFx7CIpHlEf84JAg7v3LCDz
	Ajvie1JTMH3+EFVtUtXDyRKDPVKbud0Maby85ObujncHzmTr4nu40VhApjhh0nl1eQlr
	4apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kdE7tNIM4QnjfnkeRvliaIVYu9qjQMZSsX2l5cVNhzA=;
	b=aQoDQrVLwZsiAon0kJpydOIDIor7Dcw9f0bVQik7neXomZ8Mvk1cLa8F13cMpUJJVO
	Os4IBIWSky3sbca6MXCCYAEhQJqyiCdl1Am6pl47op6LaW8jC0Hs9cozgLz/EdaMFU2E
	m3i8/MPuVG9sPW5Tln61m07kwirTiLmxtWjOFGieci3AwHT0yPYZoYm9R9mNcKOVSA45
	89pxm4SzoKj45O8aEeFi69SLCGKm+GOiVL3j0lts4X5lvROnD417fmj08y1AuvqrgXPG
	AUcmTLmE3bI1j2FlsxZ9kUFqsJfpBCStufga9E+wUgohmpD4zVav7y0mNBY0L3wUZ5GE
	AfOQ==
X-Gm-Message-State: APjAAAU+i0XU5NxBOVvkPVfYkYhqGqDd/y7IExQgtRfi+5taLFIdR6vI
	M/Aq/HNit09s//6pssLuINqKhg==
X-Google-Smtp-Source: APXvYqxQ8+cXHNWhJvGtgniY1Tqfhd2qKZe6dBqmtG/ucRo8bnU4Oz1qkqyYmvCVePTpsMqk8fOoeQ==
X-Received: by 2002:a1c:2986:: with SMTP id p128mr3834970wmp.134.1556643161811;
	Tue, 30 Apr 2019 09:52:41 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	n2sm13158964wra.89.2019.04.30.09.52.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:52:37 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 03BF81FF9A;
	Tue, 30 Apr 2019 17:52:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:29 +0100
Message-Id: <20190430165234.32272-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PATCH  v5 10/15] cputlb: Drop attribute flatten
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
Message-ID: <20190430165229.FecKEOTZmSFzb7k1G6mAKhateGCVu5V55w3FvaQ23Gc@z>

From: Richard Henderson <richard.henderson@linaro.org>

Going to approach this problem via __attribute__((always_inline))
instead, but full conversion will take several steps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 105 ++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 63 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 9c04eb1687..ccbb47d8d1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1291,51 +1291,44 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
  * We don't bother with this widened value for SOFTMMU_CODE_ACCESS.
  */
 
-tcg_target_ulong __attribute__((flatten))
-helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                    uintptr_t retaddr)
+tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
+                                     TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 1, false, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
-helper_le_lduw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, false, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
-helper_be_lduw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, true, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
-helper_le_ldul_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, false, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
-helper_be_ldul_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, true, false);
 }
 
-uint64_t __attribute__((flatten))
-helper_le_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                  uintptr_t retaddr)
+uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
+                           TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, false, false);
 }
 
-uint64_t __attribute__((flatten))
-helper_be_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                  uintptr_t retaddr)
+uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
+                           TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, true, false);
 }
@@ -1519,51 +1512,44 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     }
 }
 
-void __attribute__((flatten))
-helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
-                   TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
+                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 1, false);
 }
 
-void __attribute__((flatten))
-helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 2, false);
 }
 
-void __attribute__((flatten))
-helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 2, true);
 }
 
-void __attribute__((flatten))
-helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 4, false);
 }
 
-void __attribute__((flatten))
-helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 4, true);
 }
 
-void __attribute__((flatten))
-helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 8, false);
 }
 
-void __attribute__((flatten))
-helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 8, true);
 }
@@ -1627,51 +1613,44 @@ helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 
 /* Code access functions.  */
 
-uint8_t __attribute__((flatten))
-helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                    uintptr_t retaddr)
+uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 1, false, true);
 }
 
-uint16_t __attribute__((flatten))
-helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, false, true);
 }
 
-uint16_t __attribute__((flatten))
-helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, true, true);
 }
 
-uint32_t __attribute__((flatten))
-helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, false, true);
 }
 
-uint32_t __attribute__((flatten))
-helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, true, true);
 }
 
-uint64_t __attribute__((flatten))
-helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, false, true);
 }
 
-uint64_t __attribute__((flatten))
-helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, true, true);
 }
-- 
2.20.1


