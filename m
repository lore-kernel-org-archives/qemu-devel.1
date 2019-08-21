Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00205C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3B623429
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f/NIIbJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3B623429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LAQ-0006Er-O2
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0H-0004Oo-3W
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0F-0007tG-JT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:25:57 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56535)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0E-0007qL-UK; Wed, 21 Aug 2019 03:25:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Czj83TS8z9sN4; Wed, 21 Aug 2019 17:25:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372348;
 bh=ayx3nzstSDjtZqU/970bwyPPJjJjjO8A8z3dit5XMbY=;
 h=From:To:Cc:Subject:Date:From;
 b=f/NIIbJWCL1pQDPzNx58VSbQIkZaTichWpwRGEP/KzfeBcLrMXTmjX8CrkNDEYlDE
 bTv5+xbxp3mZKp3vt2VDCrQhgxL7ocmrCXEQrwnUBUEjpgiajLYKDL3PoS5e6qIMgN
 LvqFyG1JT7IfJwJHHskJLOFhSfjocN47jKfdn1+4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:00 +1000
Message-Id: <20190821072542.23090-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 00/42] ppc-for-4.2 queue 20190821
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 17dc57990320edaad52ac9ea808be9719c91ce=
a6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-08-20' into staging (2019-08-20 14:14:20 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20190821

for you to fetch changes up to c0e6616b6685ffdb4c5e091bc152e46e14703dd1:

  ppc: Fix emulated single to double denormalized conversions (2019-08-21=
 17:17:39 +1000)

----------------------------------------------------------------
ppc patch queue for 2019-08-21

First ppc and spapr pull request for qemu-4.2.  Includes:
   * Some TCG emulation fixes and performance improvements
   * Support for the mffsl instruction in TCG
   * Added missing DPDES SPR
   * Some enhancements to the emulation of the XIVE interrupt
     controller
   * Cleanups to spapr MSI management
   * Some new suspend/resume infrastructure and a draft suspend
     implementation for spapr
   * New spapr hypercall for TPM communication (will be needed for
     secure guests under an Ultravisor)
   * Fix several memory leaks

And a few other assorted fixes.

----------------------------------------------------------------
Alex Benn=C3=A9e (1):
      target/ppc: move opcode decode tables to PowerPCCPU

Alexey Kardashevskiy (3):
      spapr_iommu: Fix xlate trace to print translated address
      pseries: Update SLOF firmware image
      target/ppc: Add Directed Privileged Door-bell Exception State (DPDE=
S) SPR

Cornelia Huck (1):
      hw: add compat machines for 4.2

C=C3=A9dric Le Goater (8):
      ppc/xive: use an abstract type for XiveNotifier
      ppc/xive: Implement TM_PULL_OS_CTX special command
      ppc/xive: Provide backlog support
      ppc/xive: Provide escalation support
      ppc/xive: Provide unconditional escalation support
      ppc/xive: Provide silent escalation support
      ppc/xive: Improve 'info pic' support
      spapr/xive: Mask the EAS when allocating an IRQ

Daniel Black (1):
      spapr: quantify error messages regarding capability settings

David Gibson (1):
      spapr_pci: Allow 2MiB and 16MiB IOMMU pagesizes by default

Greg Kurz (3):
      spapr/pci: Consolidate de-allocation of MSIs
      spapr/pci: Free MSIs during reset
      spapr/irq: Drop spapr_irq_msi_reset()

Maxiwell S. Garcia (1):
      migration: Do not re-read the clock on pre_save in case of paused g=
uest

Michael Roth (2):
      docs/specs: initial spec summary for Ultravisor-related hcalls
      spapr: initial implementation for H_TPM_COMM/spapr-tpm-proxy

Nicholas Piggin (7):
      spapr: Implement dispatch tracking for tcg
      spapr: Implement H_PROD
      spapr: Implement H_CONFER
      spapr: Implement H_JOIN
      machine: Add wakeup method to MachineClass
      i386: use machine class ->wakeup method
      spapr: Implement ibm,suspend-me

