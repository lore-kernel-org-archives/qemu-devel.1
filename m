Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883FBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAEB20771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMpv+LdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAEB20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uRw-0007HT-GQ
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uPr-0003sS-D9
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:19:55 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uPp-00018O-P2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:19:55 -0400
Received: by mail-pg1-x544.google.com with SMTP id s15so1380384pgc.8
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jMyCh+YeOhdMjPLdLsR5j0kgHNJrks8+hvyL+Yjz/84=;
 b=DMpv+LdCydkAxltYsDakxLALllgSYdbu8doogBi4YLzeRDCqDMCoSFKOZYzDVxqC++
 pXxGkUpiD4qPSExa9XNyB5uu0BWeLhUHo2bm/NS3Ahh3zWa+Wkfw6wH8uAvpqJ51lmi0
 feswXiEyi/fwgiscXgPPwSuVi3i4tuuX3rjnDQcSzGSCnb03E01rhyzYBdM5HHiz6XbI
 Pqzhh7QRq+cScScwM+3KvGhrWkSy1nitllnc78hjPS+sNd0xp/phwt0HZNq8S5+/s4HN
 +vedV37BDoo7HbPvO2tnDBAwdSt/3mZ/b1ksirYnzPzNIWtPvt306Tz5+RiXJmjTmdlw
 chfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jMyCh+YeOhdMjPLdLsR5j0kgHNJrks8+hvyL+Yjz/84=;
 b=PGF7BXX8PNC552cbHsAXdlr9CV+vKpOncT9z8nXYwNB6OFAo/nS16UyJMFiwoePOJ8
 NzFL6NnA283akMYgaioWKwl+eOnoSmCddiZSe+63rJjMAhaa66/Y2ts2PwoL/R1wHwPY
 cB2Dg9FSKBIzy7Dfhgpn+3mp0Xkz8naOmF6W75DEffHxpCRTif2/ftu7j4OAODmHcJSQ
 2ONsV9svfsFL7FmX7UXCiajnVxrpO8kyvCSiFG8hnSyr5M3byDWyx89xWXZnUZ0BlVCJ
 Nkpe7KdSceNhQMgSt2o5LX+MoOtLH6UYqlRjVtUD/yHOYD0VOBalY7FUYwr9PR84RSfv
 TeAA==
X-Gm-Message-State: AOAM530y3us2zA3XlPCtHZaSDrDfJsH7OetWhNWomhEMMiCf68qzq5e3
 c6Fgwlwn92GWz0yLKxpZgyFKgEeptgk=
X-Google-Smtp-Source: ABdhPJzPRmnwD1928Ac2WkFKGrsP46WAAl6oKcBs74Y7UNd7aIbRNwvEr/uTwzlU44mIkjakyndbxA==
X-Received: by 2002:a63:d143:: with SMTP id c3mr167852pgj.306.1597252792088;
 Wed, 12 Aug 2020 10:19:52 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y79sm3097206pfb.65.2020.08.12.10.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 10:19:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/arm: Merge ISS for data abort from tag check fail
Date: Wed, 12 Aug 2020 10:19:46 -0700
Message-Id: <20200812171946.2044791-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812171946.2044791-1-richard.henderson@linaro.org>
References: <20200812171946.2044791-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: Andrey Konovalov <andreyknvl@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Merge the ISS data saved by the translator for the originating insn.
Use merge_syn_data_abort so that we properly take the target EL into
account.  Set the WnR bit properly in all cases.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index a40454588d..2dff4c548d 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -519,7 +519,7 @@ static void mte_check_fail(CPUARMState *env, uint32_t desc,
 {
     int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     ARMMMUIdx arm_mmu_idx = core_to_aa64_mmu_idx(mmu_idx);
-    int el, reg_el, tcf, select;
+    int el, target_el, reg_el, tcf, select, is_write, syn;
     uint64_t sctlr;
 
     reg_el = regime_el(env, arm_mmu_idx);
@@ -543,13 +543,17 @@ static void mte_check_fail(CPUARMState *env, uint32_t desc,
          *
          * In restore_state_to_opc, we set the exception syndrome
          * for the load or store operation.  Unwind first so we
-         * may overwrite that with the syndrome for the tag check.
+         * may merge that with the syndrome for the tag check.
          */
         cpu_restore_state(env_cpu(env), ra, true);
         env->exception.vaddress = dirty_ptr;
-        raise_exception(env, EXCP_DATA_ABORT,
-                        syn_data_abort_no_iss(el != 0, 0, 0, 0, 0, 0, 0x11),
-                        exception_target_el(env));
+
+        target_el = exception_target_el(env);
+        is_write = FIELD_EX32(desc, MTEDESC, WRITE);
+        syn = merge_syn_data_abort(env->exception.syndrome, target_el,
+                                   target_el == el, 0, 0, is_write, 0x11);
+
+        raise_exception(env, EXCP_DATA_ABORT, syn, target_el);
         /* noreturn, but fall through to the assert anyway */
 
     case 0:
-- 
2.25.1


