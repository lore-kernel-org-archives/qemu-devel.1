Received: from eggs.gnu.org ([2001:4830:134:3::10]:39226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJu8-0000kf-II
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJu4-0000gf-MN
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJu4-0000eq-HK
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:24 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:06:04 +0800
Message-Id: <20171116130610.23582-22-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 21/27] qmp: let migrate-incoming allow
 out-of-band
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

So it can get rid of being run on main thread.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index bbc4671ded..95098072dd 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1063,7 +1063,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
+{ 'command': 'migrate-incoming', 'data': {'uri': 'str' },
+  'allow-oob': true }
 
 ##
 # @xen-save-devices-state:
-- 
2.13.6
