Received: from eggs.gnu.org ([2001:4830:134:3::10]:40081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1enenR-0002Qh-6e
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1enenO-0007Kh-3E
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:29 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:52125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1enenN-0007K2-P3
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:26 -0500
From: David Brenken <david.brenken@efs-auto.org>
Date: Mon, 19 Feb 2018 07:18:22 +0100
Message-Id: <20180219061827.2112-1-david.brenken@efs-auto.org>
Subject: [Qemu-devel] [PATCH 0/5] tricore: added small features + fixed
 wrong masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, David Brenken <david.brenken@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

Hello,

this is my first commit of a patch set for QEMU. 

This patch series contains a few updates for the target tricore:
- adding a few additional, previously missing cpu instructions
- adding CORE_ID
- fixing some masks
- fixing a wrong shift (context PCXI PIE)


David Brenken (5):
  tricore: added some missing cpu instructions
  tricore: added CORE_ID
  tricore: fixed wrong masking of IE
  tricore: fixed wrong mask of PCXI_PIE
  tricore: fixed wrong shifting of PCXI PIE

 target/tricore/cpu.h             |  5 +++--
 target/tricore/csfr.def          |  1 +
 target/tricore/op_helper.c       |  3 ++-
 target/tricore/translate.c       | 22 ++++++++++++++++++++++
 target/tricore/tricore-opcodes.h |  4 ++++
 5 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.7.4
