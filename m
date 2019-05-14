Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17579C04A6B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 03:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D3F20818
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 03:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cI/k2fgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D3F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38576 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQOVS-0000qy-NR
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 23:53:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQOUU-0000BE-3T
	for qemu-devel@nongnu.org; Mon, 13 May 2019 23:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQOUS-000355-Uk
	for qemu-devel@nongnu.org; Mon, 13 May 2019 23:52:34 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:36943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxJ-0003Ay-9X
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:07 -0400
Received: by mail-pf1-x42a.google.com with SMTP id g3so8067283pfi.4
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=yjaWcvw9UbJX/NgPrNoAKyN+ZZwbI4Jl9YPntsAKSX4=;
	b=cI/k2fglzCzVv0W2UtPeSLi5Lo4mXGxJ9Uae728eJQPc2FXSW9n4qUv3tG0dKTNRua
	fI0eaDJ8V+0JNDwbtKovaO9gGa+OeDA0YnZEdQWDdOYJPLGhoSqJ+cySa6voAT/ay840
	AE/STidMQbjqfkDERn+rVlRcIXBzwQDUSKU8+F5vDH/m9xtpVQSFyXc4IqG5lm+7KB/i
	Hu4imRsPpzXwnltiowpjIr1OhtuIuejwJLqF4gy427lgk3s4knHcFIv6eWI7Btojx1/S
	GCXLqly92L1BnKVh0baAvZ/4Pr0PE2EATks10BZxdqGde1y/WU0bXTtzR1IY3qyjlhm0
	R0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=yjaWcvw9UbJX/NgPrNoAKyN+ZZwbI4Jl9YPntsAKSX4=;
	b=Lv5Ax1B95WYaMGNx9J/UlBswDWJ/Wft7X7vHeG2DT6RthXahDiNnfy+D8XX6r7lC9T
	m3IX0wDaptd/lmiUZVE9dkQIETIgJUyZtm2jbqlGUjcsqovREaHd0RQAayB5P6BlJwjn
	7EFvpPgTZnXVCvpEbWl8CJtLJiWphfpr7LgOcJoYml8I64RWUbFOordsmFw1Yq4qaEDJ
	gWijQy6kmekPRNUvYMfJWH5dz9b+fd/kyHIAoPCRH9Suqr0Xu2aEcPHpWuf9EUoANdK8
	YVOty5/xcKT5/zHhjr1eZpO65bQ8weL5UElSq+djoFfgEE36dApzGCRMOELGhUCPm7IE
	FUEg==
X-Gm-Message-State: APjAAAUlgwY708Q7+FTcZCtTd5tUmkz7MzciWUVicl0N9JiiLThH6gDJ
	cxInp50ycwQL+R8owtz08c1xA7d+YT0=
X-Google-Smtp-Source: APXvYqydk+4PGzlJS7rbgB1f+8+HV7dB6KptajTLSSdx4nJVwJssr0ryCVh/xmt11unpLa0+8EhZQw==
X-Received: by 2002:a65:5241:: with SMTP id q1mr34254286pgp.298.1557792357975; 
	Mon, 13 May 2019 17:05:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:20 -0700
Message-Id: <20190514000540.4313-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42a
Subject: [Qemu-devel] [PULL 11/31] tcg: Add tcg_out_dupm_vec to the backend
 interface
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently stubbed out in all backends that support vectors.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c |  6 ++++++
 tcg/i386/tcg-target.inc.c    |  7 +++++++
 tcg/tcg.c                    | 19 ++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 3cefdd1e43..4a3cfa778a 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -822,6 +822,12 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
     return true;
 }
 
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg r, TCGReg base, intptr_t offset)
+{
+    return false;
+}
+
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long value)
 {
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 3c8229d413..f04933bc19 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -891,6 +891,13 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
     return true;
 }
 
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg r, TCGReg base, intptr_t offset)
+{
+    return false;
+}
+
+
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                              TCGReg ret, tcg_target_long arg)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2b715bf099..b9945794c4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -111,6 +111,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 #if TCG_TARGET_MAYBE_vec
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src);
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg dst, TCGReg base, intptr_t offset);
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                              TCGReg dst, tcg_target_long arg);
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
@@ -122,6 +124,11 @@ static inline bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 {
     g_assert_not_reached();
 }
+static inline bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                                    TCGReg dst, TCGReg base, intptr_t offset)
+{
+    g_assert_not_reached();
+}
 static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                                     TCGReg dst, tcg_target_long arg)
 {
@@ -3422,6 +3429,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
     TCGRegSet dup_out_regs, dup_in_regs;
     TCGTemp *its, *ots;
     TCGType itype, vtype;
+    intptr_t endian_fixup;
     unsigned vece;
     bool ok;
 
@@ -3491,7 +3499,16 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
         /* fall through */
 
     case TEMP_VAL_MEM:
-        /* TODO: dup from memory */
+#ifdef HOST_WORDS_BIGENDIAN
+        endian_fixup = itype == TCG_TYPE_I32 ? 4 : 8;
+        endian_fixup -= 1 << vece;
+#else
+        endian_fixup = 0;
+#endif
+        if (tcg_out_dupm_vec(s, vtype, vece, ots->reg, its->mem_base->reg,
+                             its->mem_offset + endian_fixup)) {
+            goto done;
+        }
         tcg_out_ld(s, itype, ots->reg, its->mem_base->reg, its->mem_offset);
         break;
 
-- 
2.17.1


