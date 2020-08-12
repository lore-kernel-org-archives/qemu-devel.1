Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0B0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8788A20838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qkG00kZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8788A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wMI-00065B-OR
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLJ-0004br-W6; Wed, 12 Aug 2020 15:23:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLH-0000Qi-LQ; Wed, 12 Aug 2020 15:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260199; x=1628796199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vcurfjazEvMMtOCVG9Klun77gGKJkNPeMTrWvizvDhc=;
 b=qkG00kZUg91PhPJ/Tl6cM4GttrJtxb46oPshMXXCM90oBWPFHsPmKpB3
 Bv4y1SPJnpgHecgOhoiStvogho5BOxqlI+QxBdROa9/K/QnW7bWr2xi6T
 Wh4yJ73WmMPl63JNmdcK6Ph4I8PCoE7cgDNXQI6oRSe51BzerpVWSjvKp
 aHHA9L+P8okO6hF9IF9i/awNtzGjaVsob+RiffpZSNfeLcBmODuQRPnej
 mMEyw4f77BxEP/Cr2UwjvKEmGpz6EasTcwG+26Kt+zEYOsiH88pSqehv9
 ysknO8jEpAePMAiybdBbFxfXwHNNKwxGZs2T+KiGklm347ff6+92q3HKn w==;
IronPort-SDR: GfUyoyGLarePZMYXIp8ThAE9CqG/O5PogzdXg+/Su6NqtQrjmW+xe0zTt1hXtMULuR/vLQZ0AF
 el+t1tjOP3PRBW8TAyLgo9YOQMvUj0nReKLSsmkg9m0TAbbc9yxsKiVXNNFJhRs5teNfyse0J7
 TiZ+kfW2/zKBte+0fVA8SnfKou5uICU1VZN+/fi4Dn8EmNoNvlmOh21PSula5QY5PQsduarYhz
 O5hc18yQfeJER1d2aa2x4RvX6uKdwmpS8NimUNUyBXTtNvXuhgNQcIvjxKvKWUim80fbmfKijC
 e6E=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144786678"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:16 +0800
IronPort-SDR: ii49DnrbmH24uTUXU/gZoBrH+yj8k7xbxna2S2BYgQQ72hckUvMHk242+AtP6rLqvae6/T8SDA
 empCkgI/c01g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:11:08 -0700
IronPort-SDR: LqX//zM9FQjRt/lD18USpcQ4leE553RuuQP09AdwXpa9sB23KaZEE3csiKOtsMlQj+9pSnY7uF
 RLKUohES8x6w==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 12:23:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 01/13] target/riscv: Allow setting a two-stage lookup in
 the virt status
Date: Wed, 12 Aug 2020 12:13:16 -0700
Message-Id: <08cdefb171b1bdb0c9e3151c509aaadefc3dcd3e.1597259519.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597259519.git.alistair.francis@wdc.com>
References: <cover.1597259519.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 15:23:14
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, anup.patel@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a804a5d0ba..383808bf88 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -321,6 +321,8 @@ bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
 void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
+bool riscv_cpu_two_stage_lookup(CPURISCVState *env);
+void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 8117e8b5a7..ba0a5b50ff 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -467,6 +467,7 @@
  * page table fault.
  */
 #define FORCE_HS_EXCEP      2
+#define HS_TWO_STAGE        4
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 75d2ae3434..68abccc993 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -220,6 +220,24 @@ void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
     env->virt = set_field(env->virt, FORCE_HS_EXCEP, enable);
 }
 
+bool riscv_cpu_two_stage_lookup(CPURISCVState *env)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    return get_field(env->virt, HS_TWO_STAGE);
+}
+
+void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt = set_field(env->virt, HS_TWO_STAGE, enable);
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.27.0


