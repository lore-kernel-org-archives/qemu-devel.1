Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE2DC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C912086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="waYaDbqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C912086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfZb-0001T1-BR
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEk-0000qg-Ka
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:14 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEi-00058I-Nz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:14 -0400
Received: by mail-pl1-x643.google.com with SMTP id v16so538712plo.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3uXgbXQfxy84sZbsepYGP345y9mJ6wAlQjnYKexGZh0=;
 b=waYaDbqw7mPc8xLWro+g10siz+o5no1/UXVM5EeSrbtqflFtRWaF86IQP+bU24TDTz
 0+CorueswN2wCp7JwhznL0G1c0eEFe4CLeiahYr1AsqOL02sSWXfdMYWO++ifEv6FgJo
 6loYRm6kl9vZYD0BkX8Us/VM9N4QjPx8OGrQbqtspTc+6nOBqMZJZdRfT1fsL0/0aIm0
 a4iOfLKFl1wYmp8hfKQuTvUwEvuZCpYHh0Zcdw34jUZqHqaEk+yMfuCBxI0cOaL4gJni
 vy4UUteZ71uQDVFz89YkkZxDYzFB8wCnRcQ/uGyb12Ij1+nZwHe+Phaq5QkrIQIl6+2c
 69Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3uXgbXQfxy84sZbsepYGP345y9mJ6wAlQjnYKexGZh0=;
 b=haCaof+HcdlFPzOkiwNMLvTDE/lyAjERR42ULUdKQeaT/yfvAPWyfOE1z3lEyqvu7t
 CiHxtKeQVD9SAW2AE7hn+REhhSL+BOt63XfZjhpuaq9WWSVI9/xIHauV+nJnxISFDlAc
 Z+YLv/256kYDpqKug/yOF0WbHH1r3xX4eR7TLBAI9KXLzXeqWHnwT84QSBO0JI9CIRlj
 QwOVUSSauoQr44+C2HFMIcfgriva11Svf4zubJV2BXFpX+YftFYywJ5h92I6UmHYGEIc
 mbRb1mRO+58tH0v85iTerSto2CR8CjCaE2CkSMdGLwbkmLLePeZSiqpeMvy/e8E74rvz
 DlXg==
X-Gm-Message-State: AOAM531kfEM5jbArW03WBJ5Ryo5pzrURh6kU2vz3GaJw2A0h09XfkoBN
 T2eFhrHciuAacpP7mF35N3KbhM+VrfriyQ==
X-Google-Smtp-Source: ABdhPJwlAKFBNcQCF8Nq04OM1deI1f1B+1tsb0cNU25w0w1dPdW7yy4gfGIXxd7BjmDFNL06CJUO1w==
X-Received: by 2002:a17:902:24c:: with SMTP id
 70mr1470722plc.284.1598624411010; 
 Fri, 28 Aug 2020 07:20:11 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/76] target/microblaze: Remove SIM_COMPAT
Date: Fri, 28 Aug 2020 07:18:43 -0700
Message-Id: <20200828141929.77854-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6a9710d76d..a90e56a17f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -34,10 +34,9 @@
 #include "exec/log.h"
 
 
-#define SIM_COMPAT 0
 #define DISAS_GNU 1
 #define DISAS_MB 1
-#if DISAS_MB && !SIM_COMPAT
+#if DISAS_MB
 #  define LOG_DIS(...) qemu_log_mask(CPU_LOG_TB_IN_ASM, ## __VA_ARGS__)
 #else
 #  define LOG_DIS(...) do { } while (0)
@@ -1749,11 +1748,9 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
 static void mb_tr_disas_log(const DisasContextBase *dcb, CPUState *cs)
 {
 #ifdef DEBUG_DISAS
-#if !SIM_COMPAT
     qemu_log("IN: %s\n", lookup_symbol(dcb->pc_first));
     log_target_disas(cs, dcb->pc_first, dcb->tb->size);
 #endif
-#endif
 }
 
 static const TranslatorOps mb_tr_ops = {
-- 
2.25.1


