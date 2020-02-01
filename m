Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB37EC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C6A2063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EHRbF8mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C6A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhJz-0006IF-PX
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGw-0000nE-Ba
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGv-0006AU-7I
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:30 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGu-00069K-SW; Fri, 31 Jan 2020 20:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519308; x=1612055308;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9qktGF13kdXFA93/pM0XjdXemD5w7LblcIOe3JTZvfk=;
 b=EHRbF8mM2YvbrwVaAjOp7y4wO/IG4NsiKZSKmuMx5qr9E/hyCc7pYxcw
 m9Fu3IC9u10uPblxGndaqVGobxdLQkuBQnOtnYMGUCiQZBBUw8CSpK8aQ
 TcZP+iqxrSljbKFwPSo4LSZS52Q7UqP6BxKwAf/mdq1wQA6BOZCCw4SDD
 FYVToR8KsOw3LWcIfEwmY03nHUY4svFkpp60lA9CaZ2OKPaPxJb4lDPUY
 8YpJRnwAD6+wFbDIrUKQS6tJwOAIvSfy3tNZaCEK/eK7lyfWVNh3Epge6
 w5QsKNx18f5Iheh9baY30ZTOutSkMRLSIM2jzHH1RS9YA5un3lwqKvVOv g==;
IronPort-SDR: 9VeqVS1qU9QX0vQ09W1wDOddcrsx/AzEby1OsEGPaeUeidriQCqB7AL9gNwrMhDWFuzc7oc6aK
 ExroPOPIar3HYXntQg/n3lGIvf5J+DQnUkjsUKwBpqopO1vYdPTONgnCr3UAyouDn7z9cr+qi3
 ceNckirGJfxhByZ6OLZZMAZGhb3vBf2uh+C+jqjiuMASg6aTj84I4+dhwE8PD4kFa6akpM95xo
 mE2sZKBnSQpPt3Kb1S0bUbfGzuifW6X4uwqoGMsgA6sUjAE57o4ly1ZMFoBPLMDtuQlxAWSuKO
 NEc=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872405"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:28 +0800
IronPort-SDR: w9M0gE2uve5IomOwjCFaLmwJ0CZmNNVSiMvaNdtYpaSekPZdzU+eZsuW8JpCnA984UNpWOciqI
 OObw6Bp+VCCyAj/IDHW2UpDWAJBERzh71U4B2sXSyDi9fzG+aYuNFL22zm4bVtOBshMful0jVx
 CGUC1km7+yu3/7C7hHIIvwGwkibAogBp/x7rO6DSS56m9Jn1gvqRbpgm2HBnTJXGssd+gfnX6/
 hxCD5J8VgrqsOlfHfoNFaMRTyvLBfxAjxEFQj96lgxuUo7x1TmF3AnwuAmkVTY8+OiZD54vRkV
 cI61gjVMiFK1/a0J4rNLp8Bo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:36 -0800
IronPort-SDR: bN5PNFomiyDzBxAAfxOZobFiN4gOTeQxKzhsalvpBB4Ykzl4lObDPL1PasLnGO1meJ4+54TxS/
 uDRFE9VNgFhFun6zCORy+p046HlABuWQ4x+wbgBj+m18dVfZbK1F9G8jDwr9dA0FxaxVIHRsGy
 LHd9dsDvDU4DzOQQTb4N7kw7KVZ1a+kyiAXg3NPCrtelS10Cg5GkyMVAy2U102pHz7Fz6MKeqh
 FtyvBNQ22/Qj62+L+apgodanFWT6V3al65Wr/EbtPBDwRK4Tb3a12MDVnSZLepee9RATiWosn9
 kSU=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:28 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 06/35] target/riscv: Add the virtulisation mode
Date: Fri, 31 Jan 2020 17:01:51 -0800
Message-Id: <0a577a9823fa87fce9e0bda9035f764410c5d237.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h        |  4 ++++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c7f7ae5c38..a9cbd8584e 100644
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
index 8f746fb06f..5844e543f3 100644
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
2.25.0


