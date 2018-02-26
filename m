Received: from eggs.gnu.org ([2001:4830:134:3::10]:43660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eq94r-0001vZ-MA
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 22:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eq94o-000329-JE
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 22:03:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eq94o-00031g-F8
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 22:03:42 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon, 26 Feb 2018 11:03:25 +0800
Message-Id: <20180226030326.20219-2-famz@redhat.com>
In-Reply-To: <20180226030326.20219-1-famz@redhat.com>
References: <20180226030326.20219-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/2] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, f4bug@amsat.org, stefanha@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

git-publish [1] is a convenient tool to send patches and has been
popular among QEMU developers.  Recently it has been made available in
Fedora/Debian official repo.

One nice feature of the tool is a per-project configuration with
profiles, especially in which the cccmd option is a handy method to
create the Cc list.

[1]: https://github.com/stefanha/git-publish

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 .gitpublish | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 .gitpublish

diff --git a/.gitpublish b/.gitpublish
new file mode 100644
index 0000000000..a13f8c7c0e
--- /dev/null
+++ b/.gitpublish
@@ -0,0 +1,51 @@
+#
+# Common git-publish profiles that can be used to send patches to QEMU upstream.
+#
+# See https://github.com/stefanha/git-publish for more information
+#
+[gitpublishprofile "default"]
+base = master
+to = qemu-devel@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "rfc"]
+base = master
+prefix = RFC PATCH
+to = qemu-devel@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "stable"]
+base = master
+to = qemu-devel@nongnu.org
+cc = qemu-stable@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "trivial"]
+base = master
+to = qemu-devel@nongnu.org
+cc = qemu-trivial@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "block"]
+base = master
+to = qemu-devel@nongnu.org
+cc = qemu-block@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "arm"]
+base = master
+to = qemu-devel@nongnu.org
+cc = qemu-arm@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "s390"]
+base = master
+to = qemu-devel@nongnu.org
+cc = qemu-s390@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "ppc"]
+base = master
+to = qemu-devel@nongnu.org
+cc = qemu-ppc@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
-- 
2.14.3
