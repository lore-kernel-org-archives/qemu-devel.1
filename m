Received: from eggs.gnu.org ([2001:4830:134:3::10]:49892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dkPWO-0002TP-5A
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dkPWK-0007cL-8D
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:52:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dkPWK-0007c0-1u
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:52:08 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 23 Aug 2017 14:51:10 +0800
Message-Id: <1503471071-2233-8-git-send-email-peterx@redhat.com>
In-Reply-To: <1503471071-2233-1-git-send-email-peterx@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 7/8] migration: hmp: migrate_incoming don't
 need BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Allow this command to run without BQL held.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp-commands.hx | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1941e19..e8d8812 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -968,6 +968,7 @@ ETEXI
         .params     = "uri",
         .help       = "Continue an incoming migration from an -incoming defer",
         .cmd        = hmp_migrate_incoming,
+        .without_bql = true,
     },
 
 STEXI
-- 
2.7.4
