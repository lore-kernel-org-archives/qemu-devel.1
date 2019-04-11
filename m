Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F93C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 08:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C462133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 08:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C462133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43573 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEUfE-0000Vy-Tx
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 04:02:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUdP-0007PP-P4
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUdO-0007wN-R8
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:35 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:41846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEUdO-0007qj-HQ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:34 -0400
Received: from player779.ha.ovh.net (unknown [10.109.160.39])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 804725A086
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 10:00:31 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
	[86.201.133.22]) (Authenticated sender: clg@kaod.org)
	by player779.ha.ovh.net (Postfix) with ESMTPSA id 6331B48B8ACD;
	Thu, 11 Apr 2019 08:00:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 Apr 2019 09:59:58 +0200
Message-Id: <20190411080004.8690-1-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 17590497198647184358
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.74.227
Subject: [Qemu-devel] [PATCH 0/6] ppc: misc fixes for Radix and Hash
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411075958.CqE4CVg3K8kF-XoVU-LDShd-DRdjy1_SxG5WyhghVDU@z>

Hi,

Here is a series of patches from Ben providing MMU fixes for sPAPR and
PowerNV. They seem of interest and deserve a closer look by people
with good knowledge of the PPC MMU.

Thanks,

C.

Benjamin Herrenschmidt (6):
  target/ppc: Don't check UPRT in radix mode when in HV real mode
  ppc/spapr: Use proper HPTE accessors for H_READ
  ppc/hash64: Rework R and C bit updates
  ppc/hash32: Rework R and C bit updates
  memory_ldst: Add atomic ops for PTE updates
  ppc: Fix radix RC updates

 include/exec/memory_ldst.inc.h |  6 +++
 include/hw/ppc/spapr.h         |  2 +
 target/ppc/cpu.h               |  5 +-
 target/ppc/mmu-hash64.h        |  2 -
 hw/ppc/spapr.c                 | 41 ++++++++++++++--
 hw/ppc/spapr_hcall.c           | 24 +++++-----
 memory_ldst.inc.c              | 80 +++++++++++++++++++++++++++++++
 target/ppc/mmu-hash32.c        | 45 ++++++++++++------
 target/ppc/mmu-hash64.c        | 76 ++++++++++++++++++------------
 target/ppc/mmu-radix64.c       | 86 ++++++++++++++++++++++++++++------
 10 files changed, 288 insertions(+), 79 deletions(-)

--=20
2.20.1


