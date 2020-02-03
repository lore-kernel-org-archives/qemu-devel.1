Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971BFC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214662080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Yg5ajBTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214662080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyUzn-0006TB-3h
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxL-0002Kn-6d
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxI-0002TD-F2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:35 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51035 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxH-0002Nt-LA; Mon, 03 Feb 2020 01:11:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBl5S55z9sRh; Mon,  3 Feb 2020 17:11:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710287;
 bh=6azcQBuOKskA6ccJ4NGfaKl0AO+DNig5GfNFWZb77g0=;
 h=From:To:Cc:Subject:Date:From;
 b=Yg5ajBTpUgsVeUFpZh9PIBAMri7J7cvBePPoF0Gan1ndHIs+0lfr3mLOXTQuRw067
 JoTbKX3rSaAJweJRBCC4VxNej6K6MaqZhvnE7FmsiOeesiHMX9nIBuvFgGXT8oqePL
 +sGW+VrbmyGEvX6JMK7m9CBvBPjyld6iJr4bVmys=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/35] ppc-for-5.0 queue 20200203
Date: Mon,  3 Feb 2020 17:10:48 +1100
Message-Id: <20200203061123.59150-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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

The following changes since commit 28db64fce555a03b4ca256d5b6f4290abdfbd9=
e8:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2020-01-31 17:37:00 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200203

for you to fetch changes up to 63d57c8f91d0d0e62fc4d91db6340a662b36a3c0:

  tests: Silence various warnings with pseries (2020-02-03 11:33:11 +1100=
)

----------------------------------------------------------------
ppc patch queue 2020-02093

This pull request supersedes ppc-for-5.0-20200131.  The only changes
are one extra patch to suppress some irritating warnings during tests
under TCG, and an extra Tested-by in one of the other patches.

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

Greg Kurz (3):
      spapr: Fail CAS if option vector table cannot be parsed
      spapr: Don't allow multiple active vCPUs at CAS
      tests: Silence various warnings with pseries

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
 tests/qtest/boot-serial-test.c      |    3 +-
 tests/qtest/cdrom-test.c            |    2 +-
 tests/qtest/endianness-test.c       |    2 +-
 tests/qtest/libqos/libqos-spapr.h   |    8 +
 tests/qtest/prom-env-test.c         |    3 +-
 tests/qtest/pxe-test.c              |    7 +-
 76 files changed, 7565 insertions(+), 1018 deletions(-)
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

