Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAED6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6CD2177B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0FvhHcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6CD2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFo2d-00014P-GK
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFno1-00015b-BH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:45 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:34063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnz-0002MA-Dv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:45 -0400
Received: by mail-pj1-x1032.google.com with SMTP id n3so471258pjq.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Uou06gf/IRn+bzfObWOTsvklHo4+rp/muN9749mhiKU=;
 b=N0FvhHcq4yJNnx+FK2kzubQa6Dk0g63AJphJPE1Hq9820NiJSN/7+zeHtL+HqfgiKJ
 LiTNkRxt1JH+YjWB57h3YkwGs3scC9qExFjU9azta3bBOmgtP/WNtl2fhzA9JdNF30gU
 pv4j5MTnjS8cvzPNo8EauSM73YXUJAj4qRfrW6a83+Y6V5Sal8FKcI09rOH44XKIRoSD
 kDo1yGBoPCAp8EYvClhqDwsYluPxoYWJJMWMXOoU+9lV+2rIkiauEVuDNbbEcTdGhqqn
 jE7Znpi2Jw/nYK8IZSK1BVS0ICpkxmT2qL0e0jroVtVzLaiIAF2gOtPXV0aLyfkWO448
 PppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uou06gf/IRn+bzfObWOTsvklHo4+rp/muN9749mhiKU=;
 b=XQbmTaBAzg2T3p3MDcE2hu2fXqrYbLPbt7/sCV7vXxk23mWFzdLgnIXH3GdpdrTaei
 T8q6Q2K9GrCF7VjlTAoa9qSQtxtfbq1/i1UdadREl3yNC89az9C4fwnUu+1WYpRk50DT
 hkwBoWg+SWyMBN1qQGYgeaeyKW0RA88Gf4+6IZKBADEhdwxgwD81OEMzZCdCEN3A/AFe
 YQWvAyufFkIsYH4poApDrdZLJ5MAe54djYifQk2COqznBWM8E7j0WYUH+Q942IDwz/KZ
 5uHrvwBC9BEyWmNcaNQtXDlEaqDmG9QGdJdDAO4TTL6nrrO9DLPJvh5yghBLcX99nWHj
 DYCQ==
X-Gm-Message-State: AOAM5307ST4+dWn8Vc8w/wbi/EQHvrFq0iBTqQtYjMjGV424Vmq4Orih
 xS683SJmJkbokRvJbAAw46HULY0dsofKhw==
X-Google-Smtp-Source: ABdhPJxTCZlmm4irIO8XDVeEB6jdwPbtTph+uU5CQdKOn9s2OvVu8hF1PWcgNOezaglZeQjcvQvRhQ==
X-Received: by 2002:a17:90a:7f93:: with SMTP id
 m19mr1249399pjl.194.1599610661719; 
 Tue, 08 Sep 2020 17:17:41 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/43] tcg/sparc: Convert to tcg-constr.c.inc
Date: Tue,  8 Sep 2020 17:16:46 -0700
Message-Id: <20200909001647.532249-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc/tcg-target-constr.h | 27 +++++++++++++
 tcg/sparc/tcg-target.c.inc    | 74 ++++++++++++-----------------------
 2 files changed, 51 insertions(+), 50 deletions(-)
 create mode 100644 tcg/sparc/tcg-target-constr.h

