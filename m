Received: from eggs.gnu.org ([2001:4830:134:3::10]:41408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWneo-0000wP-Es
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWnem-0005yU-Rs
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:16:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWnem-0005yG-Mq
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:16:20 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD4FA80469
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 17:16:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 26 Jan 2017 17:16:12 +0000
Message-Id: <20170126171613.1399-2-stefanha@redhat.com>
In-Reply-To: <20170126171613.1399-1-stefanha@redhat.com>
References: <20170126171613.1399-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] qapi: add missing
 trace_visit_type_enum() call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

A trace event exists for enums but it's never called.  This patch fixes
this oversight so that enums are traced just like the other QAPI types.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/qapi-visit-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 63bd97b..e6e93f0 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -374,6 +374,7 @@ void visit_type_enum(Visitor *v, const char *name, int *obj,
                      const char *const strings[], Error **errp)
 {
     assert(obj && strings);
+    trace_visit_type_enum(v, name, obj);
     switch (v->type) {
     case VISITOR_INPUT:
         input_type_enum(v, name, obj, strings, errp);
-- 
2.9.3
