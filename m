Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A80FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7723216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7723216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuo1-0001v1-8u
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kZumm-0000eM-Q5; Tue, 03 Nov 2020 06:47:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kZumh-0005W4-5B; Tue, 03 Nov 2020 06:47:36 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQSgt5vyMz15QTp;
 Tue,  3 Nov 2020 19:47:22 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 19:47:19 +0800
From: Xinhao Zhang <zhangxinhao1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/3] target/arm: add spaces around operator
Date: Tue, 3 Nov 2020 19:45:27 +0800
Message-ID: <20201103114529.638233-1-zhangxinhao1@huawei.com>
X-Mailer: git-send-email 2.29.0-rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhangxinhao1@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:56:56
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
Cc: alex.chen@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-trivial@nongnu.org, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix code style. Operator needs spaces both sides.

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
---
 target/arm/arch_dump.c | 8 ++++----
 target/arm/arm-semi.c  | 8 ++++----
 target/arm/helper.c    | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 7693e17e96..0184845310 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -114,8 +114,8 @@ static int aarch64_write_elf64_prfpreg(WriteCoreDumpFunction f,
 
     for (i = 0; i < 32; ++i) {
         uint64_t *q = aa64_vfp_qreg(env, i);
-        note.vfp.vregs[2*i + 0] = cpu_to_dump64(s, q[0]);
-        note.vfp.vregs[2*i + 1] = cpu_to_dump64(s, q[1]);
+        note.vfp.vregs[2 * i + 0] = cpu_to_dump64(s, q[0]);
+        note.vfp.vregs[2 * i + 1] = cpu_to_dump64(s, q[1]);
     }
 
     if (s->dump_info.d_endian == ELFDATA2MSB) {
@@ -125,8 +125,8 @@ static int aarch64_write_elf64_prfpreg(WriteCoreDumpFunction f,
          */
         for (i = 0; i < 32; ++i) {
             uint64_t tmp = note.vfp.vregs[2*i];
-            note.vfp.vregs[2*i] = note.vfp.vregs[2*i+1];
-            note.vfp.vregs[2*i+1] = tmp;
+            note.vfp.vregs[2 * i] = note.vfp.vregs[2 * i + 1];
+            note.vfp.vregs[2 * i + 1] = tmp;
         }
     }
 
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 8718fd0194..c1df664f7e 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -755,7 +755,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         if (use_gdb_syscalls()) {
             arm_semi_open_guestfd = guestfd;
             ret = arm_gdb_syscall(cpu, arm_semi_open_cb, "open,%s,%x,1a4", arg0,
-                                  (int)arg2+1, gdb_open_modeflags[arg1]);
+                                  (int)arg2 + 1, gdb_open_modeflags[arg1]);
         } else {
             ret = set_swi_errno(env, open(s, open_modeflags[arg1], 0644));
             if (ret == (uint32_t)-1) {
@@ -852,7 +852,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         GET_ARG(1);
         if (use_gdb_syscalls()) {
             ret = arm_gdb_syscall(cpu, arm_semi_cb, "unlink,%s",
-                                  arg0, (int)arg1+1);
+                                  arg0, (int)arg1 + 1);
         } else {
             s = lock_user_string(arg0);
             if (!s) {
@@ -870,7 +870,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         GET_ARG(3);
         if (use_gdb_syscalls()) {
             return arm_gdb_syscall(cpu, arm_semi_cb, "rename,%s,%s",
-                                   arg0, (int)arg1+1, arg2, (int)arg3+1);
+                                   arg0, (int)arg1 + 1, arg2, (int)arg3 + 1);
         } else {
             char *s2;
             s = lock_user_string(arg0);
@@ -896,7 +896,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         GET_ARG(1);
         if (use_gdb_syscalls()) {
             return arm_gdb_syscall(cpu, arm_semi_cb, "system,%s",
-                                   arg0, (int)arg1+1);
+                                   arg0, (int)arg1 + 1);
         } else {
             s = lock_user_string(arg0);
             if (!s) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 97bb6b8c01..4586e33014 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12518,7 +12518,7 @@ uint32_t HELPER(usad8)(uint32_t a, uint32_t b)
     uint32_t sum;
     sum = do_usad(a, b);
     sum += do_usad(a >> 8, b >> 8);
-    sum += do_usad(a >> 16, b >>16);
+    sum += do_usad(a >> 16, b >> 16);
     sum += do_usad(a >> 24, b >> 24);
     return sum;
 }
-- 
2.29.0-rc1


