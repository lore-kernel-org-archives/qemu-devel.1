Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4E0C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF962075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBjeiBOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF962075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBanL-0001b0-1M
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacu-0005Co-Ip
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacs-0004MZ-QW
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id a5so628847wrm.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=q2SOyhlGgEPSy3V2k6pu6+0RR4P2AO7ul/vaktw5y5o=;
 b=YBjeiBOf8NK3YhBeNVqfGWLW5SKxyIGobWDCj7TzEhkdulVWXI7DpMD8IsXZPVSwqH
 eISHGJlXyFhHET4XL0gRCwfHOMOH+7VtjCObV91GtiwfVJZPWjWPlM7q+GW1Id49aWR4
 w2E9/ow1epqnwiR/usMYpi+pAVJlja2p7RbECEbDGUI+onMuXQ9y/7hKl2V0ulAn2mpu
 ICQXD17+t7JFCcO+tqV7gAbjhWTV6RaifotT87D9irI0yluyOKOcS7sSedaLCj4f1PX/
 n1IFSB6DKizKQjUuWHexTMj8T+sUbjBr9TVjc5MzfTZielgckQ/modWmNzmqqw0hURMZ
 rcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q2SOyhlGgEPSy3V2k6pu6+0RR4P2AO7ul/vaktw5y5o=;
 b=ctoMDsiccBqn/XYYmhJGg0lWXQlBlKHju8/rl7HSSgwRs7Te1A0gMHSeTQVded4JXO
 0JJDDMY+FFOjiUw4eyDEwPIR8fbP4d2QZyjwKR9f8Hk55WSiLDjDYoa0WGJRNjE9zG9W
 gtC3NedSOXAqtiesQpjF0Ep9rt5K7z/me/Dk+odSnS0Mj03FIYUnsxA033f5i0JKtRmn
 PbFf21r9AaosE+PlDN549M0qQ2sMaCYhtpRU8+UnZTrTyAnbvr8hsMldbxL23MbwE9Wp
 egQMB+Wkmf0dcshntH7GW8IJziRf6oTi3PgL454mNKeTlfU3OnSeFQbEtIzUuq5yCKgR
 GBTQ==
X-Gm-Message-State: AOAM532sDKni9XY2/DWam60EZeFnMudppI8L5x6/sn/jSlQ9wHL+L/c+
 MWQR2KFlRbECCTOKZjO/HL2IjEX9pPJ7umBC
X-Google-Smtp-Source: ABdhPJxvQUOvP7fVmmMmDMfFnNZL71uHcnIivXtSFW5TY8gjONkJYxUMPqTikZuvcDoBxQGYy5mWUA==
X-Received: by 2002:a5d:4850:: with SMTP id n16mr688817wrs.92.1598606689264;
 Fri, 28 Aug 2020 02:24:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/35] target/arm: Split out gen_gvec_ool_zzp
Date: Fri, 28 Aug 2020 10:24:06 +0100
Message-Id: <20200828092413.22206-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Model after gen_gvec_fn_zzz et al.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index aba156d5ab6..6d10e2ac2c7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -142,6 +142,17 @@ static int pred_gvec_reg_size(DisasContext *s)
     return size_for_gvec(pred_full_reg_size(s));
 }
 
+/* Invoke an out-of-line helper on 2 Zregs and a predicate. */
+static void gen_gvec_ool_zzp(DisasContext *s, gen_helper_gvec_3 *fn,
+                             int rd, int rn, int pg, int data)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       pred_full_reg_offset(s, pg),
+                       vsz, vsz, data, fn);
+}
+
 /* Invoke an out-of-line helper on 3 Zregs and a predicate. */
 static void gen_gvec_ool_zzzp(DisasContext *s, gen_helper_gvec_4 *fn,
                               int rd, int rn, int rm, int pg, int data)
@@ -415,11 +426,7 @@ static bool do_zpz_ool(DisasContext *s, arg_rpr_esz *a, gen_helper_gvec_3 *fn)
         return false;
     }
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           pred_full_reg_offset(s, a->pg),
-                           vsz, vsz, 0, fn);
+        gen_gvec_ool_zzp(s, fn, a->rd, a->rn, a->pg, 0);
     }
     return true;
 }
@@ -603,11 +610,7 @@ static bool do_movz_zpz(DisasContext *s, int rd, int rn, int pg,
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
-                           vec_full_reg_offset(s, rn),
-                           pred_full_reg_offset(s, pg),
-                           vsz, vsz, invert, fns[esz]);
+        gen_gvec_ool_zzp(s, fns[esz], rd, rn, pg, invert);
     }
     return true;
 }
@@ -616,11 +619,7 @@ static bool do_zpzi_ool(DisasContext *s, arg_rpri_esz *a,
                         gen_helper_gvec_3 *fn)
 {
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           pred_full_reg_offset(s, a->pg),
-                           vsz, vsz, a->imm, fn);
+        gen_gvec_ool_zzp(s, fn, a->rd, a->rn, a->pg, a->imm);
     }
     return true;
 }
-- 
2.20.1


