Received: from eggs.gnu.org ([2001:4830:134:3::10]:56943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drLjI-0008MB-2b
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drLjE-0002dC-S7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:14:11 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drLjE-0002cq-Lk
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:14:08 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 3361993377
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 12:14:07 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 11 Sep 2017 12:13:56 +0200
Message-ID: <150512483616.8642.15831240906912354238.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/2] spapr_pci: some more cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

---

Greg Kurz (2):
      spapr_pci: convert sprintf() to g_strdup_printf()
      spapr_pci: don't create 64-bit MMIO window if we don't need to


 hw/ppc/spapr_pci.c |   37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)
