Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DCFC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7D52146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U94X5p9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7D52146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKSx-0003b5-Kb
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58027)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hiKLz-0004w8-BY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hiKLv-0007aO-JQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:05:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hiKLt-0007Xd-Oc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:05:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id p11so7038147wro.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cAdcykhsBr9KRoTt+e4UsNPsrOD05Rn6WRA4P8vaXKM=;
 b=U94X5p9dk+Ez+gN8gaKJ1FW8MyToLqAT1fp5T1gw45kWf0e79qSgm16XMo+S6O5dry
 LjMMYcn12U8neQd340btUsXYHC9PTm4X6TLoLwUJekGN3ipEJ3eVNOcxhvdR+/ZWZCWd
 JxjZPEPhsgCNTgYS3PnHUGmlg26dndq4GGutDf5ULJt1l+76ZmYuhZWROzONAvB8wGkq
 VNNJch7k2jL0aRcSjMjWZDDDvbrbsz9zPnW49FJnEXPgePVnQQDGfi3VkHH/GYvfIsYV
 YgCxzdfWKVcHA13cm3xHAhcUvXf26T4dXcpU1j+P1JCw8cgD/omQU622Al8iFFSSBcsi
 JxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cAdcykhsBr9KRoTt+e4UsNPsrOD05Rn6WRA4P8vaXKM=;
 b=KQxNHo+4KDs7zjGDcXGhmMxNMIXVA4K+salYtJAVup/ek4IXLeFWPpNIbhNMkCvUnW
 DrDqbJSlIxm8UxINDCLmqBRm5WG/eWqhGCxNixYcRuVJtAtUP8B+V2GN+uvlytHuSVgm
 BzIsoa01xmkgPmqNkMBUw/QAd8w77tSyuqDK31XX7woOF2IPa6vQem+rgkflh+qPoLrm
 qNvQcdrT+nos4ZaphPvOCpycNMLVQ7+qBjFc8Rcw6N3wrhu48iqyh7CrYQzs5w1KM46v
 LUvaQe4uKVcVxN6LZVUrzAbppWwO1U409sHdLI7fFjB1QnEqHeL9sLReihxdViA2+rJk
 euoA==
X-Gm-Message-State: APjAAAXmOzSTi0o7DY89QVxIYzw6DzKV8gXuhdaKSpdaMkQWm/7rzFJA
 GUwRJlvl3L29bEhLY7M0cDK+CyKyiLkEuw==
X-Google-Smtp-Source: APXvYqxblBOYdntwoovufjWbi9/dYo2YTYOYVAuVVocmDjPaA/Gy32FA75dd3+qJ+pQHwTi9kAVRpw==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr18369095wrh.230.1562079946734; 
 Tue, 02 Jul 2019 08:05:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id w10sm12975657wru.76.2019.07.02.08.05.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 08:05:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:05:41 +0200
Message-Id: <20190702150542.12008-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702150542.12008-1-richard.henderson@linaro.org>
References: <20190702150542.12008-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 2/3] tcg/riscv: Fix RISC-VH host build failure
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Commit 269bd5d8 "cpu: Move the softmmu tlb to CPUNegativeOffsetState'
broke the RISC-V host build as there are two variables that are used but
not defined.

This patch renames the undefined variables mask_off and table_off to the
existing (but unused) mask_ofs and table_ofs variables.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <79729cc88ca509e08b5c4aa0aa8a52847af70c0f.1561039316.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 1f0ae64aae..3e76bf5738 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -980,8 +980,8 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
     int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
     TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
 
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, mask_base, mask_off);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, table_base, table_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, mask_base, mask_ofs);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, table_base, table_ofs);
 
     tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP2, addrl,
                     TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
-- 
2.17.1


