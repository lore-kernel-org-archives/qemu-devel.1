Received: from eggs.gnu.org ([2001:4830:134:3::10]:36327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAj-00071w-Lq
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAe-0007bA-NC
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxmAe-0007ao-HC
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:00 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:41 +0800
Message-Id: <20170929033844.26935-20-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 19/22] qmp: let migrate-incoming allow
 out-of-band
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

So it can get rid of being run on main thread.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index f8b365e3f5..2accc2899e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1017,7 +1017,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
+{ 'command': 'migrate-incoming', 'data': {'uri': 'str' },
+  'allow-oob': true }
 
 ##
 # @xen-save-devices-state:
-- 
2.13.5
