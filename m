Received: from eggs.gnu.org ([2001:4830:134:3::10]:43457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNta-0008OX-LP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNtV-0004lV-Q2
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:47:14 -0500
Received: from [45.249.212.187] (port=2979 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNtV-0004kF-DN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:47:09 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 22 Feb 2017 11:46:35 +0800
Message-ID: <1487735198-127300-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/3] filter-rewriter: fix two bugs and one
 optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

Hi,

Patch 1 fixes a double free bug, and patch 2 fixes a memory leak bug.
Patch 3 is an optimization for filter-rewriter.

Please review, thanks.

zhanghailiang (3):
  net/colo: fix memory double free error
  filter-rewriter: fix memory leak for connection in
    connection_track_table
  filter-rewriter: skip net_checksum_calculate() while offset = 0

 net/colo.c            |  4 +--
 net/colo.h            |  4 +++
 net/filter-rewriter.c | 86 +++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 79 insertions(+), 15 deletions(-)

-- 
1.8.3.1
