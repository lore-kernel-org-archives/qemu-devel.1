Received: from eggs.gnu.org ([2001:4830:134:3::10]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fqInj-0006AB-Hp
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fqInb-0000AU-8M
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:58:56 -0400
From: Julio Faracco <jcfaracco@gmail.com>
Date: Thu, 16 Aug 2018 10:58:33 -0300
Message-Id: <20180816135837.13149-1-jcfaracco@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/4] Adding LZFSE compression support for
 DMG block driver.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Since Mac OS X El Capitain (v10.11), Apple uses LZFSE compression to 
generate compressed DMGs as an alternative to BZIP2. Possible, Apple
want to keep this algorithm as default in long term. Some years ago, 
Apple opened the LZFSE algorithm to opensource and the main source (or 
the most active repo), can be found at: https://github.com/lzfse/lzfse

Julio Faracco (4):
  block: adding lzfse decompressing support as a module.
  configure: adding support to lzfse library.
  dmg: including dmg-lzfse module inside dmg block driver.
  dmg: exchanging hardcoded dmg UDIF block types to enum.

 block/Makefile.objs |  2 ++
 block/dmg-lzfse.c   | 49 ++++++++++++++++++++++++++++++++++
 block/dmg.c         | 65 ++++++++++++++++++++++++++++++++++++---------
 block/dmg.h         |  3 +++
 configure           | 31 +++++++++++++++++++++
 5 files changed, 138 insertions(+), 12 deletions(-)
 create mode 100644 block/dmg-lzfse.c

-- 
2.17.1
