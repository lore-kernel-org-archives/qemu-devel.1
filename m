Received: from eggs.gnu.org ([2001:4830:134:3::10]:56120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chAEp-0004p8-9v
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chAEl-0005An-CL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:24:23 -0500
Received: from [59.151.112.132] (port=7392 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chAEl-00059n-05
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:24:19 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 24 Feb 2017 15:22:49 +0800
Message-ID: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V9 0/2] Add new qmp commands to suppurt Xen COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>

Xen COLO depend on qemu COLO replication function.
So, We need new qmp commands for Xen to use qemu replication.

Corresponding libxl patches already in xen.git.
Commit ID:

ed37ef1f91c20f0ab162ce60f8c38400b917fa64
COLO: introduce new API to prepare/start/do/get_error/stop replication

a0ddc0b359375b2418213966dfbdbfab593ecc6f
tools/libxl: introduction of libxl__qmp_restore to load qemu state


Zhang Chen (2):
  Add a new qmp command to start/stop replication
  Add a new qmp command to do checkpoint, query xen replication status

 migration/colo.c | 49 +++++++++++++++++++++++++++++++++++++
 qapi-schema.json | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

-- 
2.7.4
