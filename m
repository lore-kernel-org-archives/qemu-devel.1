Received: from eggs.gnu.org ([2001:4830:134:3::10]:52064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cakVe-0002I2-E7
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cakVZ-0003zb-Ph
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:43:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cakVZ-0003zR-KV
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:43:09 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C40BB80F8F
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 14:43:09 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-14.ams2.redhat.com
	[10.36.117.14])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v16Eh8pA002818
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 09:43:09 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  6 Feb 2017 15:43:07 +0100
Message-Id: <20170206144307.18290-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH qemu-web] add <link> tag for /feed.xml
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	Just an example of what a website patch would look like.

 _includes/assets.html | 1 +
 1 file changed, 1 insertion(+)

diff --git a/_includes/assets.html b/_includes/assets.html
index e3f09e0..77c2942 100644
--- a/_includes/assets.html
+++ b/_includes/assets.html
@@ -9,6 +9,7 @@
 	<link rel="stylesheet" href="/assets/css/style.css" />
 	<link rel="stylesheet" href="/assets/css/style-mobile.css" media="(max-width:699px)"/>
 	<link rel="stylesheet" href="/assets/css/style-desktop.css" media="(min-width:700px)" />
+	<link rel="alternate" title="QEMU Blog (Atom feed)" href="/feed.xml" type="application/atom+xml" />
 	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
 	{% if page.colorbox %}
 	<script src="/assets/js/jquery.colorbox.js"></script>
-- 
2.9.3
