Received: from eggs.gnu.org ([2001:4830:134:3::10]:53145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cS6iW-0008FF-DL
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cS6iS-0008FK-Ad
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:36:48 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:59525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cS6iR-0008Ez-WB
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:36:44 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 13 Jan 2017 19:36:28 +0100
Message-Id: <1484332593-16782-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 0/5] Fixes for target/m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, rth@twiddle.net, Laurent Vivier <laurent@vivier.eu>

This is a series of fixes for target/m68k found:
- with RISU (bit operation with immediate)
- while debugging package build under chroot
  (gen_flush_flags() and CAS address modes)
- while I was working on the softmmu mode
  (CAS alignment and SP address modes)

v2:
- Don't align stack access on coldfire.

v3:
- Fix v2 :( that has introduced a subi instead of
  an addi

Laurent Vivier (5):
  target-m68k: fix bit operation with immediate value
  target-m68k: fix gen_flush_flags()
  target-m68k: manage pre-dec et post-inc in CAS
  target-m68k: CAS doesn't need aligned access
  target-m68k: increment/decrement with SP

 target/m68k/translate.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

-- 
2.7.4
