Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7457621D41
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7457621D41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmR0-0001tm-Fl
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kQmAK-00063I-FC; Fri, 09 Oct 2020 02:46:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5210 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kQmAI-0001JS-CH; Fri, 09 Oct 2020 02:46:08 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0CC368D2AD7916C895B5;
 Fri,  9 Oct 2020 14:46:03 +0800 (CST)
Received: from localhost (10.174.186.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 14:45:53 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH V2 04/14] rx/: fix some comment spelling errors
Date: Fri, 9 Oct 2020 14:44:39 +0800
Message-ID: <20201009064449.2336-5-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20201009064449.2336-1-zhaolichang@huawei.com>
References: <20201009064449.2336-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.238]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:45:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: David
 Edmondson <david.edmondson@oracle.com>, zhaolichang <zhaolichang@huawei.com>,
 qemu-devel@nongnu.org, Philippe Mathieu-Daude <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu/target/rx.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Reviewed-by: Philippe Mathieu-Daude<f4bug@amsat.org>
---
 target/rx/op_helper.c | 2 +-
 target/rx/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index f89d294f2b..59389f4992 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -318,7 +318,7 @@ void helper_swhile(CPURXState *env, uint32_t sz)
     env->psw_c = (tmp <= env->regs[2]);
 }
 
-/* accumlator operations */
+/* accumulator operations */
 void helper_rmpa(CPURXState *env, uint32_t sz)
 {
     uint64_t result_l, prev;
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 482278edd2..9ea941c630 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1089,7 +1089,7 @@ static void rx_sub(TCGv ret, TCGv arg1, TCGv arg2)
     tcg_gen_xor_i32(temp, arg1, arg2);
     tcg_gen_and_i32(cpu_psw_o, cpu_psw_o, temp);
     tcg_temp_free_i32(temp);
-    /* CMP not requred return */
+    /* CMP not required return */
     if (ret) {
         tcg_gen_mov_i32(ret, cpu_psw_s);
     }
-- 
2.26.2.windows.1


