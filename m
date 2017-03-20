Received: from eggs.gnu.org ([2001:4830:134:3::10]:49330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6X-0003hj-V5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6U-0002ce-0k
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cpx6T-0002cQ-QF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 14:11:55 +0100
Message-Id: <1490015515-25851-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1490015515-25851-1-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 6/6] qapi2texi: Fix translation of
 *strong* and _emphasized_
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py            | 4 ++--
 tests/qapi-schema/doc-good.texi | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 5c4db78..9e01500 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -35,12 +35,12 @@ EXAMPLE_FMT = """@example
 
 def subst_strong(doc):
     """Replaces *foo* by @strong{foo}"""
-    return re.sub(r'\*([^*\n]+)\*', r'@emph{\1}', doc)
+    return re.sub(r'\*([^*\n]+)\*', r'@strong{\1}', doc)
 
 
 def subst_emph(doc):
     """Replaces _foo_ by @emph{foo}"""
-    return re.sub(r'\b_([^_\n]+)_\b', r' @emph{\1} ', doc)
+    return re.sub(r'\b_([^_\n]+)_\b', r'@emph{\1}', doc)
 
 
 def subst_vars(doc):
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 1160aaf..c410626 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -2,7 +2,7 @@
 
 @subsection Subsection
 
-@emph{strong}  @emph{with emphasis} 
+@strong{strong} @emph{with emphasis}
 @code{var} @{in braces@}
 @itemize @bullet
 @item
@@ -67,7 +67,7 @@ Example:
 Examples:
 @itemize @minus
 @item
-@emph{verbatim}
+@strong{verbatim}
 @item
 @{braces@}
 @end itemize
@@ -76,12 +76,12 @@ Examples:
 
 @deftp {Enum} Enum
 
-@subsection Produces @emph{invalid} texinfo
+@subsection Produces @strong{invalid} texinfo
 
 @b{Values:}
 @table @asis
 @item @code{one}
-The  @emph{one}  @{and only@}
+The @emph{one} @{and only@}
 @item @code{two}
 Not documented
 @end table
-- 
2.7.4
