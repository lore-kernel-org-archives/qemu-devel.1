Received: from eggs.gnu.org ([2001:4830:134:3::10]:53816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK4El-0000uh-SY
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK4Eh-0006zR-TU
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:25:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eK4Eh-0006zE-Ng
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:25:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1D6385A07
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 15:25:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 29 Nov 2017 09:25:10 -0600
Message-Id: <20171129152510.25833-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] maint: Mention web site maintenance in README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com

Now that we have a website that accepts patches on the list, the
main project should make it easier to find information about that
process.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Doc only, so it could go in -rc3 if we have a reason to slip it
in this late; but I'm also fine if it waits for 2.12.

 README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README b/README
index b92a07a61a..2c8e1c8cc4 100644
--- a/README
+++ b/README
@@ -68,6 +68,10 @@ the QEMU website
   https://qemu.org/Contribute/SubmitAPatch
   https://qemu.org/Contribute/TrivialPatches

+The QEMU website is also maintained under source control.
+
+  git clone git://git.qemu.org/qemu-web.git
+  https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/

 Bug reporting
 =============
-- 
2.14.3
