Received: from eggs.gnu.org ([209.51.188.92]:42145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCp0-00040l-RO
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCp0-0004Q3-5m
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:43:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1goCp0-0004Pu-03
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:43:54 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 28 Jan 2019 17:43:49 -0200
Message-Id: <20190128194351.14679-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Machine queue, 2019-01-28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

The following changes since commit 5f39a91dbd9a186edb999afd4d17524f4b1da14f:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-01-28 12:54:06 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 21d1683690e048663855dd6feb3034ab7c5039bc:

  hostmem: add more information in error messages (2019-01-28 15:52:05 -0200)

----------------------------------------------------------------
Machine queue, 2019-01-28

* Fix small leak on NUMA code
* Improve memory backend error messages

----------------------------------------------------------------

Queue for Machine Core patches


Zhang Yi (2):
  numa: Fixed the memory leak of numa error message
  hostmem: add more information in error messages

 backends/hostmem-file.c | 6 ++++--
 backends/hostmem.c      | 8 +++++---
 numa.c                  | 1 +
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
