Received: from eggs.gnu.org ([2001:4830:134:3::10]:44670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIeZj-0000H9-96
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIeZf-0000M1-7q
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:16:55 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:38231)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIeZf-0000Iq-1F
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:16:51 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 562B63DCE3
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 19:16:47 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 07 Jun 2017 19:16:36 +0200
Message-ID: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 0/5] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

v3: - preparatory cleanup in pnv (patch 1)
    - rework ICPState realization and vmstate registration (patches 2,3,4)
    - fix migration using dummy icp/server entries (patch 5)

v2: - some patches from v1 are already merged in ppc-for-2.10
    - added a new fix to a potential memory leak (patch 1)
    - consolidate dt_id computation (patch 3)
    - see individual changelogs for patch 2 and 4

This series is based on:

https://github.com/dgibson/qemu.git ppc-for-2.10

This was lightly tested.

--
Greg

---

Greg Kurz (5):
      pnv_core: drop reference on ICPState object during CPU realization
      xics: add reset() handler to ICPStateClass
      xics: setup cpu at realize time
      xics: directly register ICPState objects to vmstate
      spapr: fix migration of ICPState objects from/to older QEMU


 hw/intc/xics.c          |   86 ++++++++++++++++++++++------------------------
 hw/intc/xics_kvm.c      |   27 +-------------
 hw/ppc/pnv_core.c       |   15 ++++----
 hw/ppc/spapr.c          |   88 ++++++++++++++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_cpu_core.c |   21 +++++------
 include/hw/ppc/spapr.h  |    2 +
 include/hw/ppc/xics.h   |    3 +-
 7 files changed, 148 insertions(+), 94 deletions(-)
