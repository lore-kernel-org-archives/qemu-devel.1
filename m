Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C15C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1341A221EC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K3bdBplu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1341A221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMXDB-0001H2-7D
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 09:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5325bd5c7=alistair.francis@wdc.com>)
 id 1kMXC0-0000Dw-Hr; Sun, 27 Sep 2020 09:58:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5325bd5c7=alistair.francis@wdc.com>)
 id 1kMXBy-0000RQ-7O; Sun, 27 Sep 2020 09:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601215098; x=1632751098;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZCcrT5YMrpdRhbHJhpIScGh+bM4d/wBPd7bfiV9lqEk=;
 b=K3bdBpluvvLD/0JPZyIQcnBd9uWFauZ7TdPm5roZvxzQLHPLdkrj/heD
 Diqsn712SjgYTE5aTsnFdWcL6rXWrJ+tORY4ySpyRpYCvqcxTBbTYikzq
 e8yWiQ/mkce7E+XYaOgyBJdZonEqnUq2lKcE5xf2IX4OWiXcrj9vAJwut
 BRZs0qAVe4ZmriKflOpCsSWPDMbz9VqHuGRW2P/11ydSxPlhQ1m8kM38H
 6Df0NpMK3alvmmQpmBC5cPD0+C361u7uwbtxu7JEl8D7MazRAyGyuDN+T
 v6CUA9IvfbVS8qUcIZUH4yU1GcV4O2XSUhzbzaPj1UVDeeRrFlvDECnlX w==;
IronPort-SDR: BtZku4Lax1clj4qCoLu3trF5PQDgErM8Rvm2aA3C7ZxEtPt9wi9q7JOLtRu5n/5fBghCOCENQ4
 CvHL/TsuT/56wkp4VVxqqbKGBEJdZKiv9tDFEjVPFqdUPzM1yNtDJ9ZlRNVwNfenlCGiNS7iw7
 x8bEiVBIxzERfMenZszHwikvUanC35uz+oNJYLYRtEfjVSl7yCDi+qokHIEgdYvoSKPEI3ye4q
 vQPLlhU1rQgQEHt3fjWeCLp2TDssRYkn7yIFkZEbyMJ49BCpWhBp1swEEgzVM8s99cx9tx13rW
 tnw=
X-IronPort-AV: E=Sophos;i="5.77,310,1596470400"; d="scan'208";a="148291543"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2020 21:58:16 +0800
IronPort-SDR: 1KsMsqWD+/BNgF+JRm3J3yRqUy+r9KnzJUH+npUGOlSMYWiXoAiUALzA8hFLiAbrDkOpRH506f
 vQUAwyyivZ7g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 06:45:13 -0700
IronPort-SDR: +HltbB0QGWRVDTc4DEgUiNbDRdA5MYyrvBOQBd1GjwtMngjlNaMYrQOnVRcI85KVvl6nzSG0EX
 E2dELgWO+6Ew==
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.38])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 06:58:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/1] riscv: Convert interrupt logs to use qemu_log_mask()
Date: Sun, 27 Sep 2020 06:47:20 -0700
Message-Id: <20e41bdc81dbde7f9b3fdc1c768510ea99e8f565.1601214416.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5325bd5c7=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 09:57:06
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we log interrupts and exceptions using the trace backed in
riscv_cpu_do_interrupt(). We also log execptions using the interrupt log
mask (-d int) in riscv_raise_exception().

This PR converts riscv_cpu_do_interrupt() to log both interrupts and
exceptions with the interrupt log mask, so that both are printed when a
user runs QEMU with -d int.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 7 +++++--
 target/riscv/op_helper.c  | 1 -
 target/riscv/trace-events | 3 ---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 904899054d..9df3238213 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -894,8 +894,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
     }
 
-    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval,
-        riscv_cpu_get_trap_name(cause, async));
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
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index b7e371ee97..6be2147c8f 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -1,6 +1,3 @@
-# cpu_helper.c
-riscv_trap(uint64_t hartid, bool async, uint64_t cause, uint64_t epc, uint64_t tval, const char *desc) "hart:%"PRId64", async:%d, cause:%"PRId64", epc:0x%"PRIx64", tval:0x%"PRIx64", desc=%s"
-
 # pmp.c
 pmpcfg_csr_read(uint64_t mhartid, uint32_t reg_index, uint64_t val) "hart %" PRIu64 ": read reg%" PRIu32", val: 0x%" PRIx64
 pmpcfg_csr_write(uint64_t mhartid, uint32_t reg_index, uint64_t val) "hart %" PRIu64 ": write reg%" PRIu32", val: 0x%" PRIx64
-- 
2.28.0


