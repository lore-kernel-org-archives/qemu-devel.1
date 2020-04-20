Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2747AC54FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 02:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E9E206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 02:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E9E206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQM8e-0005LN-3r
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 22:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46680 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jQM80-0004wI-3n
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 22:25:44 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jQM7z-0000gI-AW
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 22:25:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35512 helo=huawei.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jQM7y-0000Me-Gn
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 22:25:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E464268657D295F85E8B
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 10:25:29 +0800 (CST)
Received: from opensource.huawei.com (10.175.104.212) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Apr 2020 10:25:20 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <ysato@users.sourceforge.jp>
Subject: [PATCH] op_helper: fix some compile warnings
Date: Mon, 20 Apr 2020 01:49:59 -0400
Message-ID: <20200420054959.8082-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/19
 22:25:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: euler.robot@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We got the following compile-time warnings(gcc7.3):
/mnt/sdb//qemu/target/rx/op_helper.c: In function ‘helper_scmpu’:
/mnt/sdb/qemu/target/rx/op_helper.c:213:24: error: ‘tmp1’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     env->psw_c = (tmp0 >= tmp1);
                  ~~~~~~^~~~~~~~
/mnt/sdb/qemu/target/rx/op_helper.c:213:24: error: ‘tmp0’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
/mnt/sdb/qemu/target/rx/op_helper.c: In function ‘helper_suntil’:
/mnt/sdb/qemu/target/rx/op_helper.c:299:23: error: ‘tmp’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     env->psw_c = (tmp <= env->regs[2]);
                  ~~~~~^~~~~~~~~~~~~~~~
/mnt/sdb/qemu/target/rx/op_helper.c: In function ‘helper_swhile’:
/mnt/sdb/qemu/target/rx/op_helper.c:318:23: error: ‘tmp’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     env->psw_c = (tmp <= env->regs[2]);

Actually, it looks like a false-positive because it will enter the body of while loop and init it for the first time.
Let's change 'while' to 'do .. while' to avoid it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 target/rx/op_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index f89d294f2b..b612ab1da8 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -201,14 +201,14 @@ void helper_scmpu(CPURXState *env)
     if (env->regs[3] == 0) {
         return;
     }
-    while (env->regs[3] != 0) {
+    do {
         tmp0 = cpu_ldub_data_ra(env, env->regs[1]++, GETPC());
         tmp1 = cpu_ldub_data_ra(env, env->regs[2]++, GETPC());
         env->regs[3]--;
         if (tmp0 != tmp1 || tmp0 == '\0') {
             break;
         }
-    }
+    } while (env->regs[3] != 0);
     env->psw_z = tmp0 - tmp1;
     env->psw_c = (tmp0 >= tmp1);
 }
@@ -287,14 +287,14 @@ void helper_suntil(CPURXState *env, uint32_t sz)
     if (env->regs[3] == 0) {
         return ;
     }
-    while (env->regs[3] != 0) {
+    do {
         tmp = cpu_ldufn[sz](env, env->regs[1], GETPC());
         env->regs[1] += 1 << sz;
         env->regs[3]--;
         if (tmp == env->regs[2]) {
             break;
         }
-    }
+    } while (env->regs[3] != 0);
     env->psw_z = tmp - env->regs[2];
     env->psw_c = (tmp <= env->regs[2]);
 }
@@ -306,14 +306,14 @@ void helper_swhile(CPURXState *env, uint32_t sz)
     if (env->regs[3] == 0) {
         return ;
     }
-    while (env->regs[3] != 0) {
+    do {
         tmp = cpu_ldufn[sz](env, env->regs[1], GETPC());
         env->regs[1] += 1 << sz;
         env->regs[3]--;
         if (tmp != env->regs[2]) {
             break;
         }
-    }
+    } while (env->regs[3] != 0);
     env->psw_z = env->regs[3];
     env->psw_c = (tmp <= env->regs[2]);
 }
-- 
2.18.2


