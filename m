Received: from eggs.gnu.org ([2001:4830:134:3::10]:56642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dosKV-000894-1u
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dosKP-0002hf-1Z
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:26:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dosKO-0002h0-P5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:26:16 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon,  4 Sep 2017 15:26:07 +0100
Message-Id: <20170904142608.4897-2-berrange@redhat.com>
In-Reply-To: <20170904142608.4897-1-berrange@redhat.com>
References: <20170904142608.4897-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH web 1/2] Update all links to prefer qemu.org
 over qemu-project.org
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

The qemu-project.org site sends a redirect to qemu.org, so
we should use qemu.org as a preferred link target to avoid
the redirects.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 .htaccess                                            |  6 +++---
 _download/source.html                                | 12 ++++++------
 _includes/footer.html                                | 10 +++++-----
 _includes/releases.html                              |  6 +++---
 _posts/2017-02-04-the-new-qemu-website-is-up.md      | 10 +++++-----
 _posts/2017-03-19-qemu-in-the-blogs-february-2017.md |  2 +-
 contribute.md                                        |  8 ++++----
 documentation.md                                     |  8 ++++----
 index.html                                           |  2 +-
 9 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/.htaccess b/.htaccess
index c037a2c..73da09b 100644
--- a/.htaccess
+++ b/.htaccess
@@ -3,6 +3,6 @@ RewriteBase /
 RewriteRule ^Download$       /download/                          [R=301]
 RewriteRule ^Contribute$     /contribute/                        [R=301]
 RewriteRule ^Documentation$  /documentation/                     [R=301]
-RewriteRule ^[A-Z].*         http://wiki.qemu-project.org/$0     [NE,R]
-RewriteRule ^download(/.+)   http://download.qemu-project.org$1  [NE,R]
-RewriteRule ^images(/.+)   http://wiki.qemu-project.org/images$1 [NE,R]
+RewriteRule ^[A-Z].*         http://wiki.qemu.org/$0     [NE,R]
+RewriteRule ^download(/.+)   http://download.qemu.org$1  [NE,R]
+RewriteRule ^images(/.+)   http://wiki.qemu.org/images$1 [NE,R]
diff --git a/_download/source.html b/_download/source.html
index d090a5e..5e06ee7 100644
--- a/_download/source.html
+++ b/_download/source.html
@@ -1,21 +1,21 @@
 
 	<p>Grab the source code for the latest releases and compile it yourself!
 	Detailed compilation instructions can be found in the wiki for
-		<a href="http://wiki.qemu-project.org/Hosts/Linux">Linux</a>,
-		<a href="http://wiki.qemu-project.org/Hosts/Windows">Win32</a> and
-		<a href="http://wiki.qemu-project.org/Hosts/Mac">macOS</a>.</p>
+		<a href="http://wiki.qemu.org/Hosts/Linux">Linux</a>,
+		<a href="http://wiki.qemu.org/Hosts/Windows">Win32</a> and
+		<a href="http://wiki.qemu.org/Hosts/Mac">macOS</a>.</p>
 
 	<div id="releases">
 	{% include releases.html %}
 	</div>
 	<p>or stay on the bleeding edge with the
-	   <a href="http://git.qemu-project.org/">git repository!</a></p>
+	   <a href="http://git.qemu.org/">git repository!</a></p>
 
 	<h2>Build instructions</h2>
 
 	{% for release in site.data.releases offset: 0 limit: 1 %}
 	<p>To download and build QEMU {{release.branch}}.{{release.patch}}:</p>
-<pre>wget http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz
+<pre>wget http://download.qemu.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz
 tar xvJf qemu-{{release.branch}}.{{release.patch}}.tar.xz
 cd qemu-{{release.branch}}.{{release.patch}}
 ./configure
@@ -24,7 +24,7 @@ make
 	{% endfor %}
 
 	<p>To download and build QEMU from git:</p>
-<pre>git clone git://git.qemu-project.org/qemu.git
+<pre>git clone git://git.qemu.org/qemu.git
 cd qemu
 git submodule init
 git submodule update --recursive
diff --git a/_includes/footer.html b/_includes/footer.html
index 7a3e8b1..979a477 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -8,15 +8,15 @@
 		<ul class="style">
 			<li><a href="/contribute">Contribute</a></li>
 			<li><a href="/contribute/report-a-bug">Reporting a bug</a></li>
