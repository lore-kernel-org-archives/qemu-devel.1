Received: from eggs.gnu.org ([2001:4830:134:3::10]:48177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eJhHa-0002ri-20
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eJhHU-0002hW-JF
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:54:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eJhHU-0002gx-Co
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:54:40 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 28 Nov 2017 15:53:58 +0100
Message-Id: <1511880838-56509-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] numa: fix missing '-numa cpu' in '-help' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, eblake@redhat.com, mjt@tls.msk.ru, armbru@redhat.com

commit 419fcdec3c (numa: add '-numa cpu,...' option for property based node mapping)
added '-numa cpu' option but forgot to update appropriate section for '--help'.
Add '-numa cpu' description to '-help' output

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 qemu-options.hx | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index df19cf2..972a5c6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -163,7 +163,9 @@ ETEXI
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
     "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
-    "-numa dist,src=source,dst=destination,val=distance\n", QEMU_ARCH_ALL)
+    "-numa dist,src=source,dst=destination,val=distance\n"
+    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
+    QEMU_ARCH_ALL)
 STEXI
 @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
 @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
-- 
2.7.4
