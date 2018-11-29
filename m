Received: from eggs.gnu.org ([2001:4830:134:3::10]:36704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSK6i-0007C4-QJ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSK6e-0002Al-Md
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:03:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSK6e-0002AO-FK
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:03:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95049C058CB0
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:03:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 29 Nov 2018 11:03:34 +0000
Message-Id: <20181129110334.27721-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [qemu-web PATCH v3] download: document version
 numbering scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The new version numbering scheme was mentioned in the blog post
announcing 3.0 previously, but this will fall out of view over
time. It is thus preferrable to mention this on the download page
too.

Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 download.html | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/download.html b/download.html
index 5a1e4ea..3c2df66 100644
--- a/download.html
+++ b/download.html
@@ -39,6 +39,30 @@ permalink: /download/
 	{% include_relative _download/source.html %}
 </article>
 </div>
+
+<h2>Version numbering</h2>
+<div>
+  <p>
+  Since version 3.0.0, QEMU uses a time based version numbering scheme:
+  </p>
+<dl>
+<dt>major</dt>
+<dd>incremented by 1 for the first release of the year</dd>
+<dt>minor</dt>
+<dd>reset to 0 with every major increment, otherwise incremented by 1 fo=
r each release from git master</dd>
+<dt>micro</dt>
+<dd>always 0 for releases from git master, incremented by 1 for each sta=
ble branch release</dd>
+</dl>
+  <p>
+    The implication of this is that changes in major version number
+    <strong>do not</strong> have any bearing on the scope of changes
+    included in the release. Non-backward compatible changes may be made
+    in any master branch release, provided they have followed the
+    <a href=3D"https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-fea=
tures">deprecation policy</a>
+    which calls for warnings to be emitted for a minimum of two releases
+    prior to the change.
+  </p>
+</div>
 <script>
 function animateOnClick(jqThis, slide) {
    $('.horiz-menu li').removeClass('active');
--=20
2.19.2
