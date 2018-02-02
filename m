Received: from eggs.gnu.org ([2001:4830:134:3::10]:45495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ehcfn-0006XK-Jb
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ehcfZ-0006po-RA
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:50:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ehcfZ-0006pC-Dm
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:50:25 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  2 Feb 2018 14:34:11 +0800
Message-Id: <20180202063412.22466-2-famz@redhat.com>
In-Reply-To: <20180202063412.22466-1-famz@redhat.com>
References: <20180202063412.22466-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, stefanha@redhat.com

git-publish [1] is a convenient tool to send patches and has been
popular among QEMU developers.  Recently it has been made available in
Fedora official repo thanks to Stefan's work.

One nice feature of the tool is a per-project configuration with
profiles, especially in which the cccmd option is a handy method to
create the Cc list.

[1]: https://github.com/stefanha/git-publish

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 .gitpublish | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 .gitpublish

diff --git a/.gitpublish b/.gitpublish
new file mode 100644
index 0000000000..170bd2ed48
--- /dev/null
+++ b/.gitpublish
@@ -0,0 +1,57 @@
+#
+# Common git-publish profiles that can be used to send patches to QEMU upstream.
+#
+# See https://github.com/stefanha/git-publish for more information
+#
+[gitpublishprofile "default"]
+base = master
+prefix = PATCH
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
+prefix = PATCH
+to = qemu-devel@nongnu.org
+cc = qemu-stable@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "trivial"]
+base = master
+prefix = PATCH
+to = qemu-devel@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "block"]
+base = master
+prefix = PATCH
+to = qemu-devel@nongnu.org
+cc = qemu-block@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "arm"]
+base = master
+prefix = PATCH
+to = qemu-devel@nongnu.org
+cc = qemu-arm@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "s390"]
+base = master
+prefix = PATCH
+to = qemu-devel@nongnu.org
+cc = qemu-s390@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
+
+[gitpublishprofile "ppc"]
+base = master
+prefix = PATCH
+to = qemu-devel@nongnu.org
+cc = qemu-pcc@nongnu.org
+cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
-- 
2.14.3
