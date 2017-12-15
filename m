Received: from eggs.gnu.org ([2001:4830:134:3::10]:47162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePldQ-0003iN-6P
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePldN-0003IC-39
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:46:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2053 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ePldM-00039t-P6
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:46:21 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 15 Dec 2017 16:45:53 +0800
Message-ID: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/2] vhost: two fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: weidong.huang@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, gary.liuzhe@huawei.com, dgilbert@redhat.com, imammedo@redhat.com

v1 -> v2:
  * delete the "used_memslots" global variable, and add it
    for vhost-user and vhost-kernel separately

Jay Zhou (2):
  vhost: add used memslot number for vhost-user and vhost-kernel    
    separately
  vhost: double check used memslots number

 hw/virtio/vhost-backend.c         | 14 ++++++++++++++
 hw/virtio/vhost-user.c            | 31 +++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 | 39 ++++++++++++++++++++++++++++++---------
 include/hw/virtio/vhost-backend.h |  4 ++++
 4 files changed, 79 insertions(+), 9 deletions(-)

-- 
1.8.3.1
