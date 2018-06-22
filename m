Received: from eggs.gnu.org ([2001:4830:134:3::10]:56716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO38-0000pu-D2
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO35-0000In-Mf
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWO35-0000IQ-IZ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32F38402333A
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:32:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-237.ams2.redhat.com
	[10.36.117.237])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FD3111166E8
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:32:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 22 Jun 2018 17:32:28 +0200
Message-Id: <20180622153228.23594-11-armbru@redhat.com>
In-Reply-To: <20180622153228.23594-1-armbru@redhat.com>
References: <20180622153228.23594-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] MAINTAINERS: Update QAPI stanza for
 commit fb0bc835e56
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit fb0bc835e56 moved code from scripts/qapi-*.py to
scripts/qapi/*.py.  It neglected to update MAINTAINERS: scripts/qapi*
matches only the former, not the latter.  Do that now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180620124827.17106-1-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f222bf8b16..8270863f3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1623,7 +1623,8 @@ F: tests/test-*-visitor.c
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
