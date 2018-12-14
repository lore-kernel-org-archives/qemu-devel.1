Received: from eggs.gnu.org ([2001:4830:134:3::10]:39914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXwgU-0000xG-Uz
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 18:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXwgU-0003Gr-1b
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 18:15:54 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 14 Dec 2018 18:15:09 -0500
Message-Id: <20181214231512.5295-5-jsnow@redhat.com>
In-Reply-To: <20181214231512.5295-1-jsnow@redhat.com>
References: <20181214231512.5295-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/7] iotests.py: don't abort if IMGKEYSECRET
 is undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Instead of using os.environ[], use .get with a default of empty string
to match the setup in check to allow us to import the iotests module
(for debugging, say) without needing a crafted environment just to
import the module.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index d537538ba0..a34e66813a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -63,7 +63,7 @@ socket_scm_helper = os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_helper')
 debug = False
 
 luks_default_secret_object = 'secret,id=keysec0,data=' + \
-                             os.environ['IMGKEYSECRET']
+                             os.environ.get('IMGKEYSECRET', '')
 luks_default_key_secret_opt = 'key-secret=keysec0'
 
 
-- 
2.17.2
