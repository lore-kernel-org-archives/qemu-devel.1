Received: from eggs.gnu.org ([2001:4830:134:3::10]:52744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg8Bw-0002R3-D1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg8Bq-00073F-Uq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:01:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cg8Bq-00072t-O8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:01:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 12:00:57 +0100
Message-Id: <1487674859-26249-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qapi: Improve qobject input visitor error
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com

The improvement is nice for QMP, but my real motivation is to avoid
embarrassingly horrible error messages for command line options once
we use the qobject input visitor there, as we do in "[PATCH RFC v2
0/2] block: Crude initial implementation of -blockdev".

Markus Armbruster (2):
  qapi: Clean up after commit 3d344c2
  qapi: Improve qobject input visitor error reporting

 include/qapi/visitor.h       |   6 --
 qapi/qobject-input-visitor.c | 133 +++++++++++++++++++++++++++++--------------
 2 files changed, 90 insertions(+), 49 deletions(-)

-- 
2.7.4
