Received: from eggs.gnu.org ([2001:4830:134:3::10]:45434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fJB2I-0001mT-9J
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fJB1v-000125-Sh
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:01:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:63840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fJB1v-0000tQ-EL
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:00:43 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Wed, 16 May 2018 23:00:22 -0600
Message-Id: <20180517050024.20101-3-ross.zwisler@linux.intel.com>
In-Reply-To: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
References: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [qemu PATCH v2 2/4] tests/.gitignore: add entry for
 generated file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>

After a "make check" we end up with the following:

$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	tests/test-block-backend

nothing added to commit but untracked files present (use "git add" to track)

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Fixes: commit ad0df3e0fdac ("block: test blk_aio_flush() with blk->root == NULL")
---
 tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/.gitignore b/tests/.gitignore
index fb62d2299b..2bc61a9a58 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -21,6 +21,7 @@ test-base64
 test-bdrv-drain
 test-bitops
 test-bitcnt
+test-block-backend
 test-blockjob
 test-blockjob-txn
 test-bufferiszero
-- 
2.14.3
