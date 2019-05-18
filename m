Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC07CC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFF520873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhEPtYKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFF520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37789 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4rr-0006vJ-Lj
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:19:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dV-0002qF-Fk
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4ar-0002Xs-7x
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:06 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4ar-0002Wb-1N
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:05 -0400
Received: by mail-pg1-x542.google.com with SMTP id z16so4815668pgv.11
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=oqAGJXCcrmzUdmSG3sZCijkOSbKbEdDFHwT2UnQhICM=;
	b=UhEPtYKeH5fq9a+ZB+yE+cTcz+u6NMq4KOnYjrgfpRBs1lPp9X5WnCKtdbQvcXPken
	T6EIPSM2XXet021UOC942f2EpbBTc7GweprHrSMdHOgKcdjwYWF1T3oq1Af9ALtDPig+
	TT7w/wN89/lr7L1f92FBgvBZ0t2DQVPE4MEtpuI/oAienRz72K9dzd0bl0jysx/YB0QR
	o4cWuIgsxrDPtqu5u9xIGiXQiyrx9zFkMxeyWGnxv2Byb6QBgZW8J5oaylZcuCb7Xi1G
	C036Y7vldaem901bNhIetsvzXYdnogqA5PaMHt1hqusg7kKZ7ZFucL/UrwxGS5KQ4SSx
	BIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=oqAGJXCcrmzUdmSG3sZCijkOSbKbEdDFHwT2UnQhICM=;
	b=m8BJQdh/UijBeYgkI7UZQew5VuEK+RXFoxZWZQ7K79lfuFMRN3NZ7Ho/4cOiEqW7oD
	4ic5tuBj5hK7MgfxEaT+V07lWQcuV+FGNjOclGmSNSIzyaxCBp7jBcKjOlBwBL56bFjj
	UJYpfdHE+j3Yborta4K1rRTuZ55t6gb31nnj8BFNbRE0uaM3x6nVApAe0KjvF/vPGQze
	lMkzwnHPQBUZtkqLamYSsmucoySitUzXXFOOPpp1pv9302RjbNMCOFJVfCHsg6uS5vzr
	Wi2/xOoa1waSxt+Xs0uvIabB+L5wKjJYmb61gHPG4ypJIA53B53AyGVDhyhheWj46ikL
	+ynw==
X-Gm-Message-State: APjAAAXH6PFcX9SX/KuVvgyrs4uFGhakU0OSlxFJiW//d7NI0pWNdZwj
	UJYbiY0EqRTOTyy+UHQzZU+ZkqdO31g=
X-Google-Smtp-Source: APXvYqw1PlscMq7R+CTkBnCU+haUGclqqikLOmMumTHGPmqFh2lWw5nPloGMG6RAXE3FBEU8nGNb4g==
X-Received: by 2002:aa7:8c12:: with SMTP id c18mr71305950pfd.194.1558206123711;
	Sat, 18 May 2019 12:02:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.02
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:43 -0700
Message-Id: <20190518190157.21255-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 02/16] tcg: Fix missing checks and clears in
 tcg_gen_gvec_dup_mem
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

The paths through tcg_gen_dup_mem_vec and through MO_128 were
missing the check_size_align.  The path through MO_128 was also
missing the expand_clr.  This last was not visible because the
only user is ARM SVE, which would set oprsz == maxsz, and not
require the clear.

Fix by adding the check_size_align and using do_dup directly
instead of duplicating the check in tcg_gen_gvec_dup_{i32,i64}.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 48 ++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 338ddd9d9e..bbf70e3cd9 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1446,36 +1446,35 @@ void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
 void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
                           uint32_t oprsz, uint32_t maxsz)
 {
+    check_size_align(oprsz, maxsz, dofs);
     if (vece <= MO_64) {
-        TCGType type = choose_vector_type(0, vece, oprsz, 0);
+        TCGType type = choose_vector_type(NULL, vece, oprsz, 0);
         if (type != 0) {
             TCGv_vec t_vec = tcg_temp_new_vec(type);
             tcg_gen_dup_mem_vec(vece, t_vec, cpu_env, aofs);
             do_dup_store(type, dofs, oprsz, maxsz, t_vec);
             tcg_temp_free_vec(t_vec);
-            return;
+        } else if (vece <= MO_32) {
+            TCGv_i32 in = tcg_temp_new_i32();
+            switch (vece) {
+            case MO_8:
+                tcg_gen_ld8u_i32(in, cpu_env, aofs);
+                break;
+            case MO_16:
+                tcg_gen_ld16u_i32(in, cpu_env, aofs);
+                break;
+            default:
+                tcg_gen_ld_i32(in, cpu_env, aofs);
+                break;
+            }
+            do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);
+            tcg_temp_free_i32(in);
+        } else {
+            TCGv_i64 in = tcg_temp_new_i64();
+            tcg_gen_ld_i64(in, cpu_env, aofs);
+            do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
+            tcg_temp_free_i64(in);
         }
-    }
-    if (vece <= MO_32) {
-        TCGv_i32 in = tcg_temp_new_i32();
-        switch (vece) {
-        case MO_8:
-            tcg_gen_ld8u_i32(in, cpu_env, aofs);
-            break;
-        case MO_16:
-            tcg_gen_ld16u_i32(in, cpu_env, aofs);
-            break;
-        case MO_32:
-            tcg_gen_ld_i32(in, cpu_env, aofs);
-            break;
-        }
-        tcg_gen_gvec_dup_i32(vece, dofs, oprsz, maxsz, in);
-        tcg_temp_free_i32(in);
-    } else if (vece == MO_64) {
-        TCGv_i64 in = tcg_temp_new_i64();
-        tcg_gen_ld_i64(in, cpu_env, aofs);
-        tcg_gen_gvec_dup_i64(MO_64, dofs, oprsz, maxsz, in);
-        tcg_temp_free_i64(in);
     } else {
         /* 128-bit duplicate.  */
         /* ??? Dup to 256-bit vector.  */
@@ -1504,6 +1503,9 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             tcg_temp_free_i64(in0);
             tcg_temp_free_i64(in1);
         }
+        if (oprsz < maxsz) {
+            expand_clr(dofs + oprsz, maxsz - oprsz);
+        }
     }
 }
 
-- 
2.17.1


