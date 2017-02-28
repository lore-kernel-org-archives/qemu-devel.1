Received: from eggs.gnu.org ([2001:4830:134:3::10]:41477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLz-00006t-4p
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLu-0004ky-OD
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:49:59 -0500
Received: from [59.151.112.132] (port=36439 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLu-0004kD-AM
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:49:54 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 28 Feb 2017 18:48:19 +0800
Message-ID: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] COLO-compare: Make COLO-compare support Xen
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

This series focus on COLO Xen support.
We add a new chardev socket in colo-compare as the way
of communicate with Xen COLO-frame.
Xen part:
https://lists.xenproject.org/archives/html/xen-devel/2017-02/msg02067.html

This series is a frame, have some TODO job depend on this patch:
https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05055.html


Zhang Chen (3):
  COLO-compare: Add new parameter for communicate with Xen colo-frame
  COLO-compare: Add Xen notify chardev socket handler frame
  COLO-compare: Add colo-compare Xen notify

 net/colo-compare.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx    | 38 ++++++++++++++++++++++++---
 2 files changed, 111 insertions(+), 4 deletions(-)

-- 
2.7.4
