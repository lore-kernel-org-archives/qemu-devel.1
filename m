Received: from eggs.gnu.org ([2001:4830:134:3::10]:48339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fcm4V-0006ZQ-Q4
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fcm4Q-0005iw-P3
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:24:23 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fcm4Q-0005f6-FE
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:24:18 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 10 Jul 2018 08:23:49 +0200
Message-Id: <20180710062352.9843-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] Linux user for 3.0 patches
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

The following changes since commit 43a473993fd9378bf850dcafa68eb6dee8c300f8:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-07-06 18:18:08 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request

for you to fetch changes up to 84ca4fa99d7b6c83ce31e1e41300d55cb4e97dcb:

  linux-user: Report error message on stderr, rather than stdout (2018-07-09 00:52:50 +0200)

----------------------------------------------------------------
Sanitize linux-user stdout

----------------------------------------------------------------

Philippe Mathieu-Daudé (3):
  linux-user: Do not report "Unsupported syscall" by default
  linux-user: Do not report "syscall not implemented" by default
  linux-user: Report error message on stderr, rather than stdout

 linux-user/alpha/cpu_loop.c      | 2 +-
 linux-user/cris/cpu_loop.c       | 2 +-
 linux-user/cris/signal.c         | 4 ++--
 linux-user/microblaze/cpu_loop.c | 6 +++---
 linux-user/microblaze/signal.c   | 4 ++--
 linux-user/nios2/signal.c        | 2 +-
 linux-user/sh4/cpu_loop.c        | 2 +-
 linux-user/sparc/cpu_loop.c      | 2 +-
 linux-user/sparc/signal.c        | 4 ++--
 linux-user/syscall.c             | 2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.17.1
