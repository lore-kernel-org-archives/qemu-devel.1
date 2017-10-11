Received: from eggs.gnu.org ([2001:4830:134:3::10]:55560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1e2CMf-0000MJ-E4
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1e2CMc-0005Ge-AC
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:27:41 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:34706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiang.biao2@zte.com.cn>)
	id 1e2CMb-0005Ca-V5
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:27:38 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Wed, 11 Oct 2017 16:24:39 +0800
Message-Id: <1507710279-11737-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] checkpatch: ignore perl files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn

Most coding styles are not suit for perl files. If we check
scripts/checkpatch.pl with itself, there would be tons of complaints.
And if we make patches for checkpatch.pl, patchew.org and
checkpatch.pl would complain errors for the patches.

Ignore perl files taking Linux kernel version as reference.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3c0a28e..c4ec031 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1442,7 +1442,7 @@ sub process {
 		}
 
 # check we are in a valid source file if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c|cpp|s|S|pl|py|sh)$/);
+		next if ($realfile !~ /\.(h|c|cpp|s|S|py|sh)$/);
 
 #90 column limit
 		if ($line =~ /^\+/ &&
-- 
2.9.5
