Received: from eggs.gnu.org ([2001:4830:134:3::10]:50111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu2Cs-0006sH-Hn
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu2Co-0004IU-NC
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:27:34 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 16:27:22 -0300
Message-Id: <20170331192724.14339-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/2] etsec: (TYPE_)ETSEC_COMMON macro
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, qemu-ppc@nongnu.org, Fabien Chouteau <chouteau@adacore.com>, Jason Wang <jasowang@redhat.com>

When working on other things, I got confused by the etsec code,
that didn't use the TYPE_ETSEC_COMMON macro in its type
declaration, and had no subclasses despite being named
ETSEC_COMMON.

This is a very simple cleanup to remove the _COMMON suffix from
the macros, and to use the TYPE_ETSEC macro when registering and
creating devices instead of hardcoding the "eTSEC" name.

Cc: Alexander Graf <agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Fabien Chouteau <chouteau@adacore.com>
Cc: qemu-ppc@nongnu.org

Eduardo Habkost (2):
  etsec: Rename (TYPE_)ETSEC_COMMON to (TYPE_)ETSEC
  etsec: Use TYPE_ETSEC macro when registering/creating device

 hw/net/fsl_etsec/etsec.h |  6 +++---
 hw/net/fsl_etsec/etsec.c | 10 +++++-----
 hw/ppc/e500.c            |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.11.0.259.g40922b1
