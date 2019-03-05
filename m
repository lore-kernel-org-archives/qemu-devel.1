Received: from eggs.gnu.org ([209.51.188.92]:50186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Ecc-0001T1-3S
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Eca-0002DD-Cp
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1EcY-0002Bd-Ba
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:56 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Mar 2019 18:16:02 +0000
Message-Id: <20190305181602.9051-22-dgilbert@redhat.com>
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/21] qapi/migration.json: Remove a variable
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
