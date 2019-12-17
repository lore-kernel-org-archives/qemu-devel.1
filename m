Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14C4C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3FE206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D12S99Is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3FE206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4mv-0005m6-56
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hq-0007uf-Rk
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hp-0005BL-6m
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:34 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37911 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ho-00059H-Kv; Mon, 16 Dec 2019 23:43:33 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWM41bzz9sRh; Tue, 17 Dec 2019 15:43:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557807;
 bh=EGjlyELKPxsFZoIVp8oxMOFfr57BGiA5hdDUq4uX5gw=;
 h=From:To:Cc:Subject:Date:From;
 b=D12S99IsbkgI4WvfEw2grFYzBsnO6+fTOqr3LDIwMWQLzNPVrvIctP0NpwgnktIga
 QEy0sXg52SxjqR9zMtxKjOb0WPjtc17NCkPbKVYWdsFGRazgMH/+MJw79Sza0xISWn
 c8EkPsarQ5iGKxOalCPN/8amaztRM0iHCEjP1b0Q=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/88] ppc-for-5.0 queue 20191217
Date: Tue, 17 Dec 2019 15:41:54 +1100
Message-Id: <20191217044322.351838-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit cb88904a54903ef6ba21a68a61d9cd51e21663=
04:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-dec-16-=
2019' into staging (2019-12-16 14:07:56 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20191217

for you to fetch changes up to a363e9ed8731f45674260932a340a0d81c4b0a6f:

  pseries: Update SLOF firmware image (2019-12-17 11:40:23 +1100)

----------------------------------------------------------------
ppc patch queue 2019-12-17

This is the first pull request for the qemu-5.0 branch.  It has a lot
of accumulated changes, including:

    * SLOF update to support boot using the IOMMU (will become
      necessary for secure guests)

    * Clean ups to pnv handling of chip models

    * A number of extensions to the powernv machine model

    * TCG extensions to allow powernv emulated systems to run KVM guests

    * Outline support for POWER10 chips in powernv

    * Cleanups to the ibm,client-architecture-support feature negotiation=
 path

    * XIVE reworks to better handle the powernv machine

    * Improvements to not waste interrupt queues and other semi-scarce
      resources when using XIVE under KVM

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

C=C3=A9dric Le Goater (40):
      ppc/pnv: Add a PNOR model
      ppc/pnv: Add a "/qemu" device tree node
      ppc/pnv: Add a LPC "ranges" property
      ppc/xive: Record the IPB in the associated NVT
      ppc/xive: Introduce helpers for the NVT id
      ppc/pnv: Remove pnv_xive_vst_size() routine
      ppc/pnv: Quiesce some XIVE errors
      ppc/xive: Introduce OS CAM line helpers
      ppc/xive: Check V bit in TM_PULL_POOL_CTX
      ipmi: Add support to customize OEM functions
      ppc/pnv: Add HIOMAP commands
      ppc/pnv: Create BMC devices at machine init
      ppc/xive: Introduce a XivePresenter interface
      ppc/xive: Implement the XivePresenter interface
      ppc/pnv: Loop on the threads of the chip to find a matching NVT
      ppc: Introduce a ppc_cpu_pir() helper
      ppc/pnv: Introduce a pnv_xive_is_cpu_enabled() helper
      ppc/pnv: Fix TIMA indirect access
      ppc/xive: Introduce a XiveFabric interface
      ppc/pnv: Implement the XiveFabric interface
      ppc/spapr: Implement the XiveFabric interface
      ppc/xive: Use the XiveFabric and XivePresenter interfaces
      ppc/xive: Extend the TIMA operation with a XivePresenter parameter
      ppc/pnv: Clarify how the TIMA is accessed on a multichip system
      ppc/xive: Move the TIMA operations to the controller model
      ppc/xive: Remove the get_tctx() XiveRouter handler
      ppc/xive: Introduce a xive_tctx_ipb_update() helper
      ppc/xive: Synthesize interrupt from the saved IPB in the NVT
      ppc/pnv: Introduce a pnv_xive_block_id() helper
      ppc/pnv: Extend XiveRouter with a get_block_id() handler
      ppc/pnv: Dump the XIVE NVT table
      target/ppc: Add POWER10 DD1.0 model information
      ppc/pnv: Introduce a POWER10 PnvChip and a powernv10 machine
      ppc/psi: cleanup definitions
      ppc/pnv: add a PSI bridge model for POWER10
      ppc/pnv: add a LPC Controller model for POWER10
      ppc/pnv: Loop on the whole hierarchy to populate the DT with the XS=
