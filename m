Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17897C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF8D2089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdTUrcB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF8D2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZkX-00044A-Vg
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:30:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZin-0002vo-Pq
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZil-0007Ik-UE
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:29 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e]:38467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZil-0007I3-Pi
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:27 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id x7so1498465ybg.5
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oqAGJXCcrmzUdmSG3sZCijkOSbKbEdDFHwT2UnQhICM=;
	b=LdTUrcB0dW7oQ5OSz+p27Rw/40IUzZ3kspAb9Bb6GZdmumh4WAMq8CbMTfus2JQ0xy
	tAbAaNlcRSpLTy9OpQFsl/uXOcrSsFDB+UCWUAyKyDQLrOVblP3ICU44EHQW+cx29nBq
	xNo5yzrVaqa7jMuuMA2adv6Sy9ejThl+A7eeGc4HD9nvdwE4+MWXd9q9XdCUGSbuP67v
	U589o1ETHPPYizq2ieyJMSXc/MmzRYPS1glL7n/bBTULF4a34CF6JCeAYQVOrPMma0vq
	HSl9N/4OAUTCQsKzeei0e5jc5J+l2QYzc52hQwfbinDI3CzWpJXsmHg0keLiZaRKao1N
	MNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=oqAGJXCcrmzUdmSG3sZCijkOSbKbEdDFHwT2UnQhICM=;
	b=Mgkijv1uB7qI1XYhEB05JQADxx2Ck8NYlocaOSdbWMOnYflI8kwLQzWRIMFUG12sJM
	i5V2Kp+smcHzzNCymTGpqii2vHNqBXh0Es3FiPjKzhXN1HtJx8fkpa0GN1EJlobl03YA
	rOFajLnf8QJQrBydHGxDsK7OZkLlvn/DaEvhviQ2nTkVd6z3StKwPf/IpNjjA9O9WeWh
	h+5thi0jPE5XHwdKKpN+q5xY1oa6X4eP4JL7wkpLKbBhzkR18PICgfKD0M3qdsMTlMzS
	1W47lJrocI2MlpO1squL4h7SsLPc5pWKjTksOO2ZnZhHZ6vG07RFqk4LIQ30gR2DEDvV
	Lm0Q==
X-Gm-Message-State: APjAAAVS25y2MulzFUcPmtrsvLcyYras9kD9IYknTSHXiI/rb3/4hK3/
	r03V8cB7REKeb99Snnn0p/28Cr7uAQo=
X-Google-Smtp-Source: APXvYqyaWBHL/vMYhDm9OJzFA1nl8x2ogsnMA1Sh0YOctUAvf17Cia67NpVXBzZRqaxL5hi1YMy6iw==
X-Received: by 2002:a25:7711:: with SMTP id s17mr16169011ybc.327.1558564106446;
	Wed, 22 May 2019 15:28:26 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:07 -0400
Message-Id: <20190522222821.23850-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b2e
Subject: [Qemu-devel] [PULL 02/16] tcg: Fix missing checks and clears in
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
Cc: peter.maydell@linaro.org
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


