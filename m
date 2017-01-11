Received: from eggs.gnu.org ([2001:4830:134:3::10]:56990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEF-0008N7-Kf
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEA-0005Zt-MR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:15 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:48232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1cRJEA-0005XU-EV
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:10 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 11 Jan 2017 14:45:44 +0100
Message-Id: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 0/5] tricore-patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 50788a3fdbade5f8ed1c8296988578133c52c6aa:
                                                                                                                                                                                                                                                                                  
  target-tricore: Add updfl instruction (2017-01-11 14:37:37 +0100)

are available in the git repository at: 

  https://github.com/bkoppelmann/qemu-tricore-upstream.git tags/pull-tricore-2017-01-11-2

for you to fetch changes up to 50788a3fdbade5f8ed1c8296988578133c52c6aa:

  target-tricore: Add updfl instruction (2017-01-11 14:37:37 +0100)

----------------------------------------------------------------
TriCore FPU patches

----------------------------------------------------------------

Bastian Koppelmann (3):
  target-tricore: Added FTOUZ instruction
  target-tricore: Added MADD.F and MSUB.F instructions
  target-tricore: Add updfl instruction

Peer Adelt (2):
  target-tricore: Added new MOV instruction variant
  target-tricore: Added new JNE instruction variant

 target/tricore/fpu_helper.c      | 134 ++++++++++++++++++++++++++++++++++++++-
 target/tricore/helper.h          |   4 ++
 target/tricore/translate.c       |  48 ++++++++++++++
 target/tricore/tricore-opcodes.h |   3 +
 4 files changed, 188 insertions(+), 1 deletion(-)

-- 
2.11.0
