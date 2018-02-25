Received: from eggs.gnu.org ([2001:4830:134:3::10]:48600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epmlE-00081A-Mt
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 22:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epml9-0005U3-Jt
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 22:14:00 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:53641 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epml9-0005Mb-0j
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 22:13:55 -0500
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Sun, 25 Feb 2018 11:13:09 +0800
Message-Id: <1519528389-14023-1-git-send-email-suhang16@mails.ucas.ac.cn>
In-Reply-To: <1519480458-9573-1-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1519480458-9573-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH v2 RFC] scripts/checkpatch.pl:Add check for
 `while` and `for`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, eblake@redhat.com, stefanha@redhat.com
Cc: qemu-devel@nongnu.org

Add check for `while` and `for` statement, which condition has more than
one line.

The former checkpatch.pl can check `if` statement, which condition has more
than one line, whether block misses brace round, like this:
'''
if (cond1 ||
    cond2)
    statement;
'''
But it doesn't do the same check for `for` and `while` statement.

Suggested-by: Eric Blake <eblake@redhat.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1b4b812e28fa..7e332135e177 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2353,7 +2353,8 @@ sub process {
 		}
 
 # check for missing bracing round if etc
-		if ($line =~ /(^.*)\bif\b/ && $line !~ /\#\s*if/) {
+		if ($line =~ /(^.*)\b(if|for|while)\b/ &&
+			$line !~ /\#\s*(if|for|while)/) {
 			my ($level, $endln, @chunks) =
 				ctx_statement_full($linenr, $realcnt, 1);
                         if ($dbg_adv_apw) {
-- 
2.7.4
