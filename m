Received: from eggs.gnu.org ([2001:4830:134:3::10]:33275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eI5Wf-0002Pe-5d
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eI5We-0005Vz-8l
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:23:41 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 24 Nov 2017 15:23:23 +1100
Message-Id: <20171124042325.28012-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 0/2] target/ppc: hpt on radix and
 compat migration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com, groug@kaod.org

The following patches fix 2 migration bugs.

The first being that migration of a hpt guest on a radix host currently
doesn't work. The first patch fixes this by installing the correct value
in patb_entry.

The second bug is that migration in a compat mode will currently result
in no compat mode actually being set on the receiving side. Fix this
by ensuring the compat_pvr is communicated to kvm.

The hpt on radix migration will require the host kernel to contain the patch:
KVM: PPC: Book3S HV: Fix migration and HPT resizing of HPT guests on radix hosts

Suraj Jitindar Singh (2):
  target/ppc: Move setting of patb_entry on hash table init
  target/ppc: Fix setting of cpu->compat_pvr on incoming migration

 hw/ppc/spapr.c       | 4 ++--
 target/ppc/machine.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.13.6
