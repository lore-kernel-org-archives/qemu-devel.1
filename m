Received: from eggs.gnu.org ([2001:4830:134:3::10]:44087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tj-0006zF-AX
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tf-0003bd-Lj
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Tf-0003b1-Fd
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 980FF81E12
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:31 +0200
Message-Id: <20171002141341.24616-2-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 01/11] qapi-schema: Fix
 query-vm-generation-id's doc comment markup
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
List-ID: <qemu-devel.nongnu.org>

Reported-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index a9dd043f65..3490a5edaf 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3188,7 +3188,7 @@
 #
 # Show Virtual Machine Generation ID
 #
-# Since 2.9
+# Since: 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
 
-- 
2.13.6
