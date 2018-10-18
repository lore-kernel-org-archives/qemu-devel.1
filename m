Received: from eggs.gnu.org ([2001:4830:134:3::10]:45740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9kT-0003pc-1s
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9kM-0007U2-Dr
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gD9kJ-0007Ql-ON
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:57:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 547E0307D84E
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 14:57:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 18 Oct 2018 15:57:48 +0100
Message-Id: <20181018145748.11697-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [web PATCH] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This adds a config file for git-publish, primarily so that patches get
sent with the "web" subject prefix to distinguish them from patches to
the main git repo.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

I picked Paolo & Thomas as CC since they appear to be the people
actually committing patches to qemu-web.git so far. Feel free to
correct me if needed...

 .gitpublish | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 .gitpublish

diff --git a/.gitpublish b/.gitpublish
new file mode 100644
index 0000000..4cf08bc
--- /dev/null
+++ b/.gitpublish
@@ -0,0 +1,11 @@
+#
+# Common git-publish profiles that can be used to send patches to QEMU u=
pstream.
+#
+# See https://github.com/stefanha/git-publish for more information
+#
+[gitpublishprofile "default"]
+base =3D master
+to =3D qemu-devel@nongnu.org
+prefix =3D web PATCH
+cc =3D Paolo Bonzini <pbonzini@redhat.com>
+cc =3D Thomas Huth <thuth@redhat.com>
--=20
2.17.2
