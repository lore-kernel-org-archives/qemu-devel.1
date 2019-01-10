Received: from eggs.gnu.org ([209.51.188.92]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghW3f-00009G-9H
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghVrG-00019O-Of
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:38:35 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:39433)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ghVrD-00018O-Hf
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:38:33 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 10 Jan 2019 09:37:35 +0100
Message-Id: <20190110083737.5036-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] Linux user for 4.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22f0:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-request' into staging (2019-01-08 16:07:32 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.0-pull-request

for you to fetch changes up to 2bd3f8998e1e7dcd9afc29fab252fb9936f9e956:

  linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0 (2019-01-10 09:36:41 +0100)

----------------------------------------------------------------
Minor linux-user update (2019-01-10)
Fixes LTP tests pwrite03 and pwrite03_64

----------------------------------------------------------------

Peter Maydell (1):
  linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0

Tom Deseyn (1):
  Add getsockopt for settable SOL_IPV6 options

 linux-user/syscall.c | 61 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

-- 
2.20.1
