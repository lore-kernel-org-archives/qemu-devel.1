Received: from eggs.gnu.org ([2001:4830:134:3::10]:36544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Uu2-00089g-1Q
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Uty-00081O-AS
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:53 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Uty-0007zK-3Z
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:50 -0400
Received: by mail-wr0-x242.google.com with SMTP id c24so2415704wrc.6
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:50 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:20 +0200
Message-Id: <1523034681-33787-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/20] maint: Add .mailmap entries for patches
 claiming list authorship
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The list did not author any patches, but it does rewrite the
'From:' header of messages sent from any domain with restrictive
SPF policies that would otherwise prevent the message from reaching
all list recipients.  If a maintainer is not careful to undo the
list header rewrite, and the author did not include a manual
'From:' line in the body to fix the munged header, then 'git am'
happily attributes the patch to the list.  Add some mailmap
entries to correct the few that have escaped our attention; while
we also work on improving the tooling to catch the problem in
the future before a merge is even made.

Also improve the comments occurring in the file, including line
length improvements.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .mailmap | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index cf689b9..778a4d4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1,6 +1,7 @@
-# This mailmap just translates the weird addresses from the original import into git
-# into proper addresses so that they are counted properly in git shortlog output.
-#
+# This mailmap fixes up author names/addresses.
+
+# The first section translates weird addresses from the original git import
+# into proper addresses so that they are counted properly by git shortlog.
 Andrzej Zaborowski <balrogg@gmail.com> balrog <balrog@c046a42c-6fe2-441c-8c8c-71466251a162>
 Anthony Liguori <anthony@codemonkey.ws> aliguori <aliguori@c046a42c-6fe2-441c-8c8c-71466251a162>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
@@ -15,10 +16,19 @@ Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
 Paul Burton <paul.burton@mips.com> <paul@archlinuxmips.org>
 Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251a162>
 malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
+
 # There is also a:
 #    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
 # for the cvs2svn initialization commit e63c3dc74bf.
-#
+
+# Next, translate a few commits where mailman rewrote the From: line due
+# to strict SPF, although we prefer to avoid adding more entries like that.
+Ed Swierk <eswierk@skyportsystems.com> Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>
+Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu.org>
+Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
+Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
+
+
 # Also list preferred name forms where people have changed their
 # git author config
 Daniel P. Berrangé <berrange@redhat.com>
-- 
1.8.3.1
