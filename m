Received: from eggs.gnu.org ([2001:4830:134:3::10]:41387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZpPC-0007wi-G7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 21:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZpP9-0001CT-9Q
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 21:49:18 -0500
Received: from [45.249.212.35] (port=45659 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eZpP8-00015W-TV
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 21:49:15 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 12 Jan 2018 10:47:56 +0800
Message-ID: <cover.1515724314.git.jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 0/3] vhost: two fixes and used_memslots
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
Cc: mst@redhat.com, imammedo@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, jianjay.zhou@huawei.com, liuzhe13@huawei.com

Jay Zhou (3):
  vhost: remove assertion to prevent crash
  vhost: fix memslot limit check
  vhost: used_memslots refactoring

 hw/virtio/vhost-backend.c         | 15 +++++++-
 hw/virtio/vhost-user.c            | 74 +++++++++++++++++++++++++++------------
 hw/virtio/vhost.c                 | 30 +++++++++-------
 include/hw/virtio/vhost-backend.h |  6 ++--
 4 files changed, 86 insertions(+), 39 deletions(-)

--
1.8.3.1
