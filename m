Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A834C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36B7221F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hY9oeFj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36B7221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzQD-0000Y8-GD
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyr-0004FZ-3X
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyn-0001Y4-Rl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466865; x=1635002865;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qFWvR5KAMA47jbNsvf8MmZ6kG1i3mjBIrx/D3hW3FeI=;
 b=hY9oeFj4RCNRd0uMKqxwgEnmTY5MHh/0YAoOwMyoRPwey9OMKcCrY/55
 DntYcf8GC2l+qD/EGEIkfdpKSjTHwt5J+c5Ss1pPnB+0ODtbnBWIhl1UD
 ONgCzYxfqR2Ep5guPUfun6zZK5mwT8Can4itiqXbZxMYSuKB5JcacUIvw
 DkyMuEjjp04iA0pTIgir22Ff/tizvZ5fAGmPugmF3Q8FpDCGI38aIYUhk
 +GRQ4ZVQRaw6HqUXHLYcsdBsbL5CEtH6o3d3Q5o8wTyu/7F7O86mSCkot
 QC8Y4UHcF1vo6tBeUe3Z2QZyF5P2J+oIOG1IGFe5Mv7SfEFpRGrs7lRIs g==;
IronPort-SDR: 84qF3Gu3gU/0GdKzNUMsGWemigqSnNKk0tVU/hZi2DOzVj9bCusV9CbZA+rdSykpLA1WZ39nF3
 aKh7qXoBmmfGdJYauX0ThfkRyqqGQD7X4aboPQfqOPRZV0lzXZLJyeyCJY4AUbk/nNxK+ZFVHe
 UyB5Mj3uFm/xM+dDAE5rBqI4YtB9LKdowmLzBzfb70DGba5biCTXsgdAv2zJpblzu5p0QrUpMm
 RomJlJf31/Cy0iUIKqm0lKAnOZBbn3p/pRvs+iD3j3cNs6YoWoJs4LzT1mEIwUIunkL1EUicQN
 Nfw=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652317"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:42 +0800
IronPort-SDR: 4O0RbvWX3nqjEyeFPqZErjhzTENO2EYl4wGiUlnbMRRdripRHoxeI21RpKqMtY4GhMPRUyWh9P
 xYJBxaxYYyymJwp8MCSMYuILQrC0rCgDI/iwSorO76iGHYrLTXfPynPc0wmhQKNKMzGKh4WbBt
 fXrEtMkyeJWhSpEB8sljfwmy1JaLqJD9CvtKGzsq1yoQkPVBpZO3XUFIKFoAGi1wcorgm0xYGq
 Jx2Ue0bCyf3axnNGjzZWLhosWj4TmOwarMwYw9Yqt1WVDmoMzQNj+WSCdAfr6J2/nzQQGfDv0L
 I9BhK2MzPU36UK6RGBmq7uG7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:12:58 -0700
IronPort-SDR: 6j6gXNlgnBDBxelCL1wscQaDzpdq1O7JG4Cmrzj1gCoE/H7daFRV83KVrBWJ8gN/acMKLQNoG9
 l3W2+IvH7H2xH9KbXxz8InImuNcOQiAjMV6UAsHTPtLmOTOle2oYYRW0cmTUHjyJaD0y4AHrkw
 g6iP5foNLjSJkC3yzbquHtGPZv/3s4aSZvTrwQLqYDHYXw7/fqRHHfHp11hSZu+zNKcTVbyIq9
 A3QofMzv75pP9TwYTKU/kltk6Bg8IcCOHr2zlXfX7Ox2CcOVBzXYtYHZNoGn/3S7RhiFrJH9RV
 hk8=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 01/12] riscv: Convert interrupt logs to use qemu_log_mask()
Date: Fri, 23 Oct 2020 08:16:08 -0700
Message-Id: <20201023151619.3175155-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we log interrupts and exceptions using the trace backend in
riscv_cpu_do_interrupt(). We also log exceptions using the interrupt log
mask (-d int) in riscv_raise_exception().

This patch converts riscv_cpu_do_interrupt() to log both interrupts and
exceptions with the interrupt log mask, so that both are printed when a
user runs QEMU with -d int.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 29a8c766c7c4748d0f2711c3a0abb81208138c5e.1601652179.git.alistair.francis@wdc.com
---
 target/riscv/cpu_helper.c | 8 +++++++-
 target/riscv/op_helper.c  | 1 -
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 904899054d..6c68239a46 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -895,7 +895,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     }
 
     trace_riscv_trap(env->mhartid, async, cause, env->pc, tval,
-        riscv_cpu_get_trap_name(cause, async));
+                     riscv_cpu_get_trap_name(cause, async));
+
+    qemu_log_mask(CPU_LOG_INT,
+                  "%s: hart:"TARGET_FMT_ld", async:%d, cause:"TARGET_FMT_lx", "
+                  "epc:0x"TARGET_FMT_lx", tval:0x"TARGET_FMT_lx", desc=%s\n",
+                  __func__, env->mhartid, async, cause, env->pc, tval,
+                  riscv_cpu_get_trap_name(cause, async));
 
     if (env->priv <= PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 9b9ada45a9..e987bd262f 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -29,7 +29,6 @@ void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
                                           uint32_t exception, uintptr_t pc)
 {
     CPUState *cs = env_cpu(env);
-    qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
     cs->exception_index = exception;
     cpu_loop_exit_restore(cs, pc);
 }
-- 
2.28.0


