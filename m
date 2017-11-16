Received: from eggs.gnu.org ([2001:4830:134:3::10]:35355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eFBbK-0004Qc-83
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 23:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eFBbJ-0001hn-GO
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 23:16:30 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 16 Nov 2017 15:16:06 +1100
Message-Id: <20171116041607.31852-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH] Use compat mode to set cpu features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, sjitindarsingh@gmail.com

Currently the compat mode isn't used when determining the values of the
ibm,arch-vec-5-platform-support and ibm,pa-features device tree nodes.

This means a POWER9 guest run in a prePOWER9 compat mode (or with a
prePOWER9 cpu model for TCG) will still use the radix mmu mode when
it shouldn't, because the capability is exposed through
ibm,arch-vec-5-platform-support.

The following patch fixes the setting of these properties by correctly
taking the compat mode into account.

Suraj Jitindar Singh (1):
  target/ppc: Update setting of cpu features to account for compat modes

 hw/ppc/spapr.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.9.5
