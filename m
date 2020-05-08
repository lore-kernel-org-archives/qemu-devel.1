Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDDCC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271F920736
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUWi3kzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271F920736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4mC-0006kq-Kt
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4ee-0002ko-79
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:12 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4ed-00049G-36
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:11 -0400
Received: by mail-pj1-x1042.google.com with SMTP id fu13so4361717pjb.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N87+uoODPiN2PxHSS9BG0v3AbBww5OeyNSCwJsVaeMs=;
 b=OUWi3kzqWsRbphN5foKSoQBdk58BLmncizVFzR6E4ZSO+NsdqrDlv8iyJ2jeMo0cuV
 L3ybrT5zWS74B3g0d7rpq75Js4ahJlOgdDzs1BAhZKU43ZyUbjmx6PZ2mI9T9Op5FThL
 XPohekfig5BGjC12dng8euU1JB9kSYxcEmlp8VUokjlzPc9Oy79IMfe5vfRfq4O32cXm
 skABQkgV1v4IXQmjLOiFN6Utt8koq4Rvp2ZQ4X4W3vGccqxS30gAkMj5MLJcog/Xriu0
 fCk2k0Ip6YvOOotQonItwbMvH0Zv72Wa8UOed2Dyii9zGpg+cHfBk3kERKtLLx9pRHwK
 SWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N87+uoODPiN2PxHSS9BG0v3AbBww5OeyNSCwJsVaeMs=;
 b=nf1LT/dBCRqn57twlnkZXVHMOGyK75Mqb4xg3O/NY+BlolIJrcS/cfphDy5xNhLiT5
 ZWsKWtH43gZ4u8cU/gmmMlAlNvjqRR4dh1F+ZvLSeOLEG96Way0w5OrgWXXTdcepezj3
 J8NlkfE/W9BoTzrj2g5Wys160tnajHdCSaE/swR2R1wCEbooIc11JUG3nxnHTYq72hzH
 Z4K1jWsDi91MSxYldIbp+kvR0xvdscBTBkh6fgpF+2n+wZgRweXfzy501xEqLPzDw/WA
 iUiuVUGJh/QAPJIL9S3xNnlQDFtCdoz7LQXT8F79UH03f9VaVQXpU2AuHpFzP1pW2LIT
 b7aQ==
X-Gm-Message-State: AGi0PuaHc0c9MA/2LdVuMAgX5nqq9BgS1dk33S+vfJWamoaOy27K/A9c
 mfAuhQqz/AJNL9o0z49mDBkjw1KnxqY=
X-Google-Smtp-Source: APiQypJPcot5XcvmP6yDf8BSKrWsJm478BI/I0n/Bdpg7znVPgSn/OTozZKE4MPnKfR/5Fo1XNpMqg==
X-Received: by 2002:a17:902:8b88:: with SMTP id
 ay8mr2862403plb.235.1588950669263; 
 Fri, 08 May 2020 08:11:09 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d13sm1557562pga.64.2020.05.08.08.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:11:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/10] tcg: Improve move ops in liveness_pass_2
Date: Fri,  8 May 2020 08:10:55 -0700
Message-Id: <20200508151055.5832-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151055.5832-1-richard.henderson@linaro.org>
References: <20200508151055.5832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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

If the output of the move is dead, then the last use is in
the store.  If we propagate the input to the store, then we
can remove the move opcode entirely.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 78 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index aa13158999..216a6963b3 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2982,34 +2982,68 @@ static bool liveness_pass_2(TCGContext *s)
         }
 
         /* Outputs become available.  */
-        for (i = 0; i < nb_oargs; i++) {
-            arg_ts = arg_temp(op->args[i]);
+        if (opc == INDEX_op_mov_i32 || opc == INDEX_op_mov_i64) {
+            arg_ts = arg_temp(op->args[0]);
             dir_ts = arg_ts->state_ptr;
-            if (!dir_ts) {
-                continue;
+            if (dir_ts) {
+                op->args[0] = temp_arg(dir_ts);
+                changes = true;
+
+                /* The output is now live and modified.  */
+                arg_ts->state = 0;
+
+                if (NEED_SYNC_ARG(0)) {
+                    TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
+                                      ? INDEX_op_st_i32
+                                      : INDEX_op_st_i64);
+                    TCGOp *sop = tcg_op_insert_after(s, op, sopc);
+                    TCGTemp *out_ts = dir_ts;
+
+                    if (IS_DEAD_ARG(0)) {
+                        out_ts = arg_temp(op->args[1]);
+                        arg_ts->state = TS_DEAD;
+                        tcg_op_remove(s, op);
+                    } else {
+                        arg_ts->state = TS_MEM;
+                    }
+
+                    sop->args[0] = temp_arg(out_ts);
+                    sop->args[1] = temp_arg(arg_ts->mem_base);
+                    sop->args[2] = arg_ts->mem_offset;
+                } else {
+                    tcg_debug_assert(!IS_DEAD_ARG(0));
+                }
             }
-            op->args[i] = temp_arg(dir_ts);
-            changes = true;
+        } else {
+            for (i = 0; i < nb_oargs; i++) {
+                arg_ts = arg_temp(op->args[i]);
+                dir_ts = arg_ts->state_ptr;
+                if (!dir_ts) {
+                    continue;
+                }
+                op->args[i] = temp_arg(dir_ts);
+                changes = true;
 
-            /* The output is now live and modified.  */
-            arg_ts->state = 0;
+                /* The output is now live and modified.  */
+                arg_ts->state = 0;
 
-            /* Sync outputs upon their last write.  */
-            if (NEED_SYNC_ARG(i)) {
-                TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
-                                  ? INDEX_op_st_i32
-                                  : INDEX_op_st_i64);
-                TCGOp *sop = tcg_op_insert_after(s, op, sopc);
+                /* Sync outputs upon their last write.  */
+                if (NEED_SYNC_ARG(i)) {
+                    TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
+                                      ? INDEX_op_st_i32
+                                      : INDEX_op_st_i64);
+                    TCGOp *sop = tcg_op_insert_after(s, op, sopc);
 
-                sop->args[0] = temp_arg(dir_ts);
-                sop->args[1] = temp_arg(arg_ts->mem_base);
-                sop->args[2] = arg_ts->mem_offset;
+                    sop->args[0] = temp_arg(dir_ts);
+                    sop->args[1] = temp_arg(arg_ts->mem_base);
+                    sop->args[2] = arg_ts->mem_offset;
 
-                arg_ts->state = TS_MEM;
-            }
-            /* Drop outputs that are dead.  */
-            if (IS_DEAD_ARG(i)) {
-                arg_ts->state = TS_DEAD;
+                    arg_ts->state = TS_MEM;
+                }
+                /* Drop outputs that are dead.  */
+                if (IS_DEAD_ARG(i)) {
+                    arg_ts->state = TS_DEAD;
+                }
             }
         }
     }
-- 
2.20.1


