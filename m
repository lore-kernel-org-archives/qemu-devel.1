Received: from eggs.gnu.org ([2001:4830:134:3::10]:52193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpzwM-0000Dt-Lb
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpzwJ-0004l9-F2
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cpzwJ-0004kn-9a
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:13:47 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 17:13:42 +0100
Message-Id: <1490026424-11330-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/2] Fix string input visitor and "info
 memdev" regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Markus Armbruster (2):
  qapi: Fix string input visitor regression for empty lists
  Revert "hostmem: fix QEMU crash by 'info memdev'"

 backends/hostmem.c                | 22 ++++++++--------------
 qapi/string-input-visitor.c       |  4 ++++
 tests/test-string-input-visitor.c | 11 ++++++++---
 3 files changed, 20 insertions(+), 17 deletions(-)

-- 
2.7.4
