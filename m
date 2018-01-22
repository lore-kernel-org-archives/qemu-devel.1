Received: from eggs.gnu.org ([2001:4830:134:3::10]:60744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1edW4k-0006pG-5r
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1edW4f-0001ry-Bb
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:59:26 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2310 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1edW4f-0001oC-0r
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:59:21 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Mon, 22 Jan 2018 14:57:48 +0800
Message-ID: <cover.1516527761.git.jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 0/2] vhost: used_memslots limit check fixes
 and refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, jianjay.zhou@huawei.com, liuzhe13@huawei.com

v6 -> v7:
  rebase on the master

Jay Zhou (2):
  vhost: fix memslot limit check
  vhost: used_memslots refactoring

 hw/virtio/vhost-backend.c         | 15 +++++++-
 hw/virtio/vhost-user.c            | 77 ++++++++++++++++++++++++++-------------
 hw/virtio/vhost.c                 | 30 ++++++++-------
 include/hw/virtio/vhost-backend.h |  6 ++-
 4 files changed, 86 insertions(+), 42 deletions(-)

--
1.8.3.1
