Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2696C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A37E2054F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YMPQgVf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A37E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieO6C-0007Xh-1j
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbS-00089T-8v
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbR-0007qc-7i
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:50 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7465)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbQ-0007jP-VS; Mon, 09 Dec 2019 13:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915498; x=1607451498;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IbEhJgeEcUoKZDupg/Z3GBBNYwuh30M22uZxO4GMSmM=;
 b=YMPQgVf1SylKhmOaMdiMH+IyrjgE869Ax1ld0CuUvpIMgxCvw2I21/sh
 8H/NV+e8CVKap/wpd+cCXqqvLwRHWZh5wVGlSL7Wf91WL4RJLgXA3BBr+
 iWVN1B202xzenGhpG4nmIImYHG53R5PGi7CnG9sxTosb71jRm4ZCnMsrC
 5mCtKDEmDB6jijUZHKbSG3vCd/EAZ3oZoiPuV46gLOzIfrg83Zgn5gYXt
 08HL+v1BAdL1u1DFZhiVoGGbmH2pVJPKpk50DJnGq+jWELIq1ydRVltyD
 KOfvHZruBorO4RRKyI9xBglKCLXutgk9Fpd8nh5yobJl+HNrysXTrCcGx w==;
IronPort-SDR: xGB7mZAytnZEeKXw6cHpYGoEnjSnRkqx+DHA5ih5eeRGQmMhTtJMgmMJOoTIdwKh7/WF627mAG
 M0hTuMVOmWmk97f5nEG5XFzyflTgoe1ew53NUjcJ7Ape9IKZB8tPuW97RVRfrjfI4IKAZF9ciV
 ADEdY0xPHUUY9+AmuBJI56mGDJWxcx0iVKneOj0druakKWldvip8MT6txuGK/IWq04klHHXJuN
 j30Pt5Gh6adLlqXVEpLwSKgPLxD+deJq5SBF9gnLRMKXYJGg1MX8rK71mXgNMtqvQHETIAX14r
 BDY=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226412043"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:18:18 +0800
IronPort-SDR: sbC0hzYTtLMk2gtPKiD6vcCsm+LVd1dW0wm6NArMpXAt/KXesuCJxO85sP3uAkjSr0P9xpWu8M
 F0gkmrYeOD1TeH/j1zL3a8wymMNHpvYeoy2YnlHBZXVMKp3PopQ7WTJ1VZlc7CJQGLWneyWTTS
 Jqc5J90ASGMQFhiOv6A82soEqWn+L3u0xjN9fo5eKXk5E0mrpHuTFGkemYl/S6YXDRuPAq74HQ
 bw70LGVH09Ut+iewoWb0fxan7RQ5Kt3OXrRtHZ6t/qTskaO8iAOUjKVOn5rnKg6hHCvvLL8xtq
 daPSKN6RKbQ+1pK7T/q+MBDb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:12:26 -0800
IronPort-SDR: PNvQLqM1PWSRLkhXMV1HGSFPCYC3oO4UtiHLvfA3cTVpgEBbY/ytHFR+sy2/UykeqNIXBdyqpz
 kADx6ODh2eHuMpz81tGy4xeOjERIHhjRBo7oUjAfTFiolbrgRS/PsVY83fxYA4kZiZEuX9JeLj
 I8IOhXXKvLv3l047gdLtkwMQmQWLMBIIEoWTuXk+FLDzb/mnDVMURD+eTfXN+78EDIQBDKQhYX
 DVKrCubv4VINWYPrgJro7ygv4axTaU580hVsu7S6yskFmzSE2Z4d6Jr/1rAcc2I2qrhsWwFw+h
 G8Q=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:17:48 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 33/36] target/riscv: Set htval and mtval2 on execptions
Date: Mon,  9 Dec 2019 10:12:06 -0800
Message-Id: <3d0d12048c2cf4c5c5ec888b9ff602620285fa5b.1575914822.git.alistair.francis@wdc.com>
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
 target/riscv/cpu_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 43c6629014..aa033b8590 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -841,6 +841,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
     target_ulong deleg = async ? env->mideleg : env->medeleg;
     target_ulong tval = 0;
+    target_ulong htval = 0;
+    target_ulong mtval2 = 0;
 
     if (!async) {
         /* set tval to badaddr for traps with address information */
@@ -900,6 +902,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
 
+                htval = env->guest_phys_fault_addr;
+
                 riscv_cpu_set_virt_enabled(env, 0);
                 riscv_cpu_set_force_hs_excep(env, 0);
             } else {
@@ -910,6 +914,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                                          get_field(*env->mstatus, SSTATUS_SPP));
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
+
+                htval = env->guest_phys_fault_addr;
             }
         }
 
@@ -922,6 +928,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
         env->sepc = env->pc;
         env->sbadaddr = tval;
+        env->htval = htval;
         env->pc = (env->stvec >> 2 << 2) +
             ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_S);
@@ -936,6 +943,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             *env->mstatus = set_field(*env->mstatus, MSTATUS_MTL,
                                       riscv_cpu_force_hs_excep_enabled(env));
 
+            mtval2 = env->guest_phys_fault_addr;
+
             /* Trapping to M mode, virt is disabled */
             riscv_cpu_set_virt_enabled(env, 0);
         }
@@ -949,6 +958,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mcause = cause | ~(((target_ulong)-1) >> async);
         env->mepc = env->pc;
         env->mbadaddr = tval;
+        env->mtval2 = mtval2;
         env->pc = (env->mtvec >> 2 << 2) +
             ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_M);
-- 
2.24.0


