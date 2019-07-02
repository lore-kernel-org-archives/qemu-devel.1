Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB02C4646D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA7C216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="p69OSGXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA7C216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiC1J-0006x8-7p
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58151)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByc-0004iO-1X
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBya-0002nH-Ms
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33565 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByZ-0002kM-3m; Tue, 02 Jul 2019 02:09:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMg01HXz9sNC; Tue,  2 Jul 2019 16:09:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047743;
 bh=17YWz0VF40I2cpM7Z/AopweYIc+/WQg7xtpICYkqwG4=;
 h=From:To:Cc:Subject:Date:From;
 b=p69OSGXp8f36ndmHrJ5LB1679CSqUc0N9hOof5enIno7jgG7paNtAenXSe9pTfYML
 ei32D6KpBdojm4cRq0KK47QltxcinRiOK06uJzG+OB8NeIygYZBUHW0knQ19M7/7UM
 q8wamHSjDk0oQIxwNlciPwa8H9B6tPgz0bPSda8c=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:08 +1000
Message-Id: <20190702060857.3926-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 00/49] ppc-for-4.1 queue 20190702
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7=
c6:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull=
-request' into staging (2019-07-01 17:40:32 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190702

for you to fetch changes up to 1c3d4a8f4b4f24baa9dae31db0599925abc7d2a2:

  spapr/xive: Add proper rollback to kvmppc_xive_connect() (2019-07-02 10=
:11:44 +1000)

----------------------------------------------------------------
ppc patch queue 2019-07-2

Here's my next pull request for qemu-4.1.  I'm not sure if this will
squeak in just before the soft freeze, or just after.  I don't think
it really matters - most of this is bugfixes anyway.  There's some
cleanups which aren't stictly bugfixes, but which I think are safe
enough improvements to go in the soft freeze.  There's no true feature
work.

Unfortunately, I wasn't able to complete a few of my standard battery
of pre-pull tests, due to some failures that appear to also be in
master.  I'm hoping that hasn't missed anything important in here.

Highlights are:
  * A number of fixe and cleanups for the XIVE implementation
  * Cleanups to the XICS interrupt controller to fit better with the new
    XIVE code
  * Numerous fixes and improvements to TCG handling of ppc vector
    instructions
  * Remove a number of unnnecessary #ifdef CONFIG_KVM guards
  * Fix some errors in the PCI hotplug paths
  * Assorted other fixes

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      spapr/rtas: Force big endian compile for rtas

C=C3=A9dric Le Goater (11):
      docs: updates on the POWER9 XIVE interrupt controller documentation
      ppc/pnv: fix StoreEOI activation
      ppc/pnv: fix XSCOM MMIO base address for P9 machines with multiple =
chips
      ppc/pnv: remove xscom_base field from PnvChip
      target/ppc: fix compile error in kvmppc_define_rtas_kernel_token()
      spapr/xive: rework the mapping the KVM memory regions
      spapr/xive: simplify spapr_irq_init_device() to remove the emulated=
 init
      ppc/xive: Force the Physical CAM line value to group mode
      ppc/xive: Make the PIPR register readonly
      ppc/pnv: Rework cache watch model of PnvXIVE
      ppc/xive: Fix TM_PULL_POOL_CTX special operation

Greg Kurz (21):
      xics/spapr: Prevent RTAS/hypercalls emulation to be used by in-kern=
el XICS
      xics/spapr: Register RTAS/hypercalls once at machine init
      xics/spapr: Detect old KVM XICS on POWER9 hosts
      xics: Add comment about CPU hotplug
      spapr_pci: Fix DRC owner in spapr_dt_pci_bus()
      xics/spapr: Only emulated XICS should use RTAS/hypercalls emulation
      spapr_pci: Drop useless CONFIG_KVM ifdefery
      hw/ppc/mac_oldworld: Drop useless CONFIG_KVM ifdefery
      hw/ppc/mac_newworld: Drop useless CONFIG_KVM ifdefery
      hw/ppc/prep: Drop useless CONFIG_KVM ifdefery
      hw/ppc: Drop useless CONFIG_KVM ifdefery
      xics/spapr: Drop unused function declaration
      xics/spapr: Rename xics_kvm_init()
      xics/kvm: Skip rollback when KVM XICS is absent
      xics/kvm: Always use local_err in xics_kvm_init()
      xics/kvm: Add error propagation to ic*_set_kvm_state() functions
      xics/kvm: Add proper rollback to xics_kvm_init()
      ppc: Introduce kvmppc_set_reg_tb_offset() helper
      target/ppc/machine: Add kvmppc_pvr_workaround_required() stub
      spapr_pci: Unregister listeners before destroying the IOMMU address=
 space
      spapr/xive: Add proper rollback to kvmppc_xive_connect()

