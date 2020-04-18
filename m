Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40B2C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01B12054F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwtnPhgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01B12054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqFv-0001JR-88
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBo-0004Iz-IH
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBn-0005Lc-Bo
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqBn-0005Ii-5y
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id h69so2754936pgc.8
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Zdjt8WpN4waxB25J3ykCncF8gpDtxEJVdnhsqarrM50=;
 b=QwtnPhgrhOXmMsn5hHVTSYL6WN5GsmWrg4zkIQUdfrJde0kF067gpRLj+SPPQK/nHi
 GG6t/U3QvIZSm6oeClE2vY6y2fedj5uftEENO1YEZ3Bj9wmFdEqNywAPYnGBM3UEgaES
 d5dpiQZ+F6u7ALkGJVUbj855Zu/SY8GQJti970BSif7jBq/2nGcZuDKjxvT8es67F4Oz
 HGrwl2Q89BwwirzurxT9l+VrO/IzAGNF7gpc72K15FbJ2F73EfsBOr/Ra14/HQwbGZRc
 lssz1cppqTTpk1xp42HjDPT54cOJ79UtctyWzh3QD2NKlu9q7DPMlUWQlXKiv7g9TLYN
 6tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zdjt8WpN4waxB25J3ykCncF8gpDtxEJVdnhsqarrM50=;
 b=QHe+bvN72krQrTQs/vZM3+ACHoByX3SLk9/Wsl7Gl5Fj3oY7EbSVvcHNYANIEugUrc
 sh/qz/D7ZDoQntbCb2/h/+3La0ON6WEpKlXN8MQjx7GlMPeyIRhSaVRJ6wb0IzOOrpUF
 QHcVe2GfhmGh9f+TQNb6IAuHAq++LQDDvBSaBR0ORWu1DeMW4AKX8Tv3xO9zJPGvpN9D
 28OaHUDkwJhuNp/4fsoniiglx8oeCljWNDPMDjUdnjpTiuPMH5NgWK61un0+Mm75CDtu
 9i4XK3vmQfG0uNeX81ond+W4mAEytlc4Rt6++Q8gFChqkAjsU/EKKeoEczNO7NisSTKs
 YsWg==
X-Gm-Message-State: AGi0PubarhSHkkELsO+hRSewIYg4VPLMjiU3rR2WbwbIZ85QCK0UQ7x0
 wRvAnl7lchFM6G6doeKkhgTF5unAQxk=
X-Google-Smtp-Source: APiQypKDg0AkuSVsHB1urbNkgRijU4ptJbLKxeAME0OPyBz0WT56X7vaYYGlCMf+soRVGp/ENJrbrA==
X-Received: by 2002:aa7:93c2:: with SMTP id y2mr8580079pff.50.1587226769846;
 Sat, 18 Apr 2020 09:19:29 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i187sm22398382pfc.112.2020.04.18.09.19.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:19:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/16] tcg/tci: Add special tci_movi_{i32,i64} opcodes
Date: Sat, 18 Apr 2020 09:19:08 -0700
Message-Id: <20200418161914.4387-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418161914.4387-1-richard.henderson@linaro.org>
References: <20200418161914.4387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

The normal movi opcodes are going away.  We need something
for TCI to use internally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 8 ++++++++
 tcg/tci.c                | 4 ++--
 tcg/tci/tcg-target.inc.c | 4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 9288a04946..7dee9b38f7 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -268,6 +268,14 @@ DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
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


