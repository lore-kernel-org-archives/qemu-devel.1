Received: from eggs.gnu.org ([2001:4830:134:3::10]:43569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f7eFG-0000ii-OZ
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 05:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f7eFD-0007Mf-Ld
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 05:46:50 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f7eFD-0007Kj-CX
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 05:46:47 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 15 Apr 2018 11:46:37 +0200
Message-Id: <20180415094638.3278-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/1] m68k fixes for 2.12-rc4
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

The following changes since commit 38e83a71d02e026d4a6d0ab1ef9855c4924c2c68:

  Update version for v2.12.0-rc3 release (2018-04-11 19:03:24 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request

for you to fetch changes up to 000761dc0c97d70e7314db3e8f52783880325a22:

  m68k: fix exception stack frame for 68000 (2018-04-15 11:37:58 +0200)

----------------------------------------------------------------
This patch fixes a problem with the exception stack for
68000 only CPU. As we use 68040 for linux-user and coldfire
for softmmu, I don't think we should trigger a -rc4
only for that, so merge this only if a -rc4 is needed
by something else.
----------------------------------------------------------------

Pavel Dovgalyuk (1):
  m68k: fix exception stack frame for 68000

 target/m68k/op_helper.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

-- 
2.14.3
