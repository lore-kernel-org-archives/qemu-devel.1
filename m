Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CD9C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD262076A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6qWBGXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD262076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtQU-0002oC-07
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtPl-0002Br-Ov
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtPk-0005wX-AW
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:21:53 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtPk-0005w9-5Q
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:21:52 -0400
Received: by mail-pf1-x444.google.com with SMTP id r14so4137379pfl.12
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=t2sALsyCMMNQl+/8FmLCPuHasRrqoSojD5dypqshy1s=;
 b=k6qWBGXUMQGdG4L801yUD0CBa9KUZWJQCLwsgGPYl/I2VJjZ4q+nrmBR9MLWNt1Gjd
 1TiOACf0dKTBjQqemktNCtQ0HdOLjV0nbkeTWg7IDclXU8YvNE2UQazw14m6AGOUROyR
 RpXuV5GJz3e6PeImUS0fjZ5XTORTAzUqKUUAsvFY6JYby8LTKcdlASVGp91STYo1v8ct
 YLGaHQfy0JJx1n35AIKm3McnOH5Tyb2Q4r+qP+Vu5utdX2QOwPy1qOjZtqEVCIqkZUja
 Z8/b8qu/BwnvUeNTxUGrhOtbhZHcLPPKvPWgaaIFfLtZdxpQyA272eP4fSG4dK9cx04y
 DE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=t2sALsyCMMNQl+/8FmLCPuHasRrqoSojD5dypqshy1s=;
 b=EJrwlB63XKiF7LH201+COtRIsfy098S/9IttsOxZ+gb2bY1jcbEy0ckVVBciqyhJ2M
 jtLZH0ojBtvksEsrvF5OYtjsL3+HfqEiQur9lMzUNS3c0egjsGa/W3HASyVIBRRWfajv
 ZY3Xh26taf1een8SPSxE0PkOwK+1vLkOR+1V/OtfkPwy5lnpdzm4f4s47CY4MiRY7puF
 pdHknJr80vMLC4K/I0NUy7liPvgnQR530q9fPLZ5NOWwSXEubhmXj1vEZ/eYzmK2husl
 wNphj0kL+vOXJD/4oCWyJeR1947Ovp0SdH6yhH31kDjQuS70ESyiAjksmTV1g+Z5y1a/
 pfSw==
X-Gm-Message-State: AGi0PuaDUgw/SEZbFyk2GbkzI7V9n7xH9MoSq+fxS24/7P+PdVeYiz1w
 9IJG0aN6TDcpjfbKmPCCNzA=
X-Google-Smtp-Source: APiQypLOMSAvZAOVmdTh3/xVhGIylyDIoCT43TP1W6oweKMcx07p6DU4u4BAs3R3Egz33M4rokbdUQ==
X-Received: by 2002:a63:c20:: with SMTP id b32mr164314pgl.75.1586762510767;
 Mon, 13 Apr 2020 00:21:50 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.21.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:21:50 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 0/15] KVM: MIPS: Add Loongson-3 support (Host Side)
Date: Mon, 13 Apr 2020 15:30:09 +0800
Message-Id: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

We are preparing to add KVM support for Loongson-3. VZ extension is
fully supported in Loongson-3A R4+, and we will not care about old CPUs
(at least now). We already have a full functional Linux kernel (based
on Linux-5.4.x LTS) and QEMU (based on 5.0.0-rc2) and their git
repositories are here:

QEMU: https://github.com/chenhuacai/qemu
Kernel: https://github.com/chenhuacai/linux

Of course these two repositories need to be rework and not suitable for
upstream (especially the commits need to be splitted). We show them here
is just to tell others what we have done, and how KVM/Loongson will look
like.

Our plan is make the KVM host side be upstream first, and after that,
we will make the KVM guest side and QEMU emulator be upstream.

Mike Rapoport(1):
 mips: define pud_index() regardless of page table folding

Xing Li(2):
 KVM: MIPS: Define KVM_ENTRYHI_ASID to cpu_asid_mask(&boot_cpu_data)
 KVM: MIPS: Fix VPN2_MASK definition for variable cpu_vmbits

Huacai Chen(12):
 KVM: MIPS: Increase KVM_MAX_VCPUS and KVM_USER_MEM_SLOTS to 16
 KVM: MIPS: Add EVENTFD support which is needed by VHOST
 KVM: MIPS: Use lddir/ldpte instructions to lookup gpa_mm.pgd
 KVM: MIPS: Introduce and use cpu_guest_has_ldpte
 KVM: MIPS: Use root tlb to control guest's CCA for Loongson-3
 KVM: MIPS: Let indexed cacheops cause guest exit on Loongson-3
 KVM: MIPS: Add more types of virtual interrupts
 KVM: MIPS: Add Loongson-3 Virtual IPI interrupt support
 KVM: MIPS: Add CPUCFG emulation for Loongson-3
 KVM: MIPS: Add CONFIG6 and DIAG registers emulation
 KVM: MIPS: Add more MMIO load/store instructions emulation
 KVM: MIPS: Enable KVM support for Loongson-3

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig                    |   1 +
 arch/mips/include/asm/cpu-features.h |   3 +
 arch/mips/include/asm/kvm_host.h     |  50 +++-
 arch/mips/include/asm/mipsregs.h     |   7 +
 arch/mips/include/asm/pgtable-64.h   |   4 +-
 arch/mips/include/uapi/asm/inst.h    |  11 +
 arch/mips/kernel/cpu-probe.c         |   2 +
 arch/mips/kvm/Kconfig                |   1 +
 arch/mips/kvm/Makefile               |   5 +-
 arch/mips/kvm/emulate.c              | 461 ++++++++++++++++++++++++++++++++++-
 arch/mips/kvm/entry.c                |  19 +-
 arch/mips/kvm/interrupt.c            |  93 +------
 arch/mips/kvm/interrupt.h            |  14 +-
 arch/mips/kvm/loongson_ipi.c         | 215 ++++++++++++++++
 arch/mips/kvm/mips.c                 |  49 +++-
 arch/mips/kvm/tlb.c                  |  39 +++
 arch/mips/kvm/trap_emul.c            |   3 +
 arch/mips/kvm/vz.c                   | 204 +++++++++++-----
 18 files changed, 1013 insertions(+), 168 deletions(-)
 create mode 100644 arch/mips/kvm/loongson_ipi.c
--
2.7.0

