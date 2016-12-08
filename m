Received: from eggs.gnu.org ([2001:4830:134:3::10]:39658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cEtbu-0001s8-Qu
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cEtbu-0007On-6p
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:59:22 -0500
Received: from [59.151.112.132] (port=7487 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cEtbt-00074l-Hl
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:59:22 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 8 Dec 2016 15:55:13 +0800
Message-ID: <1481183716-7342-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 V2 0/3] Add new qmp commands to suppurt
 Xen COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>

Xen COLO depend on qemu COLO replication function.
So, We need new qmp commands for Xen to use qemu replication.

Corresponding libxl patches already in xen.git.
Commit ID:

ed37ef1f91c20f0ab162ce60f8c38400b917fa64
COLO: introduce new API to prepare/start/do/get_error/stop replication

a0ddc0b359375b2418213966dfbdbfab593ecc6f
tools/libxl: introduction of libxl__qmp_restore to load qemu state


Zhang Chen (3):
  Migration: Don't load vmdesc when xen is enabled
  Add a new qmp command to start/stop replication
  Add a new qmp command to do checkpoint, get replication error

 docs/qmp-commands.txt | 41 +++++++++++++++++++++++++++++++++++++++++
 migration/colo.c      | 32 ++++++++++++++++++++++++++++++++
 migration/savevm.c    |  4 ++++
 qapi-schema.json      | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

-- 
2.7.4
