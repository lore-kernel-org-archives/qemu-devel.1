Received: from eggs.gnu.org ([2001:4830:134:3::10]:51550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj3v-0004iL-8C
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj3r-000558-9e
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:23:59 -0500
Received: from mail-sn1nam01on0075.outbound.protection.outlook.com
	([104.47.32.75]:17117
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj3q-00054v-NP
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:23:55 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:51:28 -0500
Message-ID: <148900628810.27090.3461280348833651824.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 02/20] memattrs: add debug attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

Add a new debug attribute, the attribute should be set when guest memory
accesses are performed for debug purposes.

The attribute will be used in SEV guest, where we need to distinguish normal
vs debug access to guest memory. In debug mode, we need to use SEV commands
to access the guest memory.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 include/exec/memattrs.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index e601061..b802073 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
     unsigned int user:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+    /* Memory access for debug purposes */
+    unsigned int debug:1;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
@@ -46,4 +48,6 @@ typedef struct MemTxAttrs {
  */
 #define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = 1 })
 
+/* Access the guest memory for debug purposes */
+#define MEMTXATTRS_DEBUG ((MemTxAttrs) { .debug = 1 })
 #endif
