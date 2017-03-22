Received: from eggs.gnu.org ([2001:4830:134:3::10]:37105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqilo-0006XK-86
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqill-0001l2-N5
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqill-0001jR-HL
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60C3F43A59
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 559BE784AE
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 17:05:42 +0100
Message-Id: <1490198748-4753-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1490198748-4753-1-git-send-email-armbru@redhat.com>
References: <1490198748-4753-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 11/17] qapi2texi: Fix translation of
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490015515-25851-7-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py            | 4 ++--
 tests/qapi-schema/doc-good.texi | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 5c4db78..9e01500 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -35,12 +35,12 @@ EXAMPLE_FMT =3D """@example
=20
 def subst_strong(doc):
     """Replaces *foo* by @strong{foo}"""
-    return re.sub(r'\*([^*\n]+)\*', r'@emph{\1}', doc)
+    return re.sub(r'\*([^*\n]+)\*', r'@strong{\1}', doc)
=20
=20
 def subst_emph(doc):
     """Replaces _foo_ by @emph{foo}"""
-    return re.sub(r'\b_([^_\n]+)_\b', r' @emph{\1} ', doc)
+    return re.sub(r'\b_([^_\n]+)_\b', r'@emph{\1}', doc)
=20
=20
 def subst_vars(doc):
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index 1160aaf..c410626 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -2,7 +2,7 @@
=20
 @subsection Subsection
=20
-@emph{strong}  @emph{with emphasis}=20
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
=20
 @deftp {Enum} Enum
=20
-@subsection Produces @emph{invalid} texinfo
+@subsection Produces @strong{invalid} texinfo
=20
 @b{Values:}
 @table @asis
 @item @code{one}
-The  @emph{one}  @{and only@}
+The @emph{one} @{and only@}
 @item @code{two}
 Not documented
 @end table
--=20
2.7.4
