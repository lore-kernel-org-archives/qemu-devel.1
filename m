Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B82C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFFCC207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HVwtaO6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFCC207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGK82-0002ae-LE
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2C-0004oz-Id
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2B-0004ym-3A
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:00 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60137 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2A-0004vd-LH; Fri, 04 Oct 2019 05:37:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YD5wFQz9sQn; Fri,  4 Oct 2019 19:37:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181872;
 bh=9sNrV3fIK79qRSsFHVhpf0yb3OOfexGJVF5ay8gwKVs=;
 h=From:To:Cc:Subject:Date:From;
 b=HVwtaO6AsAGq3wjKM6vh15uE9tlnBGC/ho3UVQ9aggoqqswJbrgRYR66RDpFVnAfk
 zLUc1ZjLa5JntR6Wr2eJ13upJc35RSYAd475TzyjyZQ1TvODEliDQdC7jqPSe20LDV
 8t4Wn05AzG7fMc2VGlUPuS2A54lDqmXRfLZoVRwo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/53] ppc-for-4.2 queue 20191004
Date: Fri,  4 Oct 2019 19:36:54 +1000
Message-Id: <20191004093747.31350-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4f59102571fce49af180cfc6d4cdd2b5df7bdb=
14:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-oct-01-=
2019' into staging (2019-10-01 16:21:42 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191004

for you to fetch changes up to 1aba8716c8335e88b8c358002a6e1ac89f7dd258:

  ppc/pnv: Remove the XICSFabric Interface from the POWER9 machine (2019-=
10-04 19:08:23 +1000)

----------------------------------------------------------------
ppc patch queue 2019-10-04

Here's the next batch of ppc and spapr patches.  Includes:
  * Fist part of a large cleanup to irq infrastructure
  * Recreate the full FDT at CAS time, instead of making a difficult
    to follow set of updates.  This will help us move towards
    eliminating CAS reboots altogether
  * No longer provide RTAS blob to SLOF - SLOF can include it just as
    well itself, since guests will generally need to relocate it with
    a call to instantiate-rtas
  * A number of DFP fixes and cleanups from Mark Cave-Ayland
  * Assorted bugfixes
  * Several new small devices for powernv

----------------------------------------------------------------
Alexey Kardashevskiy (8):
      ppc/kvm: Skip writing DPDES back when in run time state
      spapr: Fixes a leak in CAS
      spapr: Skip leading zeroes from memory@ DT node names
      spapr: Do not put empty properties for -kernel/-initrd/-append
      spapr: Stop providing RTAS blob
      pseries: Update SLOF firmware image
      spapr-pci: Stop providing assigned-addresses
      spapr: Render full FDT on ibm,client-architecture-support

Balamuruhan S (4):
      hw/ppc/pnv: fix checkpatch.pl coding style warnings
      hw/ppc/pnv_xscom: retrieve homer/occ base address from PBA BARs
      hw/ppc/pnv_occ: add sram device model for occ common area
      hw/ppc/pnv_homer: add PowerNV homer device model

C=C3=A9dric Le Goater (5):
      ppc/pnv: fix "bmc" node name in DT
      spapr/irq: Introduce an ics_irq_free() helper
      spapr/irq: Only claim VALID interrupts at the KVM level
      spapr/xive: skip partially initialized vCPUs in presenter
      ppc/pnv: Remove the XICSFabric Interface from the POWER9 machine

David Gibson (22):
      spapr: Simplify handling of pre ISA 3.0 guest workaround handling
      spapr: Move handling of special NVLink numa node from reset to init
      xics: Minor fixes for XICSFabric interface
      xics: Eliminate 'reject', 'resend' and 'eoi' class hooks
      xics: Rename misleading ics_simple_*() functions
      xics: Eliminate reset hook
      xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes
      xics: Create sPAPR specific ICS subtype
      spapr: Fold spapr_phb_lsi_qirq() into its single caller
      spapr: Replace spapr_vio_qirq() helper with spapr_vio_irq_pulse() h=
elper
      spapr: Clarify and fix handling of nr_irqs
      spapr: Eliminate nr_irqs parameter to SpaprIrq::init
      spapr: Fix indexing of XICS irqs
      spapr: Simplify spapr_qirq() handling
      spapr: Eliminate SpaprIrq:get_nodename method
      spapr: Remove unhelpful tracepoints from spapr_irq_free_xics()
      spapr: Handle freeing of multiple irqs in frontend only
      spapr, xics, xive: Better use of assert()s on irq claim/free paths
      xive: Improve irq claim/free path
      spapr: Use less cryptic representation of which irq backends are su=
pported
      spapr: Add return value to spapr_irq_check()
      spapr: Eliminate SpaprIrq::init hook

Greg Kurz (2):
      spapr-tpm-proxy: Drop misleading check
      spapr: Report kvm_irqchip_in_kernel() in 'info pic'

