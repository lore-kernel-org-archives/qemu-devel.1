Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE9BC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7022420724
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgbx5lFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7022420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4Jj-0007s9-JJ
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41f-00027Q-2P
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41d-0002hL-Ar
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:06 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41b-0002dV-Ap
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:03 -0400
Received: by mail-pg1-x544.google.com with SMTP id f20so240982pgl.12
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m5JVm/hE+eWqh7YcSUCXJKnRiJGAH05U8LdEck/jm6k=;
 b=bgbx5lFiP+6nO0u2d4Sd8AC2RBpviAKo3HBql/Rrpk5IKeX1y8ZJDhWwZ9xCcff881
 o7nsDWZPQTP4DT+izGkxH6WsB6+/XP71ndSrSPGZjPt4Fiqjau26JD0cCmuNyq4YWnFV
 KRbq2rcLU65zJmWPglmCnTvNFHnqq+QI/76+TVsAVDIeYIQWyxrAEXFlCQX9SbLOuyjL
 JxJ44oEKfDyNx83U647vtCke+BmtFXfU4pHIZ7t34DbfkDYxTLB0AoDcRm40JpwNRqg2
 X166eTLUOmuJEFWBkOFAwtElHUm/hGDrY/KU+mmJG0eQq0LtlRUvRsG6BQbo0rTAwdj/
 KCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m5JVm/hE+eWqh7YcSUCXJKnRiJGAH05U8LdEck/jm6k=;
 b=m7dVee7bqU1YVcgnaHpgaEiwUdEQGFFQ78EdVqE8pi5r9Tfudp0lj9RMMDwKO+AUF9
 1zySSk0bfL+QHb+Ka89pr2aA1DU16suYcyaXAx65wP3bp+7Me8L+nP9X02eBAnJdmfN3
 JCYSDdtjQ9Uezd6cmHj5ciSo4jpxf27oRFiDQ55Hs95jrFpBJMW1YDgzz1klONiXIXHP
 yXSZOFTWnOqY5k00Nr4J31Ln1/fgKs4HuWyZMS0qs432FP1QIjgdVB5lyb99cgjIz/X1
 3A+oGAFa5hkBaRTmSmYfckB0mR4lIi4Q4rurT9DqpSsn2XcZZxQ59/gg/o55nXYAbrbX
 QI/g==
X-Gm-Message-State: AGi0PuZWQ9Wd7PsleFpkfRmFFMqYeUOWaoZg3o42wOgHhTi9TNcrBlBp
 xIzM+slstDWDLY4Mtci2FKKaOsI6jSk=
X-Google-Smtp-Source: APiQypKHwOPBeu/5n5H7a7ru39mmDGO8Vz522pzMgFKnN5MNd1LIVDvBiCbgeqfOLAlDk11DyY/JoQ==
X-Received: by 2002:a62:528e:: with SMTP id
 g136mr10769621pfb.165.1587518281596; 
 Tue, 21 Apr 2020 18:18:01 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:18:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/36] tcg: Remove expansion to shift by vector from
 do_shifts
Date: Tue, 21 Apr 2020 18:17:16 -0700
Message-Id: <20200422011722.13287-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
index 4af92d6b0a..52c1b66283 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -781,7 +781,7 @@ void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 }
 
 static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
-                      TCGv_i32 s, TCGOpcode opc_s, TCGOpcode opc_v)
+                      TCGv_i32 s, TCGOpcode opc)
 {
     TCGTemp *rt = tcgv_vec_temp(r);
     TCGTemp *at = tcgv_vec_temp(a);
@@ -790,48 +790,35 @@ static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
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


