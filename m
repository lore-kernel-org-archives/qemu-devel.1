Received: from eggs.gnu.org ([2001:4830:134:3::10]:58166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSJqd-00038Z-Kd
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSJqa-0007GL-AW
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:47:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSJqa-0007Fl-4e
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:47:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 998AA3086269
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:47:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 29 Nov 2018 10:46:58 +0000
Message-Id: <20181129104658.26585-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [qemu-web PATCH v2] Document how to test the site with
 jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Add a README file that tells people this is a jekyll based static
website, and shows people how to run jekyll for testing purposes.

Tested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .gitignore  |  2 ++
 README      | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 _config.yml |  2 ++
 3 files changed, 59 insertions(+)
 create mode 100644 README

diff --git a/.gitignore b/.gitignore
index 29949d4..c744144 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,2 +1,4 @@
 /_site
 /Gemfile.lock
+/vendor
+/.bundle
diff --git a/README b/README
new file mode 100644
index 0000000..2e591fe
--- /dev/null
+++ b/README
@@ -0,0 +1,55 @@
+QEMU Website
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This repository provides content for the QEMU website.
+
+It uses the Jekyll site generator for turning the static content into
+a format which can then be directly hosted by a regular HTTP server
+such as Apache.
+
+
+Testing locally with Jekyll
+---------------------------
+
+When adding/changing content on this site, it is possible to run a
+local Jekyll service to test the result.
+
+QEMU requires a specific version of Jekyll (listedin Gemfile) which may
+not match that provided by your OS vendor. Thus as a one time step the
+required Jekyll software should be installed locally:
+
+* Install OS vendor ruby with development headers
+
+   # sudo dnf install ruby ruby-devel   (Fedora)
+   # sudo yum install ruby ruby-devel   (RHEL)
+   # sudo apt-get install ruby ruby-dev (Debian / Ubuntu)
+
+* Install OS vendor ruby gem bundler
+
+   # sudo dnf install rubygem-bundler  (Fedora)
+   # sudo yum install rubygem-bundler  (RHEL)
+   # sudo apt-get install bundler      (Debian / Ubuntu)
+
+* Install Jekyll and its dependencies
+
+   # bundle install --path vendor
+
+  NB this last command must be run from the qemu-web.git checkout
+  root directory.
+
+Jekyll is now installed into the 'vendor/' directory of the git checkout=
.
+Note the 'vendor/' path has been explicitly excluded from the web conten=
t
+in '_config.yml', so don't try to use a different path within the git
+checkout.
+
+To test the site launch jeykll
+
+  # bundle exec jekyll serve
+
+Now simply point a local web browser to http://127.0.0.1:4000 to browse
+the generated site.
+
+Jekyll will usually automatically detect changes to files in the git
+checkout and regenerate the site. It is thus not normally necessary
+to restart jekyll after changing content, unless it shows signs of being
+confused / stale.
diff --git a/_config.yml b/_config.yml
index 0a0201c..576b0a5 100644
--- a/_config.yml
+++ b/_config.yml
@@ -37,3 +37,5 @@ gems:
 exclude:
   - Gemfile
   - Gemfile.lock
+  - vendor/
+  - README
--=20
2.19.2
