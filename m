Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDECC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B269621479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLUVCTrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B269621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkdj-0006N0-My
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:42:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWe-0008Uq-6I
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWd-0007yl-50
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:04 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWc-0007yB-VH
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id f36so3538773plb.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=pV+13kF6P9BlfNwiU+pC3oUPKYg5eIexnBRNkKkWSQQ=;
	b=uLUVCTrQ9EuLTgdoWbM/n6PWVNrSAqioVlwSLoLTzuUJ4ojaMx3UXAcnnFp5Nwrdnr
	yNnZNq8/eNmLsRGSkdtx2hVBc6ZnYiahmDI3DwRaSJcoudNNv6ztCwWvSVnOxKkGLZTY
	b6M389lWgGmIASDDDb6G/NO/hXTagkS05iXrkdiDu9d/uS9FT/v5FhR9OP2STjPhlNgh
	6i+pbwh78p0T6lu84yeUbwIJMwkKvDl+ouREVYMEuUMPzKIUwtpzPvwFxN97nCScxm6J
	b6VJe8Bt1VtPi0jycqOoev3d8CFC6sAMETXdQpAFLvIw5Mb4nVkXRHoAa6z3s8h2RCZu
	RrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=pV+13kF6P9BlfNwiU+pC3oUPKYg5eIexnBRNkKkWSQQ=;
	b=iIzkuzbYvMWUM7Xys3o0nz+NpqHPagZEf3S+wpY4PCmCaq2YznBc/oloVQT5igHGNm
	MWflFemRZGC5W/At5lNHrbo+2dl6lFDWzf3h96+aOFUtKy4CCtwIft3tBOnfqmOMLzG2
	gBJOyPX9XmLQJke8kiN5U7OOhhgqc4qLL9VbrrGb6UiYkxkrEXdkad+Z6E869Ta59RjJ
	T9T89ODqs3NNmx3bfODx2WQRWN4xo+g5hypXrUox/zstWmDvz2loFHz8JU8puRKmCtwv
	bOH1cpP7swG/Q1yDXa8w9SBH23lCP7GiAusUvSqasNIaXYJQxLaXEJXyXvlfprCY1hpf
	ROFQ==
X-Gm-Message-State: APjAAAWqczx3XyiyYNaPFDLWvNpfXVxCzPmCw+dqfVWb+1FgZFFGqVav
	tL0ZfcB39M7Su51iWZDFNbyQNNZM7xo=
X-Google-Smtp-Source: APXvYqyoQD03Wg4ifoS7FrNUqFNEq27xyKfRvx5UUYC7MFdfBJBff2ukYW6raj3EdCFjKgpJ71/hTQ==
X-Received: by 2002:a17:902:9a0c:: with SMTP id
	v12mr8411359plp.184.1555745701818; 
	Sat, 20 Apr 2019 00:35:01 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:14 -1000
Message-Id: <20190420073442.7488-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 10/38] tcg/aarch64: Implement tcg_out_dupm_vec
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073414.KooGS1Jg2dJglqI5I4qVkTVcTlEAhwZPSjCXBac48LU@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 38 ++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 3f95930e88..1db4e22365 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -381,6 +381,9 @@ typedef enum {
     I3207_BLR       = 0xd63f0000,
     I3207_RET       = 0xd65f0000,
 
+    /* AdvSIMD load/store single structure.  */
+    I3303_LD1R      = 0x0d40c000,
+
     /* Load literal for loading the address at pc-relative offset */
     I3305_LDR       = 0x58000000,
     I3305_LDR_v64   = 0x5c000000,
@@ -414,6 +417,8 @@ typedef enum {
     I3312_LDRVQ     = 0x3c000000 | 3 << 22 | 0 << 30,
     I3312_STRVQ     = 0x3c000000 | 2 << 22 | 0 << 30,
 
+
+
     I3312_TO_I3310  = 0x00200800,
     I3312_TO_I3313  = 0x01000000,
 
@@ -566,7 +571,14 @@ static inline uint32_t tcg_in32(TCGContext *s)
 #define tcg_out_insn(S, FMT, OP, ...) \
     glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
 
-static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn, int imm19, TCGReg rt)
+static void tcg_out_insn_3303(TCGContext *s, AArch64Insn insn, bool q,
+                              TCGReg rt, TCGReg rn, unsigned size)
+{
+    tcg_out32(s, insn | (rt & 0x1f) | (rn << 5) | (size << 10) | (q << 30));
+}
+
+static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn,
+                              int imm19, TCGReg rt)
 {
     tcg_out32(s, insn | (imm19 & 0x7ffff) << 5 | rt);
 }
@@ -825,7 +837,29 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg r, TCGReg base, intptr_t offset)
 {
-    return false;
+    if (offset != 0) {
+        AArch64Insn add_insn = I3401_ADDI;
+        TCGReg temp = TCG_REG_TMP;
+
+        if (offset < 0) {
+            add_insn = I3401_SUBI;
+            offset = -offset;
+        }
+        if (offset <= 0xfff) {
+            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset);
+        } else if (offset <= 0xffffff) {
+            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff000);
+            if (offset & 0xfff) {
+                tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff);
+            }
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, temp, offset);
+            tcg_out_insn(s, 3502, ADD, 1, temp, temp, base);
+        }
+        base = temp;
+    }
+    tcg_out_insn(s, 3303, LD1R, type == TCG_TYPE_V128, r, base, vece);
+    return true;
 }
 
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
-- 
2.17.1


