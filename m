Received: from eggs.gnu.org ([2001:4830:134:3::10]:44476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpwqs-00005C-Ak
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpwqr-0005MF-Hf
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:58 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 13:55:48 +0100
Message-Id: <1490014548-15083-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490014548-15083-1-git-send-email-armbru@redhat.com>
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 5/5] MAINTAINERS: Add myself for files
 I touched recently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf1aafb..3f20288 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1218,6 +1218,15 @@ M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
 F: backends/baum.c
 
+Command line option argument parsing
+M: Markus Armbruster <armbru@redhat.com>
+S: Supported
+F: include/qemu/option.h
+F: tests/test-keyval.c
+F: tests/test-qemu-opts.c
+F: util/keyval.c
+F: util/qemu-option.c
+
 Coverity model
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
@@ -1352,7 +1361,9 @@ X: include/qapi/qmp/
 F: include/qapi/qmp/dispatch.h
 F: tests/qapi-schema/
 F: tests/test-*-visitor.c
+F: tests/test-qapi-*.c
 F: tests/test-qmp-*.c
+F: tests/test-visitor-serialization.c
 F: scripts/qapi*
 F: docs/qapi*
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
-- 
2.7.4
