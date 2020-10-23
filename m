Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9ADC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1EE2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mup447R+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1EE2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzdZ-00024a-JV
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFi-0002uC-Gp; Fri, 23 Oct 2020 11:45:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFc-0003kI-Dd; Fri, 23 Oct 2020 11:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467909; x=1635003909;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=myXjNQiOt7ti2QSW3Dswf5jD8xRwo2yguEV3vPAYFhY=;
 b=mup447R+ZcNb5MO1YCB3rbaH2NyOoayxrKZtLXIhIom6fS+Y/4HkTTmI
 rD7Jh42ei6JjS3hNjOV/irLkQvNlGDlAx8Yl8h+uxzi0quLf1aObMVcVp
 T+sjORvBho0iHgs0TSzrfOcRVLcqDmSrN9PGH0j9co5jxXJkQoP/OgBZn
 TKbVupQwZSoXrK21Ee19EKg3naDDI0JpcN3cQU0bj9xL6bE48s6HSUTqa
 nzlbfUODZ3xmPbqpOjGG2jf6dUlu+Qm633NwxdIPOUigiPRlwIF7gPrN9
 OhsAenTDL1EXFeJd62PhsubLz7pvtiDrcN7FJlIz4j/I2pD2bVg3Qzb/8 Q==;
IronPort-SDR: 7Z1OF8oVfprqs5hUNh8v8MYkYUx5spoYQiqzYLkggfEQxyfhKz6IyNziF5jFPqT3xNbTRmUgho
 sIqiDaYsOC/oRAAEu5agBiLLHf+IgAryP7PIlElyNEgy9aAo5ddWjbKzzoFq7v6e9TGzjchhCY
 9L6gqXxqO6OwZCh3TqP3Kw+6GivvA6RqYgOaCH6narNk0QyzjcydcpX3wvABQoFjyeQEiCLFZ3
 MQnI8oGJh1iieGVbRJi/CLWsn4uTEVe5z4QpWbO/y1jl3XgSCi/gCkAYF80b1OzVlvGSyWbBBa
 bzY=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="151960172"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:45:07 +0800
IronPort-SDR: rjXeMbUaL2bCCtFp/h5iNOqreMK/vxefmYhninL6LkuVrcilG8b3VmtyGFsUUEOBkUnLwza+G3
 kcmTvLFEgnHAKTtJAFOuTK76eJi/bLj7+jbGNRmwY6j/Ia2/NT6sWqDcgv38fUSlunQZgP0vcl
 yufWHsXNwwmbtUufF8zWCkiUhujvN+8uYipkD0qJx/0/3TomzzdTzvS/wiqj7URUIFfCPB3j58
 ECJF+i3eRpvVREpuSW01XlChxN7HJUIV8u+vPqnCrVSjKjM9x201D7k/HQidG2LtO7a4YyrYc9
 PT02jrvj3mPkRvbi0u2GEz9H
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:31:29 -0700
IronPort-SDR: kZLY2Hna68zkPnt2QHdGgRxJmmyuClQZWxAVw/8L1n/IjfdqJApvhutWK6CNdVfoEwIUv6R6Ga
 wkbz2fWP3pTA7nyTixV4un5thLmVTwG94xTXpSEoqC1xKjKNIk0TIvBEix0+2AkzRmXjy9wJZh
 +YX0Unh22LhCzHI69E8YX1awjkiwJhQz0OBS2hNvPvyfQ+ND6oh9c8jtTfu5z4vfFeGVk4/+M6
 dvIvRIjVtD7EpuDrwQk8c2l/BPz//gfDDcib+ifiENpBlVESmeHQuP4+nV4u/gQ2kjxaEjGcb2
 bQg=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2020 08:45:06 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 12/16] target/riscv: cpu_helper: Remove compile time XLEN
 checks
Date: Fri, 23 Oct 2020 08:33:46 -0700
Message-Id: <6b17e9aff7bd6823574a94dc0d615117ce6edef6.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:44:34
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  6 ++---
 target/riscv/cpu_helper.c | 52 ++++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6096243aed..8bde15544d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -194,9 +194,8 @@ struct CPURISCVState {
     target_ulong vscause;
     target_ulong vstval;
     target_ulong vsatp;
-#ifdef TARGET_RISCV32
+    /* This is RV32 only */
     target_ulong vsstatush;
-#endif
 
     target_ulong mtval2;
     target_ulong mtinst;
@@ -209,9 +208,8 @@ struct CPURISCVState {
     target_ulong stval_hs;
     target_ulong satp_hs;
     target_ulong mstatus_hs;
-#ifdef TARGET_RISCV32
+    /* This is RV32 only */
     target_ulong mstatush_hs;
-#endif
 
     target_ulong scounteren;
     target_ulong mcounteren;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 4652082df1..62aed24feb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -126,10 +126,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
         env->mstatus &= ~mstatus_mask;
         env->mstatus |= env->mstatus_hs;
 
-#if defined(TARGET_RISCV32)
-        env->vsstatush = env->mstatush;
-        env->mstatush |= env->mstatush_hs;
-#endif
+        if (riscv_cpu_is_32bit(env)) {
+            env->vsstatush = env->mstatush;
+            env->mstatush |= env->mstatush_hs;
+        }
 
         env->vstvec = env->stvec;
         env->stvec = env->stvec_hs;
@@ -154,10 +154,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
         env->mstatus &= ~mstatus_mask;
         env->mstatus |= env->vsstatus;
 
-#if defined(TARGET_RISCV32)
-        env->mstatush_hs = env->mstatush;
-        env->mstatush |= env->vsstatush;
-#endif
+        if (riscv_cpu_is_32bit(env)) {
+            env->mstatush_hs = env->mstatush;
+            env->mstatush |= env->vsstatush;
+        }
 
         env->stvec_hs = env->stvec;
         env->stvec = env->vstvec;
@@ -472,11 +472,13 @@ restart:
             return TRANSLATE_PMP_FAIL;
         }
 
-#if defined(TARGET_RISCV32)
-        target_ulong pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
-#elif defined(TARGET_RISCV64)
-        target_ulong pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
-#endif
+        target_ulong pte;
+        if (riscv_cpu_is_32bit(env)) {
+            pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
+        } else {
+            pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
+        }
+
         if (res != MEMTX_OK) {
             return TRANSLATE_FAIL;
         }
@@ -995,19 +997,19 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             if (riscv_cpu_virt_enabled(env)) {
                 riscv_cpu_swap_hypervisor_regs(env);
             }
-#ifdef TARGET_RISCV32
-            env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
-                                       riscv_cpu_virt_enabled(env));
-            if (riscv_cpu_virt_enabled(env) && tval) {
-                env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
-            }
-#else
-            env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
-                                      riscv_cpu_virt_enabled(env));
-            if (riscv_cpu_virt_enabled(env) && tval) {
-                env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
+            if (riscv_cpu_is_32bit(env)) {
+                env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
+                                           riscv_cpu_virt_enabled(env));
+                if (riscv_cpu_virt_enabled(env) && tval) {
+                    env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
+                }
+            } else {
+                env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
+                                          riscv_cpu_virt_enabled(env));
+                if (riscv_cpu_virt_enabled(env) && tval) {
+                    env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
+                }
             }
-#endif
 
             mtval2 = env->guest_phys_fault_addr;
 
-- 
2.28.0


