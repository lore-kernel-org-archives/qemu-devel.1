Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F289C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D97E20885
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sl0OPoAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D97E20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jof8d-0004wp-LK
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5q-0007xB-7a
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:31:58 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5o-0001lT-ES
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:31:57 -0400
Received: by mail-pj1-x1042.google.com with SMTP id d6so4363692pjs.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qjCCkNm/WEF6pUjIrj3rNiuTiPovNxbXAxAumNuxRgg=;
 b=sl0OPoAPJZ32vi3cuqMGpLe0l1Db0N8wy2GmD3dvaF2SWhvYhBzVfmDl3Al3Of7q4V
 nx3iBeyV8jBaosfUhbyD/am/XYhiqYXyTUNoDHJwTZYiyQSi679GBK3tbaeYd6SD82LB
 +b9r9VpDHqggPa6hfwFO392CZMS6jfscKypQslKAxN4EK3ZnW8ibV8rUBB3Kw5zqMqGC
 N+6Z9fBbbwQc7yrQoC+8w6mN0T8IdOS0fAlN5dhKOUmGMaIUFKKU+iZI2wgisPO2qGkb
 2sKrLsd39OA4zzlBC3GYqWSXs661HYML0rbj05l0AvwsEAD7ReT4K7o5Nu2/OtJvut+Q
 SbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qjCCkNm/WEF6pUjIrj3rNiuTiPovNxbXAxAumNuxRgg=;
 b=qvEKntHju0Q9aILb4OM0910O5t+0QwyoSQBfI96RwcWP5ZdSAXzHc6+6h3FpJSg650
 VMCcSOfQJBUw375ypUDQMymb3wBQwJKJzP4/gczYOiaRPdIeYA4XvGrZICvP1j+feSU9
 ATpWNPH//yLQfqn3fkNJztNZ/VltVXUqpGPVrNK/ZpkdPZ93WM1HYdg7rGF1QWLm9Muv
 q/u80H4bBuleMqOHexUbW/IUidQSVWErLtUswLZgmPjov+dA7cwjC4UKa0KT/+72muoL
 2R2tAyGYPDad3yUd1vejQM1e555RV6StqiHeEWGU81uGzIqPhqhKFUnBGh7TapGAE5ca
 WafQ==
X-Gm-Message-State: AOAM531d1dDS0SEZTQ50UEqUBgM9doHIQxTyH4ACxKVYXDjYjmBs3Ovn
 DCJM2fqntmP1W34jrXzTU6s2timwZI0=
X-Google-Smtp-Source: ABdhPJy6rTyqjn9QNaRLi2Bn7B+xM0io5wgO5sIuIZ5XLg3dXSwKinYiNErnkedUDHKq13GKdM14cw==
X-Received: by 2002:a17:902:121:: with SMTP id 30mr903461plb.44.1593142314544; 
 Thu, 25 Jun 2020 20:31:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:31:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 06/46] target/arm: Add DISAS_UPDATE_NOCHAIN
Date: Thu, 25 Jun 2020 20:31:04 -0700
Message-Id: <20200626033144.790098-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an option that writes back the PC, like DISAS_UPDATE_EXIT,
but does not exit back to the main loop.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     | 2 ++
 target/arm/translate-a64.c | 3 +++
 target/arm/translate.c     | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index d5edef2943..6dfe24cedc 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -173,6 +173,8 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
  * return from cpu_tb_exec.
  */
 #define DISAS_EXIT      DISAS_TARGET_9
+/* CPU state was modified dynamically; no need to exit, but do not chain. */
+#define DISAS_UPDATE_NOCHAIN  DISAS_TARGET_10
 
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e4795ae100..027be7d8c2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14298,6 +14298,9 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_EXIT:
             tcg_gen_exit_tb(NULL, 0);
             break;
+        case DISAS_UPDATE_NOCHAIN:
+            gen_a64_set_pc_im(dc->base.pc_next);
+            /* fall through */
         case DISAS_JUMP:
             tcg_gen_lookup_and_goto_ptr();
             break;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 146ff5ddc2..c39a929b93 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8874,6 +8874,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
         case DISAS_UPDATE_EXIT:
+        case DISAS_UPDATE_NOCHAIN:
             gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
@@ -8897,6 +8898,9 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_TOO_MANY:
             gen_goto_tb(dc, 1, dc->base.pc_next);
             break;
+        case DISAS_UPDATE_NOCHAIN:
+            gen_set_pc_im(dc, dc->base.pc_next);
+            /* fall through */
         case DISAS_JUMP:
             gen_goto_ptr();
             break;
-- 
2.25.1


