Received: from eggs.gnu.org ([2001:4830:134:3::10]:48019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fKnjM-0007ob-Da
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fKnjI-000878-5Z
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:32:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:48360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fKnjH-00086Q-SZ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:32:12 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Mon, 21 May 2018 10:32:01 -0600
Message-Id: <20180521163203.26590-3-ross.zwisler@linux.intel.com>
In-Reply-To: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [qemu PATCH v4 2/4] tests/.gitignore: add entry for
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
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>, Kevin Wolf <kwolf@redhat.com>

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
Cc: Kevin Wolf <kwolf@redhat.com>
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
