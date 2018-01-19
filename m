Received: from eggs.gnu.org ([2001:4830:134:3::10]:45404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZcl-0005ki-2B
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZck-0006dn-B2
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:34:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecZck-0006dN-5i
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:34:38 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Jan 2018 14:33:31 -0200
Message-Id: <20180119163345.10649-6-ehabkost@redhat.com>
In-Reply-To: <20180119163345.10649-1-ehabkost@redhat.com>
References: <20180119163345.10649-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 05/19] numa: fix missing '-numa cpu' in
 '-help' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

commit 419fcdec3c (numa: add '-numa cpu,...' option for property based node mapping)
added '-numa cpu' option but forgot to update appropriate section for '--help'.
Add '-numa cpu' description to '-help' output

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1511880838-56509-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-options.hx | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 5b0ee43b18..b3e03c5464 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -169,7 +169,9 @@ ETEXI
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
2.14.3
