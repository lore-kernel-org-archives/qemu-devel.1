Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85453C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5B32073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LW421/qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5B32073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmW8-0003Oj-B9
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKW-0004eG-AC
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:48 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:40376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKU-000612-Gj
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:47 -0400
Received: by mail-pf1-x42b.google.com with SMTP id c142so805695pfb.7
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ef/2KrHveuUVDAO5/6dwQJ/JaWE1rIYd4ZjYlC8sz1Y=;
 b=LW421/qUgz+4vnbJfWBhNJ0uD4bGl1l/iC/nOnCyD+p4dfO+lcF0cincKUvLD4ZGND
 9azSaqBSoU/Tyd6upMcG4QuMCoEpJJ4ntNDHi4xD5bCQwXvjkwz6CDyGyGn1id9d88xm
 Y/drgAKi5XHHcIpj0eYKwgoao8nNccSSFakIwjHd5OxI4G769jS9a8FahzcnYdATebGu
 94XanQOqdrv7m4/JX48ocikDOlw9SQu+uoWVtZKuxIR579coyk3MD1n/zYkxpdNmItco
 0+l/RG5XRXvLwSLzDejLgHHuz1RGiUxIkVRdKvsISqiwTI4QOe7EHrGE4c6B947PW/3z
 fjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ef/2KrHveuUVDAO5/6dwQJ/JaWE1rIYd4ZjYlC8sz1Y=;
 b=iXQ72gKZryQv+FM65RtdcORqlFPHNLo/kWvJZ9OWH6ReqL4CnCUhuX6IhI0jagVBTN
 bmFD/2JWj5An5c1V+SxJJLWCJEm5mY3SfeMzBEFFKUVm67IbLOryMWJMXJ9EbuTEGSsA
 gkKABhoAaXnUc6YkrNcrRENAKBlEbWaJSwIlWRwC6K4XWHi0VWJFM2Q3w1wKbk7PkhjE
 p5mN85RvjKacUkEqYQ60Vm2uVwueWcl00Rl0q32CWsa0DZd7w1GemGMaguySkoyKPHnc
 KS2PVFk2YUErA+TKAzHHJ6uKeDAwzb+bTmsTncvkSKY9IUUXEAAXNmFFgYyvms+lZUNK
 0dWw==
X-Gm-Message-State: AOAM532nb1AKxnG6aA1K+ZdKlnw8/a9IVnOFe2/D1353kpszVCJeS7ZC
 6RQvax59wLk0C+YhcJeKYoFQbjYCGuzDYA==
X-Google-Smtp-Source: ABdhPJw0hbLczPPDwkZwe3JQv05cVoEwHFBs2pE8gVW+/DD6zVaV3JfVOlfuxmvSUF9wOs8ylUy10Q==
X-Received: by 2002:a05:6a00:1507:: with SMTP id
 q7mr1875016pfu.303.1598890004547; 
 Mon, 31 Aug 2020 09:06:44 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/76] target/microblaze: Remove SIM_COMPAT
Date: Mon, 31 Aug 2020 09:05:15 -0700
Message-Id: <20200831160601.833692-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


