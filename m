Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A89C2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AD320748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GD5P2E+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AD320748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLfzR-0001FI-U5
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyK-0007xq-0A
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyI-0004AC-PH
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35869 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jLfyI-00045O-1D; Tue, 07 Apr 2020 00:36:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xF3J6xFpz9sSG; Tue,  7 Apr 2020 14:36:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586234172;
 bh=vS5oh8wqbrvKDelqXzkt74+5PsnzwENrqYN0ykci3QY=;
 h=From:To:Cc:Subject:Date:From;
 b=GD5P2E+C6rDYX0kpYxqA54VZTJWIIaZFLUDdm0GETc4FexV4O3fjtdXpUqgehekSC
 CWEXAN0xVskCNAbq19cFHz2ol5QgbLhuNIX/x8wRC8sgHpti5yM3stncXtPeyp5RCB
 LGGRZlfNFYNg7GtMk3atSXSkyyjgw4J+lL31lznU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/10] ppc-for-5.0 queue 20200407
Date: Tue,  7 Apr 2020 14:35:56 +1000
Message-Id: <20200407043606.291546-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c2=
50:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00406' into staging (2020-04-06 12:36:45 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200407

for you to fetch changes up to 25f3170b06544e4de620336da5b2ea3b392d66bc:

  ppc/pnv: Create BMC devices only when defaults are enabled (2020-04-07 =
08:55:11 +1000)

----------------------------------------------------------------
ppc patch queue 2020-04-07

An assortment of fixes for qemu-5.0, including a number for the FWNMI
feature which is new this release.

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      vfio/spapr: Fix page size calculation
      pseries: Update SLOF firmware image

C=C3=A9dric Le Goater (1):
      ppc/pnv: Create BMC devices only when defaults are enabled

David Gibson (1):
      spapr: Fix failure path for attempting to hot unplug PCI bridges

Nicholas Piggin (4):
      ppc/spapr: KVM FWNMI should not be enabled until guest requests it
      ppc/spapr: Improve FWNMI machine check delivery corner case comment=
s
      ppc/spapr: Add FWNMI machine check delivery warnings
      ppc/spapr: Don't kill the guest if a recovered FWNMI machine check =
delivery fails

Peter Maydell (2):
      hw/ppc/e500.c: Handle qemu_find_file() failure
      hw/ppc/ppc440_uc.c: Remove incorrect iothread locking from dcr_writ=
e_pcie()

 hw/ppc/e500.c         |   4 ++++
 hw/ppc/pnv.c          |  32 +++++++++++++++++++++++++++-----
 hw/ppc/pnv_bmc.c      |  45 ++++++++++++++++++++++++++++++++++++++++++++=
+
 hw/ppc/ppc440_uc.c    |   3 ---
 hw/ppc/spapr_caps.c   |   7 ++++---
 hw/ppc/spapr_events.c |  49 ++++++++++++++++++++++++++++++++++++++------=
-----
 hw/ppc/spapr_pci.c    |   1 +
 hw/ppc/spapr_rtas.c   |  10 ++++++++++
 hw/vfio/spapr.c       |   6 +++---
 include/hw/ppc/pnv.h  |   2 ++
 pc-bios/README        |   2 +-
 pc-bios/slof.bin      | Bin 965008 -> 965112 bytes
 roms/SLOF             |   2 +-
 target/ppc/kvm.c      |   7 +++++++
 target/ppc/kvm_ppc.h  |   6 ++++++
 15 files changed, 149 insertions(+), 27 deletions(-)

