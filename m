Received: from eggs.gnu.org ([2001:4830:134:3::10]:56861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ciaCR-0007Ri-Ks
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ciaCO-0002ev-G2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:19:47 -0500
Received: from [59.151.112.132] (port=24133 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ciaCO-0002eU-1r
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:19:44 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 28 Feb 2017 13:18:07 +0800
Message-ID: <1488259090-30034-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 0/3] COLO-compare: Optimize the code and fix
 some bug
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

This series we will Optimize the code and fix some bug.
Patch1: Rename colo_packet_compare() and remove duplicate check in compare icmp.
Patch2: Optimize compare_common and increase compare performance.
Patch3: Fix debug info always print bug.


Zhang Chen (3):
  COLO-compare: Rename compare function and remove duplicate codes
  COLO-compare: Optimize compare_common and compare_tcp
  COLO-compare: Fix icmp and udp compare different packet always dump
    bug

 net/colo-compare.c | 66 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

-- 
2.7.4