COM nodes
      ppc/pnv: populate the DT with realized XSCOM devices
      ppc/pnv: Introduce PBA registers
      ppc/pnv: Fix OCC common area region mapping

David Gibson (4):
      spapr: Don't trigger a CAS reboot for XICS/XIVE mode changeover
      spapr: Improve handling of fdt buffer size
      spapr: Fold h_cas_compose_response() into h_client_architecture_sup=
port()
      spapr: Simplify ovec diff

Greg Kurz (38):
      ppc/pnv: Drop "chip" link from POWER9 PSI object
      xive: Link "cpu" property to XiveTCTX::cs pointer
      xive: Link "xive" property to XiveSource::xive pointer
      xive: Link "xive" property to XiveEndSource::xrtr pointer
      ppc/pnv: Link "psi" property to PnvLpc::psi pointer
      ppc/pnv: Link "psi" property to PnvOCC::psi pointer
      ppc/pnv: Link "chip" property to PnvHomer::chip pointer
      ppc/pnv: Link "chip" property to PnvCore::chip pointer
      ppc/pnv: Link "chip" property to PnvXive::chip pointer
      xics: Link ICS_PROP_XICS property to ICSState::xics pointer
      xics: Link ICP_PROP_XICS property to ICPState::xics pointer
      xics: Link ICP_PROP_CPU property to ICPState::cs pointer
      spapr: Abort if XICS interrupt controller cannot be initialized
      xive/kvm: Trigger interrupts from userspace
      ppc/pnv: Instantiate cores separately
      linux-headers: Update
      spapr: Pass the maximum number of vCPUs to the KVM interrupt contro=
ller
      spapr/xics: Configure number of servers in KVM
      spapr/xive: Configure number of servers in KVM
      ppc: Deassert the external interrupt pin in KVM on reset
      xics: Don't deassert outputs
      ppc: Don't use CPUPPCState::irq_input_state with modern Book3s CPU =
models
      ppc: Ignore the CPU_INTERRUPT_EXITTB interrupt with KVM
      ppc: Make PPCVirtualHypervisor an incomplete type
      ppc/pnv: Make PnvXScomInterface an incomplete type
      ppc: Drop useless extern annotation for functions
      ppc/pnv: Introduce PnvPsiClass::compat
      ppc/pnv: Drop PnvPsiClass::chip_type
      ppc/pnv: Introduce PnvMachineClass and PnvMachineClass::compat
      ppc/pnv: Introduce PnvMachineClass::dt_power_mgt()
      ppc/pnv: Drop pnv_is_power9() and pnv_is_power10() helpers
      ppc/pnv: Introduce PnvChipClass::intc_print_info() method
      ppc/pnv: Introduce PnvChipClass::xscom_core_base() method
      ppc/pnv: Pass XSCOM base address and address size to pnv_dt_xscom()
      ppc/pnv: Pass content of the "compatible" property to pnv_dt_xscom(=
)
      ppc/pnv: Drop pnv_chip_is_power9() and pnv_chip_is_power10() helper=
s
      ppc/pnv: Introduce PnvChipClass::xscom_pcba() method
      ppc/pnv: Drop PnvChipClass::type

Suraj Jitindar Singh (4):
      target/ppc: Implement the VTB for HV access
      target/ppc: Work [S]PURR implementation and add HV support
      target/ppc: Add SPR ASDR
      target/ppc: Add SPR TBU40

Vladimir Sementsov-Ogievskiy (1):
      ppc: well form kvmppc_hint_smt_possible error hint helper

 hw/intc/pnv_xive.c                           | 415 ++++++++++++++-------=
