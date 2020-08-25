Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2091C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F29E206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1mG4tBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F29E206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgc4-0000fX-Mb
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4A-0000HH-LK
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:14 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg48-000219-KK
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:14 -0400
Received: by mail-pf1-x441.google.com with SMTP id k15so1823277pfc.12
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0IyoDEFe3ZWYDga+MAV6Bg/xEkFwuDqD20ZUdnvyl1Q=;
 b=i1mG4tBBmW5Rvw7Ff45f/KekuzbCVOHea7q3wNIXaWEXghFSU/Qf3QCeGeJSjEq9Ds
 wTz63U2RYBYkjGSd/Jb3QHJMz+GZEw4Axpb1IvYmO9hN6+7HYvbJI9YsNMF70B6VWZaC
 nXixW9pxyULrAfoyMXWgj8yQn0CiMO7+ttqvgx+CLthK+fwh6XvUyXoPXDmXE9vCi+Zz
 O0PU/gIJm2+wPIv5O94bMRGsVJmSBDSDH6U68xlayedQVz48OmKZRDH9gJMaFJpB/xBs
 KXFhKw8yFuZZp3VTzeDu1K15/C96t1eF+fjHEQ1wx+T2hGdGxt+I7/Mz652ZsTJWA58s
 so5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0IyoDEFe3ZWYDga+MAV6Bg/xEkFwuDqD20ZUdnvyl1Q=;
 b=irimzTcjKflac/Kgz/W9GbZR/CtEWZbZOU/aYwKgSk2zRXMCFvW8sOS+QExH/4pn10
 kse2RlTrXFonyLeYnFcEpYgMjA9o9xG+ZdiY4HWLJ/yisYj/qClnNEU0mivPmGg6SY++
 0hcCL3N2CHqvwCFiDIuwwFntVYBG0zppidNYcpU2MJt4wAJ7dumrX2mv5xP+ZDzDxaUC
 9kGRMuSqB4ARvcMb7171alc798YpaHLnPBOPxT0IgPpcKS+znfBK3pZtuFpwfWfyGQKl
 AN8PH60eNRjvmRXA0agE1NfzRmnjZJtkeHH5DOZJeF5QnWeh4idVKG8u/P9aBVwAjIuK
 R/kA==
X-Gm-Message-State: AOAM53015nXxQYoyLJQ9jDJjBTg4R+phipWln4x0xAXYS9WuuI7m9QrP
 1S3hfSxAIIPOi6J4ABsDu8IteITGcg9s4w==
X-Google-Smtp-Source: ABdhPJxodVQMv5bVGIs0sw8Q7Jl5NqeGZdmiMLbpNOTsDZ2nD7oEFwfPmMVIMjvWNPF/uPZ7pIzU2w==
X-Received: by 2002:a05:6a00:14d0:: with SMTP id
 w16mr9330728pfu.39.1598389270962; 
 Tue, 25 Aug 2020 14:01:10 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 59/77] target/microblaze: Replace clear_imm with
 tb_flags_to_set
Date: Tue, 25 Aug 2020 13:59:32 -0700
Message-Id: <20200825205950.730499-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This more general update variable will be able to handle
delay slots as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6e70873333..18009103c7 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -75,7 +75,7 @@ typedef struct DisasContext {
     unsigned int cpustate_changed;
     unsigned int delayed_branch;
     unsigned int tb_flags;
-    unsigned int clear_imm;
+    unsigned int tb_flags_to_set;
     int mem_index;
 
 #define JMP_NOJMP     0
@@ -535,8 +535,7 @@ static bool trans_imm(DisasContext *dc, arg_imm *arg)
 {
     dc->ext_imm = arg->imm << 16;
     tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
-    dc->tb_flags |= IMM_FLAG;
-    dc->clear_imm = 0;
+    dc->tb_flags_to_set = IMM_FLAG;
     return true;
 }
 
@@ -1680,7 +1679,8 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
                   (uint32_t)dc->base.pc_next);
     }
 
-    dc->clear_imm = 1;
+    dc->tb_flags_to_set = 0;
+
     ir = cpu_ldl_code(env, dc->base.pc_next);
     if (!decode(dc, ir)) {
         old_decode(dc, ir);
@@ -1692,10 +1692,13 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         dc->r0_set = false;
     }
 
-    if (dc->clear_imm && (dc->tb_flags & IMM_FLAG)) {
-        dc->tb_flags &= ~IMM_FLAG;
+    /* Discard the imm global when its contents cannot be used. */
+    if ((dc->tb_flags & ~dc->tb_flags_to_set) & IMM_FLAG) {
         tcg_gen_discard_i32(cpu_imm);
     }
+
+    dc->tb_flags &= ~IMM_FLAG;
+    dc->tb_flags |= dc->tb_flags_to_set;
     dc->base.pc_next += 4;
 
     if (dc->delayed_branch && --dc->delayed_branch == 0) {
-- 
2.25.1