Laurent Vivier (1):
      pseries: do not allow memory-less/cpu-less NUMA node

Mark Cave-Ayland (8):
      target/ppc: introduce get_dfp{64,128}() helper functions
      target/ppc: introduce set_dfp{64,128}() helper functions
      target/ppc: update {get,set}_dfp{64,128}() helper functions to read=
/write DFP numbers correctly
      target/ppc: introduce dfp_finalize_decimal{64,128}() helper functio=
ns
      target/ppc: change struct PPC_DFP decimal storage from uint64[2] to=
 ppc_vsr_t
      target/ppc: use existing VsrD() macro to eliminate HI_IDX and LO_ID=
X from dfp_helper.c
      target/ppc: remove unnecessary if() around calls to set_dfp{64,128}=
() in DFP macros
      target/ppc: use Vsr macros in BCD helpers

Paul A. Clarke (3):
      ppc: Add support for 'mffscrn','mffscrni' instructions
      ppc: Add support for 'mffsce' instruction
      ppc: Use FPSCR defines instead of constants

 MAINTAINERS                        |   2 -
 Makefile                           |   2 +-
 configure                          |   6 +-
 hw/char/spapr_vty.c                |   3 +-
 hw/intc/spapr_xive.c               |  26 +--
 hw/intc/spapr_xive_kvm.c           |  48 ++++-
 hw/intc/trace-events               |  10 +-
 hw/intc/xics.c                     | 210 +++++++-------------
 hw/intc/xics_kvm.c                 |   8 +
 hw/intc/xics_spapr.c               |  48 ++++-
 hw/intc/xive.c                     |   8 +
 hw/net/spapr_llan.c                |   3 +-
 hw/ppc/Makefile.objs               |   1 +
 hw/ppc/pnv.c                       | 118 +++++++----
 hw/ppc/pnv_bmc.c                   |   5 +-
 hw/ppc/pnv_homer.c                 | 272 +++++++++++++++++++++++++
 hw/ppc/pnv_occ.c                   |  78 ++++++++
 hw/ppc/pnv_psi.c                   |   6 +-
 hw/ppc/pnv_xscom.c                 |  34 +++-
 hw/ppc/spapr.c                     | 219 ++++++++-------------
 hw/ppc/spapr_hcall.c               |   9 +-
 hw/ppc/spapr_irq.c                 | 345 +++++++++++++------------------=
-
 hw/ppc/spapr_pci.c                 |  45 +----
 hw/ppc/spapr_rtas.c                |  41 ----
 hw/ppc/spapr_tpm_proxy.c           |   2 +-
 hw/ppc/spapr_vio.c                 |   3 +-
 hw/ppc/trace-events                |   4 -
 include/hw/pci-host/spapr.h        |   7 -
 include/hw/ppc/pnv.h               |  21 ++
 include/hw/ppc/pnv_homer.h         |  53 +++++
 include/hw/ppc/pnv_occ.h           |   3 +
 include/hw/ppc/spapr.h             |   4 +-
 include/hw/ppc/spapr_irq.h         |  27 +--
 include/hw/ppc/spapr_vio.h         |   5 +-
 include/hw/ppc/spapr_xive.h        |   4 +-
 include/hw/ppc/xics.h              |  38 ++--
 include/hw/ppc/xics_spapr.h        |   4 +-
 include/hw/ppc/xive.h              |   2 +-
 pc-bios/README                     |   2 +-
 pc-bios/slof.bin                   | Bin 930656 -> 930640 bytes
 pc-bios/spapr-rtas.bin             | Bin 20 -> 0 bytes
 pc-bios/spapr-rtas/Makefile        |  27 ---
 pc-bios/spapr-rtas/spapr-rtas.S    |  37 ----
 roms/SLOF                          |   2 +-
 target/ppc/cpu.h                   |  10 +-
 target/ppc/dfp_helper.c            | 394 ++++++++++++++++++-------------=
------
 target/ppc/fpu_helper.c            | 122 ++++++------
 target/ppc/helper.h                |   2 +-
 target/ppc/int_helper.c            |  72 +++----
 target/ppc/internal.h              |   3 +
 target/ppc/kvm.c                   |   5 +
 target/ppc/translate/fp-impl.inc.c |  99 +++++++++-
 target/ppc/translate/fp-ops.inc.c  |   6 +
 target/ppc/translate_init.inc.c    |   9 +-
 54 files changed, 1421 insertions(+), 1093 deletions(-)
 create mode 100644 hw/ppc/pnv_homer.c
 create mode 100644 include/hw/ppc/pnv_homer.h
 delete mode 100644 pc-bios/spapr-rtas.bin
 delete mode 100644 pc-bios/spapr-rtas/Makefile
 delete mode 100644 pc-bios/spapr-rtas/spapr-rtas.S

