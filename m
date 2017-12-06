Received: from eggs.gnu.org ([2001:4830:134:3::10]:50021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfw7-0006TQ-22
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfw3-0002nB-Rb
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:55 -0500
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com
	([104.47.32.43]:55952
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfw3-0002ma-Ix
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:51 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:40 -0600
Message-Id: <20171206200346.116537-18-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 17/23] qapi: add SEV_MEASUREMENT event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

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
index 7eec403cd34a..f63659eda45b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3203,3 +3203,16 @@
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
+# Since: 2.11
+#
+##
+{ 'event' : 'SEV_MEASUREMENT',
+  'data' : { 'value' : 'str' } }
-- 
2.9.5
