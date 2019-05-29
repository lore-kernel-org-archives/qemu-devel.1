Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14085C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACD0208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dSLYFlay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACD0208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsUl-0003uD-1m
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:55:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsPy-0008Cz-Dg
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsPw-0002Vd-Up
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:50:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35061 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsPw-0002Qu-Bd; Wed, 29 May 2019 02:50:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv13hhrz9sB8; Wed, 29 May 2019 16:50:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112621;
	bh=EZJqcEEPSulnpuBPVm9M3MWDQjvDKJoRrB0O9wjWsLw=;
	h=From:To:Cc:Subject:Date:From;
	b=dSLYFlayOhbc32RxN3lXGLdvtzM4SuKxto9pbvGHTUe2sCgB4484RIyLq0kcqVsv2
	mVnrbcavt5v11/+DdMlhWLvFHuAfEXYOtszs0whLJg6MN9z7MNCpDdNzNXup+mRO5D
	f+DGtHyjIuVBD6kk837DdQnQHZSIEutaZOLwjbSU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:49:33 +1000
Message-Id: <20190529065017.15149-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 00/44] ppc-for-4.1 queue 20190529
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8c1ecb590497b0349c550607db923972b37f69=
63:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-28=
0519-2' into staging (2019-05-28 17:38:32 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190529

for you to fetch changes up to ce4b1b56852ea741170ae85d3b8c0771c1ca7c9e:

  ppc/pnv: add dummy XSCOM registers for PRD initialization (2019-05-29 1=
1:39:47 +1000)

----------------------------------------------------------------
ppc patch queue 2019-05-29

Next pull request against qemu-4.1.  Highlights:
  * KVM accelerated support for the XIVE interrupt controller in PAPR
    guests
  * A number of TCG vector fixes
  * Fixes for the PReP / 40p machine
  * Improvements to make check-tcg test coverage

Other than that it's just a bunch of assorted fixes, cleanups and
minor improvements.

This supersedes both the pull request dated 2019-05-21 and the one
dated 2019-05-22.  I've dropped one hunk which I think may have caused
the check-tcg failure that Peter saw (by enabling the ppc64abi32
build, which I think has been broken for ages).  I'm not entirely
certain, since I haven't reproduced exactly the same failure.

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

C=C3=A9dric Le Goater (21):
      spapr/xive: EQ page should be naturally aligned
      spapr/xive: fix EQ page addresses above 64GB
      spapr/xive: print out the EQ page address in the monitor
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
      docs: provide documentation on the POWER9 XIVE interrupt controller
      spapr/xive: fix multiple resets when using the 'dual' interrupt mod=
e
      spapr: change default interrupt mode to 'dual'
      ppc/pnv: introduce new skiboot platform properties
      ppc/pnv: add dummy XSCOM registers for PRD initialization

David Gibson (3):
      tests: Fix up docker cross builds for ppc64 (BE) targets
      spapr: Add forgotten capability to migration stream
      spapr: Fix phb_placement backwards compatibility

Greg Kurz (3):
      spapr/xive: Sanity checks of OV5 during CAS
      spapr: Print out extra hints when CAS negotiation of interrupt mode=
 fails
      spapr: Don't migrate the hpt_maxpagesize cap to older machine types

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

 MAINTAINERS                                        |   1 +
 configure                                          |  49 +-
 docs/index.rst                                     |   1 +
 docs/specs/index.rst                               |  13 +
 docs/specs/ppc-spapr-xive.rst                      | 174 +++++
 docs/specs/ppc-xive.rst                            | 199 +++++
 hw/core/sysbus.c                                   |  10 +
 hw/intc/Makefile.objs                              |   1 +
 hw/intc/spapr_xive.c                               | 193 ++++-
 hw/intc/spapr_xive_kvm.c                           | 823 +++++++++++++++=
++++++
 hw/intc/xics.c                                     |  10 +-
 hw/intc/xics_kvm.c                                 | 113 ++-
 hw/intc/xics_spapr.c                               |   7 +
 hw/intc/xive.c                                     |  53 +-
 hw/isa/i82378.c                                    |   4 -
 hw/ppc/Kconfig                                     |   5 +
 hw/ppc/pnv.c                                       |  13 +-
 hw/ppc/pnv_xscom.c                                 |  18 +
 hw/ppc/prep.c                                      |   7 +-
 hw/ppc/spapr.c                                     |  38 +-
 hw/ppc/spapr_caps.c                                |  13 +-
 hw/ppc/spapr_cpu_core.c                            |   2 +
 hw/ppc/spapr_hcall.c                               |  26 +
 hw/ppc/spapr_irq.c                                 | 140 +++-
 hw/ppc/spapr_rtas.c                                |   6 +-
 include/hw/ppc/spapr.h                             |   2 +
 include/hw/ppc/spapr_irq.h                         |   2 +
 include/hw/ppc/spapr_xive.h                        |  39 +
 include/hw/ppc/xics.h                              |   1 +
 include/hw/ppc/xics_spapr.h                        |   1 +
 include/hw/ppc/xive.h                              |  14 +
 include/hw/ppc/xive_regs.h                         |   6 +
 include/hw/sysbus.h                                |   1 +
 target/ppc/helper.h                                |  12 -
 target/ppc/int_helper.c                            |  53 +-
 target/ppc/kvm.c                                   |   9 +-
 target/ppc/kvm_ppc.h                               |   6 +
 target/ppc/trace-events                            |   2 +-
 target/ppc/translate/vmx-impl.inc.c                |  24 +-
 target/ppc/translate/vsx-impl.inc.c                |  86 ++-
 tests/docker/Makefile.include                      |   1 +
 tests/docker/dockerfiles/debian-ppc64-cross.docker |  11 +
 tests/tcg/ppc/Makefile.include                     |   3 +
 43 files changed, 1980 insertions(+), 212 deletions(-)
 create mode 100644 docs/specs/index.rst
 create mode 100644 docs/specs/ppc-spapr-xive.rst
 create mode 100644 docs/specs/ppc-xive.rst
 create mode 100644 hw/intc/spapr_xive_kvm.c
 create mode 100644 tests/docker/dockerfiles/debian-ppc64-cross.docker

