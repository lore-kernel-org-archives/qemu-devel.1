Received: from eggs.gnu.org ([2001:4830:134:3::10]:36037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5qwu-0004bn-RI
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5qws-0007Z5-9k
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:56:28 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f5qwr-0007Y9-Vr
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:56:26 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 10 Apr 2018 12:56:04 +0200
Message-Id: <20180410105606.16413-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/2] linux-user fixes for -rc3
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

The following changes since commit 1e7e92e2ef874aa3a235d59b2be1da7a29b6fd29:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180409' into staging (2018-04-09 18:21:23 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request

for you to fetch changes up to f5d29f9074c4cd62dfb7b229b9ad208639217a35:

  linux-user: add microblaze/microblazeel magic numbers in qemu-binfmt-conf.sh (2018-04-10 12:18:40 +0200)

----------------------------------------------------------------
Trivial fixes for microblaze
----------------------------------------------------------------

Laurent Vivier (2):
  linux-user: fix microblaze get_sp_from_cpustate()
  linux-user: add microblaze/microblazeel magic numbers in
    qemu-binfmt-conf.sh

 linux-user/microblaze/target_signal.h |  2 +-
 scripts/qemu-binfmt-conf.sh           | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.14.3
