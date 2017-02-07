Received: from eggs.gnu.org ([2001:4830:134:3::10]:45878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cb8BX-0003dV-7C
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cb8BS-0006mS-QC
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:00:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cb8BS-0006lE-KV
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:59:58 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  7 Feb 2017 16:59:56 +0100
Message-Id: <20170207155956.21573-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

I have converted all .gz and .bz2 files to .xz on download.qemu.org
and this patch would change the links in the website.  This would save
about 5 GB of bandwidth every day (about 20% savings).

xz should be available for all platforms.  Besides providing better
compression ratios, decompression of .xz files is about twice as fast
compared to bzip2.  Compression instead is about 5.5 times slower.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 _download/source.html   | 4 ++--
 _includes/releases.html | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/_download/source.html b/_download/source.html
index 1ac8f4f..d090a5e 100644
--- a/_download/source.html
+++ b/_download/source.html
@@ -15,8 +15,8 @@
 
 	{% for release in site.data.releases offset: 0 limit: 1 %}
 	<p>To download and build QEMU {{release.branch}}.{{release.patch}}:</p>
-<pre>wget http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.bz2
-tar xvjf qemu-{{release.branch}}.{{release.patch}}.tar.bz2
+<pre>wget http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz
+tar xvJf qemu-{{release.branch}}.{{release.patch}}.tar.xz
 cd qemu-{{release.branch}}.{{release.patch}}
 ./configure
 make
diff --git a/_includes/releases.html b/_includes/releases.html
index 2caab8d..226c719 100644
--- a/_includes/releases.html
+++ b/_includes/releases.html
@@ -1,9 +1,9 @@
 <ul>
 {% for release in site.data.releases offset: 0 limit: 4 %}
 <li><strong><a
-  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.bz2">{{release.branch}}.{{release.patch}}</a></strong>
+  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz">{{release.branch}}.{{release.patch}}</a></strong>
   {{release.date}}<br><a
-  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.bz2.sig">signature</a> &mdash; <a
+  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz.sig">signature</a> &mdash; <a
   href="http://wiki.qemu-project.org/ChangeLog/{{release.branch}}">changes</a></li>
 {% endfor %}
 </ul>
-- 
2.9.3
