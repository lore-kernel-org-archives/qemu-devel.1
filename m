Received: from eggs.gnu.org ([2001:4830:134:3::10]:56647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dosKW-00089E-Rx
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dosKQ-0002iW-QB
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:26:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dosKQ-0002i7-GF
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:26:18 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon,  4 Sep 2017 15:26:08 +0100
Message-Id: <20170904142608.4897-3-berrange@redhat.com>
In-Reply-To: <20170904142608.4897-1-berrange@redhat.com>
References: <20170904142608.4897-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH web 2/2] Use https links whereever possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The following sites all support https

   qemu.org
   wiki.qemu.org
   git.qemu.org
   download.qemu.org
   planet.virt-tools.org
   libvirt.org
   www.linux-kvm.org
   xenproject.org

Update all links to these sites to use https. This is particularly
important for the links to the release downloads, to avoid the chance
of downloads being compromised

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 .htaccess                                            |  6 +++---
 _download/source.html                                | 10 +++++-----
 _includes/footer.html                                | 18 +++++++++-----=
----
 _includes/releases.html                              |  8 ++++----
 _posts/2017-02-04-the-new-qemu-website-is-up.md      | 10 +++++-----
 _posts/2017-03-19-qemu-in-the-blogs-february-2017.md |  4 ++--
 _posts/2017-08-10-deprecation.md                     |  2 +-
 contribute.md                                        |  6 +++---
 contribute/report-a-bug.md                           |  6 +++---
 documentation.md                                     |  8 ++++----
 index.html                                           |  2 +-
 11 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/.htaccess b/.htaccess
index 73da09b..baa6ef0 100644
--- a/.htaccess
+++ b/.htaccess
@@ -3,6 +3,6 @@ RewriteBase /
 RewriteRule ^Download$       /download/                          [R=3D30=
1]
 RewriteRule ^Contribute$     /contribute/                        [R=3D30=
1]
 RewriteRule ^Documentation$  /documentation/                     [R=3D30=
1]
-RewriteRule ^[A-Z].*         http://wiki.qemu.org/$0     [NE,R]
-RewriteRule ^download(/.+)   http://download.qemu.org$1  [NE,R]
-RewriteRule ^images(/.+)   http://wiki.qemu.org/images$1 [NE,R]
+RewriteRule ^[A-Z].*         https://wiki.qemu.org/$0     [NE,R]
+RewriteRule ^download(/.+)   https://download.qemu.org$1  [NE,R]
+RewriteRule ^images(/.+)   https://wiki.qemu.org/images$1 [NE,R]
diff --git a/_download/source.html b/_download/source.html
index 5e06ee7..d64d7ba 100644
--- a/_download/source.html
+++ b/_download/source.html
@@ -1,21 +1,21 @@
=20
 	<p>Grab the source code for the latest releases and compile it yourself=
!
 	Detailed compilation instructions can be found in the wiki for
-		<a href=3D"http://wiki.qemu.org/Hosts/Linux">Linux</a>,
-		<a href=3D"http://wiki.qemu.org/Hosts/Windows">Win32</a> and
-		<a href=3D"http://wiki.qemu.org/Hosts/Mac">macOS</a>.</p>
+		<a href=3D"https://wiki.qemu.org/Hosts/Linux">Linux</a>,
+		<a href=3D"https://wiki.qemu.org/Hosts/Windows">Win32</a> and
+		<a href=3D"https://wiki.qemu.org/Hosts/Mac">macOS</a>.</p>
=20
 	<div id=3D"releases">
 	{% include releases.html %}
 	</div>
 	<p>or stay on the bleeding edge with the
-	   <a href=3D"http://git.qemu.org/">git repository!</a></p>
+	   <a href=3D"https://git.qemu.org/">git repository!</a></p>
=20
 	<h2>Build instructions</h2>
=20
 	{% for release in site.data.releases offset: 0 limit: 1 %}
 	<p>To download and build QEMU {{release.branch}}.{{release.patch}}:</p>
-<pre>wget http://download.qemu.org/qemu-{{release.branch}}.{{release.pat=
ch}}.tar.xz
+<pre>wget https://download.qemu.org/qemu-{{release.branch}}.{{release.pa=
tch}}.tar.xz
 tar xvJf qemu-{{release.branch}}.{{release.patch}}.tar.xz
 cd qemu-{{release.branch}}.{{release.patch}}
 ./configure
