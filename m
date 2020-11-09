Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E75BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06938206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ1LgZPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06938206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3RO-0004kx-1N
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thatlemon@gmail.com>)
 id 1kc3KY-0008HD-BN; Mon, 09 Nov 2020 04:19:18 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:32817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thatlemon@gmail.com>)
 id 1kc3KW-00024q-CW; Mon, 09 Nov 2020 04:19:18 -0500
Received: by mail-wr1-x433.google.com with SMTP id b8so7868258wrn.0;
 Mon, 09 Nov 2020 01:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KBIjlQM66mJvwO/muE6YXc28qkIsRWc0niT1cUKfknY=;
 b=fJ1LgZPNGSy3Wb2hZhpgHglCYuLT8Mw/qmjP73CPdsCz8Xpr6UR2Wf/BlBaE+EwjdV
 yXEueTt00/CxPOeWkgbLZebT3fG2QUGwAhRQ15AO8mbb8QoVUJKkkARR7D1WpUK264PM
 x0DcWBEqaS/mscv1WJMq+9QdX1RmP/cQyRocft8wIEwL3LSw0P6q2Q1IGPBsD7z+yj8D
 JXsWcfZku+k0T9Xv2rksYuEMH+EH8SMmV46uy4B27LT7MnRqbeofR7oJAFGOSQbUd9u7
 N6WW2lpdO1bfaH1AafLFKtKbGiP+tDK2Dzqr4GLJYk4yHwl6O+4dyTbwQSc/yFtWB1+Y
 gG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KBIjlQM66mJvwO/muE6YXc28qkIsRWc0niT1cUKfknY=;
 b=AukUZ+E+VokOAhUFGe03+VwnYX/5cIsm9MoVnSNmcw/LTm0dE2YgIIQ12pChZIL8kn
 FHtLdx3y0wXJp9XJRafmFY0p1gaon9KJjG/T5od2rDIMsBIkt37ooBLDnXMCuGYmz8Kh
 en1MmGcxg+EaM1VlGOjxgI9rcOuefwNkBZk1zltTXYBmd7/xq117UihIYkgjCmothp3t
 YtHdhJlW1k7qC3xQY40EL7Ik4mGLUs1DwszMZjyKjqyhii2bEiwFBVQf3Hmv32PjXhQ7
 AHda18RHdXBuv2RMLlJABWL1Iq9HsjBJErCmwTUsvP3RRPbtlk7nhDdTO7eBo7m5cwbR
 svmA==
X-Gm-Message-State: AOAM531P+38t8IF0GUfBk65vrXPQNnGDMbeY+BXpVZwwfkw+yclQI1wz
 1bEMO6wV16D9UCQHWZKFohrchgZwEyZZdw==
X-Google-Smtp-Source: ABdhPJwAvrKzsAY1WxKOyDSJ7evDponzb9OPlEbMH6zD3L+kIGyNFCXK3uBbD8GZBwWN6N3vojOk5Q==
X-Received: by 2002:adf:bb06:: with SMTP id r6mr1742886wrg.286.1604913553775; 
 Mon, 09 Nov 2020 01:19:13 -0800 (PST)
Received: from localhost.localdomain ([151.33.227.77])
 by smtp.gmail.com with ESMTPSA id o17sm12281612wmd.34.2020.11.09.01.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 01:19:13 -0800 (PST)
From: LemonBoy <thatlemon@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] ppc/translate: Implement lxvwsx opcode
Date: Mon,  9 Nov 2020 10:17:10 +0100
Message-Id: <d7d533e18c2bc10d924ee3e09907ff2b41fddb3a.1604912739.git.thatlemon@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=thatlemon@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement the "Load VSX Vector Word & Splat Indexed" opcode, introduced
in Power ISA v3.0.

Buglink: https://bugs.launchpad.net/qemu/+bug/1793608
Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
---
 target/ppc/translate/vsx-impl.c.inc | 30 +++++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.c.inc  |  1 +
 2 files changed, 31 insertions(+)

diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index b518de46db..075f063e98 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -139,6 +139,36 @@ static void gen_lxvw4x(DisasContext *ctx)
     tcg_temp_free_i64(xtl);
 }
 
+static void gen_lxvwsx(DisasContext *ctx)
+{
+    TCGv EA;
+    TCGv_i32 data;
+
+    if (xT(ctx->opcode) < 32) {
+        if (unlikely(!ctx->vsx_enabled)) {
+            gen_exception(ctx, POWERPC_EXCP_VSXU);
+            return;
+        }
+    } else {
+        if (unlikely(!ctx->altivec_enabled)) {
+            gen_exception(ctx, POWERPC_EXCP_VPU);
+            return;
+        }
+    }
+
+    gen_set_access_type(ctx, ACCESS_INT);
+    EA = tcg_temp_new();
+
+    gen_addr_reg_index(ctx, EA);
+
+    data = tcg_temp_new_i32();
+    tcg_gen_qemu_ld_i32(data, EA, ctx->mem_idx, MO_TEUL);
+    tcg_gen_gvec_dup_i32(MO_UL, vsr_full_offset(xT(ctx->opcode)), 16, 16, data);
+
+    tcg_temp_free(EA);
+    tcg_temp_free_i32(data);
+}
+
 static void gen_bswap16x8(TCGv_i64 outh, TCGv_i64 outl,
                           TCGv_i64 inh, TCGv_i64 inl)
 {
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index 7fd3942b84..1d41beef26 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -5,6 +5,7 @@ GEN_HANDLER_E(lxsibzx, 0x1F, 0x0D, 0x18, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(lxsihzx, 0x1F, 0x0D, 0x19, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(lxsspx, 0x1F, 0x0C, 0x10, 0, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(lxvd2x, 0x1F, 0x0C, 0x1A, 0, PPC_NONE, PPC2_VSX),
+GEN_HANDLER_E(lxvwsx, 0x1F, 0x0C, 0x0B, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(lxvdsx, 0x1F, 0x0C, 0x0A, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(lxvw4x, 0x1F, 0x0C, 0x18, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(lxvh8x, 0x1F, 0x0C, 0x19, 0, PPC_NONE,  PPC2_ISA300),
-- 
2.27.0


