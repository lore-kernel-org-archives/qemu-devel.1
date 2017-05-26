Received: from eggs.gnu.org ([2001:4830:134:3::10]:43774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dEDK2-0006G6-MO
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dEDK1-0006OR-DH
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:22:22 -0400
Received: from [59.151.112.132] (port=32520 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dEDK1-0006Nv-1o
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:22:21 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 26 May 2017 19:22:04 +0800
Message-ID: <1495797727-16695-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 0/3] COLO-compare: Make COLO-compare support
 remote COLO-frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

This series focus on COLO-proxy remote colo-frame support.
Xen COLO-frame is the first user. We add a new chardev socket
in colo-compare as the way of communicate with remote COLO-frame.
And remote COLO-frame notify colo-proxy part depend on this serise:
https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg03904.html

I will send another part of this series after depend patchset have
been merged.

V2:
 - Rename this series.
 - Change communication way to remote colo-frame.
 - Some bugfix.
 - Split the main function, anther part wait depend patchset.


Zhang Chen (3):
  COLO-compare: Add new parameter for communicate with remote colo-frame
  COLO-compare: Add remote checkpoint notify chardev socket handler
    frame
  COLO-compare: Add remote initialization and checkpoint notification

 net/colo-compare.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx    | 41 ++++++++++++++++++++----
 2 files changed, 124 insertions(+), 8 deletions(-)

-- 
2.7.4
