Received: from eggs.gnu.org ([2001:4830:134:3::10]:40526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cb2wD-0000wJ-D9
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cb2wA-0002UM-9c
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cb2wA-0002Se-3F
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:23:50 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4781013A5E
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 10:23:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  7 Feb 2017 11:23:41 +0100
Message-Id: <1486463022-4780-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1486463022-4780-1-git-send-email-thuth@redhat.com>
References: <1486463022-4780-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH 1/2] Add missing HTML tag to close the
 screenshots section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

The final "</section>" tag is missing here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 index.html | 1 +
 1 file changed, 1 insertion(+)

diff --git a/index.html b/index.html
index cf31912..ab33b8a 100644
--- a/index.html
+++ b/index.html
@@ -59,6 +59,7 @@ $('.colorbox').on("click.random-namespace", function() {
 })
 </script>
 
+			</section>
 		</div>
 		<hr>
 		<p>QEMU is a member of <a href="http://wiki.qemu-project.org/Conservancy">Software Freedom Conservancy</a>.</p>
-- 
1.8.3.1
