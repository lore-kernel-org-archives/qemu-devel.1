Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37098C433EC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B49420725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B49420725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvGj-0007zt-9b
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jtvEK-0005Nn-WE; Fri, 10 Jul 2020 11:46:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:55298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jtvEJ-0008Ob-AV; Fri, 10 Jul 2020 11:46:28 -0400
IronPort-SDR: 0qRnyIwsyObCp8JJ6ajXOYnwgFj1iZ1JMIlmi2ge0dL3s3aUxbO1e/hc+WE3swwvIaN25jJZWO
 eeWlJwJ3Llag==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="136427512"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; d="scan'208";a="136427512"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2020 08:46:15 -0700
IronPort-SDR: sNJvHibO3HmZs/Pemt+BXXteic9oJ7gh/dqpXIK/401nj86pC+dX9hrE/qIcifsvr37TJLQAZU
 f5SIjgji6e2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; d="scan'208";a="484686318"
Received: from unknown (HELO localhost.localdomain.sh.intel.com)
 ([10.239.153.142])
 by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:46:14 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 1/4] target/nios2: add DISAS_NORETURN case for nothing more
 to generate
Date: Fri, 10 Jul 2020 19:34:30 -0400
Message-Id: <20200710233433.19729-1-wentong.wu@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=wentong.wu@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 11:46:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, marex@denx.de, crwulff@gmail.com,
 Wentong Wu <wentong.wu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add DISAS_NORETURN case for nothing more to generate because at runtime
execution will never return from some helper call. And at the same time
replace DISAS_UPDATE in t_gen_helper_raise_exception and gen_exception
with the newly added DISAS_NORETURN.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 target/nios2/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index e17656e6..b052be85 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -149,7 +149,7 @@ static void t_gen_helper_raise_exception(DisasContext *dc,
     tcg_gen_movi_tl(dc->cpu_R[R_PC], dc->pc);
     gen_helper_raise_exception(dc->cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-    dc->is_jmp = DISAS_UPDATE;
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 static bool use_goto_tb(DisasContext *dc, uint32_t dest)
@@ -802,7 +802,7 @@ static void gen_exception(DisasContext *dc, uint32_t excp)
     tcg_gen_movi_tl(cpu_R[R_PC], dc->pc);
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-    dc->is_jmp = DISAS_UPDATE;
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 /* generate intermediate code for basic block 'tb'.  */
@@ -877,6 +877,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
         tcg_gen_exit_tb(NULL, 0);
         break;
 
+    case DISAS_NORETURN:
     case DISAS_TB_JUMP:
         /* nothing more to generate */
         break;
-- 
2.21.3


