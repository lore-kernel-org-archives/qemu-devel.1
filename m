Received: from eggs.gnu.org ([2001:4830:134:3::10]:48279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVi-0005N7-Pg
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVe-0006Uq-Ah
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:06 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVe-0006UE-3i
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:02 -0500
Received: by mail-wm0-x243.google.com with SMTP id z9so22089062wmb.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:19 +0100
Message-Id: <1520342370-123606-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/34] checkpatch: add check for `while` and
 `for`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Su Hang <suhang16@mails.ucas.ac.cn>

From: Su Hang <suhang16@mails.ucas.ac.cn>

Adding check for `while` and `for` statements, which condition has more than
one line.

The former checkpatch.pl can check `if` statement, which condition has more
than one line, whether block misses brace round, like this:
'''
if (cond1 ||
    cond2)
    statement;
'''
But it doesn't do the same check for `for` and `while` statements.

Using `(?:...)` instead of `(...)` in regex pattern catch.
Because `(?:...)` is faster and avoids unwanted side-effect.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Suggested-by: Eric Blake <eblake@redhat.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
Message-Id: <1520319890-19761-1-git-send-email-suhang16@mails.ucas.ac.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a88af61..d1fe79b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2352,8 +2352,9 @@ sub process {
 			}
 		}
 
-# check for missing bracing round if etc
-		if ($line =~ /(^.*)\bif\b/ && $line !~ /\#\s*if/) {
+# check for missing bracing around if etc
+		if ($line =~ /(^.*)\b(?:if|while|for)\b/ &&
+			$line !~ /\#\s*if/) {
 			my ($level, $endln, @chunks) =
 				ctx_statement_full($linenr, $realcnt, 1);
                         if ($dbg_adv_apw) {
-- 
1.8.3.1
