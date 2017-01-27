Received: from eggs.gnu.org ([2001:4830:134:3::10]:41280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cX3Kg-0007fX-Tm
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cX3Kb-0006gW-SX
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cX3Kb-0006gK-FR
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:33 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C79C80495
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 10:00:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 27 Jan 2017 10:00:25 +0000
Message-Id: <20170127100029.11356-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] block/gluster: cleanups for GlfsPreopened
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Code added in commit 6349c15410361d3fe52c9beee309954d606f8ccd ("block/gluster:
memory usage: use one glfs instance per volume") does not follow conventions
and violates QEMU coding style.  Although any single issue in isolation is not
worth patching, there are several of these and I think it's worth resolving
them together in one sweep.

Stefan Hajnoczi (4):
  block/gluster: fix wrong indent in glfs_find_preopened()
  block/gluster: drop intermediate ListElement struct
  block/gluster: use conventional names for GlfsPreopened functions
  block/gluster: add missing QLIST_HEAD_INITIALIZER()

 block/gluster.c | 66 +++++++++++++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

-- 
2.9.3
