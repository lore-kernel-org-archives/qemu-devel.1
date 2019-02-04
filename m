Received: from eggs.gnu.org ([209.51.188.92]:52203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqcQb-00066w-Pb
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqcQY-0007IJ-0Y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:28:39 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:14928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqcQS-00076s-Hk
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:28:34 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Mon, 4 Feb 2019 11:27:59 +0000
Message-ID: <20190204112803.11645-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/4] Xen queue 20190204
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

The following changes since commit b3fc0af1ff5e922d4dd7c875394dbd26dc7313b4:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-02-01 17:58:27 +0000)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190204

for you to fetch changes up to 3149f183d7ca448b1dc30fe3d4acb9e367de01bf:

  xen-block: handle resize callback (2019-02-04 11:04:49 +0000)

----------------------------------------------------------------
Xen queue

* xen-block, the Xen PV backend, now handles resize.
* configure cleanup.
* xen-bus fix.

----------------------------------------------------------------
Anthony PERARD (2):
      configure: xen: Stop build-testing for xc_domain_create
      configure: Don't add Xen's libs to LDFLAGS

Paul Durrant (2):
      xen: fix xen-bus state model to allow frontend re-connection
      xen-block: handle resize callback

 configure                      | 20 --------------------
 hw/block/dataplane/xen-block.c |  4 +---
 hw/block/trace-events          |  1 +
 hw/block/xen-block.c           | 40 ++++++++++++++++++++++++++++++++++++----
 hw/xen/xen-bus.c               | 32 +++++++++++++++++++-------------
 5 files changed, 57 insertions(+), 40 deletions(-)
