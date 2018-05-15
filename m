Received: from eggs.gnu.org ([2001:4830:134:3::10]:57946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fIYII-0004IH-Ef
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fIYEs-0005Ld-Nc
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:39:02 -0400
Received: from [45.249.212.32] (port=43185 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1fIYEr-0005CC-Pr
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:35:30 -0400
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Tue, 15 May 2018 19:35:08 +0800
Message-ID: <1526384108-49348-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] memory: delete struct AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, jianjay.zhou@huawei.com

Since struct AddressSpaceOps isn't used anywhere else,
so just delete it.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 memory.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/memory.c b/memory.c
index fc7f9b7..94b91f9 100644
--- a/memory.c
+++ b/memory.c
@@ -220,8 +220,6 @@ struct FlatRange {
     bool readonly;
 };
 
-typedef struct AddressSpaceOps AddressSpaceOps;
-
 #define FOR_EACH_FLAT_RANGE(var, view)          \
     for (var = (view)->ranges; var < (view)->ranges + (view)->nr; ++var)
 
-- 
1.8.3.1
