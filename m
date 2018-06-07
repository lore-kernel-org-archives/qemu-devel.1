Received: from eggs.gnu.org ([2001:4830:134:3::10]:36965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fR3RJ-00012W-8F
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fR3RG-00051K-48
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:31:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:60809)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fR3RF-0004z8-RU
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:31:26 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Thu,  7 Jun 2018 16:31:07 -0600
Message-Id: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [qemu PATCH 1/5] gitignore: ignore generated qapi job
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

With a fully built QEMU I currently see the following with "git status":

  Untracked files:
    (use "git add <file>..." to include in what will be committed)

  	qapi/qapi-commands-job.c
  	qapi/qapi-commands-job.h
  	qapi/qapi-events-job.c
  	qapi/qapi-events-job.h
  	qapi/qapi-types-job.c
  	qapi/qapi-types-job.h
  	qapi/qapi-visit-job.c
  	qapi/qapi-visit-job.h

These are all generated files.  Ignore them.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Fixes: commit bf42508f24ee ("job: Introduce qapi/job.json")
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 81e1f2fb0f..2980090f0a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -100,6 +100,7 @@
 /qapi/qapi-visit-ui.[ch]
 /qapi/qapi-visit.[ch]
 /qapi/qapi-doc.texi
+/qapi/qapi-*-job.[ch]
 /qemu-doc.html
 /qemu-doc.info
 /qemu-doc.txt
-- 
2.14.4
