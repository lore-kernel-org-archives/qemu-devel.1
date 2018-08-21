Received: from eggs.gnu.org ([2001:4830:134:3::10]:33248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4S-0001kk-0Y
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4I-0006TX-OI
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA49-00068m-4K
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id w11-v6so13895971wrc.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:59 +0200
Message-Id: <1534870966-9287-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/74] checkpatch: allow space in more places
 before a bracket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

Allow a space between a colon and subsequent opening bracket.  This
sequence may occur in inline assembler statements like

	asm(
		"ldr %[out], [%[in]]\n\t"
		: [out] "=r" (ret)
		: [in] "r" (addr)
	);

Allow a space between a comma and subsequent opening bracket.  This
sequence may occur in designated initializers.

To ease backporting the patch, I am also changing the comma-bracket
detection (added in QEMU by commit 409db6eb7199af7a2f09f746bd1b793e9daefe5f)
to use the same regex as brackets and colons (as done independently
by Linux commit daebc534ac15f991961a5bb433e515988220e9bf).

Link: http://lkml.kernel.org/r/20180403191655.23700-1-xypron.glpk@gmx.de
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Acked-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0553634..3765b0e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1929,9 +1929,8 @@ sub process {
 			my ($where, $prefix) = ($-[1], $1);
 			if ($prefix !~ /$Type\s+$/ &&
 			    ($where != 0 || $prefix !~ /^.\s+$/) &&
-			    $prefix !~ /{\s+$/ &&
 			    $prefix !~ /\#\s*define[^(]*\([^)]*\)\s+$/ &&
-			    $prefix !~ /,\s+$/) {
+			    $prefix !~ /[,{:]\s+$/) {
 				ERROR("space prohibited before open square bracket '['\n" . $herecurr);
 			}
 		}
-- 
1.8.3.1
