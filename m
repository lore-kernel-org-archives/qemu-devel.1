Received: from eggs.gnu.org ([2001:4830:134:3::10]:36309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePWVO-0000Ux-BU
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePWVL-0001xX-6k
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:37:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePWVK-0001t2-RL
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:37:03 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 15 Dec 2017 00:36:30 +0800
Message-ID: <1513269392-23224-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] vhost: two fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: weidong.huang@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, gary.liuzhe@huawei.com

Jay Zhou (2):
  vhost: add used memslot number for vhost-user
  vhost: double check memslot number

 hw/virtio/vhost-user.c            | 31 +++++++++++++++++++++++++
 hw/virtio/vhost.c                 | 49 ++++++++++++++++++++++++++++++++++-----
 include/hw/virtio/vhost-backend.h |  4 ++++
 3 files changed, 78 insertions(+), 6 deletions(-)

-- 
1.8.3.1
