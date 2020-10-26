Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14455C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E6120738
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E6120738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX189-0002Qa-LO
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kX16W-0000eM-9G; Mon, 26 Oct 2020 07:56:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kX16R-0000hs-5d; Mon, 26 Oct 2020 07:55:59 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CKYFP0mGSz15MWN;
 Mon, 26 Oct 2020 19:55:53 +0800 (CST)
Received: from huawei.com (10.174.186.209) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 26 Oct 2020
 19:55:41 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH V4 5/6] target/riscv: Add V extension state description
Date: Mon, 26 Oct 2020 19:55:29 +0800
Message-ID: <20201026115530.304-6-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20201026115530.304-1-jiangyifei@huawei.com>
References: <20201026115530.304-1-jiangyifei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.209]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=jiangyifei@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 07:55:44
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, victor.zhangxiaofeng@huawei.com,
 richard.henderson@linaro.org, Yifei Jiang <jiangyifei@huawei.com>,
 Alistair Francis <alistair.francis@wdc.com>, yinyipeng1@huawei.com,
 palmer@dabbelt.com, wu.wubin@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the case of supporting V extension, add V extension description
to vmstate_riscv_cpu.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/machine.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ae60050898..44d4015bd6 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -76,6 +76,30 @@ static bool hyper_needed(void *opaque)
     return riscv_has_ext(env, RVH);
 }
 
+static bool vector_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    return riscv_has_ext(env, RVV);
+}
+
+static const VMStateDescription vmstate_vector = {
+    .name = "cpu/vector",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vector_needed,
+    .fields = (VMStateField[]) {
+            VMSTATE_UINT64_ARRAY(env.vreg, RISCVCPU, 32 * RV_VLEN_MAX / 64),
+            VMSTATE_UINTTL(env.vxrm, RISCVCPU),
+            VMSTATE_UINTTL(env.vxsat, RISCVCPU),
+            VMSTATE_UINTTL(env.vl, RISCVCPU),
+            VMSTATE_UINTTL(env.vstart, RISCVCPU),
+            VMSTATE_UINTTL(env.vtype, RISCVCPU),
+            VMSTATE_END_OF_LIST()
+        }
+};
+
 static const VMStateDescription vmstate_hyper = {
     .name = "cpu/hyper",
     .version_id = 1,
@@ -166,6 +190,7 @@ const VMStateDescription vmstate_riscv_cpu = {
     .subsections = (const VMStateDescription * []) {
         &vmstate_pmp,
         &vmstate_hyper,
+        &vmstate_vector,
         NULL
     }
 };
-- 
2.19.1