diff --git a/tcg/sparc/tcg-target-constr.h b/tcg/sparc/tcg-target-constr.h
new file mode 100644
index 0000000000..28aec2ae0f
--- /dev/null
+++ b/tcg/sparc/tcg-target-constr.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Sparc target-specific operand constaints.
+ * Copyright (c) 2020 Linaro
+ */
+
+C_O0_I1(r)
+C_O0_I2(rZ, r)
+C_O0_I2(RZ, r)
+C_O0_I2(rZ, rJ)
+C_O0_I2(RZ, RJ)
+C_O0_I2(sZ, A)
+C_O0_I2(SZ, A)
+C_O1_I1(r, A)
+C_O1_I1(R, A)
+C_O1_I1(r, r)
+C_O1_I1(r, R)
+C_O1_I1(R, r)
+C_O1_I1(R, R)
+C_O1_I2(R, R, R)
+C_O1_I2(r, rZ, rJ)
+C_O1_I2(R, RZ, RJ)
+C_O1_I4(r, rZ, rJ, rI, 0)
+C_O1_I4(R, RZ, RJ, RI, 0)
+C_O2_I2(r, r, rZ, rJ)
+C_O2_I4(R, R, RZ, RZ, RJ, RI)
+C_O2_I4(r, r, rZ, rZ, rJ, rJ)
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index af480115c5..aa426a1c90 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -1592,40 +1592,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
+/* Define all constraint sets. */
+#include "../tcg-constr.c.inc"
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
-    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
-    static const TCGTargetOpDef R_r = { .args_ct_str = { "R", "r" } };
-    static const TCGTargetOpDef r_R = { .args_ct_str = { "r", "R" } };
-    static const TCGTargetOpDef R_R = { .args_ct_str = { "R", "R" } };
-    static const TCGTargetOpDef r_A = { .args_ct_str = { "r", "A" } };
-    static const TCGTargetOpDef R_A = { .args_ct_str = { "R", "A" } };
-    static const TCGTargetOpDef rZ_r = { .args_ct_str = { "rZ", "r" } };
-    static const TCGTargetOpDef RZ_r = { .args_ct_str = { "RZ", "r" } };
-    static const TCGTargetOpDef sZ_A = { .args_ct_str = { "sZ", "A" } };
-    static const TCGTargetOpDef SZ_A = { .args_ct_str = { "SZ", "A" } };
-    static const TCGTargetOpDef rZ_rJ = { .args_ct_str = { "rZ", "rJ" } };
-    static const TCGTargetOpDef RZ_RJ = { .args_ct_str = { "RZ", "RJ" } };
-    static const TCGTargetOpDef R_R_R = { .args_ct_str = { "R", "R", "R" } };
-    static const TCGTargetOpDef r_rZ_rJ
-        = { .args_ct_str = { "r", "rZ", "rJ" } };
-    static const TCGTargetOpDef R_RZ_RJ
-        = { .args_ct_str = { "R", "RZ", "RJ" } };
-    static const TCGTargetOpDef r_r_rZ_rJ
-        = { .args_ct_str = { "r", "r", "rZ", "rJ" } };
-    static const TCGTargetOpDef movc_32
-        = { .args_ct_str = { "r", "rZ", "rJ", "rI", "0" } };
-    static const TCGTargetOpDef movc_64
-        = { .args_ct_str = { "R", "RZ", "RJ", "RI", "0" } };
-    static const TCGTargetOpDef add2_32
-        = { .args_ct_str = { "r", "r", "rZ", "rZ", "rJ", "rJ" } };
-    static const TCGTargetOpDef add2_64
-        = { .args_ct_str = { "R", "R", "RZ", "RZ", "RJ", "RI" } };
-
     switch (op) {
     case INDEX_op_goto_ptr:
-        return &r;
+        return C_O0_I1(r);
 
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
@@ -1634,12 +1608,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
-        return &r_r;
+        return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-        return &rZ_r;
+        return C_O0_I2(rZ, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_mul_i32:
@@ -1655,18 +1629,18 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_setcond_i32:
-        return &r_rZ_rJ;
+        return C_O1_I2(r, rZ, rJ);
 
     case INDEX_op_brcond_i32:
-        return &rZ_rJ;
+        return C_O0_I2(rZ, rJ);
     case INDEX_op_movcond_i32:
-        return &movc_32;
+        return C_O1_I4(r, rZ, rJ, rI, 0);
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
-        return &add2_32;
+        return C_O2_I4(r, r, rZ, rZ, rJ, rJ);
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i32:
-        return &r_r_rZ_rJ;
+        return C_O2_I2(r, r, rZ, rJ);
 
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
@@ -1677,13 +1651,13 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-        return &R_r;
+        return C_O1_I1(R, r);
 
     case INDEX_op_st8_i64:
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return &RZ_r;
+        return C_O0_I2(RZ, r);
 
     case INDEX_op_add_i64:
     case INDEX_op_mul_i64:
@@ -1699,36 +1673,36 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_setcond_i64:
-        return &R_RZ_RJ;
+        return C_O1_I2(R, RZ, RJ);
 
     case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
     case INDEX_op_ext32s_i64:
     case INDEX_op_ext32u_i64:
-        return &R_R;
+        return C_O1_I1(R, R);
 
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-        return &r_R;
+        return C_O1_I1(r, R);
 
     case INDEX_op_brcond_i64:
-        return &RZ_RJ;
+        return C_O0_I2(RZ, RJ);
     case INDEX_op_movcond_i64:
-        return &movc_64;
+        return C_O1_I4(R, RZ, RJ, RI, 0);
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i64:
-        return &add2_64;
+        return C_O2_I4(R, R, RZ, RZ, RJ, RI);
     case INDEX_op_muluh_i64:
-        return &R_R_R;
+        return C_O1_I2(R, R, R);
 
     case INDEX_op_qemu_ld_i32:
-        return &r_A;
+        return C_O1_I1(r, A);
     case INDEX_op_qemu_ld_i64:
-        return &R_A;
+        return C_O1_I1(R, A);
     case INDEX_op_qemu_st_i32:
-        return &sZ_A;
+        return C_O0_I2(sZ, A);
     case INDEX_op_qemu_st_i64:
-        return &SZ_A;
+        return C_O0_I2(SZ, A);
 
     default:
         return NULL;
-- 
2.25.1


