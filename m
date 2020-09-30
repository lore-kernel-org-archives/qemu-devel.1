Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B810DC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B442074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B442074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZ07-0004Vj-49
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYot-0007le-Sz; Wed, 30 Sep 2020 05:54:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46890 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYoh-0004Pr-E9; Wed, 30 Sep 2020 05:54:43 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0378641AB2E9DBD4BE95;
 Wed, 30 Sep 2020 17:54:29 +0800 (CST)
Received: from localhost (10.174.185.186) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:54:21 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 11/14] avr/: fix some comment spelling errors
Date: Wed, 30 Sep 2020 17:53:18 +0800
Message-ID: <20200930095321.2006-12-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200930095321.2006-1-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.186]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 05:46:49
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu/target/avr.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 target/avr/helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index d96d143..9f325bc 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -97,7 +97,7 @@ int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
 
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    return addr; /* I assume 1:1 address correspondance */
+    return addr; /* I assume 1:1 address correspondence */
 }
 
 bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
@@ -298,7 +298,7 @@ void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
 }
 
 /*
- *  this function implements LD instruction when there is a posibility to read
+ *  this function implements LD instruction when there is a possibility to read
  *  from a CPU register
  */
 target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
@@ -322,7 +322,7 @@ target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
 }
 
 /*
- *  this function implements ST instruction when there is a posibility to write
+ *  this function implements ST instruction when there is a possibility to write
  *  into a CPU register
  */
 void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
-- 
2.26.2.windows.1


