Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EBFC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EADE2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EADE2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZ0J-0004f9-3w
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYp1-0007s7-Ec; Wed, 30 Sep 2020 05:54:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49942 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYol-0004QJ-06; Wed, 30 Sep 2020 05:54:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 78E83DA85810A5CBFB69;
 Wed, 30 Sep 2020 17:54:32 +0800 (CST)
Received: from localhost (10.174.185.186) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:54:23 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 13/14] alpha/: fix some comment spelling errors
Date: Wed, 30 Sep 2020 17:53:20 +0800
Message-ID: <20200930095321.2006-14-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200930095321.2006-1-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.186]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 05:46:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu/target/alpha.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 target/alpha/cpu.h       | 4 ++--
 target/alpha/translate.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index be29bdd..8a6d477 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -190,7 +190,7 @@ enum {
 
    That said, we're only emulating Unix PALcode, and not attempting VMS,
    so we don't need to implement Executive and Supervisor.  QEMU's own
-   PALcode cheats and usees the KSEG mapping for its code+data rather than
+   PALcode cheats and uses the KSEG mapping for its code+data rather than
    physical addresses.  */
 
 #define MMU_KERNEL_IDX   0
@@ -370,7 +370,7 @@ enum {
    The Unix PALcode only uses bit 4.  */
 #define PS_USER_MODE  8u
 
-/* CPUAlphaState->flags constants.  These are layed out so that we
+/* CPUAlphaState->flags constants.  These are laid out so that we
    can set or reset the pieces individually by assigning to the byte,
    or manipulated as a whole.  */
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 8870284..6aef9ec 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2939,7 +2939,7 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
        the first fp insn of the TB.  Alternately we could define a proper
        default for every TB (e.g. QUAL_RM_N or QUAL_RM_D) and make sure
        to reset the FP_STATUS to that default at the end of any TB that
-       changes the default.  We could even (gasp) dynamiclly figure out
+       changes the default.  We could even (gasp) dynamically figure out
        what default would be most efficient given the running program.  */
     ctx->tb_rm = -1;
     /* Similarly for flush-to-zero.  */
-- 
2.26.2.windows.1


