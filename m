Received: from eggs.gnu.org ([2001:4830:134:3::10]:57776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cW1kE-0004fc-Sy
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cW1kC-0004mS-8G
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:06:46 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:58339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cW1kB-0004lw-LK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:06:44 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Tue, 24 Jan 2017 22:05:45 +0800
Message-ID: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] colo-compare: Preparing work for combining
 with COLO frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, eddie.dong@intel.com, Xu Quan <xuquan8@huawei.com>

Hi,

This series is some preparing works for integrating colo-compare into COLO
frame.

It is based on patch '[PATCH] colo-compare: sort TCP packet queue by sequence number'
http://patchwork.ozlabs.org/patch/718955/ 

Please review and any commits are welcomed.

Cc: Juan Quintela <quintela@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Dr. David Alan Gilbert (git) <dgilbert@redhat.com>
Cc: eddie.dong@intel.com
Cc: Xu Quan <xuquan8@huawei.com>


Zhang Chen (1):
  colo-compare: add API to flush all queued packets while do checkpoint

zhanghailiang (2):
  colo-compare: reconstruct the mutex lock usage
  colo-compare: use notifier to notify inconsistent packets comparing

 net/colo-compare.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++------
 net/colo-compare.h |  22 +++++++++++
 net/colo.c         |   2 +
 net/colo.h         |   2 +
 4 files changed, 119 insertions(+), 12 deletions(-)
 create mode 100644 net/colo-compare.h

-- 
1.8.3.1
