Received: from eggs.gnu.org ([2001:4830:134:3::10]:44610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVcXI-0004HV-6r
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVcXF-0006Q9-4E
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:48:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVcXE-0006Q4-W0
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:48:29 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Jun 2018 14:48:27 +0200
Message-Id: <20180620124827.17106-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Update QAPI stanza for commit
 fb0bc835e56
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Commit fb0bc835e56 moved code from scripts/qapi-*.py to
scripts/qapi/*.py.  It neglected to update MAINTAINERS: scripts/qapi*
matches only the former, not the latter.  Do that now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index da91501c7a..7fa5c51a98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1615,7 +1615,8 @@ F: tests/test-*-visitor.c
 F: tests/test-qapi-*.c
 F: tests/test-qmp-*.c
 F: tests/test-visitor-serialization.c
-F: scripts/qapi*
+F: scripts/qapi-gen.py
+F: scripts/qapi/*
 F: docs/devel/qapi*
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
 
-- 
2.17.1
