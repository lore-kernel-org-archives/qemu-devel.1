Received: from eggs.gnu.org ([2001:4830:134:3::10]:51371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cP1Fl-0003ae-8p
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 01:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cP1Fg-0000gI-A5
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 01:10:21 -0500
Received: from [59.151.112.132] (port=43125 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cP1Ff-0000TG-UQ
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 01:10:16 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 5 Jan 2017 14:08:50 +0800
Message-ID: <1483596532-14552-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V6 0/2] Add new qmp commands to suppurt Xen COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Bian Naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>

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

 docs/qmp-commands.txt | 42 +++++++++++++++++++++++++++++++
 migration/colo.c      | 40 +++++++++++++++++++++++++++++
 qapi-schema.json      | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

-- 
2.7.4
