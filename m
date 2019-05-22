Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCEAC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 04:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5D82075E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 04:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YOBtR9zN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5D82075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTJE6-0007Ps-5I
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 00:51:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTJ8q-0003Lv-8d
	for qemu-devel@nongnu.org; Wed, 22 May 2019 00:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTJ8o-0006aX-S1
	for qemu-devel@nongnu.org; Wed, 22 May 2019 00:46:16 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51285)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTJ8m-0006WX-M0; Wed, 22 May 2019 00:46:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4580Ss3jGLz9sDn; Wed, 22 May 2019 14:46:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558500365;
	bh=YHUSplfrgQszf0kPC4VaN+ClMPfaRiRw+VnWBefIVS0=;
	h=From:To:Cc:Subject:Date:From;
	b=YOBtR9zNfhcpHPeSrSlYlMVYTttlt+0RkF7QdkuWsq3Vtn+yQ8/yW50h4bthG/cQn
	RiwykPvZCrNA/dEPZn4je7xiU0BELDbQnO51a9xVne2ZpXxGbu4y3FapupwmqiFR4N
	PruQkFwJOidQKcJ+0fZK2Odj4BIqg6V4S+fQZ3fw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 22 May 2019 14:45:22 +1000
Message-Id: <20190522044600.16534-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 00/38] ppc-for-4.1 queue 20190522
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
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a4f667b6714916683408b983cfe0a615a72577=
5f:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' int=
o staging (2019-05-21 16:30:13 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190522

for you to fetch changes up to 885659103ad9e1b0460e89c548e9fb823b007b7e:

  docs: provide documentation on the POWER9 XIVE interrupt controller (20=
19-05-22 10:38:22 +1000)

----------------------------------------------------------------
ppc patch queue 2019-05-22

Next pull request against qemu-4.1.  Highlights:
  * KVM accelerated support for the XIVE interrupt controller in PAPR
    guests
  * A number of TCG vector fixes
  * Fixes for the PReP / 40p machine

Other than that it's just a bunch of assorted fixes, cleanups and
minor improvements.

This supersedes the pull request dated 2019-05-21.  I've dropped the
headers update, since it had a mistake, but is now made redundant by a
similar update in Cornelia's applied PR.  I've also added a patch with
extra documentation for the XIVE interrupt controller, and fixed a
couple of minor style errors in the previous PR.

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

 MAINTAINERS                         |   1 +
 configure                           |  52 ++-
 docs/index.rst                      |   1 +
 docs/specs/index.rst                |  13 +
 docs/specs/ppc-spapr-xive.rst       | 174 ++++++++
 docs/specs/ppc-xive.rst             | 199 +++++++++
 hw/core/sysbus.c                    |  10 +
 hw/intc/Makefile.objs               |   1 +
 hw/intc/spapr_xive.c                | 188 ++++++--
 hw/intc/spapr_xive_kvm.c            | 827 ++++++++++++++++++++++++++++++=
++++++
 hw/intc/xics.c                      |  10 +-
 hw/intc/xics_kvm.c                  | 113 ++++-
 hw/intc/xics_spapr.c                |   7 +
 hw/intc/xive.c                      |  53 ++-
 hw/isa/i82378.c                     |   4 -
 hw/ppc/Kconfig                      |   5 +
 hw/ppc/prep.c                       |   7 +-
 hw/ppc/spapr.c                      |  34 +-
 hw/ppc/spapr_caps.c                 |   1 +
 hw/ppc/spapr_cpu_core.c             |   2 +
 hw/ppc/spapr_hcall.c                |  26 ++
 hw/ppc/spapr_irq.c                  | 140 ++++--
 hw/ppc/spapr_rtas.c                 |   6 +-
 include/hw/ppc/spapr.h              |   1 +
 include/hw/ppc/spapr_irq.h          |   2 +
 include/hw/ppc/spapr_xive.h         |  39 ++
 include/hw/ppc/xics.h               |   1 +
 include/hw/ppc/xics_spapr.h         |   1 +
 include/hw/ppc/xive.h               |  14 +
 include/hw/ppc/xive_regs.h          |   6 +
 include/hw/sysbus.h                 |   1 +
 target/ppc/helper.h                 |  12 -
 target/ppc/int_helper.c             |  53 +--
 target/ppc/kvm.c                    |   9 +-
 target/ppc/kvm_ppc.h                |   6 +
 target/ppc/trace-events             |   2 +-
 target/ppc/translate/vmx-impl.inc.c |  24 +-
 target/ppc/translate/vsx-impl.inc.c |  86 +++-
 38 files changed, 1926 insertions(+), 205 deletions(-)
 create mode 100644 docs/specs/index.rst
 create mode 100644 docs/specs/ppc-spapr-xive.rst
 create mode 100644 docs/specs/ppc-xive.rst
 create mode 100644 hw/intc/spapr_xive_kvm.c

