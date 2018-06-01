Received: from eggs.gnu.org ([2001:4830:134:3::10]:38978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtk-0002Yg-Jn
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtj-0007ZT-RJ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtj-0007Z3-Lh
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:27 -0400
Date: Fri, 1 Jun 2018 19:27:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-29-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 28/31] tests/.gitignore: add entry for generated
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Longpeng(Mike)" <longpeng2@huawei.com>

From: Ross Zwisler <ross.zwisler@linux.intel.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
MST
