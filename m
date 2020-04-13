Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25216C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D407F20735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4mPHI1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D407F20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtXO-0006zU-1j
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtWE-00057d-Cj
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtWD-0001Pz-3c
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:28:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:32805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtWC-0001Po-UC
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:28:33 -0400
Received: by mail-pf1-x441.google.com with SMTP id c138so4174960pfc.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=S3hrCRfxrjHE0eXCcEPzbUk7x0CckK6gtsl1aNOJN6A=;
 b=L4mPHI1YNO11GHCIk/q49dUVSuiSd1ntFPAWEiFZ8cQK/c9UA/VR6BrT3X8EF614+S
 hbA+ZetQzHcW6kqmCNZL+vWe2swQePf50Hq5L6zOfGEEe7QzgXNIiePHBk3aXaIHq51/
 oGuiCZcQsDRdGN6Eno2le70i1U0kdY2JEZrx1zRvC0jupB0K1ZBCETo0Nibe5EeY/tRR
 xn24u92AsQLXWVqDM8h7WMtKWT4mFjANIyAEZzAFXSEVesHAAFHOcdr+Fxe6p/NrAxhD
 tWTAxSS0CkL9Hoc2rs8GmfXg8wno7IVU7f8TORZeexi/UVovbH8yFNrj1FL6Flv9ZG/1
 Vduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=S3hrCRfxrjHE0eXCcEPzbUk7x0CckK6gtsl1aNOJN6A=;
 b=f0dEWOIiburG09pMrCU4tYt0TP/ENeCvlxww0v26FGi+HT7HRi/0UgIxD8YpjSedLP
 vZOudK0W45N6hG0oUMvqC00Vfy3fBrsnvr8T9TwMtHAYUtyQnNFMb5w4vQmBdMLn1Ntx
 s3PPBRvdeBcxVVwI2h0gk7RKSmAuNGXpq8EcvZrublFwTQmh6zXJGILRPVfBtrZf307T
 0xgx8wrnn73TA5Wl8cUMaN7RhJRi0hpfb4TGuLTONu+76jHfaDvCDKx347gJxO+fGq8Q
 6Yt78pYM6hh3wwTjqKnwA2yjxtJacvTqlzBu5FmZgBgs6iNSM5kIfrWNIL//Hv7VV5QY
 +01Q==
X-Gm-Message-State: AGi0PuZyVAfEsHJGjUEslUqcvCAJAoFF5Dte11/QyuLAMtapvsF6w0sZ
 6fZbVPgU3WKoUaNuHyLoJnwIFx+s7kk=
X-Google-Smtp-Source: APiQypLSUUUMvMBfYp4+yShQ1DEsf6XH5JRKGMUPdRFbylQv6kvnJmdBqMrN0RxDJqyxYpMzd4B2uw==
X-Received: by 2002:a62:5e86:: with SMTP id
 s128mr17390854pfb.157.1586762911480; 
 Mon, 13 Apr 2020 00:28:31 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.28.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:28:31 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 12/15] KVM: MIPS: Add CPUCFG emulation for Loongson-3
Date: Mon, 13 Apr 2020 15:30:21 +0800
Message-Id: <1586763024-12197-13-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
 Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson-3 overrides lwc2 instructions to implement CPUCFG and CSR
read/write functions. These instructions all cause guest exit so CSR
doesn't benifit KVM guest (and there are always legacy methods to
provide the same functions as CSR). So, we only emulate CPUCFG and let
it return 0 (which means the virtual CPU doesn't have any advanced
features, including CSR) in KVM.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/kvm_host.h  |  3 +++
 arch/mips/include/uapi/asm/inst.h | 11 +++++++++
 arch/mips/kvm/mips.c              |  3 +++
 arch/mips/kvm/vz.c                | 50 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 4022712..c291767 100644
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
index 20acd50..2d9ce8d 100644
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
index db9b0f5..0772565 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -29,6 +29,7 @@
 #include <linux/kvm_host.h>
 
 #include "interrupt.h"
+#include "loongson_regs.h"
 
 #include "trace.h"
 
@@ -1092,6 +1093,50 @@ static enum emulation_result kvm_vz_gpsi_cache(union mips_instruction inst,
 	return EMULATE_FAIL;
 }
 
+#ifdef CONFIG_CPU_LOONGSON64
+static enum emulation_result kvm_vz_gpsi_lwc2(union mips_instruction inst,
+					      u32 *opc, u32 cause,
+					      struct kvm_run *run,
+					      struct kvm_vcpu *vcpu)
+{
+	unsigned int rs, rd;
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
+		case 0x8:  /* Read CPUCFG */
+			++vcpu->stat.vz_cpucfg_exits;
+			vcpu->arch.gprs[rd] = 0; /* Don't export any advanced features to guest */
+			break;
+		default:
+			kvm_err("lwc2 emulate not impl %d rs %lx @%lx\n",
+					inst.loongson3_lscsr_format.fr, vcpu->arch.gprs[rs], curr_pc);
+			er = EMULATE_FAIL;
+			break;
+	}
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
@@ -1121,6 +1166,11 @@ static enum emulation_result kvm_trap_vz_handle_gpsi(u32 cause, u32 *opc,
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