-			<li><a href="http://wiki.qemu-project.org/Documentation/GettingStartedDevelopers">New contributors</a></li>
-			<li><a href="http://wiki.qemu-project.org/Contribute/SubmitAPatch">Submitting a patch</a></li>
-			<li><a href="http://wiki.qemu-project.org/Contribute/FAQ">Contributor FAQ</a></li>
+			<li><a href="http://wiki.qemu.org/Documentation/GettingStartedDevelopers">New contributors</a></li>
+			<li><a href="http://wiki.qemu.org/Contribute/SubmitAPatch">Submitting a patch</a></li>
+			<li><a href="http://wiki.qemu.org/Contribute/FAQ">Contributor FAQ</a></li>
 		</ul>
 		<ul class="style">
 			<li><a href="/documentation">Documentation</a></li>
 			<li><a href="https://qemu.weilnetz.de/qemu-doc.html">Manual</a></li>
-			<li><a href="http://wiki.qemu-project.org/Category:Developer_documentation">Developer docs</a></li>
-			<li><a href="http://wiki.qemu-project.org/">Wiki</a></li>
+			<li><a href="http://wiki.qemu.org/Category:Developer_documentation">Developer docs</a></li>
+			<li><a href="http://wiki.qemu.org/">Wiki</a></li>
 		</ul>
 		<ul class="style">
 			<li><a href="http://planet.virt-tools.org/">virt tools planet</a></li>
diff --git a/_includes/releases.html b/_includes/releases.html
index 683d552..4881f83 100644
--- a/_includes/releases.html
+++ b/_includes/releases.html
@@ -1,10 +1,10 @@
 <ul>
 {% for release in site.data.releases offset: 0 limit: 4 %}
 <li><strong><a
-  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz">{{release.branch}}.{{release.patch}}</a></strong>
+  href="http://download.qemu.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz">{{release.branch}}.{{release.patch}}</a></strong>
   {{release.date}}<br><a
-  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz.sig">signature</a> &mdash; <a
-  href="http://wiki.qemu-project.org/ChangeLog/{{release.branch}}">changes</a></li>
+  href="http://download.qemu.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz.sig">signature</a> &mdash; <a
+  href="http://wiki.qemu.org/ChangeLog/{{release.branch}}">changes</a></li>
 {% endfor %}
 </ul>
 <p><a {% if page.url == '/' %}class="button"{%endif%} href="http://download.qemu.org/">Full list of releases</a><p>
diff --git a/_posts/2017-02-04-the-new-qemu-website-is-up.md b/_posts/2017-02-04-the-new-qemu-website-is-up.md
index 692e561..6dc5eeb 100644
--- a/_posts/2017-02-04-the-new-qemu-website-is-up.md
+++ b/_posts/2017-02-04-the-new-qemu-website-is-up.md
@@ -9,13 +9,13 @@ At last, QEMU's new website is up!
 
 The new site aims to be simple and provides the basic information
 needed to download and start contributing to QEMU.  It complements the
