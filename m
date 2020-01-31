Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F0C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C396206A2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eJkFjsVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C396206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixPXZ-0003Ud-Jn
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 01:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ixPUo-0006ah-Jm
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ixPUn-0000Ir-3z
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:09:38 -0500
Received: from ozlabs.org ([203.11.71.1]:51119)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ixPUm-0008Ur-7a; Fri, 31 Jan 2020 01:09:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4886Hr4D96z9sRQ; Fri, 31 Jan 2020 17:09:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580450968;
 bh=VO1FEGeWVuxfOOHdHwYKoxVEtGUBVlmBxF7MTVVEorg=;
 h=From:To:Cc:Subject:Date:From;
 b=eJkFjsVwUlg+IRS7XigEgBaUk2ZoRsBoSKvmXE9zQIJjaofSnWhFOFhL8UaHaWCfE
 qqM09aLxifTzVHFIGpyLxBjv5cBEZrl8a62ltbZ0JeS0ycifqSO4guWTHmiAcm5azW
 LuOWZjdGThO2yp0ZuGqNWJY+dbu7gs/giyby+5RY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/34] ppc-for-5.0 queue 20200131
Date: Fri, 31 Jan 2020 17:08:50 +1100
Message-Id: <20200131060924.147449-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
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
Cc: lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1f5=
7d:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00130' into staging (2020-01-30 16:19:04 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200131

for you to fetch changes up to 532fe321cf06d39d864de3642b4e1b18cc83c4de:

  target/ppc: Use probe_write for DCBZ (2020-01-31 14:54:16 +1100)

----------------------------------------------------------------
ppc patch queue 2020-01-31

Here's the next batch of patches for ppc and associated machine types.
Highlights includes:
 * Remove the deprecated "prep" machine type and its OpenHackware
   firmware
 * Add TCG emulation of the msgsndp etc. supervisor privileged
   doorbell instructions
 * Allow "pnv" machine type to run Hostboot style firmwares
 * Add a virtual TPM device for spapr machines
 * Implement devices for POWER8 PHB3 and POWER9 PHB4 host bridges for
   the pnv machine type
 * Use faster Spectre mitigation by default for POWER9 DD2.3 machines
 * Introduce Firmware Assisted NMI dump facility for spapr machines
 * Fix a performance regression with load/store multiple instructions
   in TCG

as well as some other assorted cleanups and fixes.

----------------------------------------------------------------
Aravinda Prasad (7):
      Wrapper function to wait on condition for the main loop mutex
      ppc: spapr: Introduce FWNMI capability
      target/ppc: Handle NMI guest exit
      target/ppc: Build rtas error log upon an MCE
      ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS =
calls
      migration: Include migration support for machine check handling
      ppc: spapr: Activate the FWNMI functionality

BALATON Zoltan (1):
      target/ppc/cpu.h: Put macro parameter in parentheses

Benjamin Herrenschmidt (1):
      ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge

C=C3=A9dric Le Goater (9):
      ppc/pnv: use QEMU unit definition MiB
      ppc/pnv: improve error logging when a PNOR update fails
      target/ppc: Add privileged message send facilities
      target/ppc: add support for Hypervisor Facility Unavailable Excepti=
on
      ppc/pnv: Add support for HRMOR on Radix host
      ppc/pnv: remove useless "core-pir" property alias.
      ppc/pnv: Add support for "hostboot" mode
      ppc/pnv: Add models for POWER8 PHB3 PCIe Host bridge
      ppc/pnv: change the PowerNV machine devices to be non user creatabl=
e

David Gibson (1):
      spapr: Enable DD2.3 accelerated count cache flush in pseries-5.0 ma=
chine

Fabiano Rosas (1):
      target/ppc: Clarify the meaning of return values in kvm_handle_debu=
g

Greg Kurz (2):
      spapr: Fail CAS if option vector table cannot be parsed
      spapr: Don't allow multiple active vCPUs at CAS

Igor Mammedov (1):
      ppc:virtex_ml507: remove unused arguments

Marc-Andr=C3=A9 Lureau (1):
      docs/specs/tpm: reST-ify TPM documentation

Richard Henderson (4):
      target/ppc: Use probe_access for LSW, STSW
      target/ppc: Use probe_access for LMW, STMW
      target/ppc: Remove redundant mask in DCBZ
      target/ppc: Use probe_write for DCBZ

Stefan Berger (5):
      tpm: Move tpm_tis_show_buffer to tpm_util.c
      spapr: Implement get_dt_compatible() callback
      tpm_spapr: Support TPM for ppc64 using CRQ based interface
      tpm_spapr: Support suspend and resume
      hw/ppc/Kconfig: Enable TPM_SPAPR as part of PSERIES config

Thomas Huth (1):
      hw/ppc/prep: Remove the deprecated "prep" machine and the OpenHackw=
