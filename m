Received: from eggs.gnu.org ([2001:4830:134:3::10]:36368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eJegb-0004K4-44
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eJegV-0002b5-AO
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:08:25 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39606
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eJegU-0002UB-Ul
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:08:19 -0500
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
	by cn.fujitsu.com (Postfix) with ESMTP id 71EC9489C474
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 20:08:09 +0800 (CST)
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Tue, 28 Nov 2017 20:04:00 +0800
Message-ID: <20171128120402.22295-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] Rewrite TCP packet comparison in colo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In this series, rewrite the tcp packet comparison based on the tcp
sequence number instead of original method that compare the packet
based on the payload size.

Mao Zhongyi (2):
  colo: compare the packet based on the tcp sequence number
  colo: add trace for the tcp packet comparison

 net/colo-compare.c | 316 ++++++++++++++++++++++++++++++++++-------------------
 net/colo.c         |   9 ++
 net/colo.h         |  15 +++
 net/trace-events   |   2 +-
 4 files changed, 230 insertions(+), 112 deletions(-)

-- 
2.9.4
