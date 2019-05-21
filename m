Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C99C072AD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304202173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IOS3+6JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304202173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSyMd-0001Yc-Uy
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 02:35:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyHT-0005s9-6u
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyHR-0007gu-EC
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:29:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55571 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSyHP-0007Yk-WB; Tue, 21 May 2019 02:29:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 457Qpd5x8wz9s9T; Tue, 21 May 2019 16:29:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558420169;
	bh=aI18ZHuJoaFD/rH5L7CRiNf1c5a8q/B6HzZIM8NgUFY=;
	h=From:To:Cc:Subject:Date:From;
	b=IOS3+6JXBucWDs0Tld2b59Wps0d0T285SVHLZGCzb0YUSVMUuV8nQHhJEkw1tRpCN
	tdxQsFuCUajgsFCfL7AOnDg/1crnCgMRexAbyzf9tdYr59rbZkFNAx8cKU6tO0vd9v
	b+ycPPVzG+dziU60FMw8yTIYU7f1/qWfSyNzJg2U=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue, 21 May 2019 16:28:46 +1000
Message-Id: <20190521062924.6930-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 00/38] ppc-for-4.1 queue 20190521
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, gkurz@kaod.org, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2259637b95bef3116cc262459271de08e038cc=
66:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-05-20 17:22:05 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190521

for you to fetch changes up to 271226c30a2128c563974dd359cb1e25a54e1cbf:

  spapr/irq: add KVM support to the 'dual' machine (2019-05-21 10:55:47 +=
1000)

----------------------------------------------------------------
ppc patch queue 2019-05-21

Next pull request against qemu-4.1.  Highlights:
  * KVM accelerated support for the XIVE interrupt controller in PAPR
    guests
  * A number of TCG vector fixes
  * Fixes for the PReP / 40p machine

Other than that it's just a bunch of assorted fixes, cleanups and
minor improvements.

----------------------------------------------------------------
Anton Blanchard (7):
      target/ppc: Fix xvxsigdp
      target/ppc: Fix xxbrq, xxbrw
      target/ppc: Fix vslv and vsrv
      target/ppc: Fix vsum2sws
      target/ppc: Fix xxspltib
      target/ppc: Optimise VSX_LOAD_SCALAR_DS and VSX_VECTOR_LOAD_STORE
      target/ppc: Fix xvabs[sd]p, xvnabs[sd]p, xvneg[sd]p, xvcpsgn[sd]p

Artyom Tarasenko (1):
      hw/ppc/40p: use 1900 as a base year

Boxuan Li (1):
      target/ppc/kvm: Fix trace typo

C=C3=A9dric Le Goater (17):
      spapr/xive: EQ page should be naturally aligned
      spapr/xive: fix EQ page addresses above 64GB
      spapr/xive: print out the EQ page address in the monitor
      linux-headers: Update linux headers to 5.2-rc1
      spapr/xive: add KVM support
      spapr/xive: add hcall support when under KVM
      spapr/xive: add state synchronization with KVM
      spapr/xive: introduce a VM state change handler
      spapr/xive: add migration support for KVM
      spapr/xive: activate KVM support
      sysbus: add a sysbus_mmio_unmap() helper
      spapr: introduce routines to delete the KVM IRQ device
      spapr: check for the activation of the KVM IRQ device
      spapr/irq: introduce a spapr_irq_init_device() helper
      spapr/irq: initialize the IRQ device only once
      ppc/xics: fix irq priority in ics_set_irq_type()
      spapr/irq: add KVM support to the 'dual' machine

David Gibson (2):
      spapr: Add forgotten capability to migration stream
      spapr: Fix phb_placement backwards compatibility

Greg Kurz (2):
      spapr/xive: Sanity checks of OV5 during CAS
      spapr: Print out extra hints when CAS negotiation of interrupt mode=
 fails

Philippe Mathieu-Daud=C3=A9 (2):
      hw/ppc/prep: use TYPE_MC146818_RTC instead of a hardcoded string
      hw/ppc/40p: Move the MC146818 RTC to the board where it belongs

Richard Henderson (3):
      configure: Distinguish ppc64 and ppc64le hosts
      configure: Use quotes around uses of $CPU_CFLAGS
      target/ppc: Use vector variable shifts for VSL, VSR, VSRA

Satheesh Rajendran (1):
      Fix typo on "info pic" monitor cmd output for xive

