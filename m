Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730A6C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DCB206F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jAs79b4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DCB206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhR4-0000DC-Bs
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhIz-0005Bu-Ee
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhIy-00070x-8K
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:10:37 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhIx-00069K-VZ; Fri, 31 Jan 2020 20:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519436; x=1612055436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wLDyHGZ3TFNnbSS5Rlkobce5pf5JfGvgCXYxEnNxaNg=;
 b=jAs79b4ZHi2Gte3N9hIJ7ylo6Rxa8aA/I63foffeOG1nps2i5tsSm+oW
 hTSanIISpoH/VD1F8krS40PvZkF5mvgH5mt++B9lpLLsiJWT9eMFLuT30
 8VLWwXFLj274ehIGB64qO5+mRqPbEkmpiju0IBim7ENp7r/NvAn9q8Z7g
 r9prwQ/E+l46m2ljZ++6BC44zURqxGNtG3aWP/L31uzYaPQRvc63TGBZH
 qMda1QVQMsVBMDHXYD/88kG4SWbUn2ci7gyGibso4Qe+Ea8iYm5gd1JSa
 Sc7Ctdah3P8k27QbiA/gSxdcNpl69BG7MnEWmF0+NSKpdxc8/ki9BGKk2 A==;
IronPort-SDR: 5Y/xPeXYo1F/b6hEpA3SNaMAd9t9csQWSkAcDHu7P594WlqJ2rcNBId+NLdxj0084t4g9BA47e
 XzrqQ6+hi7eT86oYMhFKevOL8ud2MCuOvbQkT9AJa26RfW9cwNRmhzyeZnEwnE/DRAWFpnuku8
 8vTOVhYm2hWw9NApUC8Hyy5QeVW1gq6XL2VQp4hBlPUwjCDI/zEjL3jiuJmkWys2fTzUf+Vptt
 dVEHtDjw1rhTfv2aa5cKylv7varjCRERSJ4DbVMRPt7WYByidbaEGnPw3lrlQEdaK5GR1nJLng
 ngY=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872499"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:09:38 +0800
IronPort-SDR: Pt3D6p+GmjM75jQI4ai8l0Z4Gmymc7s1o3XP+OZ4HiBa3Ip7v7PN0MqcdMlEm4MODflYqzMkPu
 2SkZpOyxjS6eCy7EnCzBlPFcwSfm80o5qxG3yfS/FefCOcqHq/VmfcfnHoF0Rh4bTIPJYb5Zy0
 4f3oeo7gVuzSRaAKocKDev/dt/noZ72dXXUAOqB+K8UbkcDMhIN511hUPdfD+/rTnZPeqFhQoi
 JbxrmdjCVEAeSqAUJfr1kXSQHGkc+RKcFylTAcvR5uCW4aq0bV7CZcubaYKCX9GsTScBl9GNI7
 QzN1BWjZZEwW6N5xMNr3pHLc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:47 -0800
IronPort-SDR: imcKPQhyu3eFmCE8fuYvDaaG6ycdkrX3Iq3D7+zlnc+wn3F08PuP5vRpOLCXpA7gYNWvIs66iV
 q6R6QCEZiqcirDueV4sEyBN4ZlqO2Fwtzrc16ErT3KKcei9jvvQNBZp3AaVbVtiZs/3YD2UcBv
 IMhEMKKprRdnWSpgSS6tFIKwC3Dy0oUyZcP/T20RUoPYtOV1vCwiFA6n+Rdq3h0QhTAFbQ/RNR
 3qS25ZMyZclMc+2NnwywBJZyQi5PMsD+bPBx1xJJZH6VITYEARu9AF0CY6Zhka4uwQcEi5474d
 cXA=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:09:38 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 32/35] target/riscv: Set htval and mtval2 on execptions
Date: Fri, 31 Jan 2020 17:03:02 -0800
Message-Id: <6b6d0f06b64cc5d0a6ed6fe9357eb8c6d01c5d48.1580518859.git.alistair.francis@wdc.com>
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
 target/riscv/cpu_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index da994aba57..10786a077b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -838,6 +838,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
     target_ulong deleg = async ? env->mideleg : env->medeleg;
     target_ulong tval = 0;
+    target_ulong htval = 0;
+    target_ulong mtval2 = 0;
 
     if (!async) {
         /* set tval to badaddr for traps with address information */
@@ -899,6 +901,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
 
+                htval = env->guest_phys_fault_addr;
+
                 riscv_cpu_set_virt_enabled(env, 0);
                 riscv_cpu_set_force_hs_excep(env, 0);
             } else {
@@ -909,6 +913,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                                          get_field(env->mstatus, SSTATUS_SPP));
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
+
+                htval = env->guest_phys_fault_addr;
             }
         }
 
@@ -921,6 +927,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
         env->sepc = env->pc;
         env->sbadaddr = tval;
+        env->htval = htval;
         env->pc = (env->stvec >> 2 << 2) +
             ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_S);
@@ -935,6 +942,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             env->mstatus = set_field(env->mstatus, MSTATUS_MTL,
                                       riscv_cpu_force_hs_excep_enabled(env));
 
+            mtval2 = env->guest_phys_fault_addr;
+
             /* Trapping to M mode, virt is disabled */
             riscv_cpu_set_virt_enabled(env, 0);
             riscv_cpu_set_force_hs_excep(env, 0);
@@ -949,6 +958,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mcause = cause | ~(((target_ulong)-1) >> async);
         env->mepc = env->pc;
         env->mbadaddr = tval;
+        env->mtval2 = mtval2;
         env->pc = (env->mtvec >> 2 << 2) +
             ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_M);
-- 
2.25.0


