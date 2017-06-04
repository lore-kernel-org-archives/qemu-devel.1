Received: from eggs.gnu.org ([2001:4830:134:3::10]:52647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dHc0x-00033X-Mj
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 16:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dHc0w-0004Qf-UQ
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 16:20:43 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dHc0w-0004NH-OS
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 16:20:42 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun,  4 Jun 2017 22:20:31 +0200
Message-Id: <20170604202034.16615-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v4 0/3] target/s390x: implement loads/store
 quadword
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

This patchset implements the LOAD PAIR FROM QUADWORD and STORE PAIR TO
QUADWORD instructions. The corresponding patches have been in my previous
patchset and the pull request from Richard, but they failed to build on a
host without atomic128 support.

This new version fixes that. It has to be applied over the pull request
as it makes uses of the check_alignment function.

Finally the latest patch fixes a lack of alignement check in CDSG,
discovered as I used it as an example about how to properly handle hosts
without atomic128 support.

Aurelien Jarno (3):
  target/s390x: implement LOAD PAIR FROM QUADWORD
  target/s390x: implement STORE PAIR TO QUADWORD
  target/s390x: check alignment in CDSG in the !CONFIG_ATOMIC128 case

 target/s390x/helper.h      |  2 ++
 target/s390x/insn-data.def |  4 ++++
 target/s390x/mem_helper.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   | 13 ++++++++++++
 4 files changed, 72 insertions(+)

-- 
2.11.0
