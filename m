Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C5DC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E268C20888
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaRmjisP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E268C20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jylei-0005fF-8b
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 20:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZQ-0000Cy-S5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZO-0008En-LU
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:16 -0400
Received: by mail-pf1-x444.google.com with SMTP id z3so4050144pfn.12
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 17:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9BL1gLZ55ebPF1CU6VCPP/FzwVosXUicPzzehG55MPU=;
 b=qaRmjisPRMx6Bj6xIKHQ+UdKBYDsba74xVnhAR/AseeiXethgPO4Ue8+YgGEfrVr2S
 NX2L6e6SXP4LBkkNUEUt6Cz3f30tlg80W3cNgAwUs+q7QawJj52t1s+cBp10VvFJ0qZI
 zVOKxeduGUSxDzzRHWZDf9H4grMztliHSmGyLf6OMzmyYJADYwdVk8uXtzdk0oI8sWUr
 VFemrrl8l/PDHOa8zC5rsMKk5+My0bCXP66BogF923FxdpeySyUCTqLYFUEOeRdm+wqc
 xS57ZQuSY1nKS/x42WEj4qKW9kXtMIYvaxDJz3OBQuXDcSep7Na7izjkvH4rirQKw9XE
 peyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9BL1gLZ55ebPF1CU6VCPP/FzwVosXUicPzzehG55MPU=;
 b=CWq3wOxzTpvTCe3EY2+wWs9tPmQKlZsDgggFeoW2TqNUSr5cSkP43Ud5L2Yj/Qt4JP
 DI+G/jdEr+kBNrAFrY2oOCiivo5ouPkTovpYdGBPRW1KkAgkqSjPoEZvWcmCLM+SZpHS
 MclKBkgd3pFsB0uDaM53C6ZN5Nk8//J1vqe2oYWaCcWJXALJF9ueGmMDob6CJzXLol3p
 obEE0l97mK654puR3rMZw6vCun5oNJBO+eNgfyB0efQY6o8gFPP+TZqcKLFLu6ZcPSQn
 2nZOWhfcg/3RbSasdeme00rtZspNPJo/2pHj4DVkXIq73sqLBzFJPZsw92r8H6AWqVy5
 HrRg==
X-Gm-Message-State: AOAM533pHDYBHZL+sNoPX25t2GP5xq/pewfB/skRx/KvnUlGIzxF/YCx
 hMdfReTAWPxJ2EMZw18Zs+cdWS/8sJ0=
X-Google-Smtp-Source: ABdhPJwi8c+oFUbvG8EnpiHUGBnDqiPGHTdg0NBAkioxO4MP0/y98SNPP57NWBkGg78qzE4B7MF3dQ==
X-Received: by 2002:a62:8688:: with SMTP id x130mr6546500pfd.280.1595550493032; 
 Thu, 23 Jul 2020 17:28:13 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id q20sm4224635pfn.111.2020.07.23.17.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 17:28:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] target/riscv: Generate nanboxed results from
 trans_rvf.inc.c
Date: Thu, 23 Jul 2020 17:28:03 -0700
Message-Id: <20200724002807.441147-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724002807.441147-1-richard.henderson@linaro.org>
References: <20200724002807.441147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: frank.chang@sifive.com, alistair23@gmail.com, qemu-riscv@nongnu.org,
 zhiwei_liu@c-sky.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make sure that all results from inline single-precision scalar
operations are properly nan-boxed to 64-bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvf.inc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index c7057482e8..264d3139f1 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -167,6 +167,7 @@ static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a)
         tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2], cpu_fpr[a->rs1],
                             0, 31);
     }
+    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -183,6 +184,7 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
         tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
         tcg_temp_free_i64(t0);
     }
+    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -199,6 +201,7 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
         tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
         tcg_temp_free_i64(t0);
     }
+    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -369,6 +372,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
 #else
     tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
 #endif
+    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
 
     mark_fs_dirty(ctx);
     tcg_temp_free(t0);
-- 
2.25.1


