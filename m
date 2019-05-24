Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8220CC282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A80E21773
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qk7ieMjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A80E21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKJb-0002lb-JN
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:13:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK43-0005Im-Uo
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJup-0004Pn-KM
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:48:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJup-00046f-9T; Fri, 24 May 2019 19:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741680; x=1590277680;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=al8LxCnIVbOOxV+CyVlDV2vfxMzKewDCHGGm9YaIPx8=;
	b=qk7ieMjJMmcupPcrKB5VoMNFPOtFjUQNWa8ofJdYX9hqNXRfBGrDMvvy
	Cz4tHx38/CL08bd9546e3H2xWhihqTxPSY1Xv595jbMg8ONw86lyqj+EW
	sTqKW8/dmTIvhunpCHiTj6Pc67qO3oVZH5uvpN/TtPFYbr4BS0iOyeHpJ
	Wr63rvXM4HY7Bhm8R1u9Cq0JYjMpH6u7rv2CFIKILx9BKnXy6CngtH0+/
	y7zWlM2zwS7GvhgwXR9x1nqGxYMTmVW1xN9SufBO1T/3lYIXgizi23V96
	pvehgBM31EDduiE25WS/NS3nsl9J8zXPFUm5xW+PB83FP3AxdJMgEOKqx Q==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="110307768"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:47:59 +0800
IronPort-SDR: KgtMtEoXYCkJJxzZmvKUg2rmvtu9pUqBnIQiR0zXFyV1Cy4XZcbYi1/hIaPPk2CYhpsrpNFydX
	CiNqC07sKxCnAB8fE0QAWyrRiGoHhTK2iyl5kNmu7aB7HFn7yvHw+SK9iL7vgvY6nqXu+eupPR
	a1T3JYTvGa8/Mq17YwxEuESJtkdWFPtGJERyy4BmWM5HOO9oU+UxtnEQmifM+k3WL5MVqSnkHa
	qOx1so3cp21YExekbmzgNeIXWglVeVdQ09HtptqFalecR1TweTNCSWV5vqD228RQUhockR29wt
	rrLjEjlRAG0ibpl8VcxX7BLw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:38 -0700
IronPort-SDR: UNkXA2uZYN8Ntjqye84htA1ZmgQ6WCZfSpvGc0aW7/SqXxT1hc3WiaE+/TNTYvjkVm9P8A5Ey+
	WW6QdQt343l7RsLMtHGRr3sq7qfYdI72eTdbNtjQJ85asM5fLe+EaTDZwehLOlbg2Q+Sk7+seU
	/GYNK2KjQic80R4Cl4oHEkuHhWLzhA0l1gqKGLmxkyX5lAgFUBoTKOvdZiOxStA1PPCHnHiU9i
	ALyPDMmFkJghmDqOPYBTJLJMhC3vLEYQde+D4812eGtRzYskV3Md2D8cp3p/J3VtKyGzPyPuQX
	S6A=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:47:59 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:46:04 -0700
Message-Id: <65714aac56e24d23840b733f0245f9d0b5ecf450.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [RFC v1 11/23] target/riscv: Add background register
 swapping function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_bits.h   |  5 ++++
 target/riscv/cpu_helper.c | 52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b99d2b7af2..9897392ab7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -319,6 +319,7 @@ void riscv_cpu_list(void);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+void riscv_cpu_swap_background_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 9c27727e6f..28117bdd32 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -550,3 +550,8 @@
 #define SIP_SSIP                           MIP_SSIP
 #define SIP_STIP                           MIP_STIP
 #define SIP_SEIP                           MIP_SEIP
+
+/* MIE masks */
+#define MIE_SEIE                           (1 << IRQ_S_EXT)
+#define MIE_STIE                           (1 << IRQ_S_TIMER)
+#define MIE_SSIE                           (1 << IRQ_S_SOFT)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 1f466effcf..0128546e6a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -86,6 +86,58 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #if !defined(CONFIG_USER_ONLY)
 
+void riscv_cpu_swap_background_regs(CPURISCVState *env)
+{
+    RISCVCPU *cpu = riscv_env_get_cpu(env);
+    target_ulong tmp;
+    target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
+                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
+    target_ulong sie_mask = MIE_SEIE | MIE_STIE | MIE_SSIE;
+
+    g_assert(riscv_has_ext(env, RVH));
+
+#if defined(TARGET_RISCV64)
+    mstatus_mask |= MSTATUS64_UXL;
+#endif
+
+    tmp = env->bsstatus & mstatus_mask;
+    env->bsstatus = env->mstatus & mstatus_mask;
+    env->mstatus = (env->mstatus & ~mstatus_mask) | tmp;
+
+    tmp = env->bsie & sie_mask;
+    env->bsie = env->mie & sie_mask;
+    env->mie = (env->mie & ~sie_mask) | tmp;
+
+    tmp = env->bstvec;
+    env->bstvec = env->stvec;
+    env->stvec = tmp;
+
+    tmp = env->bsscratch;
+    env->bsscratch = env->sscratch;
+    env->sscratch = tmp;
+
+    tmp = env->bsepc;
+    env->bsepc = env->sepc;
+    env->sepc = tmp;
+
+    tmp = env->bscause;
+    env->bscause = env->scause;
+    env->scause = tmp;
+
+    tmp = env->bstval;
+    env->bstval = env->sbadaddr;
+    env->sbadaddr = tmp;
+
+    tmp = env->bsatp;
+    env->bsatp = env->satp;
+    env->satp = tmp;
+
+    tmp = (target_ulong)atomic_read(&env->bsip);
+    tmp = riscv_cpu_update_mip(cpu, (MIP_SSIP | MIP_STIP | MIP_SEIP), tmp);
+    tmp &= MIP_SSIP | MIP_STIP | MIP_SEIP;
+    atomic_set(&env->bsip, tmp);
+}
+
 bool riscv_cpu_virt_enabled(CPURISCVState *env)
 {
     bool tmp;
-- 
2.21.0


