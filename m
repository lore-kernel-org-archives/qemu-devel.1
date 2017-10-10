Received: from eggs.gnu.org ([2001:4830:134:3::10]:45307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1e1pPP-0007l1-Oi
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1e1pPM-0006WY-ON
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:56:59 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:48152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiang.biao2@zte.com.cn>)
	id 1e1pPM-0006R4-DI
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:56:56 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
	by Forcepoint Email with ESMTPS id BDD059A077AC56B0B882
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 15:56:45 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
	by mse01.zte.com.cn with ESMTP id v9A7uPbR043371
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 15:56:25 +0800 (GMT-8)
	(envelope-from jiang.biao2@zte.com.cn)
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Tue, 10 Oct 2017 15:54:19 +0800
Message-Id: <1507622059-4493-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] scripts/checkpatch.pl: fix false error of
 externs checking.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn

When adding a function declaration in a .c file without extern
keywork decoration, checkpatch.pl will report *externs should be
avoided in .c files* false error. This patch fixes the bug.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3c0a28e..c12bc4c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2534,7 +2534,7 @@ sub process {
 
 # check for new externs in .c files.
 		if ($realfile =~ /\.c$/ && defined $stat &&
-		    $stat =~ /^.\s*(?:extern\s+)?$Type\s+($Ident)(\s*)\(/s)
+		    $stat =~ /^.\s*(?:extern\s+)$Type\s+($Ident)(\s*)\(/s)
 		{
 			my $function_name = $1;
 			my $paren_space = $2;
-- 
2.7.4
