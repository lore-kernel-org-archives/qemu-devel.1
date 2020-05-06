Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EADC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD5420736
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z224c+SG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD5420736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOs1-0000io-9v
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo6-0004NW-8P
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:10 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:43267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo5-0002sA-5J
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:09 -0400
Received: by mail-pg1-x52e.google.com with SMTP id l12so1165603pgr.10
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J8tKD8Dhorc/rZ7Pqa63r7FVSLYqB5ObHvXNIyPd1G0=;
 b=Z224c+SGLRaP3J2LemA0zY6VD+nK3zFDJvhmhebbjwO+826eoG0S5tOoXGkggARf+8
 Hybl9uCgJJY6kfpt8S6nFki4Z8EDIWd9xNHeJx9IdlYMiJmnGdw0IJkYPVH85VblTiRI
 OmRmxnrjbdB3glj6ZUxo6WxlgdDmNbdRPax0cEFwSKA3rqOFUilAflpdYGwbzw1iAM92
 27mJf5W75Xt5OJt5iGqYB7RCGfkph4Xlu7ImVHP9Z22RkOFXndvWt+cqoCpDYUZ2KqRD
 +7uvxjrGn6++IF0h7kTkIIHz8pGA+jbi/967+JHJPSCZMwyWmeg16WDZl6QVtbCMGCog
 /yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J8tKD8Dhorc/rZ7Pqa63r7FVSLYqB5ObHvXNIyPd1G0=;
 b=sAuNQhcIsXBMgiG02Z+ZypzYa7QXKRmOdSY14KnACvBHKhdq0n5HddKUDF3s+b/Dye
 36cuBt96Wgu0A5j/hesPf0KdBFvEmlbjPXBy1+uxSeSCKHZWElw42rHqV67PwofqxNBU
 2dxTvSPgwj2E2MGfHd2gOjj0qrs836fJXgrC76wCjcd/SGlkZlZ2eI1Cn2Rka4vz0aMz
 H4sQm4CddYf7I4OQr1309eOF+v5zLeGIAojIwYTO71auMMfmdnEEfAD/wyFHQ3k9hEaB
 2vAsFj7ZgMCTu0GEgi4fjrJCLZpSxaW4jdaMAvnnxFba3jv873Z73Xc7CAAqBdxYfslv
 lssg==
X-Gm-Message-State: AGi0PuYZdM9YrA85odXy1q6eIZ0/bemvWUSGaX4l/VRuO4N1V4gyLjpk
 Bm97FWb5GbqisP5L8TncqqSvLMyrS7g=
X-Google-Smtp-Source: APiQypI30nFh8pWb9FFwQvjOmY/zv5tmkXL8BF4xy+Z/JOj9U2FCtxUerJfuH/Z9zxpJhDb9YkCbBA==
X-Received: by 2002:aa7:8dd2:: with SMTP id j18mr9491524pfr.74.1588789807476; 
 Wed, 06 May 2020 11:30:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2572589pfq.100.2020.05.06.11.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 11:30:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] target/ppc: Use tcg_gen_gvec_dup_imm
Date: Wed,  6 May 2020 11:29:55 -0700
Message-Id: <20200506183002.3192-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506183002.3192-1-richard.henderson@linaro.org>
References: <20200506183002.3192-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
Cc: peter.maydell@linaro.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can now unify the implementation of the 3 VSPLTI instructions.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/vmx-impl.inc.c | 32 ++++++++++++++++-------------
 target/ppc/translate/vsx-impl.inc.c |  2 +-
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 81d5a7a341..403ed3a01c 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -1035,21 +1035,25 @@ GEN_VXRFORM_DUAL(vcmpbfp, PPC_ALTIVEC, PPC_NONE, \
 GEN_VXRFORM_DUAL(vcmpgtfp, PPC_ALTIVEC, PPC_NONE, \
                  vcmpgtud, PPC_NONE, PPC2_ALTIVEC_207)
 
-#define GEN_VXFORM_DUPI(name, tcg_op, opc2, opc3)                       \
-static void glue(gen_, name)(DisasContext *ctx)                         \
-    {                                                                   \
-        int simm;                                                       \
-        if (unlikely(!ctx->altivec_enabled)) {                          \
-            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
-            return;                                                     \
-        }                                                               \
-        simm = SIMM5(ctx->opcode);                                      \
-        tcg_op(avr_full_offset(rD(ctx->opcode)), 16, 16, simm);         \
+static void gen_vsplti(DisasContext *ctx, int vece)
+{
+    int simm;
+
+    if (unlikely(!ctx->altivec_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VPU);
+        return;
     }
 
-GEN_VXFORM_DUPI(vspltisb, tcg_gen_gvec_dup8i, 6, 12);
-GEN_VXFORM_DUPI(vspltish, tcg_gen_gvec_dup16i, 6, 13);
-GEN_VXFORM_DUPI(vspltisw, tcg_gen_gvec_dup32i, 6, 14);
+    simm = SIMM5(ctx->opcode);
+    tcg_gen_gvec_dup_imm(vece, avr_full_offset(rD(ctx->opcode)), 16, 16, simm);
+}
+
+#define GEN_VXFORM_VSPLTI(name, vece, opc2, opc3) \
+static void glue(gen_, name)(DisasContext *ctx) { gen_vsplti(ctx, vece); }
+
+GEN_VXFORM_VSPLTI(vspltisb, MO_8, 6, 12);
+GEN_VXFORM_VSPLTI(vspltish, MO_16, 6, 13);
+GEN_VXFORM_VSPLTI(vspltisw, MO_32, 6, 14);
 
 #define GEN_VXFORM_NOA(name, opc2, opc3)                                \
 static void glue(gen_, name)(DisasContext *ctx)                         \
@@ -1559,7 +1563,7 @@ GEN_VXFORM_DUAL(vsldoi, PPC_ALTIVEC, PPC_NONE,
 #undef GEN_VXRFORM_DUAL
 #undef GEN_VXRFORM1
 #undef GEN_VXRFORM
-#undef GEN_VXFORM_DUPI
+#undef GEN_VXFORM_VSPLTI
 #undef GEN_VXFORM_NOA
 #undef GEN_VXFORM_UIMM
 #undef GEN_VAFORM_PAIRED
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 8287e272f5..b518de46db 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1579,7 +1579,7 @@ static void gen_xxspltib(DisasContext *ctx)
             return;
         }
     }
-    tcg_gen_gvec_dup8i(vsr_full_offset(rt), 16, 16, uim8);
+    tcg_gen_gvec_dup_imm(MO_8, vsr_full_offset(rt), 16, 16, uim8);
 }
 
 static void gen_xxsldwi(DisasContext *ctx)
-- 
2.20.1