Paul A. Clarke (4):
      ppc: Add support for 'mffsl' instruction
      ppc: conform to processor User's Manual for xscvdpspn
      ppc: Fix emulated INFINITY and NAN conversions
      ppc: Fix emulated single to double denormalized conversions

Paul Mackerras (1):
      spapr: Implement better workaround in spapr-vty device

Shivaprasad G Bhat (4):
      ppc: fix memory leak in spapr_caps_add_properties
      ppc: fix memory leak in spapr_dt_drc()
      ppc: fix leak in h_client_architecture_support
      ppc: remove idle_timer logic

Stefan Brankovic (5):
      target/ppc: Optimize emulation of lvsl and lvsr instructions
      target/ppc: Optimize emulation of vsl and vsr instructions
      target/ppc: Optimize emulation of vgbbd instruction
      target/ppc: Optimize emulation of vclzd instruction
      target/ppc: Optimize emulation of vclzw instruction

 disas/ppc.c                         |   5 +
 docs/specs/ppc-spapr-uv-hcalls.txt  |  76 ++++++++
 hw/arm/virt.c                       |   9 +-
 hw/char/spapr_vty.c                 |  30 ++-
 hw/core/machine.c                   |   3 +
 hw/i386/pc.c                        |  11 ++
 hw/i386/pc_piix.c                   |  14 +-
 hw/i386/pc_q35.c                    |  13 +-
 hw/intc/pnv_xive.c                  |   9 +
 hw/intc/spapr_xive.c                |   6 +-
 hw/intc/xive.c                      | 206 ++++++++++++++++-----
 hw/ppc/Makefile.objs                |   1 +
 hw/ppc/ppc.c                        |  13 +-
 hw/ppc/spapr.c                      | 115 +++++++++++-
 hw/ppc/spapr_caps.c                 |  46 +++--
 hw/ppc/spapr_drc.c                  |   7 +-
 hw/ppc/spapr_hcall.c                | 167 ++++++++++++++++-
 hw/ppc/spapr_iommu.c                |   2 +-
 hw/ppc/spapr_irq.c                  |   7 +-
 hw/ppc/spapr_pci.c                  |  29 ++-
 hw/ppc/spapr_rtas.c                 |  32 ++++
 hw/ppc/spapr_tpm_proxy.c            | 178 ++++++++++++++++++
 hw/ppc/trace-events                 |   4 +
 hw/s390x/s390-virtio-ccw.c          |  14 +-
 include/hw/boards.h                 |   4 +
 include/hw/i386/pc.h                |   3 +
 include/hw/ppc/spapr.h              |  21 ++-
 include/hw/ppc/spapr_cpu_core.h     |   1 +
 include/hw/ppc/spapr_irq.h          |   1 -
 include/hw/ppc/spapr_tpm_proxy.h    |  31 ++++
 include/hw/ppc/xive.h               |  11 +-
 include/hw/ppc/xive_regs.h          |  10 +
 pc-bios/README                      |   2 +-
 pc-bios/slof.bin                    | Bin 926432 -> 926784 bytes
 roms/SLOF                           |   2 +-
 target/ppc/cpu-qom.h                |   1 +
 target/ppc/cpu.h                    |  28 ++-
 target/ppc/fpu_helper.c             |  42 +++--
 target/ppc/helper.h                 |   7 -
 target/ppc/int_helper.c             | 335 ------------------------------=
----
 target/ppc/kvm.c                    |  75 +-------
 target/ppc/translate.c              |   3 +-
 target/ppc/translate/fp-impl.inc.c  |  22 +++
 target/ppc/translate/fp-ops.inc.c   |   4 +-
 target/ppc/translate/vmx-impl.inc.c | 355 ++++++++++++++++++++++++++++++=
++----
 target/ppc/translate_init.inc.c     |  57 +++++-
 vl.c                                |  16 +-
 47 files changed, 1417 insertions(+), 611 deletions(-)
 create mode 100644 docs/specs/ppc-spapr-uv-hcalls.txt
 create mode 100644 hw/ppc/spapr_tpm_proxy.c
 create mode 100644 include/hw/ppc/spapr_tpm_proxy.h

