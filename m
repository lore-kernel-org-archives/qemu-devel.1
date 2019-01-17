Received: from eggs.gnu.org ([209.51.188.92]:33348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDTT-0004Cj-15
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDTR-0008A1-P2
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:11 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 13:36:39 -0600
Message-Id: <20190117193658.16413-3-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-1-eblake@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/21] maint: Allow for EXAMPLES in texi2pod
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

The next commit will add an EXAMPLES section to qemu-nbd.8;
for that to work, we need to recognize EXAMPLES in texi2pod.
We also need to add a dependency from all man pages against
the generator script, since a change to the generator may
cause the resulting man page to differ.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

---
v3: add generic dependency for all man pages in $(DOCS) instead of
per-line editing [Vladimir]
---
 Makefile            | 2 ++
 scripts/texi2pod.pl | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dccba1dca27..2639437cdaf 100644
--- a/Makefile
+++ b/Makefile
@@ -858,6 +858,8 @@ docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-r=
ef.html \
     docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7: \
 	docs/interop/qemu-qmp-ref.texi docs/interop/qemu-qmp-qapi.texi

+$(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
+
 # Reports/Analysis

 %/coverage-report.html:
diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
index 39ce584a322..839b7917cf7 100755
--- a/scripts/texi2pod.pl
+++ b/scripts/texi2pod.pl
@@ -398,7 +398,7 @@ $sects{NAME} =3D "$fn \- $tl\n";
 $sects{FOOTNOTES} .=3D "=3Dback\n" if exists $sects{FOOTNOTES};

 for $sect (qw(NAME SYNOPSIS DESCRIPTION OPTIONS ENVIRONMENT FILES
-	      BUGS NOTES FOOTNOTES SEEALSO AUTHOR COPYRIGHT)) {
+	      BUGS NOTES FOOTNOTES EXAMPLES SEEALSO AUTHOR COPYRIGHT)) {
     if(exists $sects{$sect}) {
 	$head =3D $sect;
 	$head =3D~ s/SEEALSO/SEE ALSO/;
--=20
2.20.1
