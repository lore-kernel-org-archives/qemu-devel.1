Received: from eggs.gnu.org ([2001:4830:134:3::10]:43502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciYsI-0005ey-Ca
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciYsF-0004Cm-B9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:54 -0500
Received: from [45.249.212.188] (port=2944 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciYsF-0004B6-0c
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:51 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Tue, 28 Feb 2017 11:54:17 +0800
Message-ID: <1488254059-22716-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/2] filter-rewriter: fix one bug and one
 improvement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>

Hi,

Patch 1 fixes a double free bug.
Patch 2 is an optimization for filter-rewriter.

Please review, thanks.


zhanghailiang (2):
  net/colo: fix memory double free error
  filter-rewriter: skip net_checksum_calculate() while offset = 0

 net/colo.c            |  4 ++--
 net/filter-rewriter.c | 17 +++++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

-- 
1.8.3.1
