Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EF4C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47AC72146E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsOEGT2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AC72146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49933 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4cN-0001Qy-HX
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:26:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aL-0008Os-PL
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aJ-0006CF-S4
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:29 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aJ-0006A0-JZ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:27 -0400
Received: by mail-pf1-x441.google.com with SMTP id e24so2028242pfi.12
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=KjC3dR2LZ7KhCUhnKxH1B6r5HwzGCgRo7EFbENWKPC0=;
	b=HsOEGT2j/5Bb+1HmIF8ZqSCHrk/QmAdQRr6CWaNcvfajqMUxeM0Om0ZEmJqt/e5B6O
	CMyC6FI79FWaajeR9umwQB4u9Gg8V0YEMicqZD5ZDDlLUPjwXQfhDugSGsVkdoe88W7O
	oJlNT9VWN7gpJv7f0Eq1xODCSv6r0E0zl8Lqg3Tac+lsL7wgfuWGPRiqO+vlLeKgH18m
	4Q7uIUI1/UB8YNpK1ne9gg0zlWA05I+TFWwoihEg8CJJG/wJPbdDfokYdONSSd8N3HM+
	HqeoxDyLlxlNapkwXs+IKgXQQiATyNH+sIN6lEzPZaB2G7hF2J8/Ir7lh34Y5qYlyMEG
	hL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=KjC3dR2LZ7KhCUhnKxH1B6r5HwzGCgRo7EFbENWKPC0=;
	b=GJKL0fJHP2YNNXQ7piGh0i8pe3Elqg6pbo+itG41yr0rP9Pcj4hCfat5IHPYypeu//
	V/jPPfY/XBHonYwrck2ABogeRFeM66Z6IYt6qu5KcDEIvecJHw0HbtTn7ezdPRn0k1pN
	t+pgM/HQirGuCOfmarKLvpBT9jAQr5S0yjWWYtSni9Up+7mxMxhcosV9H9jzErWPzEDw
	1IpCM82zgUjKqhqcsCSWNHhCkRGpDTH3PPHSXAeKFDDlCMQpiaiJTwLXWZgEf1AiZrn9
	ws5K+bBbhULHfxbmvTEdoHcX9noEiLyUACIgsi7E1HMJ6yEpZhzdICpQNXeDIdwGJlgE
	Vebg==
X-Gm-Message-State: APjAAAUFGFotWaxz6c3syj+MJHIkwLFiQPAcI7DMBf4W7Ztc2+AHwYxr
	Mm1IbhcE3+YlYKgbMI2DJxiX6SA7PFQ=
X-Google-Smtp-Source: APXvYqzGR5La8SAPkiysfc2eW9lpCJpOCnSuFwTx2376AHO9jl9tyXSee3F5fzAbakcj/lvTsC3ZkA==
X-Received: by 2002:a63:5466:: with SMTP id e38mr45529970pgm.340.1556299465957;
	Fri, 26 Apr 2019 10:24:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:08 -0700
Message-Id: <20190426172421.27133-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PULL 02/15] tcg: Add INDEX_op_extract2_{i32,i64}
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426172408.-kbM-YtWlMHD46gj-amKd2HpT6p7E42EKDkw06d49Zg@z>

This will let backends implement the double-word shift operation.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h |  2 ++
 tcg/arm/tcg-target.h     |  1 +
 tcg/i386/tcg-target.h    |  2 ++
 tcg/mips/tcg-target.h    |  2 ++
 tcg/ppc/tcg-target.h     |  2 ++
 tcg/riscv/tcg-target.h   |  2 ++
 tcg/s390/tcg-target.h    |  2 ++
 tcg/sparc/tcg-target.h   |  2 ++
 tcg/tcg-opc.h            |  2 ++
 tcg/tcg.h                |  1 +
 tcg/tci/tcg-target.h     |  2 ++
 tcg/optimize.c           | 16 ++++++++++++++++
 tcg/tcg-op.c             |  4 ++++
 tcg/tcg.c                |  4 ++++
 tcg/README               |  7 +++++++
 15 files changed, 51 insertions(+)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 2d93cf404e..6600a54a02 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -77,6 +77,7 @@ typedef enum {
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
+#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -113,6 +114,7 @@ typedef enum {
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     1
+#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 16172f73a3..4ee6c98958 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -116,6 +116,7 @@ extern bool use_idiv_instructions;
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
+#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 7995fe3eab..2c58eaa9ed 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -124,6 +124,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
+#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -162,6 +163,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 5cb8672470..c6b091d849 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -162,6 +162,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
 #define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
@@ -177,6 +178,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
 #define TCG_TARGET_HAS_rot_i64          use_mips32r2_instructions
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 52c1bb04b1..7627fb62d3 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -77,6 +77,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
@@ -115,6 +116,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 60918cacb4..032439d806 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -93,6 +93,7 @@ typedef enum {
 #define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        0
@@ -128,6 +129,7 @@ typedef enum {
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extrl_i64_i32    1
 #define TCG_TARGET_HAS_extrh_i64_i32    1
 #define TCG_TARGET_HAS_ext8s_i64        1
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 853ed6e7aa..07accabbd1 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -85,6 +85,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_deposit_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_extract_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_sextract_i32   0
+#define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_movcond_i32    1
 #define TCG_TARGET_HAS_add2_i32       1
 #define TCG_TARGET_HAS_sub2_i32       1
@@ -121,6 +122,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_deposit_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_extract_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
 #define TCG_TARGET_HAS_sextract_i64   0
+#define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_movcond_i64    1
 #define TCG_TARGET_HAS_add2_i64       1
 #define TCG_TARGET_HAS_sub2_i64       1
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index a0ed2a3342..633841ebf2 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -116,6 +116,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -153,6 +154,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 4e0238ad1a..1bad6e4208 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -79,6 +79,7 @@ DEF(rotr_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot_i32))
 DEF(deposit_i32, 1, 2, 2, IMPL(TCG_TARGET_HAS_deposit_i32))
 DEF(extract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_extract_i32))
 DEF(sextract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_sextract_i32))
