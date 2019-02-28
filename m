Received: from eggs.gnu.org ([209.51.188.92]:36189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaV-000685-PS
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaU-0003dT-BU
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:15 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:52030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaU-0003Mt-1S
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:14 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 28 Feb 2019 17:34:35 +0000
Message-ID: <20190228173439.8013-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 0/4] xen queue 2019-02-28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 711d13d5e2e160c1c3bcbd302af6df3980a99469:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-feb-27-2019' into staging (2019-02-28 12:59:49 +0000)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190228

for you to fetch changes up to 156ac94463b42b0b9beea263af9866dfcd3683e0:

  xen-block: stop leaking memory in xen_block_drive_create() (2019-02-28 17:21:12 +0000)

----------------------------------------------------------------
Xen queue

* xen-block fixes

----------------------------------------------------------------
Paul Durrant (4):
      dataplane/xen-block: remove dead code
      xen-block: remove redundant assignment
      xen-block: report error condition from vbd_name_to_disk()
      xen-block: stop leaking memory in xen_block_drive_create()

 hw/block/dataplane/xen-block.c |  5 +----
 hw/block/xen-block.c           | 40 +++++++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 19 deletions(-)
