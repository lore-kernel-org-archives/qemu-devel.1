Received: from eggs.gnu.org ([2001:4830:134:3::10]:41623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVj0s-00081S-Lv
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVj0r-00031d-DD
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:06:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVj0r-00031W-7E
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:06:41 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 16:06:31 -0200
Message-Id: <20170123180632.28942-2-ehabkost@redhat.com>
In-Reply-To: <20170123180632.28942-1-ehabkost@redhat.com>
References: <20170123180632.28942-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-options: Rename variables on the
 -numa "cpus" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Use @var{firstcpu} and @var{lastcpu} to make the metasyntatic
variables a bit clearer. While doing this, use @var only around
the metasyntatic variables, not including the square brackets and
hyphen.

The semantics of the "cpus" option will be clarified by rewriting
the whole -numa documentation in a follow-up patch.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-options.hx | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 80df52651a..780528d6ad 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -119,11 +119,11 @@ specifies the maximum number of hotpluggable CPUs.
 ETEXI
 
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
-    "-numa node[,mem=size][,cpus=cpu[-cpu]][,nodeid=node]\n"
-    "-numa node[,memdev=id][,cpus=cpu[-cpu]][,nodeid=node]\n", QEMU_ARCH_ALL)
+    "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
+    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n", QEMU_ARCH_ALL)
 STEXI
-@item -numa node[,mem=@var{size}][,cpus=@var{cpu[-cpu]}][,nodeid=@var{node}]
-@itemx -numa node[,memdev=@var{id}][,cpus=@var{cpu[-cpu]}][,nodeid=@var{node}]
+@item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
+@itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
 @findex -numa
 Simulate a multi node NUMA system. If @samp{mem}, @samp{memdev}
 and @samp{cpus} are omitted, resources are split equally. Also, note
-- 
2.11.0.259.g40922b1
