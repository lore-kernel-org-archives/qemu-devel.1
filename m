Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56635CA9EBD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C1D20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IlIgPLZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C1D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYMP-0007SC-02
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKQ-0004bu-Bv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKO-0004yO-Ty
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:42 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41657 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKN-0004rB-TN; Thu, 24 Oct 2019 04:18:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrX210Xz9sPp; Thu, 24 Oct 2019 19:18:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905116;
 bh=1dcj9qWyGSbcbWlw7ODIxYp/AEUQEevIp7s0MAn7vy8=;
 h=From:To:Cc:Subject:Date:From;
 b=IlIgPLZJWDwiAjphd9VhMT5r4rujtYU+mXtEtp6uw5VxoFdldP4Btv77ykoojUuZt
 UYqH+OpXXWIvp7c0cyJ2X41IpXkslBtednnr5svEqNeF7C1vKQbWmXd+I/zrvSoEmG
 WS/EvhhrpUCRgMMHW461q9+1Or8kUhEVGIubO9G8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/28] ppc-for-4.2 queue 20191024
Date: Thu, 24 Oct 2019 19:17:45 +1100
Message-Id: <20191024081813.2115-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f78398bfe544db81a974825b0a2aa826f65764=
14:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-10-22' i=
nto staging (2019-10-23 16:06:13 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191024

for you to fetch changes up to 97c00c54449b4ff349f85c6ce409dadd1b935a7d:

  spapr/xive: Set the OS CAM line at reset (2019-10-24 13:34:15 +1100)

----------------------------------------------------------------
ppc patch queue 2019-10-24

Last pull request before soft freeze.
  * Lots of fixes and cleanups for spapr interrupt controllers
  * More SLOF updates to fix problems with full FDT rendering at CAS
    time (alas, more yet are to come)
  * A few other assorted changes

This isn't quite as well tested as I usually try to do before a pull
request.  But I've been sick and running into some other difficulties,
and wanted to get this sent out before heading towards KVM forum.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

C=C3=A9dric Le Goater (8):
      ppc/pnv: Improve trigger data definition
      ppc/pnv: Use address_space_stq_be() when triggering an interrupt fr=
om PSI
      spapr: move CPU reset after presenter creation
      ppc/pnv: Introduce a PnvCore reset handler
      ppc/pnv: Add a PnvChip pointer to PnvCore
      ppc: Reset the interrupt presenter from the CPU reset handler
      ppc/pnv: Fix naming of routines realizing the CPUs
      spapr/xive: Set the OS CAM line at reset

David Gibson (13):
      spapr, xics, xive: Introduce SpaprInterruptController QOM interface
      spapr, xics, xive: Move cpu_intc_create from SpaprIrq to SpaprInter=
ruptController
      spapr, xics, xive: Move irq claim and free from SpaprIrq to SpaprIn=
terruptController
      spapr: Formalize notion of active interrupt controller
      spapr, xics, xive: Move set_irq from SpaprIrq to SpaprInterruptCont=
roller
      spapr, xics, xive: Move print_info from SpaprIrq to SpaprInterruptC=
ontroller
      spapr, xics, xive: Move dt_populate from SpaprIrq to SpaprInterrupt=
Controller
      spapr, xics, xive: Match signatures for XICS and XIVE KVM connect r=
outines
      spapr: Remove SpaprIrq::init_kvm hook
      spapr, xics, xive: Move SpaprIrq::reset hook logic into activate/de=
activate
      spapr, xics, xive: Move SpaprIrq::post_load hook to backends
      spapr: Remove SpaprIrq::nr_msis
      spapr: Move SpaprIrq::nr_xirqs to SpaprMachineClass

Greg Kurz (5):
      xive: Make some device types not user creatable
      xics: Make some device types not user creatable
      spapr: Set VSMT to smp_threads by default
      spapr: Don't request to unplug the same core twice
      spapr_cpu_core: Implement DeviceClass::reset

Stefan Brankovic (1):
      target/ppc: Fix for optimized vsl/vsr instructions

 hw/intc/pnv_xive.c                  |  20 +-
 hw/intc/spapr_xive.c                | 324 ++++++++++++-------
 hw/intc/spapr_xive_kvm.c            |  22 +-
 hw/intc/xics.c                      |  18 +-
 hw/intc/xics_kvm.c                  |   9 +-
 hw/intc/xics_spapr.c                | 117 ++++++-
 hw/intc/xive.c                      |  31 +-
 hw/ppc/pnv.c                        |  18 ++
 hw/ppc/pnv_core.c                   |  31 +-
 hw/ppc/pnv_psi.c                    |  15 +-
 hw/ppc/spapr.c                      |  26 +-
 hw/ppc/spapr_cpu_core.c             |  47 ++-
 hw/ppc/spapr_irq.c                  | 611 +++++++++++++-----------------=
------
 hw/ppc/spapr_pci.c                  |   7 +-
 include/hw/pci-host/spapr.h         |   4 +-
 include/hw/ppc/pnv.h                |   1 +
 include/hw/ppc/pnv_core.h           |   3 +
 include/hw/ppc/spapr.h              |   7 +-
 include/hw/ppc/spapr_irq.h          |  64 +++-
 include/hw/ppc/spapr_xive.h         |  10 +-
 include/hw/ppc/xics.h               |   1 +
 include/hw/ppc/xics_spapr.h         |   6 +-
 include/hw/ppc/xive.h               |   1 +
 include/hw/ppc/xive_regs.h          |  26 +-
 pc-bios/README                      |   2 +-
 pc-bios/slof.bin                    | Bin 930640 -> 928552 bytes
 roms/SLOF                           |   2 +-
 target/ppc/translate/vmx-impl.inc.c |  84 +++--
 28 files changed, 840 insertions(+), 667 deletions(-)

