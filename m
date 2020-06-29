Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F9FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F342336F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F342336F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpozJ-000440-T0
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jpoyc-0003Dl-B8; Mon, 29 Jun 2020 04:17:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:2726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jpoyZ-0002Ss-Fu; Mon, 29 Jun 2020 04:17:17 -0400
IronPort-SDR: FD6CFyMecUErarYho3pSK5snzFwxnYIMnFsykeHH4mfuxdIp69kAduyQtb6Od2x8cBdbSO9bR+
 9q9Z35VY16fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="163940205"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; d="scan'208";a="163940205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 01:17:08 -0700
IronPort-SDR: 4N6khl6kmnJnWFvKf8CpLSEbQ434rGbJmXE0gIv+GItN86wGtY2ugQE5yWhoK2F4hYydYvQq8t
 mdASY0lh0bTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; d="scan'208";a="480702354"
Received: from unknown (HELO localhost.localdomain.sh.intel.com)
 ([10.239.153.142])
 by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2020 01:17:06 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/nios2: add DISAS_NORETURN case for nothing more to
 generate
Date: Mon, 29 Jun 2020 12:05:33 -0400
Message-Id: <20200629160535.3910-1-wentong.wu@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=wentong.wu@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 04:17:09
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Wentong Wu <wentong.wu@intel.com>, peter.maydell@linaro.org
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


