Received: from eggs.gnu.org ([2001:4830:134:3::10]:49078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gIBI6-0002HC-Hp
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gIBI2-0003fr-Nw
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:37:33 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43107)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gIBI0-0003dg-Qs
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:37:29 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  1 Nov 2018 12:37:10 +0100
Message-Id: <20181101113711.28074-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/1] M68k for 3.1 patches
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

The following changes since commit 7d51a855cd568ec3399a1834ada4023cfa12f231:

  Merge remote-tracking branch 'remotes/xtensa/tags/20181030-xtensa' into staging (2018-10-31 16:11:43 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-3.1-pull-request

for you to fetch changes up to b9f8e55bf7e994e192ab7360830731580384b813:

  target/m68k: use EXCP_ILLEGAL instead of EXCP_UNSUPPORTED (2018-11-01 12:12:24 +0100)

----------------------------------------------------------------
Fix illegal instruction exception number

----------------------------------------------------------------

Laurent Vivier (1):
  target/m68k: use EXCP_ILLEGAL instead of EXCP_UNSUPPORTED

 linux-user/m68k/cpu_loop.c | 1 -
 target/m68k/cpu.h          | 1 -
 target/m68k/translate.c    | 6 +++---
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.17.2
