Received: from eggs.gnu.org ([2001:4830:134:3::10]:60771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1RN-0006QJ-0M
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1RI-00068z-TE
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1db1RI-00067A-Nj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:08 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 28 Jul 2017 11:19:56 +0200
Message-Id: <20170728092000.19216-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 0/4] s390x: more fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit e01151de165070c25a1b202e9e2392950bd7c8da:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20170727-pull-request' into staging (2017-07-27 15:27:06 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170728

for you to fetch changes up to 4add0da64942d83e0564147c0876b01074bde9cb:

  s390x/css: fix bits must be zero check for TIC (2017-07-28 10:06:25 +0200)

----------------------------------------------------------------
More s390x fixes: Correct ilen, and ccw checking.

----------------------------------------------------------------

David Hildenbrand (2):
  target/s390x: fix pgm irq ilen for stsi
  target/s390x: fix pgm irq ilen in translate_pages()

Halil Pasic (2):
  s390x/css: check ccw address validity
  s390x/css: fix bits must be zero check for TIC

 hw/s390x/css.c             | 7 ++++++-
 target/s390x/misc_helper.c | 2 +-
 target/s390x/mmu_helper.c  | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.13.3
