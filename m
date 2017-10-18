Received: from eggs.gnu.org ([2001:4830:134:3::10]:56416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4jmr-00004t-IB
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4jmq-00036w-Lb
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:33:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4jmq-00035r-FU
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:33:12 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 18 Oct 2017 10:33:05 +0200
Message-Id: <20171018083305.5246-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH] tpm: Fix compilation with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Amarnath Valluri <amarnath.valluri@intel.com>

Commit
   c37cacabf2285b0731b44c1f667781fdd4f2b658

broke compilation without tpm.  Just add an empty tpm_cleanup() stub.

CC: Amarnath Valluri <amarnath.valluri@intel.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tpm.c b/tpm.c
index 3122227156..9396bb669c 100644
--- a/tpm.c
+++ b/tpm.c
@@ -194,6 +194,12 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
     return 0;
 }
 
+#else
+
+void tpm_cleanup(void)
+{
+}
+
 #endif /* CONFIG_TPM */
 
 static const TPMDriverOps *tpm_driver_find_by_type(enum TpmType type)
-- 
2.13.6
