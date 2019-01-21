Received: from eggs.gnu.org ([209.51.188.92]:39876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNk-0001A8-1z
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNf-0004zc-JB
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gliNb-0004uK-KG
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:21 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:48:48 -0600
Message-Id: <20190121224907.26634-3-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/21] maint: Allow for EXAMPLES in texi2pod
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The next commit will add an EXAMPLES section to qemu-nbd.8;
for that to work, we need to recognize EXAMPLES in texi2pod.
We also need to add a dependency from all man pages against
the generator script, since a change to the generator may
cause the resulting man page to differ.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Message-Id: <20190117193658.16413-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
