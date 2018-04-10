Received: from eggs.gnu.org ([2001:4830:134:3::10]:36334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5vin-0007rY-8A
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5vim-0002Lg-Hl
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:02:13 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f5vim-0002JT-6e
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:02:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 10 Apr 2018 18:01:39 +0200
Message-Id: <20180410160142.21096-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 0/3] linux-user fixes for -rc3
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

The following changes since commit df6378eb0e6cfd58a22a1c3ff8fa4a9039f1eaa8:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180410-pull-request' into staging (2018-04-10 14:04:27 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request

for you to fetch changes up to 46a1ee4f397ffd305da95fb65dc73be49667ff6d:

  linux-user: implement HWCAP bits on MIPS (2018-04-10 18:00:14 +0200)

----------------------------------------------------------------
Trivial fixes for microblaze
v2: add HWCAP bits on MIPS
----------------------------------------------------------------

James Cowgill (1):
  linux-user: implement HWCAP bits on MIPS

Laurent Vivier (2):
  linux-user: fix microblaze get_sp_from_cpustate()
  linux-user: add microblaze/microblazeel magic numbers in
    qemu-binfmt-conf.sh

 linux-user/elfload.c                  | 24 ++++++++++++++++++++++++
 linux-user/microblaze/target_signal.h |  2 +-
 scripts/qemu-binfmt-conf.sh           | 12 ++++++++++--
 3 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.14.3
