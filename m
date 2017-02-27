Received: from eggs.gnu.org ([2001:4830:134:3::10]:44570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMU-000658-Uu
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMS-00010B-R2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:28 +0100
Message-Id: <1488194450-28056-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 02/24] tests: Fix gcov-files-test-qemu-opts-y,
 gcov-files-test-logging-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index cb97473..fdf528c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -93,7 +93,7 @@ gcov-files-check-qom-interface-y = qom/object.c
 check-unit-y += tests/check-qom-proplist$(EXESUF)
 gcov-files-check-qom-proplist-y = qom/object.c
 check-unit-y += tests/test-qemu-opts$(EXESUF)
-gcov-files-test-qemu-opts-y = qom/test-qemu-opts.c
+gcov-files-test-qemu-opts-y = util/qemu-option.c
 check-unit-y += tests/test-write-threshold$(EXESUF)
 gcov-files-test-write-threshold-y = block/write-threshold.c
 check-unit-y += tests/test-crypto-hash$(EXESUF)
@@ -118,8 +118,8 @@ check-unit-y += tests/test-crypto-ivgen$(EXESUF)
 check-unit-y += tests/test-crypto-afsplit$(EXESUF)
 check-unit-y += tests/test-crypto-xts$(EXESUF)
 check-unit-y += tests/test-crypto-block$(EXESUF)
-gcov-files-test-logging-y = tests/test-logging.c
 check-unit-y += tests/test-logging$(EXESUF)
+gcov-files-test-logging-y = util/log.c
 check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
 check-unit-y += tests/test-bufferiszero$(EXESUF)
 gcov-files-check-bufferiszero-y = util/bufferiszero.c
-- 
2.7.4
