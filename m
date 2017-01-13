Received: from eggs.gnu.org ([2001:4830:134:3::10]:35210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cS1LE-00063l-5z
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cS1LB-0002P6-2O
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:24 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:59845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cS1LA-0002On-OW
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:21 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 13 Jan 2017 13:51:58 +0100
Message-Id: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 0/5] Fixes for target/m68k
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
