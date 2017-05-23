Received: from eggs.gnu.org ([2001:4830:134:3::10]:38740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xZ-0005kw-5O
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xX-00014h-HS
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD8xX-000141-CV
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6769580464
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 12:30:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 23 May 2017 14:30:38 +0200
Message-Id: <1495542638-12335-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1495542638-12335-1-git-send-email-armbru@redhat.com>
References: <1495542638-12335-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] qapi-schema: Remove obsolete note from
 ObjectTypeInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

The "This command is experimental" note in ObjectTypeInfo is obsolete
since 2012.  Commit 5192082097549c5b3aa7c913c6853d97a68172cb removed the
warning from the qom-list-types command documentation, but we forgot to
remove the warning from ObjectTypeInfo.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170516205351.12101-1-ehabkost@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 80603cf..e6da885 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3035,8 +3035,6 @@
 # @name: the type name found in the search
 #
 # Since: 1.1
-#
-# Notes: This command is experimental and may change syntax in future releases.
 ##
 { 'struct': 'ObjectTypeInfo',
   'data': { 'name': 'str' } }
-- 
2.7.4
