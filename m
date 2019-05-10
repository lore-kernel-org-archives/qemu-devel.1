Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69E2C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C55217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yiA54U+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C55217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49309 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPBld-0005Jv-QM
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:05:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhk-0002SC-K8
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhi-0002VD-1f
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hPBhd-0002Nq-Se
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id 198so8678939wme.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=L07Ir53L/bT8njmxfGpI+tM70yQ090QH+043WWisSwk=;
	b=yiA54U+S+deHa7/+IrX/xbPFaaFsVstt4MONTKcHtTlEUI+jTcaxnaciQhmVzjAQBd
	2vMSBBNfDBwnRTAJ19a7VSjtO7P5qPLTB3ZwQM9/iOXieupLWAmQskv531zOHUL0FGkh
	3nSNhiZ3uGpOZ9KoPYdWofwefBeG6c2IC0uzLuvxUICxL+ictPrzZ7Au3ht+kRQrMnMB
	xS2R/1rOZqMs9Q1n4KylHehc0xJqrP5PDOtNmZG3DvWkNFGuIDLmNT0uQWAG3t/Bduh5
	OfMmivzZ4o/njMsQi7jg8E7MdCkakfiBU9VOkI9+47EEEQue7qdVG+OfOXZ+Zx8PT2oF
	xH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=L07Ir53L/bT8njmxfGpI+tM70yQ090QH+043WWisSwk=;
	b=GOzCXlrPoHuWgxB2AH0z2I+GP1wqkJ5OH39Lt8wUJif3q9Dy94yWaR/ES7Q99LIUY1
	0nG2UdgWXHNblnrleelJxvg3YBadg2+Gqs80oGrcyfUIKXYWeK+/zFbCH9nx30SbReo/
	1bxlAUigGPz5t8xrF+1m78eYTUi2l/nSS5AGoyCl9IIeCmLCZarAVKdKAByU1xuXhIT+
	tIF+uhQ1bibKUz0M9NWNnnBj620vU2MMc3FzK7qaRgEWWz+c2CuC/6f37FzVuf21De82
	T/yyC1c0zoamk8Oa5j6vLJcXteF2UL450HO8ieSr/jqyxARBxNlmNleBaagWK9RsW0hi
	Eezg==
X-Gm-Message-State: APjAAAVnHrZTbjn3suZODbYqSk0J4rX+gtM9hIPkBjF81zgxN89BlyUv
	lXILbSXvW+SCCEi3/iNt/HhRLw==
X-Google-Smtp-Source: APXvYqyLAbyiYYDv4OWgAYRGYPJVfhh0GMQMOEeMlhjCFy7K9ZC7wuWF4BuGuR1fIuqzuvULK8W2Ww==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr7950555wmc.43.1557518463971;
	Fri, 10 May 2019 13:01:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b12sm12868352wrf.21.2019.05.10.13.01.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 13:01:03 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 181471FF90;
	Fri, 10 May 2019 21:01:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 10 May 2019 21:00:59 +0100
Message-Id: <20190510200101.31096-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510200101.31096-1-alex.bennee@linaro.org>
References: <20190510200101.31096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 3/5] cputlb: Drop attribute flatten
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

Going to approach this problem via __attribute__((always_inline))
instead, but full conversion will take several steps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 9c04eb1687c..ccbb47d8d1c 100644
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


