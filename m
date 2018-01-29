Received: from eggs.gnu.org ([2001:4830:134:3::10]:49189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRk-0005ou-QA
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRg-0003dQ-3C
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:20 -0500
Received: from mail-dm3nam03on0064.outbound.protection.outlook.com
	([104.47.41.64]:11072
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1egDRf-0003bl-U4
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:16 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 29 Jan 2018 11:41:26 -0600
Message-Id: <20180129174132.108925-18-brijesh.singh@amd.com>
In-Reply-To: <20180129174132.108925-1-brijesh.singh@amd.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 17/23] qapi: add SEV_MEASUREMENT event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Markus Armbruster <armbru@redhat.com>

Add SEV_MEASUREMENT event which can be used by libvirt to get the
measurement of the memory regions encrypted through the SEV launch
flow. The measurement value is base64 encoded.

Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 qapi-schema.json | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 2046c96669bf..e1f5d14e2e3f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3192,3 +3192,16 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @SEV_MEASUREMENT:
+#
+# Emitted when measurement is available for the SEV guest.
+#
+# @value: measurement value encoded in base64
+#
+# Since: 2.12
+#
+##
+{ 'event' : 'SEV_MEASUREMENT',
+  'data' : { 'value' : 'str' } }
-- 
2.9.5