diff --git a/_includes/footer.html b/_includes/footer.html
index 979a477..1669ef7 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -8,22 +8,22 @@
 		<ul class=3D"style">
 			<li><a href=3D"/contribute">Contribute</a></li>
 			<li><a href=3D"/contribute/report-a-bug">Reporting a bug</a></li>
-			<li><a href=3D"http://wiki.qemu.org/Documentation/GettingStartedDevel=
opers">New contributors</a></li>
-			<li><a href=3D"http://wiki.qemu.org/Contribute/SubmitAPatch">Submitti=
ng a patch</a></li>
-			<li><a href=3D"http://wiki.qemu.org/Contribute/FAQ">Contributor FAQ</=
a></li>
+			<li><a href=3D"https://wiki.qemu.org/Documentation/GettingStartedDeve=
lopers">New contributors</a></li>
+			<li><a href=3D"https://wiki.qemu.org/Contribute/SubmitAPatch">Submitt=
ing a patch</a></li>
+			<li><a href=3D"https://wiki.qemu.org/Contribute/FAQ">Contributor FAQ<=
/a></li>
 		</ul>
 		<ul class=3D"style">
 			<li><a href=3D"/documentation">Documentation</a></li>
 			<li><a href=3D"https://qemu.weilnetz.de/qemu-doc.html">Manual</a></li=
>
-			<li><a href=3D"http://wiki.qemu.org/Category:Developer_documentation"=
>Developer docs</a></li>
-			<li><a href=3D"http://wiki.qemu.org/">Wiki</a></li>
+			<li><a href=3D"https://wiki.qemu.org/Category:Developer_documentation=
">Developer docs</a></li>
+			<li><a href=3D"https://wiki.qemu.org/">Wiki</a></li>
 		</ul>
 		<ul class=3D"style">
-			<li><a href=3D"http://planet.virt-tools.org/">virt tools planet</a></=
li>
-			<li><a href=3D"http://www.linux-kvm.org/">KVM</a></li>
+			<li><a href=3D"https://planet.virt-tools.org/">virt tools planet</a><=
/li>
+			<li><a href=3D"https://www.linux-kvm.org/">KVM</a></li>
 			<li><a href=3D"http://libguestfs.org/">Libguestfs</a></li>
-			<li><a href=3D"http://libvirt.org/">Libvirt</a></li>
-			<li><a href=3D"http://xenproject.org">Xen</a></li>
+			<li><a href=3D"https://libvirt.org/">Libvirt</a></li>
+			<li><a href=3D"https://xenproject.org">Xen</a></li>
 		</ul>
 	</div>
 </div>
diff --git a/_includes/releases.html b/_includes/releases.html
index 4881f83..2e95631 100644
--- a/_includes/releases.html
+++ b/_includes/releases.html
@@ -1,10 +1,10 @@
 <ul>
 {% for release in site.data.releases offset: 0 limit: 4 %}
 <li><strong><a
-  href=3D"http://download.qemu.org/qemu-{{release.branch}}.{{release.pat=
ch}}.tar.xz">{{release.branch}}.{{release.patch}}</a></strong>
+  href=3D"https://download.qemu.org/qemu-{{release.branch}}.{{release.pa=
tch}}.tar.xz">{{release.branch}}.{{release.patch}}</a></strong>
   {{release.date}}<br><a
-  href=3D"http://download.qemu.org/qemu-{{release.branch}}.{{release.pat=
ch}}.tar.xz.sig">signature</a> &mdash; <a
-  href=3D"http://wiki.qemu.org/ChangeLog/{{release.branch}}">changes</a>=
</li>
+  href=3D"https://download.qemu.org/qemu-{{release.branch}}.{{release.pa=
tch}}.tar.xz.sig">signature</a> &mdash; <a
+  href=3D"https://wiki.qemu.org/ChangeLog/{{release.branch}}">changes</a=
></li>
 {% endfor %}
 </ul>
-<p><a {% if page.url =3D=3D '/' %}class=3D"button"{%endif%} href=3D"http=
://download.qemu.org/">Full list of releases</a><p>
+<p><a {% if page.url =3D=3D '/' %}class=3D"button"{%endif%} href=3D"http=
s://download.qemu.org/">Full list of releases</a><p>
diff --git a/_posts/2017-02-04-the-new-qemu-website-is-up.md b/_posts/201=
7-02-04-the-new-qemu-website-is-up.md
index 6dc5eeb..66d3181 100644
--- a/_posts/2017-02-04-the-new-qemu-website-is-up.md
+++ b/_posts/2017-02-04-the-new-qemu-website-is-up.md
@@ -9,13 +9,13 @@ At last, QEMU's new website is up!
=20
 The new site aims to be simple and provides the basic information
 needed to download and start contributing to QEMU.  It complements the
