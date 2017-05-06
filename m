Received: from eggs.gnu.org ([2001:4830:134:3::10]:38433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6z3S-0004K8-M9
	for qemu-devel@nongnu.org; Sat, 06 May 2017 08:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6z3R-0003WT-SO
	for qemu-devel@nongnu.org; Sat, 06 May 2017 08:43:22 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat,  6 May 2017 14:43:14 +0200
Message-Id: <20170506124314.23354-3-aurelien@aurel32.net>
In-Reply-To: <20170506124314.23354-1-aurelien@aurel32.net>
References: <20170506124314.23354-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 3/3] ide: export rotational qdev property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

Export the rotational qdev property in the IDENTIFY request.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 hw/ide/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 0b48b64d3a..1aa76b0d90 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -191,6 +191,9 @@ static void ide_identify(IDEState *s)
     if (dev && dev->conf.discard_granularity) {
         put_le16(p + 169, 1); /* TRIM support */
     }
+    if (dev && !dev->conf.rotational) {
+        put_le16(p + 217, 1); /* non-rotating device */
+    }
 
     ide_identify_size(s);
     s->identify_set = 1;
-- 
2.11.0
