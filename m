Received: from eggs.gnu.org ([2001:4830:134:3::10]:50332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ddFr5-0004Xv-En
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ddFr1-0004Wt-Fq
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1ddFr1-0004Un-9H
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:07:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A9326E800
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 13:07:45 +0000 (UTC)
From: Jeff Cody <jcody@redhat.com>
Date: Thu,  3 Aug 2017 09:07:43 -0400
Message-Id: <fe7e4ab1254ac9eb1c6480f1920ed8d2548b4f6c.1501765516.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-web: use https:// to access some external
 assets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, pbonzini@redhat.com

Now that we are using SSL, most (all?) web browsers will by default
block loading mixed content.  There are two assets that need to be
changed (Google fonts, and jquery).

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 _includes/assets.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/_includes/assets.html b/_includes/assets.html
index 3a526a4..826a50f 100644
--- a/_includes/assets.html
+++ b/_includes/assets.html
@@ -2,7 +2,7 @@
 	<meta name="description" content="" />
 	<meta name="keywords" content="" />
 	<meta name="viewport" content="width=device-width">
-	<link href='http://fonts.googleapis.com/css?family=Roboto+Mono:300,400%7cRoboto:300,400,500' rel='stylesheet' type='text/css'>
+	<link href='https://fonts.googleapis.com/css?family=Roboto+Mono:300,400%7cRoboto:300,400,500' rel='stylesheet' type='text/css'>
 
 	<link rel="apple-touch-icon" sizes="180x180" href="/assets/favicons/apple-touch-icon.png">
 	<link rel="icon" type="image/png" sizes="32x32" href="/assets/favicons/favicon-32x32.png">
@@ -19,7 +19,7 @@
 	<link rel="stylesheet" href="/assets/css/style-mobile.css" media="(max-width:699px)"/>
 	<link rel="stylesheet" href="/assets/css/style-desktop.css" media="(min-width:700px)" />
 	<link rel="alternate" title="QEMU Blog (Atom feed)" href="/feed.xml" type="application/atom+xml" />
-	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
+	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
 	{% if page.colorbox %}
 	<script src="/assets/js/jquery.colorbox.js"></script>
 	<link rel="stylesheet" href="/assets/css/colorbox.css" />
-- 
2.9.4
