Received: from eggs.gnu.org ([2001:4830:134:3::10]:40394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eqh5t-0007zp-TJ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eqh5q-0000Su-1v
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:23:05 -0500
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:51832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eqh5p-0000PM-RW
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:23:01 -0500
Received: from player729.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id F1EE7A558D
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 16:22:53 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 27 Feb 2018 16:22:40 +0100
Message-ID: <151974496089.17040.8929640429507724311.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/2] spapr: fix migration of old guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Lukas Doktor <ldoktor@redhat.com>

Recent VSMT work broke migration of old guests as reported in this BZ:

https://bugzilla.redhat.com/show_bug.cgi?id=1549087

Patch 1 fixes the issue, while patch 2 is a tentative code reorg to
ensure VSMT is set before anyone tries to use spapr->vsmt.

--
Greg

---

Greg Kurz (2):
      spapr: register dummy ICPs later
      spapr: harden code that depends on VSMT


 hw/ppc/spapr.c |  144 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 75 insertions(+), 69 deletions(-)
