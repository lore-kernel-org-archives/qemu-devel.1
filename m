Received: from eggs.gnu.org ([2001:4830:134:3::10]:35020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gAtNv-0008ST-Ii
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gAtNg-0006Ia-L9
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:05:21 -0400
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:50462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gAtNa-00065r-Hd
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:05:08 -0400
Received: from player796.ha.ovh.net (unknown [10.109.143.201])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id A1E2713CAAB
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 11:05:04 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 12 Oct 2018 11:04:58 +0200
Message-ID: <153933509870.3834759.13291133122604475240.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/2] spapr_pci: coding style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

As requested by David, two distinct patches and PCI still mentionned
in the new type names.

--
Greg

---

Greg Kurz (2):
      spapr_pci: convert g_malloc() to g_new()
      spapr_pci: rename some structured types


 hw/ppc/spapr_pci.c          |   22 +++++++++++-----------
 include/hw/pci-host/spapr.h |   12 ++++++------
 2 files changed, 17 insertions(+), 17 deletions(-)
