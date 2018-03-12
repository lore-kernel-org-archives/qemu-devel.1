Received: from eggs.gnu.org ([2001:4830:134:3::10]:45188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQjf-0006u7-Oe
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQjf-0006gf-3i
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:55:43 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 12 Mar 2018 17:55:25 +0100
Message-Id: <20180312165528.8969-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] vdi: Implement .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

I think cluster-size should not be exposed in QAPI (yet), but Kevin's
patch does that, while I had these patches lying around, so here is my
proposal.


Max Reitz (3):
  vdi: Pull option parsing from vdi_co_create
  vdi: Move file creation to vdi_co_create_opts
  vdi: Implement .bdrv_co_create

 qapi/block-core.json |  20 +++++++-
 block/vdi.c          | 139 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 132 insertions(+), 27 deletions(-)

-- 
2.14.3
