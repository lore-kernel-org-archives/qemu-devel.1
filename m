Received: from eggs.gnu.org ([2001:4830:134:3::10]:53150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejTrf-000551-D4
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejTrb-0002k1-RU
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:50:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lcapitulino@redhat.com>)
	id 1ejTrb-0002jX-ME
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:50:31 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Date: Wed,  7 Feb 2018 12:50:14 -0500
Message-Id: <20180207175014.11157-3-lcapitulino@redhat.com>
In-Reply-To: <20180207175014.11157-1-lcapitulino@redhat.com>
References: <20180207175014.11157-1-lcapitulino@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qmp: document query-cpus performance issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, ehabkost@redhat.com, berrange@redhat.com, mihajlov@linux.vnet.ibm.com

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 qapi-schema.json | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 82d6f12b53..0665a14dba 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -526,6 +526,10 @@
 #
 # Returns a list of information about each virtual CPU.
 #
+# WARNING: This command incurs a performance penalty for latency
+#          sensitive workloads and hence it's not recommended to
+#          to be used in production. Use query-cpus-fast instead
+#
 # Returns: a list of @CpuInfo for each virtual CPU
 #
 # Since: 0.14.0
-- 
2.14.3
