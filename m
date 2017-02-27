Received: from eggs.gnu.org ([2001:4830:134:3::10]:43735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6v-0007xB-LR
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6u-0005DH-EJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ciO6u-0005D4-8V
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:16 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 Feb 2017 13:24:55 -0300
Message-Id: <20170227162501.29280-6-ehabkost@redhat.com>
In-Reply-To: <20170227162501.29280-1-ehabkost@redhat.com>
References: <20170227162501.29280-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/11] qapi-schema: Comment about full expansion
 of non-migration-safe models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Add a note warning that static expansion may not be 100% accurate
when the CPU model is not migration-safe. This will be the case
on x86 when expansing the "host" CPU model, because there are
"host" features that can't have a migration-safe representation
(e.g. "host-cache-info").

Message-Id: <20170116211124.29245-3-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi-schema.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 150ee98e9e..2051c46cfc 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4274,6 +4274,15 @@
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
