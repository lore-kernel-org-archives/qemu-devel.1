Received: from eggs.gnu.org ([2001:4830:134:3::10]:37894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eYwx0-0000iR-NY
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eYwwv-0004yE-Rs
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:40:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2141 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eYwwu-0004sp-Sq
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:40:29 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Wed, 10 Jan 2018 00:39:02 +0800
Message-ID: <1515515942-33692-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 0/4] vhost: two fixes and used_memslots
 refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, liuzhe13@huawei.com, jianjay.zhou@huawei.com

v4 -> v5:
  Making the followed up device_add to fall back to userspace
  virtio when netdev_add fails if vhost force flag does not set.

Jay Zhou (4):
  vhost: remove assertion to prevent crash
  tap: do not close fd if only vhost failed to initialize
  vhost: fix memslot limit check
  vhost: used_memslots refactoring

 hw/virtio/vhost-backend.c         | 15 +++++++-
 hw/virtio/vhost-user.c            | 74 +++++++++++++++++++++++++++------------
 hw/virtio/vhost.c                 | 30 +++++++++-------
 include/hw/virtio/vhost-backend.h |  6 ++--
 net/tap.c                         | 25 +++++++++----
 5 files changed, 104 insertions(+), 46 deletions(-)

--
1.8.3.1
