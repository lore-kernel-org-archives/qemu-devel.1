Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E82C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817822075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfatdokm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817822075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGRg-0000iu-Np
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:54:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG94-0001hs-Te
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG93-00050s-G1
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:58 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG91-0004rm-Gk
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:57 -0400
Received: by mail-ot1-x344.google.com with SMTP id p4so4024739oti.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Iz2EvZFIABjNbnkyC3UNjG2s6yNlDWo5TqN7+5GSNOs=;
	b=dfatdokm9TB3x/9etBxCYS6//ddPBSOkTFuV2/9BVeEkCwIt96RYqU7eeFPpRKewOu
	h6JP1Vko+6UiBUDHtwlFesVK9X2zknjqagphNdZZugDkxkk+39TNs3sJ2VPRT4hvBoFP
	7Z2YvCeFj6ACEqeI588CI5UkfN0ZGnB0wmUl3mG5wOvde/CMSneDhA50kHq/BKFWwNWK
	vLB+4TqjRYDpuC+xR2xdudiuzDwqnbaDVlIhKNllUKhw785FJcHQa+MZLOtrV8HGcZLF
	42wYOth1CIv0QBxPU4FHMeo2PMIvk7wWYE5qwLG80BTPj9XgUk63cZK1lTsEs/B8E40M
	WbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Iz2EvZFIABjNbnkyC3UNjG2s6yNlDWo5TqN7+5GSNOs=;
	b=KLs3t4GbDiA6+OxFe9z4HwFF/2QgnR89+w9Jf5Aup4p77DpOQOPDJuUhua624zXsI4
	BrFVJck2XZF0Ahsq2pPq5WS/ephkEMre7fVHdlbMl8RLVJvzlK8twB807HdOry8q6HF/
	Dtm/+9D3TEe8TKEDdrWcUFX4uvWk7EI1jDHJnfrfeS80T53z2uwgmp70WIOoYOljR2AP
	fZhfSmytz1Z0L0f5JY8rwkU7a+Zdm3xZmgOZhXu03HW+ovgwWmW69GCy2UglvfNDXtuK
	Yp/cZvnvcw+nQq16mgwbFdax8YrN9lVXYsvvukdiQvDouCzES3yn46q7rI8EEiphMeb7
	UJMw==
X-Gm-Message-State: APjAAAWNheJD2zh8DTmWqby0cRwYIm6oaEFjWXz/+7j6jkTlD2lsb47J
	HH7uAg6+przlDorrxATmmudJzr03a3kDsQ==
X-Google-Smtp-Source: APXvYqyB0YpJ2C8PZ8V0sNKEt5ZT9nlp4MoAIN3spUVYvevF8tvFHEUv5Zq4cGo2w4nlud6nD2NgAg==
X-Received: by 2002:a05:6830:1050:: with SMTP id
	b16mr1746988otp.228.1559680491501; 
	Tue, 04 Jun 2019 13:34:51 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.50
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:49 -0500
Message-Id: <20190604203351.27778-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [PATCH v4 37/39] tcg/aarch64: Use LDP to load tlb
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Add QEMU_BUILD_BUG_ON for mask/table ordering; comment fixes.
---
 tcg/aarch64/tcg-target.inc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 57c297f9d7..b0f8106642 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1641,6 +1641,10 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -512);
 
+/* These offsets are built into the LDP below.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
+QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
+
 /* Load and compare a TLB entry, emitting the conditional jump to the
    slow path for the failure case, which will be patched later when finalizing
    the slow path. Generated code returns the host addend in X1,
@@ -1649,23 +1653,20 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
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