Mark Cave-Ayland (15):
      target/ppc: remove getVSR()/putVSR() from fpu_helper.c
      target/ppc: remove getVSR()/putVSR() from mem_helper.c
      target/ppc: remove getVSR()/putVSR() from int_helper.c
      target/ppc: introduce separate VSX_CMP macro for xvcmp* instruction=
s
      target/ppc: introduce GEN_VSX_HELPER_X3 macro to fpu_helper.c
      target/ppc: introduce separate generator and helper for xscvqpdp
      target/ppc: introduce GEN_VSX_HELPER_X2 macro to fpu_helper.c
      target/ppc: introduce GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
      target/ppc: introduce GEN_VSX_HELPER_X1 macro to fpu_helper.c
      target/ppc: introduce GEN_VSX_HELPER_R3 macro to fpu_helper.c
      target/ppc: introduce GEN_VSX_HELPER_R2 macro to fpu_helper.c
      target/ppc: introduce GEN_VSX_HELPER_R2_AB macro to fpu_helper.c
      target/ppc: decode target register in VSX_VECTOR_LOAD_STORE_LENGTH =
at translation time
      target/ppc: decode target register in VSX_EXTRACT_INSERT at transla=
tion time
      target/ppc: improve VSX_FMADD with new GEN_VSX_HELPER_VSX_MADD macr=
o

Philippe Mathieu-Daud=C3=A9 (1):
      spapr_pci: Fix potential NULL pointer dereference in spapr_dt_pci_b=
us()

 docs/specs/ppc-spapr-xive.rst       | 112 ++++-
 docs/specs/ppc-xive.rst             |   9 +-
 hw/intc/pnv_xive.c                  | 145 +++++--
 hw/intc/spapr_xive.c                |  38 +-
 hw/intc/spapr_xive_kvm.c            |  55 ++-
 hw/intc/xics.c                      |  40 +-
 hw/intc/xics_kvm.c                  | 117 +++--
 hw/intc/xics_spapr.c                |  55 ++-
 hw/intc/xive.c                      |  72 ++-
 hw/ppc/mac_newworld.c               |   4 -
 hw/ppc/mac_oldworld.c               |   2 -
 hw/ppc/pnv.c                        |  34 +-
 hw/ppc/pnv_xscom.c                  |  17 +-
 hw/ppc/ppc.c                        |   7 +-
 hw/ppc/prep.c                       |   2 -
 hw/ppc/spapr_irq.c                  |  39 +-
 hw/ppc/spapr_pci.c                  |  28 +-
 include/exec/memory.h               |  10 +
 include/hw/ppc/pnv.h                |   8 +-
 include/hw/ppc/pnv_xscom.h          |   2 +-
 include/hw/ppc/spapr.h              |   4 -
 include/hw/ppc/spapr_irq.h          |   1 -
 include/hw/ppc/spapr_xive.h         |   2 +-
 include/hw/ppc/xics.h               |   7 +-
 include/hw/ppc/xics_spapr.h         |   3 +-
 include/hw/ppc/xive.h               |   1 +
 memory.c                            |   7 +
 pc-bios/spapr-rtas/Makefile         |   5 +-
 target/ppc/fpu_helper.c             | 841 ++++++++++++++++--------------=
------
 target/ppc/helper.h                 | 320 +++++++-------
 target/ppc/int_helper.c             |  26 +-
 target/ppc/internal.h               |  12 -
 target/ppc/kvm.c                    |  11 +-
 target/ppc/kvm_ppc.h                |  10 +
 target/ppc/machine.c                |   2 -
 target/ppc/mem_helper.c             |  25 +-
 target/ppc/translate/vsx-impl.inc.c | 567 ++++++++++++++++--------
 target/ppc/translate/vsx-ops.inc.c  |  70 +--
 38 files changed, 1516 insertions(+), 1194 deletions(-)

