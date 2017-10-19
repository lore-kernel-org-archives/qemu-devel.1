Received: from eggs.gnu.org ([2001:4830:134:3::10]:53920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Bp7-0000gG-CK
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Bp6-00064B-Nj
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5Bp6-00063k-HV
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FCA66CB26
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:29:23 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 19 Oct 2017 15:28:48 +0100
Message-Id: <20171019142848.572-10-berrange@redhat.com>
In-Reply-To: <20171019142848.572-1-berrange@redhat.com>
References: <20171019142848.572-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 9/9] ui: pull in latest keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Latest keycodemapdb has a fix for Sun keyboard Pause mapping
and backcompat fix for QEMU's treatment of 0xb7 as an alternative
to 0x54 for triggering Print/SysRq

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/keycodemapdb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/keycodemapdb b/ui/keycodemapdb
index 56ce5650d2..10739aa260 160000
--- a/ui/keycodemapdb
+++ b/ui/keycodemapdb
@@ -1 +1 @@
-Subproject commit 56ce5650d2c6ea216b4580df44b9a6dd3bc92c3b
+Subproject commit 10739aa26051a5d49d88132604539d3ed085e72e
-- 
2.13.6
