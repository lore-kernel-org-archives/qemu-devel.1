Received: from eggs.gnu.org ([2001:4830:134:3::10]:49940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzo3-0004ny-3U
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzo0-0005GQ-15
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dCznz-0005GI-Qr
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:15 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 May 2017 10:43:52 +0800
Message-Id: <1495507439-1784-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
References: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] net/dump: Issue a warning for the
 deprecated "-net dump"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Network dumping should be done with "-object filter-dump" nowadays.
Using "-net dump" via the VLAN mechanism is considered as deprecated
and might be removed in a future release. So warn the users now
to inform them to user the filter-dump method instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
2.7.4
