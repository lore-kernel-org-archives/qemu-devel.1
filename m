Received: from eggs.gnu.org ([2001:4830:134:3::10]:36591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eqZPb-0003OA-2Z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eqZPX-0006kq-5y
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:10:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2091 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eqZPW-0006hI-RF
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:10:51 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Tue, 27 Feb 2018 15:10:03 +0800
Message-ID: <cover.1519714706.git.jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 0/2] vhost: used_memslots limit check fixes
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

v8:
 - rebased on the master
v7:
 - rebased on the master
v2 ... v6:
 - delete the "used_memslots" global variable, and add it
   for vhost-user and vhost-kernel separately
 - refine the function, commit log
 - used_memslots refactoring

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