-[wiki](http://wiki.qemu-project.org/), which remains the central point for
+[wiki](http://wiki.qemu.org/), which remains the central point for
 developers to share information quickly with the rest of the community.
 
 We tried to test the website on most browsers and to make it lightweight
 and responsive.  It is built using [Jekyll](https://jekyllrb.com/)
 and the source code for the website can be cloned from the
-[qemu-web.git](http://git.qemu-project.org/?p=qemu-web.git;a=summary)
+[qemu-web.git](http://git.qemu.org/?p=qemu-web.git;a=summary)
 repository.  Just like for any other project hosted by QEMU, the best way
 to propose or contribute a new change is by sending a patch through the
 [qemu-devel@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-devel)
@@ -23,10 +23,10 @@ mailing list.
 
 For example, if you would like to add a new screenshot to the homepage,
 you can clone the `qemu-web.git` repository, add a PNG file to the
-[`screenshots/`](http://git.qemu-project.org/?p=qemu-web.git;a=tree;f=screenshots;hb=HEAD)
-directory, and edit the [`_data/screenshots.yml`](http://git.qemu-project.org/?p=qemu-web.git;a=blob;f=_data/screenshots.yml;hb=HEAD)
+[`screenshots/`](http://git.qemu.org/?p=qemu-web.git;a=tree;f=screenshots;hb=HEAD)
+directory, and edit the [`_data/screenshots.yml`](http://git.qemu.org/?p=qemu-web.git;a=blob;f=_data/screenshots.yml;hb=HEAD)
 file to include the new screenshot.
 
 Blog posts about QEMU are also welcome; they are simple HTML or Markdown
-files and are stored in the [`_posts/`](http://git.qemu-project.org/?p=qemu-web.git;a=tree;f=_posts;hb=HEAD)
+files and are stored in the [`_posts/`](http://git.qemu.org/?p=qemu-web.git;a=tree;f=_posts;hb=HEAD)
 directory of the repository.
diff --git a/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md b/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md
index 6540f45..42af6d2 100644
--- a/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md
+++ b/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md
@@ -32,4 +32,4 @@ More virtualization blog posts can be found on the [virt tools
 planet](http://planet.virt-tools.org/).
 
 In other news, QEMU is now in hard freeze for release 2.9.0.  The preliminary
-list of features is on the [wiki](http://wiki.qemu-project.org/ChangeLog/2.9).
+list of features is on the [wiki](http://wiki.qemu.org/ChangeLog/2.9).
diff --git a/contribute.md b/contribute.md
index b10ba7f..4ee31db 100644
--- a/contribute.md
+++ b/contribute.md
@@ -5,11 +5,11 @@ permalink: /contribute/
 
 * Report a bug: [https://bugs.launchpad.net/qemu/](https://bugs.launchpad.net/qemu/)<br>[How to report a bug](report-a-bug/)
 
-* Clone the git repository: <br>`git clone git://git.qemu-project.org/qemu.git`
+* Clone the git repository: <br>`git clone git://git.qemu.org/qemu.git`
 
-* Join the mailing list: [qemu-devel@nongnu.org](http://lists.nongnu.org/mailman/listinfo/qemu-devel)<br>[See the list of QEMU mailing lists](http://wiki.qemu-project.org/MailingLists)
+* Join the mailing list: [qemu-devel@nongnu.org](http://lists.nongnu.org/mailman/listinfo/qemu-devel)<br>[See the list of QEMU mailing lists](http://wiki.qemu.org/MailingLists)
 
 * Chat with the developers on IRC: irc.oftc.net, channel #qemu
 
-* Read developer documentation: &ldquo;[Getting started for developers](http://wiki.qemu-project.org/Documentation/GettingStartedDevelopers)&rdquo;,
-  &ldquo;[Contributor FAQ](http://wiki.qemu-project.org/Contribute/FAQ)&rdquo;, &ldquo;[How to submit a patch](http://wiki.qemu-project.org/Contribute/SubmitAPatch)&rdquo;
+* Read developer documentation: &ldquo;[Getting started for developers](http://wiki.qemu.org/Documentation/GettingStartedDevelopers)&rdquo;,
+  &ldquo;[Contributor FAQ](http://wiki.qemu.org/Contribute/FAQ)&rdquo;, &ldquo;[How to submit a patch](http://wiki.qemu.org/Contribute/SubmitAPatch)&rdquo;
diff --git a/documentation.md b/documentation.md
index de6acb9..4a63cc3 100644
--- a/documentation.md
+++ b/documentation.md
@@ -4,10 +4,10 @@ permalink: /documentation/
 ---
 
 The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be read online, courtesy of Stefan Weil.
-More documentation is found in the <a href="http://git.qemu-project.org/?p=qemu.git;a=tree;f=docs;hb=master">`docs`</a>
+More documentation is found in the <a href="http://git.qemu.org/?p=qemu.git;a=tree;f=docs;hb=master">`docs`</a>
 directory of the QEMU git tree.
 
-The [QEMU wiki](http://wiki.qemu-project.org) contains more
-[user documentation](http://wiki.qemu-project.org/Category:User_documentation) and
-[developer documentation](http://wiki.qemu-project.org/Category:Developer_documentation)
+The [QEMU wiki](http://wiki.qemu.org) contains more
+[user documentation](http://wiki.qemu.org/Category:User_documentation) and
+[developer documentation](http://wiki.qemu.org/Category:Developer_documentation)
 that has not been integrated into the QEMU git tree.
diff --git a/index.html b/index.html
index 5a78a15..f4c9c18 100644
--- a/index.html
+++ b/index.html
@@ -62,7 +62,7 @@ $('.colorbox').on("click.random-namespace", function() {
 
 		</div>
 		<hr>
-		<p>QEMU is a member of <a href="http://wiki.qemu-project.org/Conservancy">Software Freedom Conservancy</a>.</p>
+		<p>QEMU is a member of <a href="http://wiki.qemu.org/Conservancy">Software Freedom Conservancy</a>.</p>
 	</div>
 </div>
 
-- 
2.13.5
