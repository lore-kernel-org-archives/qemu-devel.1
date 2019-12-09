Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FD4C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E942F2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nzd1jgY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E942F2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNix-0002XS-Hr
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaM-0006ld-DJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaL-0007C8-6R
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:42 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaK-000793-SA; Mon, 09 Dec 2019 13:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915417; x=1607451417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CgEFuX8z14DHiXti+goRqkoyUVI4syLAp7dUSxYgR9E=;
 b=Nzd1jgY/Bxd9w/nKh8bkPd/m4GbtjpgoSRcnCdjfAfkT/EkH8pY/Idnn
 NGYoNXPCA717ncKHdqetfMIDqEcTlLTzo2tDDB+I9+hmNgJ9toiwpscol
 7RzU+xaKecqu37NixBUsy6dcSS/xlDcaKpSOLkNzdlhCpS9S7MEnSs0qn
 11jwrAIu2z9VNncAwaDttrgLPIN+VGwMcvF3hmYNmXeEU0sIAjyLuYdHr
 8Zo1yc/0YP97zdk7LmBEfjpFgxFni+nAnkwaLCQWhE0/Vw/0dKtJOcMaz
 5zw0MhvLrhXa1dm1+OkfvLsbiqEdxoRMe0gClKXY9rB12e3VBh+BHKkKL Q==;
IronPort-SDR: B6b1am6x2clm3iezF44w+xOpYlMr2nGAGF2Bx1rqoPjOe1NqwXqovw/TIjW9CM6BKKf/eFgwTb
 IeL0xBgyt6XF/sc4ym+5X/NXWvQF9h90rne8hieZVdNdWv/8ED7jCcHcUmqRajoV2pksRaYi7/
 +cmo3ItOs9BPR+xcYmtV/x3agl0ipzRGOT3v2KJHezijyqIqJBiqhEmq5WiHamYn/FyXf9uJEv
 zh5g19Lu+GkaX1TaEZvMK6NtNiMtIfB+KMWz/Q4kIjisPxoi/DB8czBw8vZYcnmPsJ6/gWaGFX
 9lw=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226411927"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:16:57 +0800
IronPort-SDR: dCb/NfvHKKEhdm/s6MJMAW5PPzbO1F7ayvMAbDYzK7Vj07/mdnf65e0OeMyyt9PghiOqt+T/BN
 58CopAOQe5ua72jam0K7mqx/JD5HNtGpD5YqbYuY0MGLKcb+JY1P07iI0fbvRfRXy1kyd8yPx1
 RqUXOiDOZukX8tH9LLo6dJvhJiTE++uvCOaDUHXAZC595JKNeScOZL1b4qeRb3AOTfU55cDDFO
 cMzCafoGblQouL9XqFDjsqLwLP6hQcM4UfnGH9jP1zHA5wj8oIp66cSSAEauwDylCtXosSoK+6
 YZgAkXajmgWVqJIvQmWVaHSv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:10:56 -0800
IronPort-SDR: 6hwKV5qT+jWf03btBz28jodE0Ow6PH4RWcYjDJpe3ViWAjrBx8k0OKuW5UfQZDkqEWVjzcSmp1
 64VYkY+JfDiIjmmb0TP+uIeroJYwBi/M3s/iyqGaLucXMPcRqdM6BzVI6pG7mO6QlLNBYAcvYI
 7RwZv1KCZMNbt13Juqcy4it2XrNkGl+QndC2cOzXRzMMdN9O9QFOhAMPS2pV6JFqzmhUaoLx3n
 iIoc40K8JFpCCNVx/zhQQk9a2j4RCgwcoFu3/Z6FuEPGYbhs25tQbppp0BlwWrOGmbl9fSA9Ov
 I1M=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:16:41 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 07/36] target/riscv: Add the virtulisation mode
Date: Mon,  9 Dec 2019 10:10:58 -0800
Message-Id: <ee07ff556701bfdf0173e73d9ac393273a07d2ce.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  4 ++++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bab938103d..a73292cd20 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -117,6 +117,8 @@ struct CPURISCVState {
 
 #ifndef CONFIG_USER_ONLY
     target_ulong priv;
+    /* This contains QEMU specific information about the virt state. */
+    target_ulong virt;
     target_ulong resetvec;
 
     target_ulong mhartid;
@@ -269,6 +271,8 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
+bool riscv_cpu_virt_enabled(CPURISCVState *env);
+void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index eeaa03c0f8..2cdb0de4fe 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -430,6 +430,9 @@
 #define PRV_H 2 /* Reserved */
 #define PRV_M 3
 
+/* Virtulisation Register Fields */
+#define VIRT_ONOFF          1
+
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
 #define SATP32_ASID         0x7fc00000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c201919c54..046f3549cc 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -82,6 +82,24 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
     return false;
 }
 
+bool riscv_cpu_virt_enabled(CPURISCVState *env)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    return get_field(env->virt, VIRT_ONOFF);
+}
+
+void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt = set_field(env->virt, VIRT_ONOFF, enable);
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.24.0


