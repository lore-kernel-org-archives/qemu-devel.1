Received: from eggs.gnu.org ([2001:4830:134:3::10]:55066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwY-0005cr-HP
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwX-0001Im-E2
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:14 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwX-0001IQ-7k
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:13 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:42 +0200
Message-Id: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 00/26] target/s390x: fix,
 improve and implement some more instructions
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

This patchset tries to improve the s390x emulation by fixing and
improving some instructions. It implement some more instructions, from
the zArchitecture base or from the Extended-Translation Facility 2. The 
last patch updates the maximum TCG CPU to z800, as the ETF2 and Long-Displacement
Facility are now both fully implemented.

This patch series is based on the s390x unwind patches from Richard
Henderson. It trivally conflicts with the EXECUTE and cpu_models 
patches, but I got bored of rebasing my patches. Given the involved
patches, it's very likely that I will need to respin them, so I'll
fix the conflicts at that time, depending in which orders the other
series are going in.

Aurelien Jarno (26):
  target/s390x: remove dead code in translate.c
  target/s390x: make IPTE SMP aware
  target/s390x: implement TEST AND SET
  target/s390x: implement TEST ADDRESSING MODE
  target/s390x: implement PACK
  target/s390x: implement LOAD PAIR FROM QUADWORD
  target/s390x: implement STORE PAIR TO QUADWORD
  target/s390x: implement MOVE INVERSE
  target/s390x: implement MOVE NUMERICS
  target/s390x: implement MOVE WITH OFFSET
  target/s390x: implement MOVE ZONES
  target/s390x: improve 24-bit and 31-bit addresses read
  target/s390x: improve 24-bit and 31-bit addresses write
  target/s390x: improve 24-bit and 31-bit lengths read/write
  target/s390x: fix COMPARE LOGICAL LONG EXTENDED
  target/s390x: implement COMPARE LOGICAL LONG
  target/s390x: improve MOVE LONG and MOVE LONG EXTENDED
  target/s390x: implement COMPARE LOGICAL LONG UNICODE
  target/s390x: implement MOVE LONG UNICODE
  target/s390x: implement PACK ASCII
  target/s390x: implement PACK UNICODE
  target/s390x: implement UNPACK ASCII
  target/s390x: implement UNPACK UNICODE
  target/s390x: implement TEST DECIMAL
  target/s390x: implement TRANSLATE ONE/TWO TO ONE/TWO
  target/s390x: update maximum TCG model to z800

 target/s390x/cpu_models.c  |   4 +-
 target/s390x/helper.h      |  14 +
 target/s390x/insn-data.def |  51 ++++
 target/s390x/mem_helper.c  | 724 +++++++++++++++++++++++++++++++++++++--------
 target/s390x/misc_helper.c |   4 +-
 target/s390x/translate.c   | 223 +++++++++++++-
 6 files changed, 889 insertions(+), 131 deletions(-)

-- 
2.11.0