-
 hw/intc/spapr_xive.c                         | 102 +++++-
 hw/intc/spapr_xive_kvm.c                     |  42 ++-
 hw/intc/xics.c                               |  59 +---
 hw/intc/xics_kvm.c                           |  24 +-
 hw/intc/xics_spapr.c                         |   5 +-
 hw/intc/xive.c                               | 398 +++++++++++----------
 hw/ipmi/ipmi_bmc_sim.c                       |  50 +--
 hw/ppc/Makefile.objs                         |   4 +-
 hw/ppc/pnv.c                                 | 504 +++++++++++++++++++++=
+-----
 hw/ppc/pnv_bmc.c                             | 116 ++++++
 hw/ppc/pnv_core.c                            |  20 +-
 hw/ppc/pnv_homer.c                           | 129 ++++++-
 hw/ppc/pnv_lpc.c                             |  76 ++--
 hw/ppc/pnv_occ.c                             |  31 +-
 hw/ppc/pnv_pnor.c                            | 135 +++++++
 hw/ppc/pnv_psi.c                             |  54 ++-
 hw/ppc/pnv_xscom.c                           |  79 +----
 hw/ppc/ppc.c                                 |  79 +++--
 hw/ppc/spapr.c                               | 133 +++----
 hw/ppc/spapr_hcall.c                         |  90 +++--
 hw/ppc/spapr_irq.c                           |  30 +-
 hw/ppc/spapr_ovec.c                          |  30 +-
 include/hw/ipmi/ipmi.h                       |  42 +++
 include/hw/ppc/pnv.h                         | 109 ++++--
 include/hw/ppc/pnv_homer.h                   |   3 +
 include/hw/ppc/pnv_lpc.h                     |   6 +-
 include/hw/ppc/pnv_occ.h                     |   8 +-
 include/hw/ppc/pnv_pnor.h                    |  30 ++
 include/hw/ppc/pnv_psi.h                     |   5 +-
 include/hw/ppc/pnv_xive.h                    |   3 -
 include/hw/ppc/pnv_xscom.h                   |  58 ++-
 include/hw/ppc/ppc.h                         |   7 +-
 include/hw/ppc/spapr.h                       |   4 +-
 include/hw/ppc/spapr_irq.h                   |  10 +-
 include/hw/ppc/spapr_ovec.h                  |   4 +-
 include/hw/ppc/spapr_vio.h                   |   6 +-
 include/hw/ppc/spapr_xive.h                  |   3 +-
 include/hw/ppc/xics_spapr.h                  |   3 +-
 include/hw/ppc/xive.h                        |  72 +++-
 include/hw/ppc/xive_regs.h                   |  25 ++
 include/standard-headers/linux/ethtool.h     |   6 +
 include/standard-headers/linux/virtio_ring.h |   2 +-
 linux-headers/asm-arm/kvm.h                  |   3 +-
 linux-headers/asm-arm64/kvm.h                |   5 +-
 linux-headers/asm-mips/unistd_n32.h          |   1 +
 linux-headers/asm-mips/unistd_n64.h          |   1 +
 linux-headers/asm-mips/unistd_o32.h          |   1 +
 linux-headers/asm-powerpc/kvm.h              |   3 +
 linux-headers/linux/kvm.h                    |  11 +
 linux-headers/linux/psp-sev.h                |   3 +
 linux-user/ppc/cpu_loop.c                    |   5 +
 pc-bios/README                               |   2 +-
 pc-bios/slof.bin                             | Bin 931040 -> 931032 byte=
s
 roms/SLOF                                    |   2 +-
 target/ppc/compat.c                          |  21 +-
 target/ppc/cpu-models.c                      |   3 +
 target/ppc/cpu-models.h                      |   3 +
 target/ppc/cpu.h                             |  14 +-
 target/ppc/helper.h                          |   4 +
 target/ppc/helper_regs.h                     |   5 +
 target/ppc/kvm.c                             |   6 +-
 target/ppc/kvm_ppc.h                         |   4 +-
 target/ppc/timebase_helper.c                 |  20 ++
 target/ppc/translate_init.inc.c              | 283 ++++++++++++++-
 65 files changed, 2455 insertions(+), 956 deletions(-)
 create mode 100644 hw/ppc/pnv_pnor.c
 create mode 100644 include/hw/ppc/pnv_pnor.h

