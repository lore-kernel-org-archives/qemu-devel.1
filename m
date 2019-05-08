Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1586FC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08A1205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBNKN6cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08A1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56732 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAUD-0003BO-1v
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:31:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7T-0007vK-7X
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7S-0007xu-7n
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:35 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA7S-0007sm-0m
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:34 -0400
Received: by mail-pf1-x444.google.com with SMTP id n19so943572pfa.1
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Q3wfC3JXPXSD4aTLa6MLu/8aD8LgGGgdxJG1bAJepYk=;
	b=UBNKN6cd4oN4dhW9dnrZOQyIPXrOHDNF6JieL01oBbc6yLb/HJgcqiWnmE75G333eC
	+AJt9XWUyeyEnWRos1xpBGY+iYZYic+foPztastGro8PbcqnB+yZhoawtblTTPOyxpWL
	+6B48bqJ7AXgmUpvSeGK6dM41Do2GH36294f/IqgB6SUNk8pZ580XE2XZDHsFg9c3Wxo
	4Z3RabTu4Zfyc1MBOHAEGjlhT+P0oLhk/uTzgjLUEFj4Z/E8aEN+sURFt8tCVt3wvllt
	naGcED2fpd1vBqQM6zkx6EKfiEUziRCGu+ku5Rg/KfuX6V5RjomJUlkwOtlWqOG8d5YF
	01bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Q3wfC3JXPXSD4aTLa6MLu/8aD8LgGGgdxJG1bAJepYk=;
	b=ifSpdC9dB32fg9ddqn8kP1gtOsiwcOFUmzT68FmNnaUt7KFD2+7Sjxn1TInV2KApf/
	PskUx/F2N4SzcHn3xqFZT+CCfP6mf5Qi8w1McNDqcrXBlKEes1csXy3Vw90n570IJ3dO
	U4BnAmpXlALCNbAhSu210meJsu4U5C3pMje/kRoSDfRqgejJQRzAkqM88AsPsWGKoQub
	E/kT4DcoMNIRHQEoMSyx4tQbKoz5yM5O6/wlUsxXEJPelFMMp240KqaaoqF4heZAOR0Q
	OZuPxOo9P2qwzwhTm/wFugo0XY8dOj5NVu0QzEbQ2jCYv6VojWeZ1Zf3GaIZq5N9rcCd
	7lYQ==
X-Gm-Message-State: APjAAAX0UNy2qJvP12MWZr+09sWWs6aSS5cxbMPGhx3IrxREXdz5VK6s
	oMJtjQgODkPk9tgYkVWBEYb6mLFgBXQ=
X-Google-Smtp-Source: APXvYqz3eOeegyWioHu8FUbJDUpbpJf8N5HJ858Oo+g8k75d0/CO0gRiWNZnbgbdII2UFd038yXB3w==
X-Received: by 2002:a63:e602:: with SMTP id g2mr2858086pgh.172.1557274051785; 
	Tue, 07 May 2019 17:07:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:39 -0700
Message-Id: <20190508000641.19090-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 37/39] tcg/aarch64: Use LDP to load tlb
 mask+table
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This changes the code generation for the tlb from e.g.

	ldur     x0, [x19, #0xffffffffffffffe0]
	ldur     x1, [x19, #0xffffffffffffffe8]
	and      x0, x0, x20, lsr #8
	add      x1, x1, x0
	ldr      x0, [x1]
	ldr      x1, [x1, #0x18]

to

	ldp      x0, x1, [x19, #-0x20]
	and      x0, x0, x20, lsr #8
	add      x1, x1, x0
	ldr      x0, [x1]
	ldr      x1, [x1, #0x18]

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Add QEMU_BUILD_BUG_ON for mask/table ordering; comment fixes.
---
 tcg/aarch64/tcg-target.inc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index afac018301..2863a371a0 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1459,6 +1459,10 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -512);
 
+/* These offsets are built into the LDP below.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
+QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
+
 /* Load and compare a TLB entry, emitting the conditional jump to the
    slow path for the failure case, which will be patched later when finalizing
    the slow path. Generated code returns the host addend in X1,
@@ -1467,23 +1471,20 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
                              tcg_insn_unit **label_ptr, int mem_index,
                              bool is_read)
 {
-    int fast_ofs = TLB_MASK_TABLE_OFS(mem_index);
-    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
-    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
     unsigned a_bits = get_alignment_bits(opc);
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_mask = (1u << a_bits) - 1;
     unsigned s_mask = (1u << s_bits) - 1;
-    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0, x3;
+    TCGReg x3;
     TCGType mask_type;
     uint64_t compare_mask;
 
     mask_type = (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
-    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    tcg_out_ld(s, mask_type, TCG_REG_X0, mask_base, mask_ofs);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, table_base, table_ofs);
+    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {x0,x1}.  */
+    tcg_out_insn(s, 3314, LDP, TCG_REG_X0, TCG_REG_X1, TCG_AREG0,
+                 TLB_MASK_TABLE_OFS(mem_index), 1, 0);
 
     /* Extract the TLB index from the address into X0.  */
     tcg_out_insn(s, 3502S, AND_LSR, mask_type == TCG_TYPE_I64,
-- 
2.17.1


