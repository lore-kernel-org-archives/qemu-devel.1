Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC146C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B133A2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpY8A4WE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B133A2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmgG-0001jz-Pt
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL1-0005wH-St
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:19 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL0-00067e-7X
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:19 -0400
Received: by mail-pg1-x543.google.com with SMTP id 31so821210pgy.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+YTQPSRa7wIGfMOHKJcDIJtbiajs8gBf9sLY+UjyvJI=;
 b=FpY8A4WEPbglTlZeEI7EV5gOhMujrXdRoz8G+oo80aWvAyeqpg5MCiWqgF+J9vpiN+
 LY9c9J+B0bZnCGkX+SE+U/vttDGxajOd2+Emlh8umLnKsHxlOPYnRAWZpTIda0CyynB6
 9+7/SNJm+rrqnt/2ZURP6bha4YiEvRPmpbMFKwl4Gi8t9JY4SOVKAoQmOtvOMTEhGLrd
 /EkBrVgVKR0i2Mt4QwRs9AHGziA6XDRMnpvy1xpxAqY2n8MflZ6LSE+e8TZCsIVZhMKN
 zahGDdVyMn0zuOV+q0kB4GQYQBY6Xm2d9qmDVYmjSig9SIRZ7gz0isStbt+0H8QGcVQ/
 5OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+YTQPSRa7wIGfMOHKJcDIJtbiajs8gBf9sLY+UjyvJI=;
 b=p64gD2pZ1983popEEitFK3vu/oNsDdqYHrP/jAXR7EohAtxY4Ya3BMYrtPliJHzirM
 tkzW9eQR668WRZdqcQU0wCA3TQmc6hFid0ms7/torpMaN/8fTS2fl7ZvotH906y3hk3w
 D0F/7eNlGoCbWj/waRzN2YlQisAeqWcrGG12xxVS0ErLKXl3P3Z0bmQfT+THW0qI3Tmc
 ha8rwBfEVRJkCjEaMBk76wvtMfd6X4dfpP4t/saJtN/M+HeZWMxDvV4EYRgXZ8AgLoVp
 85jfnxvE+NRmaKH7KBAsb5CoM+JN/pGoLs1Gcsb/wTV4iEJRHqQCu0LM4af0JfWXvzdr
 1zbA==
X-Gm-Message-State: AOAM5330cY5GIG85wHLgHGEzn5GNWzSO0TZeUmo+bb27mE+XrQzgwHFE
 oDBspeNZUg8oF8HD6jqeHOWvEkYuhVom6g==
X-Google-Smtp-Source: ABdhPJwSVlogUkYoObcMNbMKGsKurYVfMZ8nFpiiUaRh01JEQb87mKH1SkXTagh8gcRKwOuuqJjFqQ==
X-Received: by 2002:a65:568b:: with SMTP id v11mr1749842pgs.396.1598890036570; 
 Mon, 31 Aug 2020 09:07:16 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/76] target/microblaze: Assert no overlap in flags making up
 tb_flags
Date: Mon, 31 Aug 2020 09:05:39 -0700
Message-Id: <20200831160601.833692-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

Create MSR_TB_MASK.  Use it in cpu_get_tb_cpu_state, and check
that IFLAGS_TB_MASK does not overlap.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 594501e4e7..2fc7cf26f1 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -261,8 +261,11 @@ struct CPUMBState {
 #define DRTE_FLAG	(1 << 17)
 #define DRTB_FLAG	(1 << 18)
 #define D_FLAG		(1 << 19)  /* Bit in ESR.  */
+
 /* TB dependent CPUMBState.  */
 #define IFLAGS_TB_MASK  (D_FLAG | IMM_FLAG | DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)
+#define MSR_TB_MASK     (MSR_UM | MSR_VM | MSR_EE)
+
     uint32_t iflags;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -372,12 +375,14 @@ typedef MicroBlazeCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
+/* Ensure there is no overlap between the two masks. */
+QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
+
 static inline void cpu_get_tb_cpu_state(CPUMBState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
-    *flags = (env->iflags & IFLAGS_TB_MASK) |
-             (env->msr & (MSR_UM | MSR_VM | MSR_EE));
+    *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
     *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
 }
 
-- 
2.25.1