Suraj Jitindar Singh (2):
      target/ppc: Add ibm,purr and ibm,spurr device-tree properties
      target/ppc: Set PSSCR_EC on cpu halt to prevent spurious wakeup

 configure                                          |  52 +-
 hw/core/sysbus.c                                   |  10 +
 hw/intc/Makefile.objs                              |   1 +
 hw/intc/spapr_xive.c                               | 188 ++++-
 hw/intc/spapr_xive_kvm.c                           | 827 +++++++++++++++=
++++++
 hw/intc/xics.c                                     |  10 +-
 hw/intc/xics_kvm.c                                 | 113 ++-
 hw/intc/xics_spapr.c                               |   7 +
 hw/intc/xive.c                                     |  53 +-
 hw/isa/i82378.c                                    |   4 -
 hw/ppc/Kconfig                                     |   5 +
 hw/ppc/prep.c                                      |   7 +-
 hw/ppc/spapr.c                                     |  34 +-
 hw/ppc/spapr_caps.c                                |   1 +
 hw/ppc/spapr_cpu_core.c                            |   2 +
 hw/ppc/spapr_hcall.c                               |  24 +
 hw/ppc/spapr_irq.c                                 | 140 +++-
 hw/ppc/spapr_rtas.c                                |   6 +-
 include/hw/ppc/spapr.h                             |   1 +
 include/hw/ppc/spapr_irq.h                         |   2 +
 include/hw/ppc/spapr_xive.h                        |  39 +
 include/hw/ppc/xics.h                              |   1 +
 include/hw/ppc/xics_spapr.h                        |   1 +
 include/hw/ppc/xive.h                              |  14 +
 include/hw/ppc/xive_regs.h                         |   6 +
 include/hw/sysbus.h                                |   1 +
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h      |  15 +-
 include/standard-headers/drm/drm_fourcc.h          | 114 ++-
 include/standard-headers/linux/ethtool.h           |  48 +-
 include/standard-headers/linux/input-event-codes.h |   9 +-
 include/standard-headers/linux/input.h             |   6 +-
 include/standard-headers/linux/pci_regs.h          | 140 ++--
 include/standard-headers/linux/virtio_config.h     |   6 +
 include/standard-headers/linux/virtio_gpu.h        |  12 +-
 include/standard-headers/linux/virtio_ring.h       |  10 -
 include/standard-headers/rdma/vmw_pvrdma-abi.h     |   1 +
 linux-headers/asm-arm/unistd-common.h              |  32 +
 linux-headers/asm-arm64/kvm.h                      |  43 ++
 linux-headers/asm-arm64/unistd.h                   |   2 +
 linux-headers/asm-generic/mman-common.h            |   4 +-
 linux-headers/asm-generic/unistd.h                 | 170 ++++-
 linux-headers/asm-mips/mman.h                      |   4 +-
 linux-headers/asm-mips/unistd_n32.h                |  30 +
 linux-headers/asm-mips/unistd_n64.h                |  10 +
 linux-headers/asm-mips/unistd_o32.h                |  40 +
 linux-headers/asm-powerpc/kvm.h                    |  48 ++
 linux-headers/asm-powerpc/unistd_32.h              |  40 +
 linux-headers/asm-powerpc/unistd_64.h              |  21 +
 linux-headers/asm-s390/kvm.h                       |   5 +-
 linux-headers/asm-s390/unistd_32.h                 |  43 ++
 linux-headers/asm-s390/unistd_64.h                 |  24 +
 linux-headers/asm-x86/kvm.h                        |   1 +
 linux-headers/asm-x86/unistd_32.h                  |  40 +
 linux-headers/asm-x86/unistd_64.h                  |  10 +
 linux-headers/asm-x86/unistd_x32.h                 |  10 +
 linux-headers/linux/kvm.h                          |  15 +-
 linux-headers/linux/mman.h                         |   4 +
 linux-headers/linux/psci.h                         |   7 +
 linux-headers/linux/psp-sev.h                      |  18 +-
 linux-headers/linux/vfio.h                         |   4 +
 linux-headers/linux/vfio_ccw.h                     |  12 +
 target/ppc/helper.h                                |  12 -
 target/ppc/int_helper.c                            |  53 +-
 target/ppc/kvm.c                                   |   9 +-
 target/ppc/kvm_ppc.h                               |   6 +
 target/ppc/trace-events                            |   2 +-
 target/ppc/translate/vmx-impl.inc.c                |  24 +-
 target/ppc/translate/vsx-impl.inc.c                |  86 ++-
 68 files changed, 2390 insertions(+), 349 deletions(-)
 create mode 100644 hw/intc/spapr_xive_kvm.c

