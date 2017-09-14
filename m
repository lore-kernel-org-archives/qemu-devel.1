Received: from eggs.gnu.org ([2001:4830:134:3::10]:59442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsUuZ-0004KN-B0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsUuV-0008NZ-IA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:14:35 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:56066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsUuV-0008MP-B0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:14:31 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id A2B42AC1DE
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 16:14:29 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Sep 2017 16:14:21 +0200
Message-ID: <150539846159.21523.16161730500010192093.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/2] spapr_pci: make index property mandatory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

Patch 1 is a proposal to silence patchew when it parses patch 2 :)

--
Greg

---

Greg Kurz (2):
      checkpatch: add hwaddr to @typeList
      spapr_pci: make index property mandatory


 hw/ppc/spapr_pci.c    |   53 ++++++++++---------------------------------------
 scripts/checkpatch.pl |    1 +
 2 files changed, 12 insertions(+), 42 deletions(-)
