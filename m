Received: from eggs.gnu.org ([209.51.188.92]:43972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Uxw-00077P-BT
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Uxu-0005sV-7H
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:44:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1Uxl-0005lr-Kn
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:57 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Mar 2019 11:42:27 +0000
Message-Id: <20190306114227.9125-23-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-1-dgilbert@redhat.com>
References: <20190306114227.9125-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/22] qapi/migration.json: Remove a variable
 that doesn't exist in example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com
Cc: eblake@redhat.com, armbru@redhat.com

From: Zhang Chen <chen.zhang@intel.com>

Remove the "active" variable in example for query-colo-status.
It is a doc bug from commit f56c0065

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190303145021.2962-6-chen.zhang@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 qapi/migration.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 6bd7fd3f1a..5684733754 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1393,7 +1393,7 @@
 # Example:
 #
 # -> { "execute": "query-colo-status" }
-# <- { "return": { "mode": "primary", "active": true, "reason": "request=
" } }
+# <- { "return": { "mode": "primary", "reason": "request" } }
 #
 # Since: 3.1
 ##
--=20
2.20.1
