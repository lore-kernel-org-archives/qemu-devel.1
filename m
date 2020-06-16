Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6B6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A75208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IG8cbs/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A75208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFFe-0008TB-DI
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF57-0001S3-B4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF55-0007Uh-Dd
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so21577827wru.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7LajX6MigHB41GQ8EUoLxZbQvXk12YJJTXi7/b1pm8I=;
 b=IG8cbs/tjzQOL7NuXNYgazP4L0BqzXhTAGCSn26mxKUwoTfxPsX4k0wGgTkQfzimfS
 tf6ScVYyYbevZPvQ0cLW52Cd+T/GdKtDjCn4le/7G/WL9eNgnosOWBZ4EdsfaU77Okan
 vcQ+dj43pjhOImPJjquB24P1LCjBiOU6lrDj7+idrCBd2nMJzfNkVUdsD6A0TcNtehNQ
 EbukkZ0cE/Cl5FjV7cQoEFvIPz198wDd7OEKmnhNt1AdwZoZv6xDL3k3ViB9XSRQTUV8
 cUSyaOR06ZDCZ0b+sBoPn81ppU4YtWyazGqSLZ3JfjcoSIrBuSPKVxc/gz7oQgOiRHIw
 bOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7LajX6MigHB41GQ8EUoLxZbQvXk12YJJTXi7/b1pm8I=;
 b=M+UVFbG+KZyQP2FhyTZ16mlwhTtQLd+TEVDjxrPtwsuaPvzjLhdrnJke/oJUy/t14H
 Jh90hETz5n6Zv7pMIUdJj5X6RueVXIktxoLzj3XoDwjj/blRlV/d3vF1QK9vqu6w3Ybe
 7I5bVQ6rIhA5T2jX8JKbSkLmiACD3att28mRWmDJ5fiPOFVi+PolRFOgMNqvKnY2q7AE
 qB+xep/JqzYIA3JiBCZt2KlTM33bgWE7PwyCp6lVZj2k9WK544A/Vvki8uzacy1v/ipm
 AR97bOnpfkw3gUYRxx23wVzHMTs/C4QZlFdYjKYxJyDVsne7kVpQEI/D3mU9k/WTcjZv
 vImw==
X-Gm-Message-State: AOAM533T5cEac5xiTJ9zdOIzFANI5sy7+VA94cdpNcvex+KV5ggm14j5
 8kr9imfBsrqqj1rXVYokN4pesg==
X-Google-Smtp-Source: ABdhPJyHcAIWSOnAmjBIqCBz8xN65TKkCD29RzerGPYBIxO1/KrkzgNl4X32whF5dxvfCe+UWM0wqQ==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr4368917wrx.55.1592327341941; 
 Tue, 16 Jun 2020 10:09:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:09:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/21] target/arm: Make gen_swap_half() take separate src and
 dest
Date: Tue, 16 Jun 2020 18:08:34 +0100
Message-Id: <20200616170844.13318-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make gen_swap_half() take a source and destination TCGv_i32 rather
than modifying the input TCGv_i32; we're going to want to be able to
use it with the more flexible function signature, and this also
brings it into line with other functions like gen_rev16() and
gen_revsh().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c |  2 +-
 target/arm/translate.c          | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index c39443c8cae..4967e974386 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3007,7 +3007,7 @@ static bool trans_VREV64(DisasContext *s, arg_VREV64 *a)
                 tcg_gen_bswap32_i32(tmp[half], tmp[half]);
                 break;
             case 1:
-                gen_swap_half(tmp[half]);
+                gen_swap_half(tmp[half], tmp[half]);
                 break;
             case 2:
                 break;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 38644995ab2..64b18a95b64 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -378,9 +378,9 @@ static void gen_revsh(TCGv_i32 dest, TCGv_i32 var)
 }
 
 /* Swap low and high halfwords.  */
-static void gen_swap_half(TCGv_i32 var)
+static void gen_swap_half(TCGv_i32 dest, TCGv_i32 var)
 {
-    tcg_gen_rotri_i32(var, var, 16);
+    tcg_gen_rotri_i32(dest, var, 16);
 }
 
 /* Dual 16-bit add.  Result placed in t0 and t1 is marked as dead.
@@ -4960,7 +4960,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         case NEON_2RM_VREV32:
                             switch (size) {
                             case 0: tcg_gen_bswap32_i32(tmp, tmp); break;
-                            case 1: gen_swap_half(tmp); break;
+                            case 1: gen_swap_half(tmp, tmp); break;
                             default: abort();
                             }
                             break;
@@ -8046,7 +8046,7 @@ static bool op_smlad(DisasContext *s, arg_rrrr *a, bool m_swap, bool sub)
     t1 = load_reg(s, a->rn);
     t2 = load_reg(s, a->rm);
     if (m_swap) {
-        gen_swap_half(t2);
+        gen_swap_half(t2, t2);
     }
     gen_smul_dual(t1, t2);
 
@@ -8104,7 +8104,7 @@ static bool op_smlald(DisasContext *s, arg_rrrr *a, bool m_swap, bool sub)
     t1 = load_reg(s, a->rn);
     t2 = load_reg(s, a->rm);
     if (m_swap) {
-        gen_swap_half(t2);
+        gen_swap_half(t2, t2);
     }
     gen_smul_dual(t1, t2);
 
-- 
2.20.1


