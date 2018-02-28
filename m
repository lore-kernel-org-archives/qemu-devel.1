Received: from eggs.gnu.org ([2001:4830:134:3::10]:60907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eqwfo-0007ac-5W
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eqwfi-0005A2-0A
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:01:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1eqwfh-00058m-PQ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:01:05 -0500
Date: Wed, 28 Feb 2018 08:00:42 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20180228080042.5d6rr4incivrurk3@starbug-vm.ie.oracle.com>
References: <1519788689-11967-1-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1519788689-11967-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v3] scripts/checkpatch.pl: add check for
 `while` and `for`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: thuth@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On Wed, Feb 28, 2018 at 11:31:29AM +0800, Su Hang wrote:
>Adding check for `while` and `for` statements, which condition has more than
>one line.
>
>The former checkpatch.pl can check `if` statement, which condition has more
>than one line, whether block misses brace round, like this:
>'''
>if (cond1 ||
>    cond2)
>    statement;
>'''
>But it doesn't do the same check for `for` and `while` statements.
>
>Using `(?:...)` instead of `(...)` in regex pattern catch.
>Because `(?:...)` is faster and avoids unwanted side-effect.
>
>Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>Suggested-by: Eric Blake <eblake@redhat.com>
>Suggested-by: Thomas Huth <thuth@redhat.com>
>Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
>---
> scripts/checkpatch.pl | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>index 10c138344fa9..bed1dbbd54d1 100755
>--- a/scripts/checkpatch.pl
>+++ b/scripts/checkpatch.pl
>@@ -2352,9 +2352,9 @@ sub process {
> 			}
> 		}
>
>-# check for missing bracing round if etc
>-		if ($line =~ /(^.*)\b(for|while|if)\b/ &&
>-			$line !~ /\#\s*(for|while|if)/) {
>+# check for missing bracing around if etc
>+		if ($line =~ /(^.*)\b(?:for|while|if)\b/ &&
>+			$line !~ /\#\s*(?:for|while|if)/) {

It's a nit, but for readability I would suggest indenting the line
above an extra tab or two to make it clear that it is part of the
condition rather than the block. (You can see other instances of
this in the file).

Otherwise:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.


> 			my ($level, $endln, @chunks) =
> 				ctx_statement_full($linenr, $realcnt, 1);
>                         if ($dbg_adv_apw) {
>-- 
>2.7.4
>
>
