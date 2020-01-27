Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE627C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8332120720
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8332120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw5gj-0002vL-K9
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iw5dg-0007oN-Tp
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iw5df-0006uL-PM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:45:20 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:55613)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iw5df-0006tX-J0
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:45:19 -0500
Received: from player692.ha.ovh.net (unknown [10.110.115.29])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 88D161575FD
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 15:45:17 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 0A93BE8B6E28;
 Mon, 27 Jan 2020 14:45:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/2] ppc/pnv: Add models for PHB4 and PHB3 PCIe Host bridges
Date: Mon, 27 Jan 2020 15:45:04 +0100
Message-Id: <20200127144506.11132-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17833410103165553638
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.76
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
Cc: qemu-ppc@nongnu.org, Oliver O'Halloran <oohall@gmail.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

These are models for the PCIe Host Bridges, PHB3 and PHB4, as found on
POWER8 and POWER9 processors. It includes the PowerBus logic interface
(PBCQ), IOMMU support, a single PCIe Gen.3/4 Root Complex, and support
for MSI and LSI interrupt sources as found on each system depending on
the interrupt controller: XICS or XIVE.

No default device layout is provided and PCI devices can be added on
any of the available PCIe Root Port (pcie.0 .. 2) with address 0x0 as
the firwware (skiboot) only accepts a single device per root port. To
run a simple system with a network and a storage adapters, use a
command line options such as :

  -device e1000e,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpcie.0,addr=3D=
0x0
  -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=3D=
virbr0,id=3Dhostnet0

  -device megasas,id=3Dscsi0,bus=3Dpcie.1,addr=3D0x0
  -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,cac=
he=3Dnone
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Dd=
rive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2

If more are needed, include a bridge.

Multi chip is supported, each chip adding its set of PHB controllers
and its PCI busses. The model doesn't emulate the EEH error handling
and cold plugging PHB devices still needs some work.

XICS requires some adjustment to support the PHB3 MSI. The changes are
provided in the PHB3 model but they could be decoupled in prereq patches.

Thanks,

C.

Benjamin Herrenschmidt (1):
  ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge

C=C3=A9dric Le Goater (1):
  ppc/pnv: Add models for POWER8 PHB3 PCIe Host bridge

 include/hw/pci-host/pnv_phb3.h      |  164 +++
 include/hw/pci-host/pnv_phb3_regs.h |  450 +++++++++
 include/hw/pci-host/pnv_phb4.h      |  230 +++++
 include/hw/pci-host/pnv_phb4_regs.h |  553 ++++++++++
 include/hw/pci/pcie_port.h          |    1 +
 include/hw/ppc/pnv.h                |   11 +
 include/hw/ppc/pnv_xscom.h          |   20 +
 include/hw/ppc/xics.h               |    5 +
 hw/intc/xics.c                      |   14 +-
 hw/pci-host/pnv_phb3.c              | 1195 ++++++++++++++++++++++
 hw/pci-host/pnv_phb3_msi.c          |  349 +++++++
 hw/pci-host/pnv_phb3_pbcq.c         |  357 +++++++
 hw/pci-host/pnv_phb4.c              | 1438 +++++++++++++++++++++++++++
 hw/pci-host/pnv_phb4_pec.c          |  593 +++++++++++
 hw/ppc/pnv.c                        |  176 +++-
 hw/pci-host/Makefile.objs           |    2 +
 hw/ppc/Kconfig                      |    2 +
 17 files changed, 5557 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/pci-host/pnv_phb3.h
 create mode 100644 include/hw/pci-host/pnv_phb3_regs.h
 create mode 100644 include/hw/pci-host/pnv_phb4.h
 create mode 100644 include/hw/pci-host/pnv_phb4_regs.h
 create mode 100644 hw/pci-host/pnv_phb3.c
 create mode 100644 hw/pci-host/pnv_phb3_msi.c
 create mode 100644 hw/pci-host/pnv_phb3_pbcq.c
 create mode 100644 hw/pci-host/pnv_phb4.c
 create mode 100644 hw/pci-host/pnv_phb4_pec.c

--=20
2.21.1


