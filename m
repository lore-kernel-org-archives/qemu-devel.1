Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0011BC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18D820868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eXRF4pPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18D820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZMxu-0007Hu-2v
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47640)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrt-000422-HU
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrr-0001fO-LR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrr-0001Pu-8h; Fri, 07 Jun 2019 17:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944668; x=1591480668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fvl20bL70W6URC8x1oiu+t8B2haDxcStjjs1M9AXrF0=;
 b=eXRF4pPcBIMG3/H40Z3QrdPk/iGB2lPG8WBW4sWrG0JZJWcUJy8bJI5q
 WDI3249t0mEf56/oyS1HKAVEjI7VymZIkde4VWgU2zQ8AskPuKcIMGTnh
 3jFzBLtrAMLSkTKcVcOq5qKNI5KXeS88FRBzcu4VWDjt2kABGKHKcTw6L
 VC+UNYRzzHMeEwQr4/BlD4Bowdm1EUEe3w3H8eeAWJipGd8sTTL/KdF6O
 Ka7NFhLMJQ0PgtKHChSj0qv4iYphUK41hHaJQriL2SrqiQQMuhviUQQZC
 856mJCsaGq7NFJ7GV73ARFIFFjN7M6VOyWjreBRN0L5iFAdRIQFaJv154 w==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014077"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:57:38 +0800
IronPort-SDR: wyG/T8MH6DVqIFaop1zfLNxRzNrhBcHW+7ZpaA2pbqywYaMY9NUwFcxJwCgStlpCw8rA9T3iC3
 g3LH+ARpVn2dkRoFL+PtiZbeFz4QhOcOQ5ePhYmrXXPXNtq+7NLNaxzbxk3XoXWg/JXLi3pNMc
 ZYN9YrXBF18TPMyR073+dnfgeYO1zArHskObZgALEHAjr8gsVABS0Qd1UvaGDoLUhlpvVaLnKi
 w2+1FbtpHCHcewvExWpWIDDetKUd4NBbn+X0ev9q/+ZZHzVt6HmAdDPJ51Hi7GkFg7DlaVQR5z
 uwXtqCfsWJDAmmhuq0cUZDCs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:34:53 -0700
IronPort-SDR: 9tcQlM9Y2r7jN1rsFOMboBDnQ/pd2MDECyzR0lXILzyG1J+5HkKdoLfjVG7Q+Kfkq09+qSysC0
 H/hRKfLZ8hQYF7vXJzS4EipsOXWofpk+imvWu40pM+lkSsBHjyN1s5NwL3dPeJImc0cPzhmfqM
 gXGJU/eoUU73f3YUjRGOne+5ymK58J8QUkuRsQUEDJETMIYELQOl6wvqibYTu0rsR85iO5j4mC
 s3W5qzkfAkGNeyvHgLFppkt223q//tOuQBEOSUl4jatStOM/OjuRHH1V5h5kQ6vN3f2wclB6HR
 yPg=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:57:37 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:27 -0700
Message-Id: <b371cd84627ab252e938cd7c3a0ab42ce5fdfe89.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 03/27] target/riscv: Add the virtulisation
 mode
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  4 ++++
 target/riscv/cpu_bits.h   |  6 ++++++
 target/riscv/cpu_helper.c | 23 +++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3337d1aef3..de4843b879 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -132,6 +132,8 @@ struct CPURISCVState {
 
 #ifndef CONFIG_USER_ONLY
     target_ulong priv;
+    /* This contains QEMU specific information about the virt state. */
+    target_ulong virt;
     target_ulong resetvec;
 
     target_ulong mhartid;
@@ -278,6 +280,8 @@ void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
+bool riscv_cpu_virt_enabled(CPURISCVState *env);
+void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index dc9d53d4be..07c95e8d2c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -417,6 +417,12 @@
 #define PRV_H 2 /* Reserved */
 #define PRV_M 3
 
+/* Virtulisation modes */
+#define VIRT_OFF            0
+#define VIRT_ON             1
+#define VIRT_MODE_SHIFT     0
+#define VIRT_MODE_MASK      (1 << VIRT_MODE_SHIFT)
+
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
 #define SATP32_ASID         0x7fc00000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 872835177a..5912ae63b7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -71,6 +71,29 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #if !defined(CONFIG_USER_ONLY)
 
+bool riscv_cpu_virt_enabled(CPURISCVState *env)
+{
+    bool tmp;
+
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    tmp = (env->virt & VIRT_MODE_MASK) >> VIRT_MODE_SHIFT;
+
+    return tmp == VIRT_ON;
+}
+
+void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt &= ~VIRT_MODE_MASK;
+    env->virt |= enable << VIRT_MODE_SHIFT;
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.21.0


