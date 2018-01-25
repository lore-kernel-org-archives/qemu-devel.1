Received: from eggs.gnu.org ([2001:4830:134:3::10]:59151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eemoU-000255-JV
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 14:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eemoR-0001rQ-FK
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 14:03:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eemoR-0001qp-9q
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 14:03:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4448780F4
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 19:03:49 +0000 (UTC)
Received: from red.redhat.com (ovpn-124-3.rdu2.redhat.com [10.10.124.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A86B5D977
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 19:03:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu, 25 Jan 2018 13:03:48 -0600
Message-Id: <20180125190348.8541-1-eblake@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] Link to git web view on contribute
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I was looking for a web view of qemu.git for reference, but
my first try was at https://www.qemu.org/contribute/ which
mentions how to clone but with no link for browsing.  Meanwhile,
the download page pointed people to the list of all repos (and
even then, only after you switch to the Source code tab), rather
than the qemu.git repo.  Make the link easier to find.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 _download/source.html | 2 +-
 contribute.md         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/_download/source.html b/_download/source.html
index d64d7ba..33cba41 100644
--- a/_download/source.html
+++ b/_download/source.html
@@ -9,7 +9,7 @@
 	{% include releases.html %}
 	</div>
 	<p>or stay on the bleeding edge with the
-	   <a href="https://git.qemu.org/">git repository!</a></p>
+	   <a href="https://git.qemu.org/?p=qemu.git">git repository!</a></p>

 	<h2>Build instructions</h2>

diff --git a/contribute.md b/contribute.md
index 88baee6..eb0f281 100644
--- a/contribute.md
+++ b/contribute.md
@@ -5,7 +5,7 @@ permalink: /contribute/

 * Report a bug: [https://bugs.launchpad.net/qemu/](https://bugs.launchpad.net/qemu/)<br>[How to report a bug](report-a-bug/)

-* Clone the git repository: <br>`git clone git://git.qemu.org/qemu.git`
+* Clone ([or browse](https://git.qemu.org/?p=qemu.git)) the git repository: <br>`git clone git://git.qemu.org/qemu.git`

 * Join the mailing list: [qemu-devel@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-devel)<br>[See the list of QEMU mailing lists](https://wiki.qemu.org/MailingLists)

-- 
2.14.3
