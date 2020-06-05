Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D45C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E14B206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQxyorMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E14B206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3w8-000476-Qh
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nq-0004oG-Bm
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:58 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3np-0000mw-G9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:58 -0400
Received: by mail-pj1-x1043.google.com with SMTP id h95so2181254pje.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7wl+QdYCs/b+nFYwpri9epwwg1rNtdW9XylmaArLSo0=;
 b=cQxyorMAU8+1QNUYtQhzCFjW1u4xVBdmi2WxWjOAJHTlfkkzJqHvbU+HiDOohvwOct
 e+nHWOqSpnXOeSORC61ph8dLA+DlEfTX2XTz9avKNWGdeWkLdhfu5H64IT6WDwgJuKU8
 3Kt5tIqD02fpdHx01TvZsQxPqhatIuQ+zjeGY3tjJ0TNN6nRI8uEK6ILwfyY0K1fx4JT
 cQ3Ht7PTuTQ9e4758AgWQHAJ83Wd8wfLvskxcvx05UD16kLKst9RFLGtAlPJH5ODt1y9
 sSErkbnQke6zY/FGpNwFcozrocgt608PdQdbqacubq5PkwglvMUtxTfWgOiY5z8rS4X9
 e6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7wl+QdYCs/b+nFYwpri9epwwg1rNtdW9XylmaArLSo0=;
 b=Au/lKkpRJtsbeqt+nNLMW2d7NqPWttAkBWPhTvsakhiTUqjJEJo5JAyeIGmA5XGKHS
 pR90WeV3Weg7mjM8CsMbqUTHVVk7mWu9aSKQesZ8Uq+0v9rAK1ukHtJndpX6/iloSVLG
 gIL8pKZ4ky0tSGfztKpQM/3TMEIWJ+fedJQPoaNba2pItnCFS5X/F+SjYfZF5g5bruIa
 6T027fH05ryO50syTaL19KiVyawodCWYZ/umB3/fw9Ev5jD1zrJOSeY1CpVJdpoqusR7
 OARZmTN57Fy6Q9CtF9gK6l9kn1A+226k2WB0UJ3QuChsdFkueEP8xTo7XU6PWiwH+hr1
 2phw==
X-Gm-Message-State: AOAM530ZjXkD/GC6GhyOrHA2qbvPt/X0WtoWUNxseT/yERgPGGIJk+hq
 yORqOJjqvAyW7pH0GljKcIQtpXsG37w=
X-Google-Smtp-Source: ABdhPJzv1aUT9Tup+DxWyiwWwBt823/qt6/B2Q4LXY7ZoXJGBef4Ak/vuRRMAh3J4PNmJ+9PKwWfyw==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr8153031pls.1.1591330675623; 
 Thu, 04 Jun 2020 21:17:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/17] target/arm: Enable MTE for user-only
Date: Thu,  4 Jun 2020 21:17:32 -0700
Message-Id: <20200605041733.415188-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 37b7cc2c9c..6395918524 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -39,6 +39,7 @@
 #include "kvm_arm.h"
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
+#include "qemu/guest-random.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -191,6 +192,22 @@ static void arm_cpu_reset(DeviceState *dev)
         /* Enable all PAC keys.  */
         env->cp15.sctlr_el[1] |= (SCTLR_EnIA | SCTLR_EnIB |
                                   SCTLR_EnDA | SCTLR_EnDB);
+        /* Enable MTE */
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            /* Enable tag access, but leave TCF0 as No Effect (0). */
+            env->cp15.sctlr_el[1] |= SCTLR_ATA0;
+            /*
+             * Exclude all tags, so that tag 0 is always used.
+             * This corresponds to Linux current->thread.gcr_incl = 0.
+             */
+            env->cp15.gcr_el1 = 0xffff;
+            /* If RGSR == 0, NextRandomTagBit will always produce 0.  */
+            do {
+                qemu_guest_getrandom_nofail(&env->cp15.rgsr_el1,
+                                            sizeof(env->cp15.rgsr_el1));
+                env->cp15.rgsr_el1 &= 0xffff0fu;
+            } while (env->cp15.rgsr_el1 == 0);
+        }
         /* and to the FP/Neon instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 2, 3);
         /* and to the SVE instructions */
-- 
2.25.1


