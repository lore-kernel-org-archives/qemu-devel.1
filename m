Received: from eggs.gnu.org ([2001:4830:134:3::10]:49090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHY1r-0000Fa-KI
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHY1o-0003oi-Hu
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:37:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHY1o-0003o9-CQ
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:37:36 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81CBF76529
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 16:37:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 Nov 2017 17:37:33 +0100
Message-Id: <20171122163733.4007-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] css: avoid over-large images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com

Make sure that images are scaled to fit inside their container.

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 assets/css/style.css | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/assets/css/style.css b/assets/css/style.css
index 2d4fe0c..b828887 100644
--- a/assets/css/style.css
+++ b/assets/css/style.css
@@ -200,6 +200,10 @@
 
 	/* Images */
 
+		img {
+			max-width: 100%;
+		}
+
 		.image
 		{
 			display: inline-block;
-- 
2.14.3
