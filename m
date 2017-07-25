Received: from eggs.gnu.org ([2001:4830:134:3::10]:36775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZxh8-0001MZ-Ek
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZxh4-0001bz-C3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dZxh4-0001bg-5p
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:08:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BE4CC013C53
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 11:08:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 25 Jul 2017 13:07:59 +0200
Message-Id: <1500980879-28505-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] Add a blog post about deprecation of
 old interfaces and features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

The list of deprecated interfaces/features in the wiki should be pretty
complete now, so it is now time to draw some more public attention to our
plans of removing certain interfaces/features in future releases.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 _posts/2017-07-25-deprecation.md | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 _posts/2017-07-25-deprecation.md

diff --git a/_posts/2017-07-25-deprecation.md b/_posts/2017-07-25-deprecation.md
new file mode 100644
index 0000000..b5eaf0b
--- /dev/null
+++ b/_posts/2017-07-25-deprecation.md
@@ -0,0 +1,26 @@
+---
+layout: post
+title:  "Deprecation of old parameters and features"
+date:   2017-07-25 9:00:00 +0200
+author: Thomas Huth
+categories: [features, 'web site']
+---
+QEMU has a lot of interfaces (like command line options or HMP commands) and
+old features (like certain devices) which are considered as deprecated
+since other more generic or better interfaces/features have been established
+instead. While the QEMU developers are generally trying to keep each QEMU
+release compatible with the previous ones, the old legacy sometimes gets into
+the way when developing new code and/or causes quite some burden of maintaining
+it.
+
+Thus we are currently considering to get rid of some of the old interfaces
+and features in a future release and have started to collect a list of such
+old items in our Wiki on a
+[page about removing legacy parts](http://wiki.qemu.org/Features/LegacyRemoval).
+If you are running QEMU directly, please have a look at this page to see
+whether you are still using one of these old interfaces or features, so you
+can adapt your setup to use the new interfaces or features instead. Or if
+you rather think that one of the legacy interfaces/features should *not* be
+removed from QEMU at all, please speak up on the
+[qemu-devel mailing list](http://wiki.qemu.org/Contribute/MailingLists)
+to explain why the interface or feature is still required.
-- 
1.8.3.1
