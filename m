Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4496DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA312186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+31fxzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA312186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmfT-00055W-AI
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDY-0004xF-Rr
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:00 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:50190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDX-0003Pq-Cs
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:00 -0400
Received: by mail-pj1-x1044.google.com with SMTP id jz3so1973289pjb.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GAkIUDgO8V3oOvXo3LsF2MLgsc+DjBVXnodAscreOV0=;
 b=h+31fxzODWT3ozuK8AeBDCzL72dq4Z/NeHnB1iLzi54oBJGaHNW4RdcdUXc+0RyV2f
 gMvVQyj7RXDpfsbJ1NKuVuoWb/3sBwnTeLmHNPZu5IBcwOXnjYyKFLN+wLGIe7odgpyg
 X9eYaZaza/uuvoTVpj2XYbiv6TagfRNSfbxJ4IYiwCtksHBEFea7mExIh47B3VbJKPX8
 vsJGtQtzrUKY20Yao/qSssyI9egnIFfEaIUzmeN31rxS6zZ3dUCHr2L6cnOL0Zlnzp7V
 wFGDLpBk0BH2/GW3n4NBNQAWnhY9YEVmABuxsxKnbN4AcVZ5kMwIbKe89R3NiC7+mXL2
 BbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GAkIUDgO8V3oOvXo3LsF2MLgsc+DjBVXnodAscreOV0=;
 b=pT+iZ2GwtLyV1kZKoVefA4WGEL5fL4E8WB7yj2lkxShy766w5nlQRuX2JTLVKnceYq
 sYac1PFONpXqJY11zvGvAhr7sTM0rhe7RCsaPAP81YbPhTsypFd3lH7rrYc5JMTHevMD
 oJqPFPRMCOOfVrL+qqpAx1M16hQ1ofjq+tvfFn0SmeaTqZwzCEnHCA1WaEGmP9XY2tTa
 IomvRHIxwPmLHslXIHAKUvfwBM0gFdGQixlVH8bh4V5hB6SGjgZ1gAp6jUw2rUvLBn7W
 hsg4yVO5g+3vUa81pk6Fts1ZjhRBQYQ3a5aMYERA1iCuZUAK+NNWv0xJbxPfrdrmcDuH
 CzJg==
X-Gm-Message-State: AOAM531gB+o2ThspGjZ5CQsa8cqkikUgrIv6dmurmiB0d1Qdci1J6KbM
 4WK/U2Eqp2Mok4di5h/RyPBs3mmFh68=
X-Google-Smtp-Source: ABdhPJwcxqpeF44rVx+JZQ/V9mCD8+6FU+cS1g3uF6g80lxT8EAvabY52bdYejl0ilP+okYu+pT+5g==
X-Received: by 2002:a17:902:9f8d:: with SMTP id
 g13mr2138887plq.292.1592454717796; 
 Wed, 17 Jun 2020 21:31:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s15sm1162840pgv.5.2020.06.17.21.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:31:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 072/100] target/arm: Use helper_gvec_mul_idx_* for aa64
 advsimd
Date: Wed, 17 Jun 2020 21:26:16 -0700
Message-Id: <20200618042644.1685561-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 341b11f98d..a3135754ce 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13037,6 +13037,22 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                                data, gen_helper_gvec_fmlal_idx_a64);
         }
         return;
+
+    case 0x08: /* MUL */
+        if (!is_long && !is_scalar) {
+            static gen_helper_gvec_3 * const fns[3] = {
+                gen_helper_gvec_mul_idx_h,
+                gen_helper_gvec_mul_idx_s,
+                gen_helper_gvec_mul_idx_d,
+            };
+            tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm),
+                               is_q ? 16 : 8, vec_full_reg_size(s),
+                               index, fns[size - 1]);
+            return;
+        }
+        break;
     }
 
     if (size == 3) {
-- 
2.25.1


