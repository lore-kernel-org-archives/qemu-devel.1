Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC21EC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558AE2225F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558AE2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVtCT-0001KE-Ap
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kVt88-0004a6-4C; Fri, 23 Oct 2020 05:13:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5207 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kVt85-0004kg-LV; Fri, 23 Oct 2020 05:12:59 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 48C1243186EAF3CA9A72;
 Fri, 23 Oct 2020 17:12:51 +0800 (CST)
Received: from huawei.com (10.174.186.209) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 23 Oct 2020
 17:12:44 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH V3 4/6] target/riscv: Add H extension state description
Date: Fri, 23 Oct 2020 17:12:23 +0800
Message-ID: <20201023091225.224-5-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20201023091225.224-1-jiangyifei@huawei.com>
References: <20201023091225.224-1-jiangyifei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.209]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=jiangyifei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 05:12:52
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
Cc: zhang.zhanghailiang@huawei.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, victor.zhangxiaofeng@huawei.com,
 richard.henderson@linaro.org, Yifei Jiang <jiangyifei@huawei.com>,
 Alistair.Francis@wdc.com, yinyipeng1@huawei.com, palmer@dabbelt.com,
 wu.wubin@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the case of supporting H extension, add H extension description
to vmstate_riscv_cpu.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
---
 target/riscv/machine.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index fc1461d88e..ae60050898 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -68,6 +68,52 @@ static const VMStateDescription vmstate_pmp = {
     }
 };
 
+static bool hyper_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    return riscv_has_ext(env, RVH);
+}
+
+static const VMStateDescription vmstate_hyper = {
+    .name = "cpu/hyper",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hyper_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(env.hstatus, RISCVCPU),
+        VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
+        VMSTATE_UINTTL(env.hideleg, RISCVCPU),
+        VMSTATE_UINTTL(env.hcounteren, RISCVCPU),
+        VMSTATE_UINTTL(env.htval, RISCVCPU),
+        VMSTATE_UINTTL(env.htinst, RISCVCPU),
+        VMSTATE_UINTTL(env.hgatp, RISCVCPU),
+        VMSTATE_UINT64(env.htimedelta, RISCVCPU),
+
+        VMSTATE_UINT64(env.vsstatus, RISCVCPU),
+        VMSTATE_UINTTL(env.vstvec, RISCVCPU),
+        VMSTATE_UINTTL(env.vsscratch, RISCVCPU),
+        VMSTATE_UINTTL(env.vsepc, RISCVCPU),
+        VMSTATE_UINTTL(env.vscause, RISCVCPU),
+        VMSTATE_UINTTL(env.vstval, RISCVCPU),
+        VMSTATE_UINTTL(env.vsatp, RISCVCPU),
+
+        VMSTATE_UINTTL(env.mtval2, RISCVCPU),
+        VMSTATE_UINTTL(env.mtinst, RISCVCPU),
+
+        VMSTATE_UINTTL(env.stvec_hs, RISCVCPU),
+        VMSTATE_UINTTL(env.sscratch_hs, RISCVCPU),
+        VMSTATE_UINTTL(env.sepc_hs, RISCVCPU),
+        VMSTATE_UINTTL(env.scause_hs, RISCVCPU),
+        VMSTATE_UINTTL(env.stval_hs, RISCVCPU),
+        VMSTATE_UINTTL(env.satp_hs, RISCVCPU),
+        VMSTATE_UINT64(env.mstatus_hs, RISCVCPU),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 1,
@@ -119,6 +165,7 @@ const VMStateDescription vmstate_riscv_cpu = {
     },
     .subsections = (const VMStateDescription * []) {
         &vmstate_pmp,
+        &vmstate_hyper,
         NULL
     }
 };
-- 
2.19.1


