Received: from eggs.gnu.org ([2001:4830:134:3::10]:36021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@git.antfield.fr>) id 1eb16S-0007Wz-OO
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@git.antfield.fr>) id 1eb16N-0003L2-2c
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:30:52 -0500
From: Luc MICHEL <luc.michel@git.antfield.fr>
Date: Mon, 15 Jan 2018 10:32:19 +0100
Message-Id: <20180115093220.9154-1-luc.michel@git.antfield.fr>
Subject: [Qemu-devel] [PATCH v2 0/1] target-ppc: Fix booke206 tlbwe TLB
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc MICHEL <luc.michel@git.antfield.fr>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

v1 is here: https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00140.html

v2:
    - Add a comment with a cite from the "PowerPC e500 Core Family Reference Manual,
      Rev. 1", as advised by David.

Thanks.

Luc MICHEL (1):
  target-ppc: Fix booke206 tlbwe TLB instruction

 target/ppc/mmu_helper.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

-- 
2.15.1
