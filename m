Received: from eggs.gnu.org ([2001:4830:134:3::10]:37673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJQoB-0003kv-7r
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJQo7-00036a-Kk
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:23:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gJQo6-00020j-NJ
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:23:47 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun,  4 Nov 2018 23:23:12 +0100
Message-Id: <20181104222312.3548-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] Use 'https://' instead of 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, famz@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org, jcody@redhat.com, berrange@redhat.com

Jeff Cody has enabled git smart HTTP support on qemu.org.  From now on HTTPS is
the preferred protocol because it adds some protection against
man-in-the-middle when cloning a repo.

This patch series updates git:// URLs and changes them to https://.  The https:// URL format is:

  https://git.qemu.org/git/<project>.git

The old git:// URL format was:

  git://git.qemu.org/<project>.git

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 _download/source.html | 2 +-
 contribute.md         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/_download/source.html b/_download/source.html
index 33cba41..aacd1e0 100644
--- a/_download/source.html
+++ b/_download/source.html
@@ -24,7 +24,7 @@ make
 	{% endfor %}
 
 	<p>To download and build QEMU from git:</p>
-<pre>git clone git://git.qemu.org/qemu.git
+<pre>git clone https://git.qemu.org/git/qemu.git
 cd qemu
 git submodule init
 git submodule update --recursive
diff --git a/contribute.md b/contribute.md
index eb0f281..56306e0 100644
--- a/contribute.md
+++ b/contribute.md
@@ -5,7 +5,7 @@ permalink: /contribute/
 
 * Report a bug: [https://bugs.launchpad.net/qemu/](https://bugs.launchpad.net/qemu/)<br>[How to report a bug](report-a-bug/)
 
-* Clone ([or browse](https://git.qemu.org/?p=qemu.git)) the git repository: <br>`git clone git://git.qemu.org/qemu.git`
+* Clone ([or browse](https://git.qemu.org/?p=qemu.git)) the git repository: <br>`git clone https://git.qemu.org/git/qemu.git`
 
 * Join the mailing list: [qemu-devel@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-devel)<br>[See the list of QEMU mailing lists](https://wiki.qemu.org/MailingLists)
 
-- 
2.17.1
