Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29448C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49C620721
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TahyT0RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49C620721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVBfu-0000c9-1R
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBec-0007HB-Ji
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:15:22 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBeb-0004uh-Ot
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:15:22 -0400
Received: by mail-pf1-x443.google.com with SMTP id x15so4071217pfa.1
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=irVmhvtEPr1kCt/3TMdgPsfS/t5ii77gdB+p7HRY6Cw=;
 b=TahyT0RJZ9eooeUVSavNED0naTITC852lMmSIMuXaULkAnV1Z2vFhqOvKRIftcYbwX
 q/W5mYIwu8VK4kyNhFd1i86ydce0kYCKKDR5uM6kwRITzVketp7yxcAiK6vYpI0Sxm/3
 HubRharQvgHDyEnHwTehUVf5xrKMDoItngANVD0hJkiqNK7r6oS2op0PvzMioZzpiEAQ
 AFGXxSex+JvKhL1AdnwPneKVPmcWVSBzkqTbgGX4GZhdS09JQ13kjjYHnqPjaO3Ado9X
 D1fUC36EM7A6yniZKMGHRXhHljYhfaXxXFFHjrrwcmYyM/p56s0ZaSg/RKiLay1D6pyS
 z+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=irVmhvtEPr1kCt/3TMdgPsfS/t5ii77gdB+p7HRY6Cw=;
 b=WmdBubnRfdFu1LTUuyTpBd/Atq2XuqO3Ic6fhOEGrb/8yCi7+f6RsARkugfo8vG8SF
 uN2ajG4oAdoziXtbKkdytvUCphh2O8fKPIZluXXUVZ9ooIyFWE4QrqGg+cVFNqq1Z/5e
 Wu6ky8aS/4ePEKW7ZbeES7XKHhJ2xWU27QEdK5PBEt0Un6dr6W6Voi873WFdU9gsDNHt
 TFnGWovxxBxml9rMXBQaacF6mr0HYn21b3HkyJbPBFfonpEWgrWaCv6uU+CAxnEy8det
 rrIQ2ePbds9ZMXjfx1iWHYc97rPEpwEJ9HYi0Byk6unrWSUHHQIBwmJNfZQ2pfYpDg5D
 h1Yg==
X-Gm-Message-State: AGi0PuaIyTWMXwMSHqcSJVpMojN26jKg+NqUoDRa/P4ESX6nv1VSL45B
 E5d6Bhy4k0mpe+GCZBf6/1g=
X-Google-Smtp-Source: APiQypJS5n7Ty/4gS/PPY7UiwzoovPQDWcs5RMjKbJr67aHDFHzbfGgOP7rc5mYvwKg7F3M2fwzXiA==
X-Received: by 2002:aa7:9d90:: with SMTP id f16mr12993751pfq.48.1588500919442; 
 Sun, 03 May 2020 03:15:19 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id r26sm6329902pfq.75.2020.05.03.03.15.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 03:15:18 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH V3 11/14] KVM: MIPS: Add CPUCFG emulation for Loongson-3
Date: Sun,  3 May 2020 18:06:04 +0800
Message-Id: <1588500367-1056-12-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=chenhuacai@gmail.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kvm@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson-3 overrides lwc2 instructions to implement CPUCFG and CSR
read/write functions. These instructions all cause guest exit so CSR
doesn't benifit KVM guest (and there are always legacy methods to
provide the same functions as CSR). So, we only emulate CPUCFG and let
it return a reduced feature list (which means the virtual CPU doesn't
have any other advanced features, including CSR) in KVM.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/kvm_host.h  |  3 ++
 arch/mips/include/uapi/asm/inst.h | 11 ++++++
 arch/mips/kvm/mips.c              |  3 ++
 arch/mips/kvm/vz.c                | 75 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f165902..3fd2f1c 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -173,6 +173,9 @@ struct kvm_vcpu_stat {
 	u64 vz_ghfc_exits;
 	u64 vz_gpa_exits;
 	u64 vz_resvd_exits;
+#ifdef CONFIG_CPU_LOONGSON64
+	u64 vz_cpucfg_exits;
+#endif
 #endif
 	u64 halt_successful_poll;
 	u64 halt_attempted_poll;
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 98f97c8..43d1faa 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -1012,6 +1012,16 @@ struct loongson3_lsdc2_format {	/* Loongson-3 overridden ldc2/sdc2 Load/Store fo
 	;))))))
 };
 
+struct loongson3_lscsr_format {	/* Loongson-3 CPUCFG&CSR read/write format */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int rs : 5,
+	__BITFIELD_FIELD(unsigned int fr : 5,
+	__BITFIELD_FIELD(unsigned int rd : 5,
+	__BITFIELD_FIELD(unsigned int fd : 5,
+	__BITFIELD_FIELD(unsigned int func : 6,
+	;))))))
+};
+
 /*
  * MIPS16e instruction formats (16-bit length)
  */