are BIOS

 .gitmodules                         |    3 -
 MAINTAINERS                         |    1 -
 Makefile                            |    2 +-
 cpus.c                              |    5 +
 docs/interop/firmware.json          |    3 +-
 docs/specs/index.rst                |    1 +
 docs/specs/tpm.rst                  |  503 ++++++++++++
 docs/specs/tpm.txt                  |  427 -----------
 hw/intc/xics.c                      |   14 +-
 hw/pci-host/Makefile.objs           |    2 +
 hw/pci-host/pnv_phb3.c              | 1197 +++++++++++++++++++++++++++++
 hw/pci-host/pnv_phb3_msi.c          |  349 +++++++++
 hw/pci-host/pnv_phb3_pbcq.c         |  358 +++++++++
 hw/pci-host/pnv_phb4.c              | 1439 +++++++++++++++++++++++++++++=
++++++
 hw/pci-host/pnv_phb4_pec.c          |  595 +++++++++++++++
 hw/ppc/Kconfig                      |    2 +
 hw/ppc/pnv.c                        |  204 ++++-
 hw/ppc/pnv_core.c                   |   33 +-
 hw/ppc/pnv_homer.c                  |    1 +
 hw/ppc/pnv_lpc.c                    |    6 +-
 hw/ppc/pnv_occ.c                    |    1 +
 hw/ppc/pnv_pnor.c                   |    6 +-
 hw/ppc/ppc.c                        |   18 -
 hw/ppc/prep.c                       |  384 +---------
 hw/ppc/spapr.c                      |   63 +-
 hw/ppc/spapr_caps.c                 |   49 +-
 hw/ppc/spapr_events.c               |  269 +++++++
 hw/ppc/spapr_hcall.c                |   20 +
 hw/ppc/spapr_rtas.c                 |   87 +++
 hw/ppc/spapr_vio.c                  |   11 +-
 hw/ppc/virtex_ml507.c               |    7 +-
 hw/tpm/Kconfig                      |    6 +
 hw/tpm/Makefile.objs                |    1 +
 hw/tpm/tpm_spapr.c                  |  429 +++++++++++
 hw/tpm/tpm_tis.c                    |   32 +-
 hw/tpm/tpm_util.c                   |   25 +
 hw/tpm/tpm_util.h                   |    3 +
 hw/tpm/trace-events                 |   16 +-
 include/hw/pci-host/pnv_phb3.h      |  164 ++++
 include/hw/pci-host/pnv_phb3_regs.h |  450 +++++++++++
 include/hw/pci-host/pnv_phb4.h      |  230 ++++++
 include/hw/pci-host/pnv_phb4_regs.h |  553 ++++++++++++++
 include/hw/pci/pcie_port.h          |    1 +
 include/hw/ppc/pnv.h                |   13 +
 include/hw/ppc/pnv_core.h           |    1 +
 include/hw/ppc/pnv_xscom.h          |   20 +
 include/hw/ppc/ppc.h                |    1 -
 include/hw/ppc/spapr.h              |   25 +-
 include/hw/ppc/spapr_vio.h          |    1 +
 include/hw/ppc/xics.h               |    5 +
 include/qemu/main-loop.h            |    8 +
 include/sysemu/tpm.h                |    3 +
 pc-bios/README                      |    3 -
 pc-bios/ppc_rom.bin                 |  Bin 1048576 -> 0 bytes
 qapi/tpm.json                       |    6 +-
 qemu-deprecated.texi                |    6 -
 qemu-doc.texi                       |   15 +-
 roms/openhackware                   |    1 -
 target/ppc/cpu.h                    |    8 +-
 target/ppc/excp_helper.c            |   79 +-
 target/ppc/helper.h                 |    4 +
 target/ppc/kvm.c                    |   43 +-
 target/ppc/kvm_ppc.h                |    8 +
 target/ppc/mem_helper.c             |  197 ++++-
 target/ppc/misc_helper.c            |   63 ++
 target/ppc/mmu-radix64.c            |    6 +
 target/ppc/trace-events             |    1 +
 target/ppc/translate.c              |   26 +
 target/ppc/translate_init.inc.c     |   20 +-
 tests/qtest/boot-order-test.c       |   25 -
 tests/qtest/cdrom-test.c            |    2 +-
 tests/qtest/endianness-test.c       |    2 +-
 72 files changed, 7549 insertions(+), 1013 deletions(-)
 create mode 100644 docs/specs/tpm.rst
 delete mode 100644 docs/specs/tpm.txt
 create mode 100644 hw/pci-host/pnv_phb3.c
 create mode 100644 hw/pci-host/pnv_phb3_msi.c
 create mode 100644 hw/pci-host/pnv_phb3_pbcq.c
 create mode 100644 hw/pci-host/pnv_phb4.c
 create mode 100644 hw/pci-host/pnv_phb4_pec.c
 create mode 100644 hw/tpm/tpm_spapr.c
 create mode 100644 include/hw/pci-host/pnv_phb3.h
 create mode 100644 include/hw/pci-host/pnv_phb3_regs.h
 create mode 100644 include/hw/pci-host/pnv_phb4.h
 create mode 100644 include/hw/pci-host/pnv_phb4_regs.h
 delete mode 100644 pc-bios/ppc_rom.bin
 delete mode 160000 roms/openhackware

