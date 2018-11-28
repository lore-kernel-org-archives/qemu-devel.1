Received: from eggs.gnu.org ([2001:4830:134:3::10]:43713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS1sD-0001NF-P4
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS1sA-0008TW-LW
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:35:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gS1sA-0008Sr-Ec
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:35:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8198C30023FD
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 15:35:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 28 Nov 2018 15:35:26 +0000
Message-Id: <20181128153526.10948-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [qemu-web PATCH] Document how to test the site with
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
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Add a README file that tells people this is a jekyll based static
website, and shows people how to run jekyll for testing purposes.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

NB, we should really mention a license in the README too, but I don't
see info about what license we consider qemu-web to be covered by...

 README      | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 _config.yml |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100644 README

diff --git a/README b/README
new file mode 100644
index 0000000..d06606a
--- /dev/null
+++ b/README
@@ -0,0 +1,53 @@
+QEMU Webite
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
+QEMU requires a specific version of Jekyll which may not match that
+provided by your OS vendor. Thus as a one time step the Jekyll software
+must be installed locally as follows:
+
+* Install OS vendor ruby with development headers
+
+   # sudo dnf install ruby ruby-devel  (Fedora)
+   # sudo yum install ruby ruby-devel  (RHEL)
+   # sudo apt-get install ruby ruby-dev (Debian / Ubuntu)
+
+* Install OS vendor ruby gem bundler
+
+   # sudo dnf install rubygem-bundler  (Fedora)
+   # sudo yum install rubygem-bundler  (RHEL)
+   # sudo apt-get install bundler (Debian / Ubuntu)
+
+* Install Jekyll and its dependencies
+
+   # bundle install --path vendor
+
+Jekyll is now installed into the 'vendor/' directory of the git checkout=
.
+Note the 'vendor/' path has been explicitly excluded from the web conten=
t
+in _config.yml, so don't try to use a different path within the git
+checkout.
+
+
+To test the site launch jeykll
+
+  # bundle exec jekyll serve
+
+Now simply point a local web browser to http://127.0.0.1:4000 to browse
+the generated site.
+
+Jekyll will usually automatically detect changes to files in the git
+checkout and regenerate the site. It is thus not normally neccessary
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
