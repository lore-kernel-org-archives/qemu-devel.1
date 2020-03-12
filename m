Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E0AC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209A620637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iz9sohRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209A620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTrE-0004Db-6t
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj4-00059i-BA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj3-0001sH-7L
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:38 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTj3-0001rX-0E
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:37 -0400
Received: by mail-pl1-x643.google.com with SMTP id g2so569180plo.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vuXdTs06kem+zl5v2k/H9+yey7HUM714c+09ME0Bjkg=;
 b=iz9sohRft4D9uRi34zYLnkcdeuYuaRlbH5kQo7eRR1/e7VPH4K4Tjc4NMe9l38s4fU
 LKU8fAYriEpgtYMww3XYpdo1P/nU8TZcCNienZSyx1UcLgNB5uV/3iKzAWvoE90xTBje
 1xm5O2JWrJuODowJIlGj8IlWMIo7mLelZe/LaARcxNRnT/hvWHYH1Pc+pqdIwtAqxRAy
 2N0XzpmdHo2zrr87q7rUR0TaaOWOwDAJ3joD7NkkFWwtgKJJzrDQtoJqa/jIYUcggRPP
 QVkvaxwtGKROVTsG2gPJ06vndlWwiTP9ABVW7LB/CF29Is/w8kVe5w6cOoJehDaw9Lo+
 3aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vuXdTs06kem+zl5v2k/H9+yey7HUM714c+09ME0Bjkg=;
 b=POtF/v2w4BOOSc9avWKsMUmKC2OlHCdEOSRWyLuEMuivSNqlkqr1PaJCeWChgborxR
 13hb0WnexZrw7aR9GKbPLPRfGO+wx/L00s5ry5Ol6Mjnh9TGFytqaIzgTg4aUYPw05HH
 d96vSLWatgYw/5A3zL02CNysf0Fn5WquCRPL0PS1jlmHDpqwGiaYB0y+zyyPQzf6Zi9E
 jdWERCZ0QvNdAUIDiBz5uEZWUo6g1jsfXrI7BMXaGORsZ/c3qyB81O6x5TZNxEdnqR/r
 Jf85o7l5VpGfxY2nWBasu7C2F2R/eBJcY2vWm36waCelYNN/Tcz6Fr7qlbCzlXaA3+w9
 zlXA==
X-Gm-Message-State: ANhLgQ15ozoGe6b+dJoqch2mUwO2yoWjQgMkex5GletrFGm2KdGBG/KC
 PKk06nw+G7UjFo/MDXRcllOhSh+IHR8=
X-Google-Smtp-Source: ADFU+vsKEQLUZZnJN6ZTtI9bx9IQVtIb8yCOdGzzJtAe2wF6GoQ+7kdu+n68zRj4ngsm8qqJtRA6ug==
X-Received: by 2002:a17:90a:e658:: with SMTP id
 ep24mr5584622pjb.70.1584042155798; 
 Thu, 12 Mar 2020 12:42:35 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/42] target/arm: Implement the GMI instruction
Date: Thu, 12 Mar 2020 12:41:48 -0700
Message-Id: <20200312194219.24406-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Inline the operation.
---
 target/arm/translate-a64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 02f31d5948..9adc259186 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5379,6 +5379,21 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
                                              cpu_reg_sp(s, rn));
         }
         break;
+    case 5: /* GMI */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        } else {
+            TCGv_i64 t1 = tcg_const_i64(1);
+            TCGv_i64 t2 = tcg_temp_new_i64();
+
+            tcg_gen_extract_i64(t2, cpu_reg_sp(s, rn), 56, 4);
+            tcg_gen_shl_i64(t1, t1, t2);
+            tcg_gen_or_i64(cpu_reg(s, rd), cpu_reg(s, rm), t1);
+
+            tcg_temp_free_i64(t1);
+            tcg_temp_free_i64(t2);
+        }
+        break;
     case 8: /* LSLV */
         handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
         break;
-- 
2.20.1


