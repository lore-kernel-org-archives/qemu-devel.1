Received: from eggs.gnu.org ([2001:4830:134:3::10]:54646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zVn-0004mo-At
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zVk-0007An-5P
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:36:55 -0400
Received: from [59.151.112.132] (port=25371 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zVj-00074l-Oc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:36:52 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:35:52 +0800
Message-ID: <1494552955-30529-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] Optimize filter-mirror and filter-rewriter
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

Fix some duplicate codes and remove unused codes.

Zhang Chen (3):
  net/filter-mirror.c: Remove duplicate check code.
  net/filter-mirror.c: Rename filter_mirror_send() and fix codestyle
  net/filter-rewriter: Remove unused option in filter-rewirter

 net/filter-mirror.c | 35 ++++++++++++++++-------------------
 qemu-options.hx     |  3 ++-
 2 files changed, 18 insertions(+), 20 deletions(-)

-- 
2.7.4
