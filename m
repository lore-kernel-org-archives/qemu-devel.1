Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC8C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31932075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZgFqRnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31932075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzMX-0001hs-Uc
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB6-0005d3-Rb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB3-0006fG-6Q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id f139so13315713wmf.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7RhrIfAtLKSoFSnxW6rvMNP1lUxxCGQ7DmZjmW38djo=;
 b=VZgFqRnYD9pvepuDFTsWH7Jhh5Ci2x/CKRlhOwN7Suc80tWKhZY8EtmYj1mMs1L+TO
 V+jwSC34Opn9U443ml24ORyTcbFbrFGnxK8z1eSqgvn3f3ZthZQuVfjndTXnb+TQTwi4
 DlbmNkqVfxdPzhDv1kh9FO4LXudh08aaEfRHG/9fYwlaH7i9WVNxIDuWa3HuzR6U/ipa
 BGlGbipVTLvojLPI76C0vxn3qc9O/CPAMo4nBZCn/oQ4uKiJzUPBg2MIiNUNni6e/yT5
 agSEJG9O7DVecbh4eYyA74xibn3+Qv4i5o3kxmDo3edHsLMQlbRslzrIuNDQfzhE1cuL
 FRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7RhrIfAtLKSoFSnxW6rvMNP1lUxxCGQ7DmZjmW38djo=;
 b=kAAaezzfCi2OOmBcAvHYfVNnCk1HH5B/+UY9rvcdQLZu5C+8MloRD0uvsrccuPHyDj
 kKzdc931bHl1XuDWdA8r9Ew3aNSpPN9IlCTxROyp2aTz/tXXNH8DMm38315VtbyQ7B1u
 6O7sfYSYFzUWJz6I77ylZNzH+aRpDOdhG57Rm9/5FKiFBYJWXwrehNx89bOjPX0JJ4Sk
 tta5VsoBdySMH7lifENS8RO0H24vcu8hcLXC9XRR6C6y+6reF8tnBfT40TndXLKboBf5
 ettMMjNEGo+xAb1hhI9HsjvCOzD2xxzA+rBOf4WJ2xlMzNYvH3C69orzoCZ3n9eXsEIx
 cIwA==
X-Gm-Message-State: AOAM531JGyJKEisURodRuMO3n3seDLlZqiqvLp2PQGG4lP34dO9xOEvr
 QxVDvzfYJ16iCIkYma8w4ZSdm/ZXToZtQQ==
X-Google-Smtp-Source: ABdhPJxaWwci1XS0FEYoWEEXM0MBsbY8Du7mcbApL9rlNhwlgIRHhF9p/zqacXLrquBQhqFBzvqzEw==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr172245wme.46.1594649487712; 
 Mon, 13 Jul 2020 07:11:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/25] target/nios2: Use gen_io_start around wrctl instruction
Date: Mon, 13 Jul 2020 15:10:58 +0100
Message-Id: <20200713141104.5139-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wentong Wu <wentong.wu@intel.com>

wrctl instruction on nios2 target will cause checking cpu
interrupt but tcg_handle_interrupt() will call cpu_abort()
if the CPU gets an interrupt while it's not in 'can do IO'
state, so add gen_io_start around wrctl instruction. Also
at the same time, end the onging TB with DISAS_UPDATE.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Message-id: 20200710233433.19729-3-wentong.wu@intel.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/nios2/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index c2a134f932d..9824544eb37 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -32,6 +32,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
+#include "exec/gen-icount.h"
 
 /* is_jmp field values */
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
@@ -518,7 +519,11 @@ static void wrctl(DisasContext *dc, uint32_t code, uint32_t flags)
     /* If interrupts were enabled using WRCTL, trigger them. */
 #if !defined(CONFIG_USER_ONLY)
     if ((instr.imm5 + CR_BASE) == CR_STATUS) {
+        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         gen_helper_check_interrupts(dc->cpu_env);
+        dc->is_jmp = DISAS_UPDATE;
     }
 #endif
 }
-- 
2.20.1


