Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D50DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5C221582
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7f+XXn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5C221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4sP-0001dK-G0
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lO-00065A-7b
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:10 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lL-00031O-US
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:09 -0400
Received: by mail-pj1-x1044.google.com with SMTP id fu13so4373403pjb.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HGZf0tXbQcHFuKfgvmWZ0tWTe9fLxbdPJyws4KGoMOc=;
 b=n7f+XXn2kHvntCSApadSf+qDX+3TOPv8Q4jiycazYfBf2CxvbveYstPCYwpbnFiYEL
 IoZlVlB/438HS7Ok1pcMTZcvXqi7XeUfQM1hETPuXpfSHBcuWzxh0ESCiQxH73sx29Ze
 rO1SWx3HIs3P5GNvEIKCAdJ6PmBlH1XYEJylwUtdhJCmr2Twc/OiVIV0WtxExpjZB++V
 G0rlKoWlqdZvR3eW5auy3Zal3BEJxQm9+SX3ZzgyiLCNNcWNAezwgWOZc+K7XOMmMr9L
 QC2RYzsQdRnEvJxi+0B+tx1SqRaC9sW5eiuvVL/7mAi/UpYcQqV6CFn4QPUHkqZ9GVy+
 DJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HGZf0tXbQcHFuKfgvmWZ0tWTe9fLxbdPJyws4KGoMOc=;
 b=XspheDCFPqDeDzC9sn5ckPRdiepk7cT6tvy1eqdEIY/jlfByZMgc1vDdtlNSgTiGos
 staZKPx3T6MgjKTny9mF5YoZwxk+48vHYJ+o5Ds7iKwmnEQvxdbuucAIYcAT1zOjyYZ0
 Q042pdg3E+y1nUVBfonqIAuFYDPyEY/NVvhlEbGnp2pvP/NYX1vj488xIbH7mKe1DD04
 aCbtsVJQDFw1b2Xcwpux7lU7S4Bo/mtRHA0kDW74xYup2iUzQJ4YpnG7+fUKWVvxHO97
 Sy2NYb7UP4ndbYSB61WWDg2XCBF0NoDWRoED8HnO0Ob2UPDyMWSolJQMdpPX7ASOJS4o
 lzXw==
X-Gm-Message-State: AGi0PubB1lacvmrJKFUN7YEfWuWQT2Q8o1FIgnUTBWNB6E/FDwoi7a9L
 221Q/BhdUAuPkJyfRa8TDEqV+LMeAk4=
X-Google-Smtp-Source: APiQypIHXeusDLkNjA271/GUMTtnoqmPIPnPt74ype/3TmD3DpEHHk3XJRCIILoTYuzCUpkRblUscw==
X-Received: by 2002:a17:90a:fe94:: with SMTP id
 co20mr6636639pjb.213.1588951085008; 
 Fri, 08 May 2020 08:18:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm2125933pfb.190.2020.05.08.08.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:18:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/19] tcg/tci: Add special tci_movi_{i32,i64} opcodes
Date: Fri,  8 May 2020 08:17:41 -0700
Message-Id: <20200508151747.6166-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151747.6166-1-richard.henderson@linaro.org>
References: <20200508151747.6166-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The normal movi opcodes are going away.  We need something
for TCI to use internally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 8 ++++++++
 tcg/tci.c                | 4 ++--
 tcg/tci/tcg-target.inc.c | 4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index e3929b80d2..5a941eaa07 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -272,6 +272,14 @@ DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 #include "tcg-target.opc.h"
 #endif
 
+#ifdef TCG_TARGET_INTERPRETER
+/* These opcodes are only for use between the tci generator and interpreter. */
+DEF(tci_movi_i32, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+#if TCG_TARGET_REG_BITS == 64
+DEF(tci_movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
+#endif
+#endif
+
 #undef TLADDR_ARGS
 #undef DATA64_ARGS
 #undef IMPL
diff --git a/tcg/tci.c b/tcg/tci.c
index 46fe9ce63f..a6c1aaf5af 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -576,7 +576,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             t1 = tci_read_r32(regs, &tb_ptr);
             tci_write_reg32(regs, t0, t1);
             break;
-        case INDEX_op_movi_i32:
+        case INDEX_op_tci_movi_i32:
             t0 = *tb_ptr++;
             t1 = tci_read_i32(&tb_ptr);
             tci_write_reg32(regs, t0, t1);
@@ -847,7 +847,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             t1 = tci_read_r64(regs, &tb_ptr);
             tci_write_reg64(regs, t0, t1);
             break;
-        case INDEX_op_movi_i64:
+        case INDEX_op_tci_movi_i64:
             t0 = *tb_ptr++;
             t1 = tci_read_i64(&tb_ptr);
             tci_write_reg64(regs, t0, t1);
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 992d50cb1e..1f1639df0d 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -530,13 +530,13 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     uint8_t *old_code_ptr = s->code_ptr;
     uint32_t arg32 = arg;
     if (type == TCG_TYPE_I32 || arg == arg32) {
-        tcg_out_op_t(s, INDEX_op_movi_i32);
+        tcg_out_op_t(s, INDEX_op_tci_movi_i32);
         tcg_out_r(s, t0);
         tcg_out32(s, arg32);
     } else {
         tcg_debug_assert(type == TCG_TYPE_I64);
 #if TCG_TARGET_REG_BITS == 64
-        tcg_out_op_t(s, INDEX_op_movi_i64);
+        tcg_out_op_t(s, INDEX_op_tci_movi_i64);
         tcg_out_r(s, t0);
         tcg_out64(s, arg);
 #else
-- 
2.20.1


