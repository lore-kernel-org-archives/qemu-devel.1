Received: from eggs.gnu.org ([2001:4830:134:3::10]:60783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d2vFM-0007Th-VK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d2vFJ-0007sm-SA
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:50:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d2vFJ-0007sC-MA
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:50:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6312685542
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:50:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 25 Apr 2017 09:50:44 +0200
Message-Id: <1493106644-6049-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] net/dump: Issue a warning for the deprecated
 "-net dump"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

Network dumping should be done with "-object filter-dump" nowadays.
Using "-net dump" via the VLAN mechanism is considered as deprecated
and might be removed in a future release. So warn the users now
to inform them to user the filter-dump method instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dump.c b/net/dump.c
index 89a149b..442eb53 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -194,6 +194,9 @@ int net_init_dump(const Netdev *netdev, const char *name,
 
     assert(peer);
 
+    error_report("'-net dump' is deprecated. "
+                 "Please use '-object filter-dump' instead.");
+
     if (dump->has_file) {
         file = dump->file;
     } else {
-- 
1.8.3.1
