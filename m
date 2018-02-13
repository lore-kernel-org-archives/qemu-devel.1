Received: from eggs.gnu.org ([2001:4830:134:3::10]:36305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eleTe-0002Fn-Ep
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eleTa-0003BC-GB
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39062 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eleTa-0003Ac-Bk
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Feb 2018 17:34:25 +0000
Message-Id: <20180213173429.19501-2-stefanha@redhat.com>
In-Reply-To: <20180213173429.19501-1-stefanha@redhat.com>
References: <20180213173429.19501-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/5] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

git-publish [1] is a convenient tool to send patches and has been
popular among QEMU developers.  Recently it has been made available in
Fedora official repo thanks to Stefan's work.

One nice feature of the tool is a per-project configuration with
profiles, especially in which the cccmd option is a handy method to
create the Cc list.

[1]: https://github.com/stefanha/git-publish

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180205054725.25634-2-famz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .gitpublish | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 1 file changed, 58 insertions(+)
 create mode 100644 .gitpublish

diff --git a/.gitpublish b/.gitpublish
new file mode 100644
index 0000000000..ed48f6e52c
--- /dev/null
+++ b/.gitpublish
@@ -0,0 +1,58 @@
+#
+# Common git-publish profiles that can be used to send patches to QEMU u=
pstream.
+#
+# See https://github.com/stefanha/git-publish for more information
+#
+[gitpublishprofile "default"]
+base =3D master
+prefix =3D PATCH
+to =3D qemu-devel@nongnu.org
+cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
+
+[gitpublishprofile "rfc"]
+base =3D master
+prefix =3D RFC PATCH
+to =3D qemu-devel@nongnu.org
+cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
+
+[gitpublishprofile "stable"]
+base =3D master
+prefix =3D PATCH
+to =3D qemu-devel@nongnu.org
+cc =3D qemu-stable@nongnu.org
+cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
+
+[gitpublishprofile "trivial"]
+base =3D master
+prefix =3D PATCH
+to =3D qemu-devel@nongnu.org
+cc =3D qemu-trivial@nongnu.org
+cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
+
+[gitpublishprofile "block"]
+base =3D master
+prefix =3D PATCH
+to =3D qemu-devel@nongnu.org
+cc =3D qemu-block@nongnu.org
+cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
+
+[gitpublishprofile "arm"]
+base =3D master
+prefix =3D PATCH
+to =3D qemu-devel@nongnu.org
+cc =3D qemu-arm@nongnu.org
+cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
+
+[gitpublishprofile "s390"]
+base =3D master
+prefix =3D PATCH
+to =3D qemu-devel@nongnu.org
+cc =3D qemu-s390@nongnu.org
+cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
+
+[gitpublishprofile "ppc"]
+base =3D master
+prefix =3D PATCH
+to =3D qemu-devel@nongnu.org
+cc =3D qemu-ppc@nongnu.org
+cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
--=20
2.14.3
