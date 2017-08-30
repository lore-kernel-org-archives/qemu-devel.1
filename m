Received: from eggs.gnu.org ([2001:4830:134:3::10]:34483)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dn6UH-0007gt-7w
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dn6UE-0003KI-26
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:09:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:50397)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dn6UD-0003Jj-O7
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:09:05 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Wed, 30 Aug 2017 18:56:50 +0200
Message-Id: <20170830165650.1528-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH] Add BSD systems to the download section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Kamil Rytarowski <n54@gmx.com>

Add basic notes about FreeBSD, NetBSD and OpenBSD.

Add BSD link to source code subsection.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 _download/bsd.md      | 19 +++++++++++++++++++
 _download/source.html |  1 +
 download.html         |  8 ++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 _download/bsd.md

diff --git a/_download/bsd.md b/_download/bsd.md
new file mode 100644
index 0000000..bbbd8a0
--- /dev/null
+++ b/_download/bsd.md
@@ -0,0 +1,19 @@
+QEMU is packaged by modern BSD systems.
+
+Installation can be performed from prebuilt packages or from package build system (aka ports).
+
+Prebuilt binary packages:
+
+* <strong>FreeBSD</strong> `pkg install qemu`
+
+* <strong>NetBSD</strong> `pkgin install qemu`
+
+* <strong>OpenBSD</strong> `pkg_add qemu`
+
+Package build system:
+
+* <strong>FreeBSD</strong> `cd /usr/ports/emulators/qemu && make install`
+
+* <strong>NetBSD</strong> `cd /usr/pkgsrc/emulators/qemu && make install`
+
+* <strong>OpenBSD</strong> `cd /usr/ports/emulators/qemu && make install`
diff --git a/_download/source.html b/_download/source.html
index d090a5e..6949daa 100644
--- a/_download/source.html
+++ b/_download/source.html
@@ -2,6 +2,7 @@
 	<p>Grab the source code for the latest releases and compile it yourself!
 	Detailed compilation instructions can be found in the wiki for
 		<a href="http://wiki.qemu-project.org/Hosts/Linux">Linux</a>,
+		<a href="http://wiki.qemu-project.org/Hosts/BSD">BSD</a>,
 		<a href="http://wiki.qemu-project.org/Hosts/Windows">Win32</a> and
 		<a href="http://wiki.qemu-project.org/Hosts/Mac">macOS</a>.</p>
 
diff --git a/download.html b/download.html
index 5a1e4ea..2dd0044 100644
--- a/download.html
+++ b/download.html
@@ -6,6 +6,7 @@ permalink: /download/
 <div class="horiz-menu">
 <ul style="display: none;">
 <li><a href="#linux">Linux</a></li>
+<li><a href="#bsd">BSD</a></li>
 <li><a href="#macos">macOS</a></li>
 <li><a href="#windows">Windows</a></li>
 <li><a href="#source">Source code</a></li>
@@ -18,6 +19,13 @@ permalink: /download/
 	{% markdown_relative _download/linux.md %}
 </article>
 
+<article id="bsd" class="active">
+	<header>
+	<h2>BSD</h2>
+	</header>
+	{% markdown_relative _download/bsd.md %}
+</article>
+
 <article id="macos" class="active">
 	<header>
 	<h2>macOS</h2>
-- 
2.14.1
