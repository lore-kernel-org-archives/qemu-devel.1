Received: from eggs.gnu.org ([2001:4830:134:3::10]:50635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fiZbu-0000g2-3n
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 02:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fiZbr-0001Vd-2o
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 02:18:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55730 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fiZbq-0001Uz-U1
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 02:18:47 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 26 Jul 2018 08:18:42 +0200
Message-Id: <20180726061844.25992-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qstring: Safer qstring_from_substr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: liujunjie23@huawei.com

This is based on liujunjie's "[PATCH] qstring: Fix
qstring_from_substr() not to provoke int overflow".  I intend to get
that one into 3.0 as a bug fix.  I figure PATCH 1 should go into 3.0
as a safety measure.  I'm not sure about PATCH 2.  Please review.

Based-on: 20180724134339.17832-1-liujunjie23@huawei.com

Markus Armbruster (2):
  qstring: Assert size calculations don't overflow
  qstring: Move qstring_from_substr()'s @end one to the right

 block/blkdebug.c      |  2 +-
 block/blkverify.c     |  2 +-
 block/nbd.c           |  2 +-
 qobject/qstring.c     | 10 +++++++---
 tests/check-qobject.c |  2 +-
 tests/check-qstring.c |  2 +-
 6 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.17.1
