Received: from eggs.gnu.org ([2001:4830:134:3::10]:54064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAoPD-0002Ow-Iu
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAoPB-0005wr-K6
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:09:39 -0400
Received: from [59.151.112.132] (port=3753 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAoPB-0005vg-8E
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:09:37 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 17 May 2017 10:09:37 +0800
Message-ID: <1494986980-11277-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 0/3] Optimize filter-mirror and
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

v3:
 - Remove the ',' in patch 3/3

v2:
 - Address Eric's comment fix typo and keep a long lien on patch 3.

Zhang Chen (3):
  net/filter-mirror.c: Remove duplicate check code.
  net/filter-mirror.c: Rename filter_mirror_send() and fix codestyle
  net/filter-rewriter: Remove unused option in filter-rewriter

 net/filter-mirror.c | 35 ++++++++++++++++-------------------
 qemu-options.hx     |  2 +-
 2 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.7.4
