Received: from eggs.gnu.org ([2001:4830:134:3::10]:60596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhAxK-0004Bi-JW
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhAxH-0002wW-OV
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:42:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17025)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dhAxH-0002wI-HI
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:42:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B886C04B008
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 08:42:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 Aug 2017 10:42:31 +0200
Message-Id: <20170814084231.10342-2-pbonzini@redhat.com>
In-Reply-To: <20170814084231.10342-1-pbonzini@redhat.com>
References: <20170814084231.10342-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] qemu-doc: Fix "-net van" typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

While Andrew S. Tanenbaum has a point by saying "Never underestimate the
bandwidth of a station wagon full of tapes hurtling down the highway",
we don't support that way of transportation in QEMU yet, so replace the
typo with the correct word "vlan".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1502365466-19432-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index aeb7bc52f5..4fc6b6f077 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -3243,7 +3243,7 @@ the ``-netdev user,guestfwd=ARGS'' argument instead.
 
 @subsection -net vlan (since 2.9.0)
 
-The ``-net van=NN'' argument is partially replaced with the
+The ``-net vlan=NN'' argument is partially replaced with the
 new ``-netdev'' argument. The remaining use cases will no
 longer be directly supported in QEMU.
 
-- 
2.13.3
