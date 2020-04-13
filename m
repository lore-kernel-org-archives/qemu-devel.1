Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DDFC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFD920735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kcx4puo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFD920735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtZm-0001JT-ME
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtYX-00009J-64
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtYW-00025a-6J
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:30:57 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtYW-00025L-0b
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:30:56 -0400
Received: by mail-pl1-x641.google.com with SMTP id n24so382786plp.13
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lozGXI+RCcD8805GHzdbsHHUQvLgBz8cDlD+L+c1heU=;
 b=Kcx4puo8ho90L2YsbhjK/H50hA2RCXsBXZpnLgbU09+jqnjb9lQ2nhCLP8GhBwv3wR
 jNAUTY9hMqoT01OY7BLsavXjZhZTs9T6sGoxGW9eYd+3ixQ1QQa74P0ahHpcb44jEMD7
 2EklggW0EczbXKxs6hGTbgQldVb0hVGNu6hFrHUqcbFeZnFRC+ntZns9C1d6z/+2OS7o
 ezf0EIsvj4MiI+zzzRz7b5W7UG6qzqOoxtXCMoWbF0MtofE+YTyFKGKxVPC2vrjjKXuS
 H4IVbXRYGQ+phiyisGvWSHm0TGMpyWqmi5uMk2PZKKMlA5Kftg4Jl3/jTzVdtJerVF4/
 RqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=lozGXI+RCcD8805GHzdbsHHUQvLgBz8cDlD+L+c1heU=;
 b=hF/byuOWUEAz3e16k+bvp28DiNMRKDrT5hWbG6DueUXAxZYRCFJj8WwJixcbdTIgHM
 6FhtaHTg77/F6RcYFm3QJs29dsXXzym3dq69nKR+zypTd3b3kXhSDGXiNzRjeJ2vr7cm
 A+q+ziLapqlMH3ZPshD5I0g4ruBNG9/7BFUreTEg2uZ+5A8WU+WWd6ROdmvwfLfWtfSB
 xXcKs8J9C1hV46jQ5j7DWOVuimtLq7JAVKA0TTn6ihG5YE1qOYK2yc5poI9pvZxatX6L
 Ox56uUdZT8ec17mEf4X0+ZUyosIPg/yXrL/gwBdyy8E6GSUc0CZqBEv1B6aUil48Hw8C
 E4Tw==
X-Gm-Message-State: AGi0PuZTrdX7xdx8MAXyfUVogEL+sSD+QNPT67rs1XvBqGObspnM+yLt
 fvXBWlJFGIn93iHk9QWQ2Fc=
X-Google-Smtp-Source: APiQypJvTPl29jy0Un/24PxwFVkWS2cBvgRYlBkmJPaXAfhrOMi4sadbxXTfHq9f1iE3cmoC12OCQg==
X-Received: by 2002:a17:902:9b90:: with SMTP id
 y16mr15589789plp.227.1586763054390; 
 Mon, 13 Apr 2020 00:30:54 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.30.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:30:54 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 15/15] KVM: MIPS: Enable KVM support for Loongson-3
Date: Mon, 13 Apr 2020 15:30:24 +0800
Message-Id: <1586763024-12197-16-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
index a1f973c..e9a1389 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1465,6 +1465,7 @@ config CPU_LOONGSON64
 	select MIPS_L1_CACHE_SHIFT_6
 	select GPIOLIB
 	select SWIOTLB
+	select HAVE_KVM
 	help
 		The Loongson GSx64(GS264/GS464/GS464E/GS464V) series of processor
 		cores implements the MIPS64R2 instruction set with many extensions,
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5bf0821..c46724e 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1958,6 +1958,7 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		c->ases |= (MIPS_ASE_LOONGSON_MMI | MIPS_ASE_LOONGSON_CAM |
 			MIPS_ASE_LOONGSON_EXT | MIPS_ASE_LOONGSON_EXT2);
+		c->ases &= ~MIPS_ASE_VZ; /* VZ of Loongson-3A2000/3000 is incomplete */
 		break;
 	case PRID_IMP_LOONGSON_64G:
 		c->cputype = CPU_LOONGSON64;
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 2ea1f13..cddd5b0 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -2666,7 +2666,7 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	 * prevents a SC on the next VCPU from succeeding by matching a LL on
 	 * the previous VCPU.
 	 */
-	if (cpu_guest_has_rw_llb)
+	if (vcpu->kvm->created_vcpus > 1)
 		write_gc0_lladdr(0);
 
 	return 0;
-- 
2.7.0


