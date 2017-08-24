Received: from eggs.gnu.org ([2001:4830:134:3::10]:49143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkqr0-0003yT-QU
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkqqv-0001xy-Pm
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkqqv-0001xk-KP
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94AA981E0F
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 12:03:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 14:02:56 +0200
Message-Id: <1503576178-23966-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1503576178-23966-1-git-send-email-armbru@redhat.com>
References: <1503576178-23966-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qapi-schema: Document how generated
 documentation is ordered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Documentation generated with qapi2texi.py is in textual order, with
included sub-schemas inserted at the first include directive
(subsequent include directives have no effect).  To get a sane and
stable order, it's best to include each sub-schema just once, or
include it first in qapi-schema.json.  Document that.

While there, drop a few redundant comments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 802ea53..76b5888 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -72,22 +72,17 @@
         'q_obj_CpuInfo-base'    # CPU, visible through query-cpu
     ] } }
 
-# QAPI common definitions
+# Documentation generated with qapi2texi.py is in textual order, with
+# included sub-schemas inserted at the first include directive
+# (subsequent include directives have no effect).  To get a sane and
+# stable order, it's best to include each sub-schema just once, or
+# include it first in qapi-schema.json.
+
 { 'include': 'qapi/common.json' }
-
-# QAPI crypto definitions
 { 'include': 'qapi/crypto.json' }
-
-# QAPI block definitions
 { 'include': 'qapi/block.json' }
-
-# QAPI event definitions
 { 'include': 'qapi/event.json' }
-
-# Tracing commands
 { 'include': 'qapi/trace.json' }
-
-# QAPI introspection
 { 'include': 'qapi/introspect.json' }
 
 ##
-- 
2.7.5
