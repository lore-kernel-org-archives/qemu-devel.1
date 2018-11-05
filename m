Received: from eggs.gnu.org ([2001:4830:134:3::10]:48131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gJgUc-0005lQ-OC
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gJgUY-00023p-OF
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:08:42 -0500
From: Julio Faracco <jcfaracco@gmail.com>
Date: Mon,  5 Nov 2018 13:08:02 -0200
Message-Id: <20181105150806.13649-1-jcfaracco@gmail.com>
Subject: [Qemu-devel] [PATCH v3 0/4] Adding LZFSE compression support for
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

Since Mac OS X El Capitain (v10.11), Apple uses LZFSE compression to 
generate compressed DMGs as an alternative to BZIP2. Possible, Apple
want to keep this algorithm as default in long term. Some years ago, 
Apple opened the LZFSE algorithm to opensource and the main source (or 
the most active repo), can be found at: https://github.com/lzfse/lzfse

v1-v2: Fixing some error handlings from dmg-lzfse.c
v2-v3: Master rebasing suggestion from Stefan.

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
