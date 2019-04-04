Received: from eggs.gnu.org ([209.51.188.92]:53603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=99015e4a8=anthony.perard@citrix.com>)
	id 1hC5q0-0005ui-Dy
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=99015e4a8=anthony.perard@citrix.com>)
	id 1hC5pz-0002OI-CP
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:07:40 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:38283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=99015e4a8=anthony.perard@citrix.com>)
	id 1hC5py-00028D-LA
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:07:39 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 4 Apr 2019 18:07:20 +0100
Message-ID: <20190404170722.4492-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 0/2] xen queue for 4.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>

The following changes since commit f4b37171378b0b1782570060c3411a504375d1bc:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190403' into staging (2019-04-03 13:13:30 +0100)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190404

for you to fetch changes up to 2bcd05cf24a7de34e7e265247c010977e43f40bc:

  xen-block: scale sector based quantities correctly (2019-04-04 18:00:07 +0100)

----------------------------------------------------------------
Xen queue

xen-block fixes

----------------------------------------------------------------
Paul Durrant (2):
      xen-block: only advertize discard to the frontend when it is enabled...
      xen-block: scale sector based quantities correctly

 hw/block/dataplane/xen-block.c | 28 +++++++++++++---------------
 hw/block/xen-block.c           | 22 +++++++++++++++++-----
 hw/block/xen_blkif.h           |  2 ++
 3 files changed, 32 insertions(+), 20 deletions(-)
