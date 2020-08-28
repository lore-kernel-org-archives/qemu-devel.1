Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2533FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E711F207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnPZbre5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E711F207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfb3-0004q8-4p
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFB-0001aO-2t
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:41 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfF6-0005HM-B4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:40 -0400
Received: by mail-pg1-x541.google.com with SMTP id i10so536426pgk.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NRLeu0duKzKFzn8XTETT/ccAhISS+EWPP5zocKzGJT0=;
 b=PnPZbre5EAruWNThBF09eEr6vSA3daKHXbZEIrItDwVgFDlcRwDKIvRIsiOpya+QyI
 qmIolpx1uWJ8tMukgZ1/dGgWlQrKCctn/4+GcRD1WG8g0PCw3XxP+Qo8nhWmqiGiHsWV
 qphQjZvNKFC5frJKO6E5lkZzwOHadgqdB9unSmMKggJ2O/zMrLbCBZ9OaJzAuk/eQjbf
 HTPRb8dM+0AGeAJqds2S9fLLHYeVGuefBV0ajCQ764jIH1yABbucnM+nVk+W9E0kWeUc
 j8BrnQbQge2S5nyE/Yg6VD438cuaCFF2tuys4dNAw4di8vNBOX8ZGj1jEa9XAQ/DYJ6K
 R8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NRLeu0duKzKFzn8XTETT/ccAhISS+EWPP5zocKzGJT0=;
 b=dW16SbXEbJ/OMJu0GKWky58qDQEeyTxPARSdLXLczpeh/gBLWnaEIuff+JHLK4wdHi
 8QMxsTswV3unNyBUJssMSBa55G6z/EZ4D7eVESWbVCBo8ud2+Il+qbGmOMn73303kDof
 OTkbGQAXJYVGVX4G6jdtwC693pBj7y20d0j/XrYCLWCXFDpJSkzAl45IGwFq7riJWsMP
 m+J8uib6qs7sIDhObQpWDLwdHTU23pcsQ7W6l8TLCh4A+ELE/+a3wl1IGeErz45S977L
 Z7XJxhKqRfG7bpQ/OfgwjxgYSlhBTbBaCfbravqWjW+2bxwtYFOsDAeHdV59iKFL84NO
 UIcA==
X-Gm-Message-State: AOAM5337wjXbsQ3eiO1LuhhqVr6FcvLcKwDN4yk5wCiayq8jSjG08p5w
 HTmQe0tpn13MCnuSJWb55iw8wYxkGuyPxw==
X-Google-Smtp-Source: ABdhPJy0ohmxd45+Uc5lrsrTKsdX3XhmtZYG/Bu8u0lQDgpqiqRf75X+7PI5I0/iyIexosCTCEYusw==
X-Received: by 2002:a63:e74e:: with SMTP id j14mr1399497pgk.182.1598624434688; 
 Fri, 28 Aug 2020 07:20:34 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 50/76] target/microblaze: Replace MSR_EE_FLAG with MSR_EE
Date: Fri, 28 Aug 2020 07:19:03 -0700
Message-Id: <20200828141929.77854-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's no reason to define MSR_EE_FLAG; we can just use the
original MSR_EE define.  Document the other flags copied into
tb_flags with iflag to reserve those bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 4 +++-
 target/microblaze/translate.c | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 013858b8e0..594501e4e7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -254,7 +254,9 @@ struct CPUMBState {
 
     /* Internal flags.  */
 #define IMM_FLAG	4
-#define MSR_EE_FLAG     (1 << 8)
+/* MSR_EE               (1 << 8)  */
+/* MSR_UM               (1 << 11) */
+/* MSR_VM               (1 << 13) */
 #define DRTI_FLAG	(1 << 16)
 #define DRTE_FLAG	(1 << 17)
 #define DRTB_FLAG	(1 << 18)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 72541905ec..1f6731e0af 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -162,7 +162,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
  */
 static bool trap_illegal(DisasContext *dc, bool cond)
 {
-    if (cond && (dc->tb_flags & MSR_EE_FLAG)
+    if (cond && (dc->tb_flags & MSR_EE)
         && dc->cpu->cfg.illegal_opcode_exception) {
         gen_raise_hw_excp(dc, ESR_EC_ILLEGAL_OP);
     }
@@ -178,7 +178,7 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     int mem_index = cpu_mmu_index(&dc->cpu->env, false);
     bool cond_user = cond && mem_index == MMU_USER_IDX;
 
-    if (cond_user && (dc->tb_flags & MSR_EE_FLAG)) {
+    if (cond_user && (dc->tb_flags & MSR_EE)) {
         gen_raise_hw_excp(dc, ESR_EC_PRIVINSN);
     }
     return cond_user;
-- 
2.25.1


