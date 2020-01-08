Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE47C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B7820705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oM4lv23l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B7820705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3qB-0005lL-BH
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oX-0003qL-CK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oW-0002cp-5R
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:29 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41909 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oV-0002U9-Df; Wed, 08 Jan 2020 00:23:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syM91pfpz9sRf; Wed,  8 Jan 2020 16:23:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460997;
 bh=l5TIZL3q5ljlmyIuqiMBunGlBC0vIzfHVpVJCPcFbL4=;
 h=From:To:Cc:Subject:Date:From;
 b=oM4lv23l7OCSgCqGwoo2GBFyNRsJlIRbjxkHEcFldx5gBtVKuKMYVk2k3lfbOOTrk
 pH/0rgF+aKgUmcRyXQbnljKei+XJRo8nVvRit+kdgw8K3MUylWLDui9+kOAjgUzEop
 61Rk/2hkh8UD8Bv85Uo0SSEMtHBZXPdct5pbb0UA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/26] ppc-for-5.0 queue 20200108
Date: Wed,  8 Jan 2020 16:22:46 +1100
Message-Id: <20200108052312.238710-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e=
7f:

  Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-req=
uest' into staging (2020-01-07 17:08:21 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200108

for you to fetch changes up to fc2527fb024abf92719952c939d751739455bd6b:

  ppc/pnv: fix check on return value of blk_getlength() (2020-01-08 12:01=
:14 +1100)

----------------------------------------------------------------
ppc patch queue 2020-01-08

Here's another pull request for qemu-5.0 of ppc related changes.
Highlights are:
 * First parts of support for POWER Secure VMs
 * Rework to clean up how we pass context information to the various
   components of the pnv machine (reduces usage of qdev_get_machine())
 * Assorted cleanups and bugfixes

----------------------------------------------------------------
Bharata B Rao (3):
      linux-headers: Update
      ppc/spapr: Support reboot of secure pseries guest
      ppc/spapr: Don't call KVM_SVM_OFF ioctl on TCG

C=C3=A9dric Le Goater (7):
      ppc/pnv: Modify the powerdown notifier to get the PowerNV machine
      spapr/xive: remove redundant check in spapr_match_nvt()
      ppc/pnv: Introduce a "xics" property alias under the PSI model
      ppc/pnv: Introduce a "xics" property under the POWER8 chip
      xive: Add a "presenter" link property to the TCTX object
      ppc/pnv: check return value of blk_pwrite()
      ppc/pnv: fix check on return value of blk_getlength()

Daniel Henrique Barboza (2):
      spapr.c: remove 'out' label in spapr_dt_cas_updates()
      ppc440_bamboo.c: remove label from bamboo_load_device_tree()

Fabiano Rosas (2):
      target/ppc: Remove unused PPC_INPUT_INT defines
      target/ppc: Handle AIL=3D0 in ppc_excp_vector_offset

Greg Kurz (11):
      spapr/xive: Use device_class_set_parent_realize()
      ppc/pnv: Drop "num-chips" machine property
      pnv/xive: Use device_class_set_parent_realize()
      spapr, pnv, xive: Add a "xive-fabric" link to the XIVE router
      xive: Use the XIVE fabric link under the XIVE router
      ppc/pnv: Add an "nr-threads" property to the base chip class
      ppc/pnv: Add a "pnor" const link property to the BMC internal simul=
ator
      spapr/xive: Deduce the SpaprXive pointer from XiveTCTX::xptr
      pnv/xive: Deduce the PnvXive pointer from XiveTCTX::xptr
      pnv/psi: Add device reset hook
      pnv/psi: Consolidate some duplicated code in pnv_psi_realize()

Laurent Vivier (1):
      mos6522: remove anh register

 hw/intc/pnv_xive.c                                 |  18 ++-
 hw/intc/spapr_xive.c                               |  14 ++-
 hw/intc/spapr_xive_kvm.c                           |   9 +-
 hw/intc/xive.c                                     |  28 ++++-
 hw/misc/mos6522.c                                  |  16 +--
 hw/ppc/pnv.c                                       | 123 ++++++++-------=
------
 hw/ppc/pnv_bmc.c                                   |   8 +-
 hw/ppc/pnv_pnor.c                                  |  10 +-
 hw/ppc/pnv_psi.c                                   |  41 ++++---
 hw/ppc/ppc440_bamboo.c                             |   8 +-
 hw/ppc/spapr.c                                     |  18 ++-
 hw/ppc/spapr_irq.c                                 |   2 +
 include/hw/misc/mos6522.h                          |   1 -
 include/hw/ppc/pnv.h                               |   7 +-
 include/hw/ppc/pnv_pnor.h                          |   2 +-
 include/hw/ppc/pnv_xive.h                          |  10 ++
 include/hw/ppc/spapr_xive.h                        |  10 ++
 include/hw/ppc/xive.h                              |  13 ++-
 include/standard-headers/asm-x86/bootparam.h       |   7 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h      |  15 ++-
 include/standard-headers/drm/drm_fourcc.h          |  28 ++++-
 include/standard-headers/linux/input-event-codes.h |  77 +++++++++++++
 include/standard-headers/linux/pci_regs.h          |   3 +
 include/standard-headers/rdma/vmw_pvrdma-abi.h     |   5 +
 linux-headers/linux/kvm.h                          |   1 +
 target/ppc/excp_helper.c                           |   2 +
 target/ppc/kvm.c                                   |  24 +++-
 target/ppc/kvm_ppc.h                               |   6 +
 28 files changed, 345 insertions(+), 161 deletions(-)

