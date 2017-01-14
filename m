Received: from eggs.gnu.org ([2001:4830:134:3::10]:50412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cSKJl-00032V-3h
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 04:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cSKJh-000314-3s
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 04:08:09 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:54074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cSKJg-0002zK-Qr
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 04:08:05 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 14 Jan 2017 10:07:49 +0100
Message-Id: <1484384878-29179-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 0/9] M68k for 2.9 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

The following changes since commit b6af8ea60282df514f87d32e36afd1c9aeee28c8:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-01-13 14:38:21 +0000)

are available in the git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.9-pull-request

for you to fetch changes up to 727d937b59f1f722f983e20f9cd23b0e7ef60165:

  target-m68k: increment/decrement with SP (2017-01-14 10:06:21 +0100)

----------------------------------------------------------------
This is the list of the remaining patches that was part of series 
reviewed during the freeze period. They use the new new deposit
and extract ops.
There is also a cleanup patch from Thomas.

The v2 includes various fixes I've sent and that have been reviewed
since the first pull request.
----------------------------------------------------------------

Laurent Vivier (5):
  target-m68k: fix bit operation with immediate value
  target-m68k: fix gen_flush_flags()
  target-m68k: manage pre-dec et post-inc in CAS
  target-m68k: CAS doesn't need aligned access
  target-m68k: increment/decrement with SP

Richard Henderson (3):
  target-m68k: Implement bitfield ops for registers
  target-m68k: Implement bitfield ops for memory
  target-m68k: Implement bfffo

Thomas Huth (1):
  m68k: Remove PCI and USB from config file

 default-configs/m68k-softmmu.mak |   2 -
 target/m68k/cpu.h                |   1 +
 target/m68k/helper.h             |  10 +
 target/m68k/op_helper.c          | 206 +++++++++++++++++++
 target/m68k/translate.c          | 427 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 636 insertions(+), 10 deletions(-)

-- 
2.7.4
