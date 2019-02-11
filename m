Received: from eggs.gnu.org ([209.51.188.92]:47494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gtEaq-0006Yc-Sz
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gtEao-0006FY-UF
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gtEam-0006Cz-SX
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CCEDAB997
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 16:21:00 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Mon, 11 Feb 2019 17:20:52 +0100
Message-Id: <20190211162052.13584-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH] [qemu-web] Put version numbering details in
 its own doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

Instead of burying the version numbering details under "Download QEMU"
page, place it in its own document.  And highlight its presence in the
website footer.

While at it, add a concrete example of the version numbering scheme.

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 _includes/footer.html |  1 +
 download.html         | 23 -----------------------
 version-numbering.md  | 26 ++++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 23 deletions(-)
 create mode 100644 version-numbering.md

diff --git a/_includes/footer.html b/_includes/footer.html
index 1669ef766cc18b0df3e27418038f9bf851b74c8a..0fb85feb564e3b23bc4ab78eb05359264d13bfa5 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -17,6 +17,7 @@
 			<li><a href="https://qemu.weilnetz.de/qemu-doc.html">Manual</a></li>
 			<li><a href="https://wiki.qemu.org/Category:Developer_documentation">Developer docs</a></li>
 			<li><a href="https://wiki.qemu.org/">Wiki</a></li>
+			<li><a href="/version-numbering">Version numbering</a></li>
 		</ul>
 		<ul class="style">
 			<li><a href="https://planet.virt-tools.org/">virt tools planet</a></li>
diff --git a/download.html b/download.html
index 3c2df66ff6757bba1246b5f0873b287fca600f11..e4c8bb5792aa6e6f7038a9fd2bdab3c432daa6ab 100644
--- a/download.html
+++ b/download.html
@@ -40,29 +40,6 @@ permalink: /download/
 </article>
 </div>
 
-<h2>Version numbering</h2>
-<div>
-  <p>
-  Since version 3.0.0, QEMU uses a time based version numbering scheme:
-  </p>
-<dl>
-<dt>major</dt>
-<dd>incremented by 1 for the first release of the year</dd>
-<dt>minor</dt>
-<dd>reset to 0 with every major increment, otherwise incremented by 1 for each release from git master</dd>
-<dt>micro</dt>
-<dd>always 0 for releases from git master, incremented by 1 for each stable branch release</dd>
-</dl>
-  <p>
-    The implication of this is that changes in major version number
-    <strong>do not</strong> have any bearing on the scope of changes
-    included in the release. Non-backward compatible changes may be made
-    in any master branch release, provided they have followed the
-    <a href="https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features">deprecation policy</a>
-    which calls for warnings to be emitted for a minimum of two releases
-    prior to the change.
-  </p>
-</div>
 <script>
 function animateOnClick(jqThis, slide) {
    $('.horiz-menu li').removeClass('active');
diff --git a/version-numbering.md b/version-numbering.md
new file mode 100644
index 0000000000000000000000000000000000000000..9ace69128f76d7eb5b71e062ccdcb3ffd768ccc6
--- /dev/null
+++ b/version-numbering.md
@@ -0,0 +1,26 @@
+---
+title: QEMU version numbering
+permalink: /version-numbering/
+---
+
+Since version 3.0.0, QEMU uses a time based version numbering scheme:
+
+  - major: incremented by 1 for the first release of the year
+
+  - minor: reset to 0 with every major increment, otherwise
+    incremented by 1 for each release from git master
+
+  - micro: always 0 for releases from git master, incremented by 1 for
+    each stable branch release
+
+The implication of this is that changes in major version number *do not*
+have any bearing on the scope of changes included in the release.
+Non-backward compatible changes may be made in any master branch
+release, provided they have followed the [deprecation
+policy](https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features)
+which calls for warnings to be emitted for a minimum of two releases
+prior to the change.
+
+Example number scheme: in the year 2019, there will be 4.0.0, 4.1.0 and
+4.2.0 releases; following that, 5.0.0, 5.1.0, 5.2.0 releases in 2020,
+and so on.
-- 
2.17.2
