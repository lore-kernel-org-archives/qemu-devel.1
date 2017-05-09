Received: from eggs.gnu.org ([2001:4830:134:3::10]:49295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d80V5-0002fm-Rj
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d80V5-00005H-2Y
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:28:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d80V4-00004y-ST
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:28:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  9 May 2017 10:27:57 +0200
Message-Id: <20170509082800.10756-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 0/3] target/s390x: misc patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

Those are just random patches I have written while trying to get a MTTCG
version of qemu/s390x. I just send them to avoid duplicated work.

Aurelien Jarno (3):
  target/s390x: mask the SIGP order_code using SIGP_ORDER_MASK
  target/s390x: fix SIGNAL PROCESSOR return value
  target/s390x: implement serialization in BRANCH CONDITION

 target/s390x/cpu.h         |  3 +++
 target/s390x/kvm.c         |  2 --
 target/s390x/misc_helper.c |  3 +--
 target/s390x/translate.c   | 16 ++++++++++++++++
 4 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.11.0
