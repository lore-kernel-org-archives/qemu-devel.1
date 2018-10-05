Received: from eggs.gnu.org ([2001:4830:134:3::10]:43232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8O1e-00036j-Lk
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8O1b-0003q7-D9
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8O1b-0003pY-71
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90DC63084040
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 11:12:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 Oct 2018 13:11:54 +0200
Message-Id: <20181005111157.12801-2-kraxel@redhat.com>
In-Reply-To: <20181005111157.12801-1-kraxel@redhat.com>
References: <20181005111157.12801-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] edid: Ignore built binary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

Added in commit 72d277a7.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20181004140522.945682-1-eblake@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 5668d02782..64efdfd929 100644
--- a/.gitignore
+++ b/.gitignore
@@ -107,6 +107,7 @@
 /qemu-doc.html
 /qemu-doc.info
 /qemu-doc.txt
+/qemu-edid
 /qemu-img
 /qemu-nbd
 /qemu-options.def
-- 
2.9.3
