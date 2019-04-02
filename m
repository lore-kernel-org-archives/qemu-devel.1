Received: from eggs.gnu.org ([209.51.188.92]:59016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hB9d7-0002RH-4V
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hB9d5-0008N6-Io
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:58:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:34893)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hB9d3-0008BN-B5
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:58:27 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue,  2 Apr 2019 10:57:28 +0800
Message-Id: <20190402025728.5636-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] vmstate: check subsection_found is enough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

subsection_found is true implies vmdesc is not NULL.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/vmstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index e2bbb7b5f7..8327179eea 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -533,7 +533,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
         sub++;
     }
 
-    if (vmdesc && subsection_found) {
+    if (subsection_found) {
         json_end_array(vmdesc);
     }
 
-- 
2.19.1
