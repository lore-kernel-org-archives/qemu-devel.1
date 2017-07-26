Received: from eggs.gnu.org ([2001:4830:134:3::10]:38252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daLv1-0005QW-Az
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daLuy-0007s3-Ab
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:00:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1daLuy-0007rR-4x
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:00:00 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 26 Jul 2017 14:59:52 +0200
Message-Id: <1501073992-6297-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] Change the "Full list of releases"
 link to point to download.qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, Jeff Cody <jcody@redhat.com>

The list in the Wiki is not up to date anymore, so let's simply point
the users to the file list on the download server instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 _includes/releases.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/_includes/releases.html b/_includes/releases.html
index 226c719..683d552 100644
--- a/_includes/releases.html
+++ b/_includes/releases.html
@@ -7,4 +7,4 @@
   href="http://wiki.qemu-project.org/ChangeLog/{{release.branch}}">changes</a></li>
 {% endfor %}
 </ul>
-<p><a {% if page.url == '/' %}class="button"{%endif%} href="http://wiki.qemu-project.org/Main_Page#News">Full list of releases</a><p>
+<p><a {% if page.url == '/' %}class="button"{%endif%} href="http://download.qemu.org/">Full list of releases</a><p>
-- 
1.8.3.1
