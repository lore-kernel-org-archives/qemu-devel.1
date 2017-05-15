Received: from eggs.gnu.org ([2001:4830:134:3::10]:60323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA9Lc-0002LU-IN
	for qemu-devel@nongnu.org; Mon, 15 May 2017 02:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA9LZ-0004D2-FX
	for qemu-devel@nongnu.org; Mon, 15 May 2017 02:19:12 -0400
Received: from [59.151.112.132] (port=40879 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA9LZ-00046a-3m
	for qemu-devel@nongnu.org; Mon, 15 May 2017 02:19:09 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Mon, 15 May 2017 14:18:19 +0800
Message-ID: <1494829102-1812-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND V2 0/3] Optimize filter-mirror and
 filter-rewriter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric Blake <eblake@redhat.com>

Fix some duplicate codes and remove unused codes.

v2: Address Eric's comment on patch 3.

Zhang Chen (3):
  net/filter-mirror.c: Remove duplicate check code.
  net/filter-mirror.c: Rename filter_mirror_send() and fix codestyle
  net/filter-rewriter: Remove unused option in filter-rewriter

 net/filter-mirror.c | 35 ++++++++++++++++-------------------
 qemu-options.hx     |  2 +-
 2 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.7.4
