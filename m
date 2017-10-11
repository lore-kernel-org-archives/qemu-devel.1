Received: from eggs.gnu.org ([2001:4830:134:3::10]:43433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1e28kK-0001lB-Q1
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 00:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1e28kH-0006Wx-Lu
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 00:35:52 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:44046 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiang.biao2@zte.com.cn>)
	id 1e28kH-0006To-AK
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 00:35:49 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Wed, 11 Oct 2017 12:33:26 +0800
Message-Id: <1507696406-11168-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] checkpatch: replace ERROR with WARN for extern
 checking.
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

There are some rare cases which need external declarations in .c
files. patchew.org and checkpatch.pl will complain errors on
patches for these declarations.

Degrade ERROR to WARN to erase the error complaints taking
checkpatch.pl in kernel as reference.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3c0a28e..9123788 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2546,7 +2546,7 @@ sub process {
 			if ($s =~ /^\s*;/ &&
 			    $function_name ne 'uninitialized_var')
 			{
-				ERROR("externs should be avoided in .c files\n" .  $herecurr);
+				WARN("externs should be avoided in .c files\n" .  $herecurr);
 			}
 
 			if ($paren_space =~ /\n/) {
@@ -2556,7 +2556,7 @@ sub process {
 		} elsif ($realfile =~ /\.c$/ && defined $stat &&
 		    $stat =~ /^.\s*extern\s+/)
 		{
-			ERROR("externs should be avoided in .c files\n" .  $herecurr);
+			WARN("externs should be avoided in .c files\n" .  $herecurr);
 		}
 
 # check for pointless casting of g_malloc return
-- 
2.9.5