-[wiki](http://wiki.qemu.org/), which remains the central point for
+[wiki](https://wiki.qemu.org/), which remains the central point for
 developers to share information quickly with the rest of the community.
=20
 We tried to test the website on most browsers and to make it lightweight
 and responsive.  It is built using [Jekyll](https://jekyllrb.com/)
 and the source code for the website can be cloned from the
-[qemu-web.git](http://git.qemu.org/?p=3Dqemu-web.git;a=3Dsummary)
+[qemu-web.git](https://git.qemu.org/?p=3Dqemu-web.git;a=3Dsummary)
 repository.  Just like for any other project hosted by QEMU, the best wa=
y
 to propose or contribute a new change is by sending a patch through the
 [qemu-devel@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-d=
evel)
@@ -23,10 +23,10 @@ mailing list.
=20
 For example, if you would like to add a new screenshot to the homepage,
 you can clone the `qemu-web.git` repository, add a PNG file to the
-[`screenshots/`](http://git.qemu.org/?p=3Dqemu-web.git;a=3Dtree;f=3Dscre=
enshots;hb=3DHEAD)
-directory, and edit the [`_data/screenshots.yml`](http://git.qemu.org/?p=
=3Dqemu-web.git;a=3Dblob;f=3D_data/screenshots.yml;hb=3DHEAD)
+[`screenshots/`](https://git.qemu.org/?p=3Dqemu-web.git;a=3Dtree;f=3Dscr=
eenshots;hb=3DHEAD)
+directory, and edit the [`_data/screenshots.yml`](https://git.qemu.org/?=
p=3Dqemu-web.git;a=3Dblob;f=3D_data/screenshots.yml;hb=3DHEAD)
 file to include the new screenshot.
=20
 Blog posts about QEMU are also welcome; they are simple HTML or Markdown
-files and are stored in the [`_posts/`](http://git.qemu.org/?p=3Dqemu-we=
b.git;a=3Dtree;f=3D_posts;hb=3DHEAD)
+files and are stored in the [`_posts/`](https://git.qemu.org/?p=3Dqemu-w=
eb.git;a=3Dtree;f=3D_posts;hb=3DHEAD)
 directory of the repository.
diff --git a/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md b/_post=
s/2017-03-19-qemu-in-the-blogs-february-2017.md
index 42af6d2..01e8e7d 100644
--- a/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md
+++ b/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md
@@ -29,7 +29,7 @@ and KVM, that were posted last month.
   by Daniel P. Berrang=C3=A9
=20
 More virtualization blog posts can be found on the [virt tools
-planet](http://planet.virt-tools.org/).
+planet](https://planet.virt-tools.org/).
=20
 In other news, QEMU is now in hard freeze for release 2.9.0.  The prelim=
inary
-list of features is on the [wiki](http://wiki.qemu.org/ChangeLog/2.9).
+list of features is on the [wiki](https://wiki.qemu.org/ChangeLog/2.9).
diff --git a/_posts/2017-08-10-deprecation.md b/_posts/2017-08-10-depreca=
tion.md
index c01a116..d0a7a35 100644
--- a/_posts/2017-08-10-deprecation.md
+++ b/_posts/2017-08-10-deprecation.md
@@ -22,5 +22,5 @@ chapter of the QEMU documentation to see whether you ar=
e still using one of
 these old interfaces or features, so you can adapt your setup to use the=
 new
 interfaces/features instead. Or if you rather think that one of the item=
s
 should *not* be removed from QEMU at all, please speak up on the
-[qemu-devel mailing list](http://wiki.qemu.org/Contribute/MailingLists)
+[qemu-devel mailing list](https://wiki.qemu.org/Contribute/MailingLists)
 to explain why the interface or feature is still required.
diff --git a/contribute.md b/contribute.md
index 4ee31db..bf4a55d 100644
--- a/contribute.md
+++ b/contribute.md
@@ -7,9 +7,9 @@ permalink: /contribute/
=20
 * Clone the git repository: <br>`git clone git://git.qemu.org/qemu.git`
=20
-* Join the mailing list: [qemu-devel@nongnu.org](http://lists.nongnu.org=
/mailman/listinfo/qemu-devel)<br>[See the list of QEMU mailing lists](htt=
p://wiki.qemu.org/MailingLists)
+* Join the mailing list: [qemu-devel@nongnu.org](https://lists.nongnu.or=
g/mailman/listinfo/qemu-devel)<br>[See the list of QEMU mailing lists](ht=
tps://wiki.qemu.org/MailingLists)
=20
 * Chat with the developers on IRC: irc.oftc.net, channel #qemu
=20
-* Read developer documentation: &ldquo;[Getting started for developers](=
http://wiki.qemu.org/Documentation/GettingStartedDevelopers)&rdquo;,
-  &ldquo;[Contributor FAQ](http://wiki.qemu.org/Contribute/FAQ)&rdquo;, =
&ldquo;[How to submit a patch](http://wiki.qemu.org/Contribute/SubmitAPat=
ch)&rdquo;
+* Read developer documentation: &ldquo;[Getting started for developers](=
https://wiki.qemu.org/Documentation/GettingStartedDevelopers)&rdquo;,
+  &ldquo;[Contributor FAQ](https://wiki.qemu.org/Contribute/FAQ)&rdquo;,=
 &ldquo;[How to submit a patch](https://wiki.qemu.org/Contribute/SubmitAP=
atch)&rdquo;
diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
index 251fb80..441c61b 100644
--- a/contribute/report-a-bug.md
+++ b/contribute/report-a-bug.md
@@ -15,12 +15,12 @@ When submitting a bug report, please try to do the fo=
llowing:
=20
 * Include information about the host and guest (operating system, versio=
n, 32/64-bit).
=20
-* Do not contribute patches on the bug tracker; send patches to the mail=
ing list. Follow QEMU's [guidelines about submitting patches](http://wiki=
.qemu.org/Contribute/SubmitAPatch).
+* Do not contribute patches on the bug tracker; send patches to the mail=
ing list. Follow QEMU's [guidelines about submitting patches](https://wik=
i.qemu.org/Contribute/SubmitAPatch).
=20
 Do NOT report security issues (or other bugs, too) as
 "private" bugs in the bug tracker.  QEMU has a [security
-process](http://wiki.qemu.org/SecurityProcess) for issues that should
+process](https://wiki.qemu.org/SecurityProcess) for issues that should
 be reported in a non-public way instead.
=20
 For problems with KVM in the kernel, use the kernel bug tracker instead;
-the [KVM wiki](http://www.linux-kvm.org/page/Bugs) has the details.
+the [KVM wiki](https://www.linux-kvm.org/page/Bugs) has the details.
diff --git a/documentation.md b/documentation.md
index 4a63cc3..f4ef9f4 100644
--- a/documentation.md
+++ b/documentation.md
@@ -4,10 +4,10 @@ permalink: /documentation/
 ---
=20
 The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be re=
ad online, courtesy of Stefan Weil.
-More documentation is found in the <a href=3D"http://git.qemu.org/?p=3Dq=
emu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
+More documentation is found in the <a href=3D"https://git.qemu.org/?p=3D=
qemu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
 directory of the QEMU git tree.
=20
-The [QEMU wiki](http://wiki.qemu.org) contains more
-[user documentation](http://wiki.qemu.org/Category:User_documentation) a=
nd
-[developer documentation](http://wiki.qemu.org/Category:Developer_docume=
ntation)
+The [QEMU wiki](https://wiki.qemu.org) contains more
+[user documentation](https://wiki.qemu.org/Category:User_documentation) =
and
+[developer documentation](https://wiki.qemu.org/Category:Developer_docum=
entation)
 that has not been integrated into the QEMU git tree.
diff --git a/index.html b/index.html
index f4c9c18..37a0fbd 100644
--- a/index.html
+++ b/index.html
@@ -62,7 +62,7 @@ $('.colorbox').on("click.random-namespace", function() =
{
=20
 		</div>
 		<hr>
-		<p>QEMU is a member of <a href=3D"http://wiki.qemu.org/Conservancy">So=
ftware Freedom Conservancy</a>.</p>
+		<p>QEMU is a member of <a href=3D"https://wiki.qemu.org/Conservancy">S=
oftware Freedom Conservancy</a>.</p>
 	</div>
 </div>
=20
--=20
2.13.5
