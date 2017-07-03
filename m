Received: from eggs.gnu.org ([2001:4830:134:3::10]:59703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dRuiM-00088l-5W
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dRuiL-0001Jv-Fu
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:20:06 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon,  3 Jul 2017 16:19:45 +1000
Message-Id: <20170703061948.18220-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [Qemu-PPC] [PATCH 0/3] target/ppc: Implement radix mmu
 debug functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, bsingharora@gmail.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

When the radix mmu emulation code was implemented the translation
debug functions were left as a todo.

Implement the functions ppc_radix64_get_phys_page_debug() and 
ppc_radix64_dump_level() to translate a single address and dump all the 
address translations respectively.

This functionality is already implemented for the hash mmu.

A slight refactor of the radix mmu emulation code was necessary to enable
the debug code to call existing functions.

Suraj Jitindar Singh (3):
  target/ppc: Refactor tcg radix mmu code
  target/ppc: Add debug function for radix mmu translation
  target/ppc: Add debug function to dump radix mmu translations

 target/ppc/mmu-radix64.c | 116 +++++++++++++++++++++++++++++++++++++++++------
 target/ppc/mmu-radix64.h |   2 +
 target/ppc/mmu_helper.c  |   5 +-
 3 files changed, 107 insertions(+), 16 deletions(-)

-- 
2.9.4