@@ -1114,6 +1124,7 @@ union mips_instruction {
 	struct mm16_r5_format mm16_r5_format;
 	struct loongson3_lswc2_format loongson3_lswc2_format;
 	struct loongson3_lsdc2_format loongson3_lsdc2_format;
+	struct loongson3_lscsr_format loongson3_lscsr_format;
 };
 
 union mips16e_instruction {
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index ed989ef..9362769 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -68,6 +68,9 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "vz_ghfc",	  VCPU_STAT(vz_ghfc_exits),	 KVM_STAT_VCPU },
 	{ "vz_gpa",	  VCPU_STAT(vz_gpa_exits),	 KVM_STAT_VCPU },
 	{ "vz_resvd",	  VCPU_STAT(vz_resvd_exits),	 KVM_STAT_VCPU },
+#ifdef CONFIG_CPU_LOONGSON64
+	{ "vz_cpucfg",	  VCPU_STAT(vz_cpucfg_exits),	 KVM_STAT_VCPU },
+#endif
 #endif
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll), KVM_STAT_VCPU },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), KVM_STAT_VCPU },
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 63d5b35..e5c751b 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -29,6 +29,7 @@
 #include <linux/kvm_host.h>
 
 #include "interrupt.h"
+#include "loongson_regs.h"
 
 #include "trace.h"
 
@@ -1092,6 +1093,75 @@ static enum emulation_result kvm_vz_gpsi_cache(union mips_instruction inst,
 	return EMULATE_FAIL;
 }
 
+#ifdef CONFIG_CPU_LOONGSON64
+static enum emulation_result kvm_vz_gpsi_lwc2(union mips_instruction inst,
+					      u32 *opc, u32 cause,
+					      struct kvm_run *run,
+					      struct kvm_vcpu *vcpu)
+{
+	unsigned int rs, rd;
+	unsigned int hostcfg;
+	unsigned long curr_pc;
+	enum emulation_result er = EMULATE_DONE;
+
+	/*
+	 * Update PC and hold onto current PC in case there is
+	 * an error and we want to rollback the PC
+	 */
+	curr_pc = vcpu->arch.pc;
+	er = update_pc(vcpu, cause);
+	if (er == EMULATE_FAIL)
+		return er;
+
+	rs = inst.loongson3_lscsr_format.rs;
+	rd = inst.loongson3_lscsr_format.rd;
+	switch (inst.loongson3_lscsr_format.fr) {
+	case 0x8:  /* Read CPUCFG */
+		++vcpu->stat.vz_cpucfg_exits;
+		hostcfg = read_cpucfg(vcpu->arch.gprs[rs]);
+
+		switch (vcpu->arch.gprs[rs]) {
+		case LOONGSON_CFG1:
+			hostcfg &= (LOONGSON_CFG1_FP | LOONGSON_CFG1_MMI |
+				    LOONGSON_CFG1_MSA1 | LOONGSON_CFG1_MSA2 |
+				    LOONGSON_CFG1_SFBP);
+			vcpu->arch.gprs[rd] = hostcfg;
+			break;
+		case LOONGSON_CFG2:
+			hostcfg &= (LOONGSON_CFG2_LEXT1 | LOONGSON_CFG2_LEXT2 |
+				    LOONGSON_CFG2_LEXT3 | LOONGSON_CFG2_LSPW);
+			vcpu->arch.gprs[rd] = hostcfg;
+			break;
+		case LOONGSON_CFG3:
+			hostcfg &= LOONGSON_CFG3_LCAMP;
+			vcpu->arch.gprs[rd] = hostcfg;
+			break;
+		default:
+			/* Don't export any other advanced features to guest */
+			vcpu->arch.gprs[rd] = 0;
+			break;
+		}
+
+		break;
+	default:
+		kvm_err("lwc2 emulate not impl %d rs %lx @%lx\n",
+			inst.loongson3_lscsr_format.fr, vcpu->arch.gprs[rs], curr_pc);
+		er = EMULATE_FAIL;
+		break;
+	}
+
+	/* Rollback PC only if emulation was unsuccessful */
+	if (er == EMULATE_FAIL) {
+		kvm_err("[%#lx]%s: unsupported lwc2 instruction 0x%08x 0x%08x\n",
+			curr_pc, __func__, inst.word, inst.loongson3_lscsr_format.fr);
+
+		vcpu->arch.pc = curr_pc;
+	}
+
+	return er;
+}
+#endif
+
 static enum emulation_result kvm_trap_vz_handle_gpsi(u32 cause, u32 *opc,
 						     struct kvm_vcpu *vcpu)
 {
@@ -1121,6 +1191,11 @@ static enum emulation_result kvm_trap_vz_handle_gpsi(u32 cause, u32 *opc,
 		er = kvm_vz_gpsi_cache(inst, opc, cause, run, vcpu);
 		break;
 #endif
+#ifdef CONFIG_CPU_LOONGSON64
+	case lwc2_op:
+		er = kvm_vz_gpsi_lwc2(inst, opc, cause, run, vcpu);
+		break;
+#endif
 	case spec3_op:
 		switch (inst.spec3_format.func) {
 #ifdef CONFIG_CPU_MIPSR6
-- 
2.7.0


