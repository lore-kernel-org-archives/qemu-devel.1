Received: from eggs.gnu.org ([2001:4830:134:3::10]:46517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYvDn-0006aq-Vf
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYvDm-0004ql-A7
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:45:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cYvDm-0004qS-2g
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:45:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  1 Feb 2017 13:44:52 +0000
Message-Id: <20170201134453.11963-10-stefanha@redhat.com>
In-Reply-To: <20170201134453.11963-1-stefanha@redhat.com>
References: <20170201134453.11963-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] qapi: add missing trace_visit_type_enum()
 call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

A trace event exists for enums but it's never called.  This patch fixes
this oversight so that enums are traced just like the other QAPI types.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170126171613.1399-2-stefanha@redhat.com
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
