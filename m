Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B4EC47258
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B6B20757
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Knx6nOk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B6B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVael-0008Qe-C7
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIF-0001Fw-6B
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIE-0001Iq-95
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id x17so20701779wrt.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=F47px45/kNqtLBz6+gTIk2HQWztn0jEg0nnhhZt81tM=;
 b=Knx6nOk9Qa+0/a0osqSlcUQlBjgFFbXuRKoca8h1AJmMOivUhkPs/gm/IuaVreNPKy
 LX43E/l+yIY3s3O+F7psHTRc3ScN5hiGET7IhNcuuKzHrqOQuHARop1BVte5aLkpyXSt
 EWnxNVPg0XLTb33Pu7qR8aFilK5hq9grngH4J0a5QWpwG6fPN6IFQTpu9RQ8vW9O6tKQ
 MsJVGHE1JuOTX52Se1DdEcjEQy4Af1DulQ98UpxyF08P9WxqLkllUlmOxmjHpiOrJEvD
 1HUTBIIY99EHp/xEUmYuQjWtiTdxnEYPKcEDNfzhWmfFegDe1hqZAzkbOQpTccfk4OFr
 WDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F47px45/kNqtLBz6+gTIk2HQWztn0jEg0nnhhZt81tM=;
 b=kLMwNwBGCv9oTpLNfC/FuVxl+BfwU+9hVSKprdb71IZ+621VfVxC3SEpz8V46IXwxb
 W7XJfzXyZPLokwILxuz0kfiPb8PFqu5ZdDt4kvHPyZB5SsG3/f1CkOOAt/hZWY2MmD82
 vi4Fd7apUzKJc2wGtL6k1j3flLd1Q98Eir64ff3VWKMYeKKbGqn6KzkIDZliHPM5KUsR
 VHG8lMCb7Vua/Kjj+RWbVAJFHgMBcivUk1k1yFZ2T+FCbxBxNeQYabvWb3lthQiknsTS
 x3ephS1kD6GwOI+RwMnUWb1ZbeFOx+qM3rJWUoycf4oeHC1LGiq6pmxpCLyuPoVoQZqf
 WAzw==
X-Gm-Message-State: AGi0PuY5gIfelLnDJHFPBJLzrM1FflxOSOsdBlEPbltZa5orFHYn0U9R
 PsZyu5mY55+05p4wCTVa1tJP7HHOPptVpQ==
X-Google-Smtp-Source: APiQypJ4gXwyOVfAgtXdKCJsaRVpAjHdB5qwpn++0BtOiHwmEQisuv1bGH38hA0k6R04sJGqNPfKhw==
X-Received: by 2002:adf:fe51:: with SMTP id m17mr18560031wrs.414.1588595632634; 
 Mon, 04 May 2020 05:33:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/39] target/arm: Convert Neon 3-reg-same VQADD/VQSUB to
 decodetree
Date: Mon,  4 May 2020 13:33:07 +0100
Message-Id: <20200504123309.3808-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon VQADD/VQSUB insns in the 3-reg-same grouping
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-19-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  6 ++++++
 target/arm/translate-neon.inc.c | 15 +++++++++++++++
 target/arm/translate.c          | 14 ++------------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index b89ea6819a9..ab59b349aaa 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -42,6 +42,9 @@
 @3same           .... ... . . . size:2 .... .... .... . q:1 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
+VQADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 1 .... @3same
+VQADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 1 .... @3same
+
 @3same_logic     .... ... . . . .. .... .... .... . q:1 .. .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=0
 
@@ -54,6 +57,9 @@ VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
 VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
 VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
 
+VQSUB_S_3s       1111 001 0 0 . .. .... .... 0010 . . . 1 .... @3same
+VQSUB_U_3s       1111 001 1 0 . .. .... .... 0010 . . . 1 .... @3same
+
 VCGT_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 0 .... @3same
 VCGT_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 0 .... @3same
 VCGE_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 1 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 952e4456f5e..854ab70cd79 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -653,3 +653,18 @@ static void gen_VTST_3s(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &cmtst_op[vece]);
 }
 DO_3SAME_NO_SZ_3(VTST, gen_VTST_3s)
+
+#define DO_3SAME_GVEC4(INSN, OPARRAY)                                   \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),           \
+                       rn_ofs, rm_ofs, oprsz, maxsz, &OPARRAY[vece]);   \
+    }                                                                   \
+    DO_3SAME(INSN, gen_##INSN##_3s)
+
+DO_3SAME_GVEC4(VQADD_S, sqadd_op)
+DO_3SAME_GVEC4(VQADD_U, uqadd_op)
+DO_3SAME_GVEC4(VQSUB_S, sqsub_op)
+DO_3SAME_GVEC4(VQSUB_U, uqsub_op)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0e6ecc0969a..13ce1a5fc1d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4848,18 +4848,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 1;
 
-        case NEON_3R_VQADD:
-            tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
-                           rn_ofs, rm_ofs, vec_size, vec_size,
-                           (u ? uqadd_op : sqadd_op) + size);
-            return 0;
-
-        case NEON_3R_VQSUB:
-            tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
-                           rn_ofs, rm_ofs, vec_size, vec_size,
-                           (u ? uqsub_op : sqsub_op) + size);
-            return 0;
-
         case NEON_3R_VMUL: /* VMUL */
             if (u) {
                 /* Polynomial case allows only P8.  */
@@ -4892,6 +4880,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VTST_VCEQ:
         case NEON_3R_VCGT:
         case NEON_3R_VCGE:
+        case NEON_3R_VQADD:
+        case NEON_3R_VQSUB:
             /* Already handled by decodetree */
             return 1;
         }
-- 
2.20.1


