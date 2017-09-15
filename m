Received: from eggs.gnu.org ([2001:4830:134:3::10]:41887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsqTJ-0002UJ-Tl
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsqTF-0003p9-SS
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:15:53 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:56821)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsqTF-0003ox-Lw
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:15:49 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 80D29AC438
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 15:15:47 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Sep 2017 15:15:33 +0200
Message-ID: <150548133297.5945.7401220081077343726.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/4] ppc/kvm: htab fd code improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

This series drops unused code and consolidates some duplicated code that
deals with KVM's htab fd feature. It also fixes some potential bugs.

--
Greg

---

Greg Kurz (4):
      ppc/kvm: drop kvmppc_has_cap_htab_fd()
      spapr: introduce helpers to migrate HPT chunks and the end marker
      ppc/kvm: change kvmppc_get_htab_fd() to return -errno on error
      ppc/kvm: generalize the use of kvmppc_get_htab_fd()


 hw/ppc/spapr.c       |   54 +++++++++++++++++++++++++++-----------------------
 target/ppc/kvm.c     |   42 ++++++++++++++++-----------------------
 target/ppc/kvm_ppc.h |   10 ++-------
 3 files changed, 48 insertions(+), 58 deletions(-)
