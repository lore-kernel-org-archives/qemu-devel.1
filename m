Received: from eggs.gnu.org ([2001:4830:134:3::10]:60939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5V-0000ex-Fk
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5S-0005bN-Da
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:53 -0400
Received: from [59.151.112.132] (port=36699 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coS5R-0005ad-BX
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:52:50 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 16 Mar 2017 17:52:05 +0800
Message-ID: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

If user use -device virtio-net-pci, virtio-net driver will add a header
to raw net packet that colo-proxy can't handle it. COLO-proxy just
focus on the packet payload, so we skip the virtio-net header to compare
the sent packet that primary guest's to secondary guest's.


Zhang Chen (3):
  COLO-proxy: Add virtio-net packet parse function
  COLO-proxy: Add a tag to mark virtio-net packet
  COLO-compare: Add virtio-net packet compare support

 net/colo-compare.c    | 42 +++++++++++++++++++++++++++++++++---------
 net/colo.c            | 14 ++++++++++----
 net/colo.h            |  7 ++++++-
 net/filter-rewriter.c | 15 ++++++++++-----
 4 files changed, 59 insertions(+), 19 deletions(-)

-- 
2.7.4
