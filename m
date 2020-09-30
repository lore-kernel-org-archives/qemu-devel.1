Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF7BC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FFF82076E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFF82076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYt5-0003ah-GZ
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYog-0007Lv-Th; Wed, 30 Sep 2020 05:54:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46690 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYoY-0004Oa-HP; Wed, 30 Sep 2020 05:54:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 90EB21BFFE83BBF6615A;
 Wed, 30 Sep 2020 17:54:18 +0800 (CST)
Received: from localhost (10.174.185.186) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:54:09 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 03/14] riscv/: fix some comment spelling errors
Date: Wed, 30 Sep 2020 17:53:10 +0800
Message-ID: <20200930095321.2006-4-zhaolichang@huawei.com>
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

I found that there are many spelling errors in the comments of qemu/target/riscv.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 target/riscv/cpu.c           | 2 +-
 target/riscv/cpu_bits.h      | 2 +-
 target/riscv/csr.c           | 6 +++---
 target/riscv/vector_helper.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0bbfd7f..f40a0b2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -472,7 +472,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
                     return;
                 }
             } else {
-                qemu_log("vector verison is not specified, "
+                qemu_log("vector version is not specified, "
                         "use the default value v0.7.1\n");
             }
             set_vext_version(env, vext_version);
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index bd36062..6e11555 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -536,7 +536,7 @@
 /* Leaf page shift amount */
 #define PGSHIFT             12
 
-/* Default Reset Vector adress */
+/* Default Reset Vector address */
 #define DEFAULT_RSTVEC      0x1000
 
 /* Exception causes */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 26ae347..559db11 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -624,7 +624,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
-/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
+/* This register is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
 static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 {
     if (env->priv_ver < PRIV_VERSION_1_11_0) {
@@ -634,7 +634,7 @@ static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
     return 0;
 }
 
-/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
+/* This register is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
 static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
 {
     if (env->priv_ver < PRIV_VERSION_1_11_0) {
@@ -1278,7 +1278,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
         !riscv_cpu_virt_enabled(env)) {
         /*
          * We are in S mode without virtualisation, therefore we are in HS Mode.
-         * Add 1 to the effective privledge level to allow us to access the
+         * Add 1 to the effective privilege level to allow us to access the
          * Hypervisor CSRs.
          */
         effective_priv++;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a156573..fa89a6e 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -709,7 +709,7 @@ typedef void vext_amo_noatomic_fn(void *vs3, target_ulong addr,
                                   uint32_t wd, uint32_t idx, CPURISCVState *env,
                                   uintptr_t retaddr);
 
-/* no atomic opreation for vector atomic insructions */
+/* no atomic operation for vector atomic insructions */
 #define DO_SWAP(N, M) (M)
 #define DO_AND(N, M)  (N & M)
 #define DO_XOR(N, M)  (N ^ M)
-- 
2.26.2.windows.1


