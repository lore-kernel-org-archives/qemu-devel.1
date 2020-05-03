Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538EC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A169620721
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbio7Q7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A169620721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVBjS-0004CU-QA
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBfd-0000th-P2
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:16:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jVBfd-0006d8-2p
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:16:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id t7so5612168plr.0
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HudJgUttq/EyxeqvRwzUzJD5SKyuTwPsUUoI6cg1zZc=;
 b=vbio7Q7J3YCQHxexqOleieZ/AttVYNhKO0Vw5zNli40i66QgMMlSkEKFg4S6cH0TZX
 9b9A9cmYi4imlMPkE690r1SZKbtblh4Z+19P0S6zEn2Lsa6WzN9XinwS/in528B6lz4V
 wCD5Um/dhvKlxxhx4klB8UcT1aft/KL6rLJp0ZHN9xrR6uVdvUG0lOsFitrdw2zl3Hr+
 kXYNerQzki3xNkK8ArHfGhRTOOtdR29zRP8bzTkqilt6TNndhkFyGfebmAsnBxgH83Um
 2VPEOe66kAWJ2jsuuSNTpxegPrZAkQGCKy3VW90mn8Z7ByhPQ7rL6mMCK9RON1F73EdU
 bqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=HudJgUttq/EyxeqvRwzUzJD5SKyuTwPsUUoI6cg1zZc=;
 b=FP5w/aenZfkATTR+jq5g6lJJXdHBV+O7QmGNrk6Di1lDTx7hfXcG99G1ASmzXFeXBl
 4fYsv9K41SIhionmALKLRCfgk9Jbqe78Z0mfvOiZz7y8RdiY+/UWJNReGd20+dUmAVOD
 /bzTEpgaeej1TTZEo8Cp1j68+vXN24RacsamEGBPC2AsOM5J7fBclIq7HCNHFsnQrD2H
 RV5iaKefpI0OJ8lLMqnspy5q+Y5x0APy6VFmusiWGu+FvBfTt3RRweGGzDdMf+sBRfGj
 XkNN/oGf8rLEGZ34IjlEAPlGIN5Mr0wHwkL5zYFbHtCtXCi01uD6FMTm8SKW7go6z1bI
 n0Vw==
X-Gm-Message-State: AGi0PuaXuN7WybglnNey2oOCd9xoz81rkUy73BisCHNs77oAx7LLk/or
 IgTRUJg7rMgJDFc6IQR2pLQ=
X-Google-Smtp-Source: APiQypIwJj+rd0+MQLSUwqg1TywA+fgdVJ2UWDufcbcYGOv2W2qRazHjEwE2Vigfg/sa1Ck2Jb8X4w==
X-Received: by 2002:a17:90a:e2d0:: with SMTP id
 fr16mr10748013pjb.146.1588500983883; 
 Sun, 03 May 2020 03:16:23 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id r26sm6329902pfq.75.2020.05.03.03.16.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 03:16:23 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH V3 14/14] KVM: MIPS: Enable KVM support for Loongson-3
Date: Sun,  3 May 2020 18:06:07 +0800
Message-Id: <1588500367-1056-15-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=chenhuacai@gmail.com; helo=mail-pl1-x644.google.com
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

This patch enable KVM support for Loongson-3 by selecting HAVE_KVM, but
only enable KVM/VZ on Loongson-3A R4+ (because VZ of early processors
are incomplete). Besides, Loongson-3 support SMP guests, so we clear the
linked load bit of LLAddr in kvm_vz_vcpu_load() if the guest has more
than one VCPUs.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig            | 1 +
 arch/mips/kernel/cpu-probe.c | 1 +
 arch/mips/kvm/vz.c           | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9f15539..9c4bdac 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1470,6 +1470,7 @@ config CPU_LOONGSON64
 	select MIPS_L1_CACHE_SHIFT_6
 	select GPIOLIB
 	select SWIOTLB
+	select HAVE_KVM
 	help
 		The Loongson GSx64(GS264/GS464/GS464E/GS464V) series of processor
 		cores implements the MIPS64R2 instruction set with many extensions,
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index be1b556..4432442 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -2008,6 +2008,7 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		c->ases |= (MIPS_ASE_LOONGSON_MMI | MIPS_ASE_LOONGSON_CAM |
 			MIPS_ASE_LOONGSON_EXT | MIPS_ASE_LOONGSON_EXT2);
+		c->ases &= ~MIPS_ASE_VZ; /* VZ of Loongson-3A2000/3000 is incomplete */
 		break;
 	case PRID_IMP_LOONGSON_64G:
 		c->cputype = CPU_LOONGSON64;
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index fc0f8d5..5f877a9 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -2695,7 +2695,7 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	 * prevents a SC on the next VCPU from succeeding by matching a LL on
 	 * the previous VCPU.
 	 */
-	if (cpu_guest_has_rw_llb)
+	if (vcpu->kvm->created_vcpus > 1)
 		write_gc0_lladdr(0);
 
 	return 0;
-- 
2.7.0


