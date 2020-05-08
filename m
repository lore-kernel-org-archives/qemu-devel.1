Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2097EC47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC15120736
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AE8E3+zN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC15120736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4jM-0002BS-VH
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4eV-0002S0-Hd
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:03 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4eU-00040i-FN
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:03 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mq3so4390403pjb.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/K1ycY1z79VZy1TG8t7nnh9EG9pxzEbf4Elb16Ela3g=;
 b=AE8E3+zNPcgfJoWKOALOSXXGsU2ya883IeASEzmfjiB7d7y9oT53m5aGyFk20VipUh
 DagXrJreD6sRv0uqtkfxsVNa/j4kHPWdsMGeij7VraSHl+ZHTYc2xjiRY1+Hb402LTeN
 jv+CrEITpe8s3E9O2iid5klqLQGtEnfAfOqusBMZsqQU9XgWpW8zDaurns3iQJTiMIs8
 5pLoFmXYMlybI59/HgRJDXEMepM5SaV8P7PMlPNs7dGoGr2ripkgHEiXXwVCmFVR0EI7
 5E4oa3cXSBxA/9hvDol6Z7dXjMS+uaH6iiaz5bEN3OPjlvjivR1suhK6Q/O4iH2/IdCX
 /fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/K1ycY1z79VZy1TG8t7nnh9EG9pxzEbf4Elb16Ela3g=;
 b=UuRJh9/r/P4nl6ECGBbE+dges5EPlJw9v3KxRCcWK27ViBp+KEl2a8jfJzwCLEoiYg
 j6YrTr1PghIyyJZM4sjDE2tTxfrmBDFR5agyRonhBgobZGOCiEWxujORC/zRQwzFkifh
 FasFybhXCNF+yiTpZsF2Czyfq4seMawhYFbYDZa+KMEcaT5eYwyUqD6+3GohcjfKCWHR
 vzJrR9AApSAijUJ22g7pps6CgaxHaeRFgoyFcy1sZSrtcwrfOaLE9L3+oCkDNuFxKZFH
 h6KMw63PtDltL4BYkrlxKH4tpw0a70C8dBtR9RRCDq00ouykJb9DybGG8rCuG1DOrolV
 Q6iw==
X-Gm-Message-State: AGi0PuZ6HjDsgEVFQZ0E+PtB7F7kvsuBxRseKZhB2IyIPa8i5I3leZ+N
 WWU66gIyxofKuENYHLT8mqHO2M46bII=
X-Google-Smtp-Source: APiQypIFon/p3UT2dVOmmVq/8gtNhAXVxrrnBxe/ERQbY1X+u0wAd2MnBvobseg7EJCkj2/pvjj+tA==
X-Received: by 2002:a17:90a:12c3:: with SMTP id
 b3mr6714772pjg.57.1588950660718; 
 Fri, 08 May 2020 08:11:00 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d13sm1557562pga.64.2020.05.08.08.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:11:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/10] tcg: Remove expansion to shift by vector from
 do_shifts
Date: Fri,  8 May 2020 08:10:48 -0700
Message-Id: <20200508151055.5832-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151055.5832-1-richard.henderson@linaro.org>
References: <20200508151055.5832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

We do not reflect this expansion in tcg_can_emit_vecop_list,
so it is unused and unusable.  However, we actually perform
the same expansion in do_gvec_shifts, so it is also unneeded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 488f9bd27b..fb1250fee6 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -707,7 +707,7 @@ void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 }
 
 static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
-                      TCGv_i32 s, TCGOpcode opc_s, TCGOpcode opc_v)
+                      TCGv_i32 s, TCGOpcode opc)
 {
     TCGTemp *rt = tcgv_vec_temp(r);
     TCGTemp *at = tcgv_vec_temp(a);
@@ -716,48 +716,35 @@ static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
     TCGArg ai = temp_arg(at);
     TCGArg si = temp_arg(st);
     TCGType type = rt->base_type;
-    const TCGOpcode *hold_list;
     int can;
 
     tcg_debug_assert(at->base_type >= type);
-    tcg_assert_listed_vecop(opc_s);
-    hold_list = tcg_swap_vecop_list(NULL);
-
-    can = tcg_can_emit_vec_op(opc_s, type, vece);
+    tcg_assert_listed_vecop(opc);
+    can = tcg_can_emit_vec_op(opc, type, vece);
     if (can > 0) {
-        vec_gen_3(opc_s, type, vece, ri, ai, si);
+        vec_gen_3(opc, type, vece, ri, ai, si);
     } else if (can < 0) {
-        tcg_expand_vec_op(opc_s, type, vece, ri, ai, si);
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
+        tcg_expand_vec_op(opc, type, vece, ri, ai, si);
+        tcg_swap_vecop_list(hold_list);
     } else {
-        TCGv_vec vec_s = tcg_temp_new_vec(type);
-
-        if (vece == MO_64) {
-            TCGv_i64 s64 = tcg_temp_new_i64();
-            tcg_gen_extu_i32_i64(s64, s);
-            tcg_gen_dup_i64_vec(MO_64, vec_s, s64);
-            tcg_temp_free_i64(s64);
-        } else {
-            tcg_gen_dup_i32_vec(vece, vec_s, s);
-        }
-        do_op3_nofail(vece, r, a, vec_s, opc_v);
-        tcg_temp_free_vec(vec_s);
+        g_assert_not_reached();
     }
-    tcg_swap_vecop_list(hold_list);
 }
 
 void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
 {
-    do_shifts(vece, r, a, b, INDEX_op_shls_vec, INDEX_op_shlv_vec);
+    do_shifts(vece, r, a, b, INDEX_op_shls_vec);
 }
 
 void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
 {
-    do_shifts(vece, r, a, b, INDEX_op_shrs_vec, INDEX_op_shrv_vec);
+    do_shifts(vece, r, a, b, INDEX_op_shrs_vec);
 }
 
 void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
 {
-    do_shifts(vece, r, a, b, INDEX_op_sars_vec, INDEX_op_sarv_vec);
+    do_shifts(vece, r, a, b, INDEX_op_sars_vec);
 }
 
 void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TCGv_vec a,
-- 
2.20.1


