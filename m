Received: from eggs.gnu.org ([2001:4830:134:3::10]:49388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOG4-0007Sx-4v
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOG0-0005GX-6r
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:28 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:43681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1faOFz-0005G3-Se
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:24 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  3 Jul 2018 18:34:44 +0200
Message-Id: <20180703163451.16936-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/7] Linux user for 3.0 patches
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

The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c656:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into staging (2018-07-02 17:57:46 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request

for you to fetch changes up to 377e93e9e85e76c7fd7af900ba965743243a6618:

  linux-user/strace: Improve recvmsg() output (2018-07-03 16:27:15 +0200)

----------------------------------------------------------------
Some strace cleanups
Minor fixes for setsockopt() and netlink
Manage 'F' flag with qemu-binfmt-conf.sh

----------------------------------------------------------------

Laurent Vivier (5):
  qemu-binfmt-conf.sh: cleanup --credential
  qemu-binfmt-conf.sh: add persistent (F) flags
  qemu-binfmt-conf.sh: allow to provide a suffix to the interpreter name
  linux-user: add netlink CARRIER_UP_COUNT/CARRIER_DOWN_COUNT
  linux-user: update do_setsockopt()

Philippe Mathieu-Daudé (2):
  linux-user/strace: Improve capget()/capset() output
  linux-user/strace: Improve recvmsg() output

 linux-user/strace.list      |  6 ++--
 linux-user/syscall.c        |  4 +++
 scripts/qemu-binfmt-conf.sh | 64 ++++++++++++++++++++++++-------------
 3 files changed, 48 insertions(+), 26 deletions(-)

-- 
2.17.1
