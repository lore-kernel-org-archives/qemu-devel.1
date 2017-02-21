Received: from eggs.gnu.org ([2001:4830:134:3::10]:53874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiK-0002qh-DB
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiI-0004Sq-M1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgIiI-0004SN-Gg
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:14 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5C25C04BD2E
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 22:15:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 23:14:55 +0100
Message-Id: <1487715299-21102-6-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 5/9] enable -g command line switch for all archs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Virtual display adapters will learn to use graphic_* variables
(which are set by the -g switch), so enable this for all archs.

RfC:  Maybe restrict to PCI-capable archs?
      Or would that be pretty much anything anyway?

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 809b2b0..4e89610 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1237,7 +1237,7 @@ ETEXI
 
 DEF("g", 1, QEMU_OPTION_g ,
     "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
-    QEMU_ARCH_PPC | QEMU_ARCH_SPARC)
+    QEMU_ARCH_ALL)
 STEXI
 @item -g @var{width}x@var{height}[x@var{depth}]
 @findex -g
-- 
1.8.3.1
