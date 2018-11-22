Received: from eggs.gnu.org ([2001:4830:134:3::10]:40134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPpoB-00060G-Fd
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPpo7-00070S-Rz
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:18:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPpo7-0006vE-HM
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:18:15 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 18:17:41 +0400
Message-Id: <20181122141741.11108-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] docs: apply some qemu.org-like CSS style to
 HTML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sw@weilnetz.de, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Style a bit the HTML documents, to make them look like qemu.org pages.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile                     |   2 +
 docs/texinfo-extra-head.html |   7 ++
 docs/texinfo.css             | 226 +++++++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+)
 create mode 100644 docs/texinfo-extra-head.html
 create mode 100644 docs/texinfo.css

diff --git a/Makefile b/Makefile
index f2947186a4..9cc4dae1a6 100644
--- a/Makefile
+++ b/Makefile
@@ -940,6 +940,8 @@ docs/version.texi: $(SRC_PATH)/VERSION
=20
 %.html: %.texi docs/version.texi
 	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
+	--set-customization-variable EXTRA_HEAD=3D"`cat $(SRC_PATH)/docs/texinf=
o-extra-head.html`" \
+	--css-include=3D$(SRC_PATH)/docs/texinfo.css \
 	--html $< -o $@,"GEN","$@")
=20
 %.info: %.texi docs/version.texi
diff --git a/docs/texinfo-extra-head.html b/docs/texinfo-extra-head.html
new file mode 100644
index 0000000000..2986b31701
--- /dev/null
+++ b/docs/texinfo-extra-head.html
@@ -0,0 +1,7 @@
+<link href=3D'https://fonts.googleapis.com/css?family=3DRoboto+Mono:300,=
400%7cRoboto:300,400,500' rel=3D'stylesheet' type=3D'text/css'>
+<!-- these are optional qemu.org resources -->
+<link rel=3D"apple-touch-icon" sizes=3D"180x180" href=3D"/assets/favicon=
s/apple-touch-icon.png">
+<link rel=3D"icon" type=3D"image/png" sizes=3D"32x32" href=3D"/assets/fa=
vicons/favicon-32x32.png">
+<link rel=3D"icon" type=3D"image/png" sizes=3D"16x16" href=3D"/assets/fa=
vicons/favicon-16x16.png">
+<link rel=3D"manifest" href=3D"/assets/favicons/manifest.json">
+<link rel=3D"mask-icon" href=3D"/assets/favicons/safari-pinned-tab.svg" =
color=3D"#5bbad5">
diff --git a/docs/texinfo.css b/docs/texinfo.css
new file mode 100644
index 0000000000..f541ed2cec
--- /dev/null
+++ b/docs/texinfo.css
@@ -0,0 +1,226 @@
+/* CSS style for QEMU Texinfo documents */
+/* based on Public domain 2016 sirgazil. All rights waived. */
+
+a:link,
+a:visited {
+    color: #F03B11;
+    text-decoration: none;
+}
+
+a:active,
+a:focus,
+a:hover {
+    text-decoration: underline;
+}
+
+abbr,
+acronym {
+    cursor: help;
+}
+
+blockquote {
+    color: #555753;
+    font-style: oblique;
+    margin: 30px 0;
+    padding-left: 3em;
+}
+
+body {
+    background: url("https://www.qemu.org/assets/images/qemu_head_200.pn=
g") no-repeat fixed 2em 80px;
+    font-family: 'Roboto', sans-serif;
+    font-size: 11pt;
+    font-weight: 300;
+    line-height: 1.75em;
+    color: #000000;
+    margin-left: 16.667%;
+    width: 66.667%;
+}
+
+code,
+samp,
+tt,
+var {
+    font-family: 'Roboto Mono', monospace;
+}
+
+div.example,
+div.lisp {
+    margin: 0;
+}
+
+dl {
+    margin: 3em 0;
+}
+
+dl dl {
+    margin: 0;
+}
+
+dt {
+    background-color: #F5F5F5;
+    padding: 0.5em;
+}
+
+h1,
+h2,
+h2.contents-heading,
+h3,
+h4 {
+    padding: 20px 0 0 0;
+    font-weight: 300;
+}
+
+h1 {
+    position: relative;
+    background: #f03b11;
+    background: -webkit-linear-gradient(top, #f03b11 0%, #f01139 100%);
+    background: linear-gradient(to bottom, #f03b11 0%, #f01139 100%);
+    background-size: cover;
+    text-align: center;
+    color: #FFF;
+    text-decoration: none;
+    font-weight: 300;
+    line-height: 1em;
+    font-size: 3em;
+}
+
+h2 {
+    font-size: 2.2em;
+    font-weight: bold;
+}
+
+h3 {
+    font-size: 1.8em;
+}
+
+h4 {
+    font-size: 1.4em;
+}
+
+hr {
+    display: none;
+}
+
+img {
+    max-width: 100%;
+}
+
+li {
+    padding: 5px;
+}
+
+pre.display,
+pre.example,
+pre.format,
+pre.lisp,
+pre.verbatim {
+    overflow: auto;
+}
+
+pre.example,
+pre.lisp,
+pre.verbatim {
+    background-color: #2D3743;
+    border-color: #000;
+    border-style: solid;
+    border-width: thin;
+    color: #E1E1E1;
+    font-size: smaller;
+    padding: 1em;
+}
+
+table {
+    border-collapse: collapse;
+    margin: 40px 0px;
+}
+
+table.index-cp *,
+table.index-fn *,
+table.index-ky *,
+table.index-pg *,
+table.index-tp *,
+table.index-vr * {
+    background-color: inherit;
+    border-style: none;
+}
+
+td,
+th {
+    border-color: silver;
+    border-style: solid;
+    border-width: thin;
+    padding: 10px;
+}
+
+th {
+    background-color: #F5F5F5;
+}
+
+.contents-heading {
+    display: none;
+}
+
+.contents {
+    margin-bottom: 4em;
+}
+
+.float {
+    margin: 3em 0em;
+}
+
+.float-caption {
+    font-size: smaller;
+    text-align: center;
+}
+
+.float>img {
+    display: block;
+    margin: auto;
+}
+
+.footnote {
+    font-size: smaller;
+    margin: 5em 0em;
+}
+
+.footnote h3 {
+    display: inline;
+    font-size: small;
+}
+
+.header {
+    background-color: #F2F2F2;
+    font-size: small;
+    padding: 0.2em 1em;
+}
+
+.key {
+    display: inline-block;
+    border: 1px solid #ccc;
+    border-radius: 4px;
+    padding: 0.1em 0.5em;
+    margin: 0 0.2em;
+    box-shadow: 0 1px 0px rgba(0, 0, 0, 0.2), 0 0 0 2px #fff inset;
+    background-color: #f7f7f7;
+}
+
+.menu * {
+    border-style: none;
+}
+
+.menu td {
+    padding: 0.5em 0em;
+}
+
+.menu td:last-child {
+    width: 60%;
+}
+
+.menu th {
+    background-color: inherit;
+}
+
+.example code,
+.example var {
+    color: #E1E1E1;
+}
--=20
2.20.0.rc1
