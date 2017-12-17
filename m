Received: from eggs.gnu.org ([2001:4830:134:3::10]:59850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1eQVvX-0006gj-Pg
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 05:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1eQVvU-0006d7-Hv
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 05:12:11 -0500
From: Stefan Weil <sw@weilnetz.de>
Date: Sun, 17 Dec 2017 11:11:36 +0100
Message-Id: <20171217101136.20206-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] s390x: Add missing QEMU_NORETURN attribute
 (CID 1383842)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

This should fix the Coverity warning:

** CID 1383842:  Integer handling issues  (DIVIDE_BY_ZERO)
/target/s390x/int_helper.c: 84 in helper_divs64()

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 target/s390x/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 1a8b6b9ae9..2a6e75d697 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -746,8 +746,8 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
 #define RA_IGNORED                  0
-void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
-                            uintptr_t ra);
+void QEMU_NORETURN s390_program_interrupt(CPUS390XState *env, uint32_t code,
+                                          int ilen, uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
 void s390_sclp_extint(uint32_t parm);
 
-- 
2.11.0
