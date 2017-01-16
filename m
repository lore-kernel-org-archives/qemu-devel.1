Received: from eggs.gnu.org ([2001:4830:134:3::10]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTEZ0-0003az-5I
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTEYw-00014M-Vd
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:11:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTEYw-00014E-Px
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:11:34 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 112F185547
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 21:11:35 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 19:11:22 -0200
Message-Id: <20170116211124.29245-3-ehabkost@redhat.com>
In-Reply-To: <20170116211124.29245-1-ehabkost@redhat.com>
References: <20170116211124.29245-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] qapi-schema: Comment about full
 expansion of non-migration-safe models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add a note warning that static expansion may not be 100% accurate
when the CPU model is not migration-safe. This will be the case
on x86 when expansing the "host" CPU model, because there are
"host" features that can't have a migration-safe representation
(e.g. "host-cache-info").

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi-schema.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index ce20f16757..33d7ef1274 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3294,6 +3294,15 @@
 #        migration-safe, but allows tooling to get an insight and work with
 #        model details.
 #
+# Note: When a non-migration-safe CPU model is expanded in static mode, some
+# features enabled by the CPU model may be omitted, because they can't be
+# implemented by a static CPU model definition (e.g. cache info passthrough and
+# PMU passthrough in x86). If you need an accurate representation of the
+# features enabled by a non-migration-safe CPU model, use @full. If you need a
+# static representation that will keep ABI compatibility even when changing QEMU
+# version or machine-type, use @static (but keep in mind that some features may
+# be omitted).
+#
 # Since: 2.8.0
 ##
 { 'enum': 'CpuModelExpansionType',
-- 
2.11.0.259.g40922b1
