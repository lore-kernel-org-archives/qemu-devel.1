Received: from eggs.gnu.org ([209.51.188.92]:51641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gzaHt-0000yq-Si
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gza3x-0004jI-JQ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 23:46:22 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  1 Mar 2019 15:46:07 +1100
Message-Id: <20190301044609.9626-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 0/2] Enable mitigations by default
 for pseries-4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This series is based on the ppc-for-4.0 branch with my large-decrementer
and count-cache-flush series applied.

Suraj Jitindar Singh (2):
  target/ppc/tcg: make spapr_caps apply cap-[cfpc/sbbc/ibs] non-fatal
    for tcg
  target/ppc/spapr: Enable mitigations by default for pseries-4.0
    machine type

 hw/ppc/spapr.c      |  9 ++++++---
 hw/ppc/spapr_caps.c | 33 ++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 12 deletions(-)

-- 
2.13.6