+DEF(extract2_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_extract2_i32))
 
 DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END)
 
@@ -146,6 +147,7 @@ DEF(rotr_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot_i64))
 DEF(deposit_i64, 1, 2, 2, IMPL64 | IMPL(TCG_TARGET_HAS_deposit_i64))
 DEF(extract_i64, 1, 1, 2, IMPL64 | IMPL(TCG_TARGET_HAS_extract_i64))
 DEF(sextract_i64, 1, 1, 2, IMPL64 | IMPL(TCG_TARGET_HAS_sextract_i64))
+DEF(extract2_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_extract2_i64))
 
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, IMPL64)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a394d78237..50de1cdda3 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -125,6 +125,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_movcond_i64      0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 086f34e69a..8b90ab71cb 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -71,6 +71,7 @@
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
@@ -97,6 +98,7 @@
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_div_i64          0
 #define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_ext8s_i64        1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 01e80c3e46..5150c38a25 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1202,6 +1202,22 @@ void tcg_optimize(TCGContext *s)
             }
             goto do_default;
 
+        CASE_OP_32_64(extract2):
+            if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
+                TCGArg v1 = arg_info(op->args[1])->val;
+                TCGArg v2 = arg_info(op->args[2])->val;
+
+                if (opc == INDEX_op_extract2_i64) {
+                    tmp = (v1 >> op->args[3]) | (v2 << (64 - op->args[3]));
+                } else {
+                    tmp = (v1 >> op->args[3]) | (v2 << (32 - op->args[3]));
+                    tmp = (int32_t)tmp;
+                }
+                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                break;
+            }
+            goto do_default;
+
         CASE_OP_32_64(setcond):
             tmp = do_constant_folding_cond(opc, op->args[1],
                                            op->args[2], op->args[3]);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7c56c92c8e..deacc63e3b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -823,6 +823,8 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
         tcg_gen_mov_i32(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i32(ret, al, ofs);
+    } else if (TCG_TARGET_HAS_extract2_i32) {
+        tcg_gen_op4i_i32(INDEX_op_extract2_i32, ret, al, ah, ofs);
     } else {
         TCGv_i32 t0 = tcg_temp_new_i32();
         tcg_gen_shri_i32(t0, al, ofs);
@@ -2333,6 +2335,8 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
         tcg_gen_mov_i64(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i64(ret, al, ofs);
+    } else if (TCG_TARGET_HAS_extract2_i64) {
+        tcg_gen_op4i_i64(INDEX_op_extract2_i64, ret, al, ah, ofs);
     } else {
         TCGv_i64 t0 = tcg_temp_new_i64();
         tcg_gen_shri_i64(t0, al, ofs);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6a22c8746c..c0730f119f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1426,6 +1426,8 @@ bool tcg_op_supported(TCGOpcode op)
         return TCG_TARGET_HAS_extract_i32;
     case INDEX_op_sextract_i32:
         return TCG_TARGET_HAS_sextract_i32;
+    case INDEX_op_extract2_i32:
+        return TCG_TARGET_HAS_extract2_i32;
     case INDEX_op_add2_i32:
         return TCG_TARGET_HAS_add2_i32;
     case INDEX_op_sub2_i32:
@@ -1523,6 +1525,8 @@ bool tcg_op_supported(TCGOpcode op)
         return TCG_TARGET_HAS_extract_i64;
     case INDEX_op_sextract_i64:
         return TCG_TARGET_HAS_sextract_i64;
+    case INDEX_op_extract2_i64:
+        return TCG_TARGET_HAS_extract2_i64;
     case INDEX_op_extrl_i64_i32:
         return TCG_TARGET_HAS_extrl_i64_i32;
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/README b/tcg/README
index 603f4df659..c30e5418a6 100644
--- a/tcg/README
+++ b/tcg/README
@@ -343,6 +343,13 @@ at bit 8.  This operation would be equivalent to
 
 (using an arithmetic right shift).
 
+* extract2_i32/i64 dest, t1, t2, pos
+
+For N = {32,64}, extract an N-bit quantity from the concatenation
+of t2:t1, beginning at pos.  The tcg_gen_extract2_{i32,i64} expander
+accepts 0 <= pos <= N as inputs.  The backend code generator will
+not see either 0 or N as inputs for these opcodes.
+
 * extrl_i64_i32 t0, t1
 
 For 64-bit hosts only, extract the low 32-bits of input T1 and place it
-- 
2.17.1


