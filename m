Received: from eggs.gnu.org ([2001:4830:134:3::10]:36448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHjy-0006ys-3f
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHjt-0001tk-1r
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:18 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40051)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsHjp-0001o9-QQ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 22 Aug 2018 03:14:10 +0200
Message-Id: <20180822011417.11608-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/7] Linux user for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

The following changes since commit 13b7b188501d419a7d63c016e00065bcc693b7d4:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-request' into staging (2018-08-21 15:57:56 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request

for you to fetch changes up to 259841c153698325e12f0186f349e1366616434e:

  linux-user: Propagate goto fail to return (2018-08-21 23:54:48 +0200)

----------------------------------------------------------------
This pull-request includes pre-requisite patches for the
"split do_syscall()" series. As they are clean-up, we can already
merge them.

----------------------------------------------------------------

Richard Henderson (7):
  linux-user: Remove DEBUG
  linux-user: Split out do_syscall1
  linux-user: Relax single exit from "break"
  linux-user: Propagate goto efault to return
  linux-user: Propagate goto unimplemented_nowarn to return
  linux-user: Propagate goto unimplemented to default
  linux-user: Propagate goto fail to return

 linux-user/syscall.c | 1609 +++++++++++++++++-------------------------
 1 file changed, 637 insertions(+), 972 deletions(-)

-- 
2.17.1
