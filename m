Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0D7C11D24
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D95208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="c2P421Bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D95208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zD2-0002Qn-86
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7l-0001sX-S9
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7k-0007xa-HT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:09 -0500
Received: from ozlabs.org ([203.11.71.1]:46879)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z7k-0007aU-5b; Thu, 20 Feb 2020 22:37:08 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwB1CSsz9sRl; Fri, 21 Feb 2020 14:36:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256218;
 bh=CxclaawKdP2BlYleNSqR08kWhjqPO+qnvQ+nGmAoM8A=;
 h=From:To:Cc:Subject:Date:From;
 b=c2P421BuMJwl18Sc0z/t/fpXbv/ThLVTTGYCr9sz4YfnZvY/3FZVtysOYmmv3xNPP
 A16ThdInbfCVSVhopzGYzSvbqRt0zEgUd10r9BoCX5JvFmWCmCX2ZEYUSSonThxxsM
 NHBtEFqiucL+bJ41awWmutbUSUAjJnwBh/fPLTrE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/20] ppc-for-5.0 queue 20200221
Date: Fri, 21 Feb 2020 14:36:30 +1100
Message-Id: <20200221033650.444386-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7afee874f1b27abc998b8b747d16b77cb63987=
16:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-=
request' into staging (2020-02-20 16:51:19 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200221

for you to fetch changes up to 438bafcac55308eef4f9029c94dbadd2c7ac3bb7:

  hw/ppc/virtex_ml507:fix leak of fdevice tree blob (2020-02-21 09:15:04 =
+1100)

----------------------------------------------------------------
ppc patch queue 2020-02-21

Here's the next patch of ppc target patches.  Highlights are:
  * Some fixes for CAS / unplug interactions
  * Remove some leaks of device trees
  * Some fixes for the PHB3 and PHB4 devices
  * Support for NVDIMMs on the pseries machine type
  * Assorted other fixes and cleanups

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      spapr/rtas: Print message from "ibm,os-term"
      spapr: Allow changing offset for -kernel image

BALATON Zoltan (4):
      target/ppc/cpu.h: Remove duplicate includes
      target/ppc: Fix typo in comments
      target/ppc/cpu.h: Move fpu related members closer in cpu env
      target/ppc/cpu.h: Clean up comments in the struct CPUPPCState defin=
ition

Chen Qun (1):
      hw/ppc/virtex_ml507:fix leak of fdevice tree blob

Greg Kurz (5):
      pnv/phb3: Convert 1u to 1ull
      pnv/phb4: Fix error path in pnv_pec_realize()
      pnv/phb3: Add missing break statement
      spapr: Don't use spapr_drc_needed() in CAS code
      spapr: Fix handling of unplugged devices during CAS and migration

Laurent Vivier (2):
      qtest: Fix rtas dependencies
      ppc/pnv: Fix PCI_EXPRESS dependency

Michael S. Tsirkin (1):
      ppc: function to setup latest class options

Pan Nengyuan (1):
      ppc: free 'fdt' after reset the machine

Shivaprasad G Bhat (4):
      mem: move nvdimm_device_list to utilities
      nvdimm: add uuid property to nvdimm
      spapr: Add NVDIMM device support
      spapr: Add Hcalls to support PAPR NVDIMM device

 default-configs/ppc64-softmmu.mak  |   1 +
 hw/acpi/nvdimm.c                   |  28 +--
 hw/mem/Kconfig                     |   2 +-
 hw/mem/nvdimm.c                    |  40 ++++
 hw/pci-host/pnv_phb3_msi.c         |   2 +-
 hw/pci-host/pnv_phb3_pbcq.c        |   1 +
 hw/pci-host/pnv_phb4_pec.c         |   2 +-
 hw/ppc/Kconfig                     |   4 +-
 hw/ppc/Makefile.objs               |   2 +-
 hw/ppc/e500.c                      |   1 +
 hw/ppc/pnv.c                       |   2 +
 hw/ppc/spapr.c                     | 116 +++++++--
 hw/ppc/spapr_drc.c                 |  62 ++++-
 hw/ppc/spapr_events.c              |   4 +
 hw/ppc/spapr_hcall.c               |  14 +-
 hw/ppc/spapr_nvdimm.c              | 475 +++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_rtas.c                |   7 +
 hw/ppc/virtex_ml507.c              |   1 +
 include/hw/mem/nvdimm.h            |   7 +
 include/hw/ppc/spapr.h             |   9 +-
 include/hw/ppc/spapr_drc.h         |  13 +-
 include/hw/ppc/spapr_nvdimm.h      |  37 +++
 include/qemu/nvdimm-utils.h        |   7 +
 qtest.c                            |   5 +-
 target/ppc/cpu.h                   | 148 +++++-------
 target/ppc/fpu_helper.c            |   4 +-
 target/ppc/translate/fp-impl.inc.c |   6 +-
 util/Makefile.objs                 |   1 +
 util/nvdimm-utils.c                |  29 +++
 29 files changed, 864 insertions(+), 166 deletions(-)
 create mode 100644 hw/ppc/spapr_nvdimm.c
 create mode 100644 include/hw/ppc/spapr_nvdimm.h
 create mode 100644 include/qemu/nvdimm-utils.h
 create mode 100644 util/nvdimm-utils.c

