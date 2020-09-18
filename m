Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15128C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A4E21707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J73Hc7k8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A4E21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLk7-0005uT-Oe
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI0-0000s3-B1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:21 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:36858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHq-0007Dj-62
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:19 -0400
Received: by mail-pg1-x533.google.com with SMTP id f2so3991113pgd.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r8CExXyc5Biic3ZXnX/VF5QU/88e8T+vsiHKGnc7erQ=;
 b=J73Hc7k8aprsC2Kyh7FWm8qs+wlrmokdslblzsDefg1yvyGeQg+MaaQgfvmro9E98J
 g588OxBgAABuD0iWM4XW5uWh1JmL5a+bdljEs4IaRRbpslOc0BtugdUBbZlfxSCPwQFx
 ZkXK5Wvdp/gU9ekjLNNqxCJmUXAtCpmLFvKIWZ48qaAbZkRD5sLCmNcANXQnk/7Aji4K
 Mi3LJ1YX7LRmZKw4aOHonMdkjz+gI50Cl2bWF6HgkLyLqXe5WldG1yruWDmLIH1ueyM7
 WBJqSPSMLIWHdgErbyIIJiseUHKEnV4pkpp1NfEOJ6iIOCq7krOpXkRoUtHsLDr41sZO
 i1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r8CExXyc5Biic3ZXnX/VF5QU/88e8T+vsiHKGnc7erQ=;
 b=D6hzmCH91G7kWd33hHL9hyU0BzXByElwmTrB3xE2SUNBj3y6B2eGhF7oHji7N6rZsO
 TIc/434KrLLbEwGoWh403qOcPc7xj40Oa1lM/f7bZzLf57iUT4bL5gCUKn8QTXFPZhj6
 MEDEx0wKc8/b91+1PEq9J7xe8cQMgzUL4qNSWoCNrkuztvXid/GeyDvgZXJjp2N/3Lpz
 gU2iMyZbxyoJQjaAoyryKRABLCDb8vsDmngD1+9XUHBvA5J20/BFzLlkAulSrbeTmkDx
 zdjHeAv1Nnu/UrkHMPOnZvouHbs51bi8OYzpkAh79fe4qGIrFnvTU74Adi7rAh62Dj3e
 grYg==
X-Gm-Message-State: AOAM5318VZRDodQETAbhuTO7TLj/1qrQYrwwOLpIyXZeARJ4MvH92jxO
 U9O0APv6rrYu9AQ/ppBqv3hPeJbggNAohw==
X-Google-Smtp-Source: ABdhPJxoYtrSLFPYDViw1wf2Agzdt/HHvbOFziCP6RXpjrXivWPOkjE8M7d2jf00y9Mx6pDQMn1tqg==
X-Received: by 2002:a62:2c8:0:b029:13e:9ee9:5b25 with SMTP id
 191-20020a6202c80000b029013e9ee95b25mr33655368pfc.1.1600454347295; 
 Fri, 18 Sep 2020 11:39:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 56/81] target/arm: Implement SVE2 integer multiply-add
 (indexed)
Date: Fri, 18 Sep 2020 11:37:26 -0700
Message-Id: <20200918183751.2787647-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  8 ++++++++
 target/arm/translate-sve.c | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index fa0a572da6..467a93052f 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -785,6 +785,14 @@ SDOT_zzxw_d     01000100 .. 1 ..... 000000 ..... .....          @rrxr_d
 UDOT_zzxw_s     01000100 .. 1 ..... 000001 ..... .....          @rrxr_s
 UDOT_zzxw_d     01000100 .. 1 ..... 000001 ..... .....          @rrxr_d
 
+# SVE2 integer multiply-add (indexed)
+MLA_zzxz_h      01000100 .. 1 ..... 000010 ..... .....          @rrxr_h
+MLA_zzxz_s      01000100 .. 1 ..... 000010 ..... .....          @rrxr_s
+MLA_zzxz_d      01000100 .. 1 ..... 000010 ..... .....          @rrxr_d
+MLS_zzxz_h      01000100 .. 1 ..... 000011 ..... .....          @rrxr_h
+MLS_zzxz_s      01000100 .. 1 ..... 000011 ..... .....          @rrxr_s
+MLS_zzxz_d      01000100 .. 1 ..... 000011 ..... .....          @rrxr_d
+
 # SVE2 integer multiply (indexed)
 MUL_zzx_h       01000100 .. 1 ..... 111110 ..... .....          @rrx_h
 MUL_zzx_s       01000100 .. 1 ..... 111110 ..... .....          @rrx_s
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 90f0b1ff9b..a6235d78d5 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3870,6 +3870,29 @@ DO_SVE2_RRX(trans_MUL_zzx_d, gen_helper_gvec_mul_idx_d)
 
 #undef DO_SVE2_RRX
 
+static bool do_sve2_zzxz_ool(DisasContext *s, arg_rrxr_esz *a,
+                             gen_helper_gvec_4 *fn)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zzxz_ool(s, a, fn);
+}
+
+#define DO_SVE2_RRXR(NAME, FUNC) \
+    static bool NAME(DisasContext *s, arg_rrxr_esz *a)  \
+    { return do_sve2_zzxz_ool(s, a, FUNC); }
+
+DO_SVE2_RRXR(trans_MLA_zzxz_h, gen_helper_gvec_mla_idx_h)
+DO_SVE2_RRXR(trans_MLA_zzxz_s, gen_helper_gvec_mla_idx_s)
+DO_SVE2_RRXR(trans_MLA_zzxz_d, gen_helper_gvec_mla_idx_d)
+
+DO_SVE2_RRXR(trans_MLS_zzxz_h, gen_helper_gvec_mls_idx_h)
+DO_SVE2_RRXR(trans_MLS_zzxz_s, gen_helper_gvec_mls_idx_s)
+DO_SVE2_RRXR(trans_MLS_zzxz_d, gen_helper_gvec_mls_idx_d)
+
+#undef DO_SVE2_RRXR
+
 /*
  *** SVE Floating Point Multiply-Add Indexed Group
  */
-- 
2.25.1


