Received: from eggs.gnu.org ([2001:4830:134:3::10]:55274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjn1S-00047J-Hp
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjn1R-0008Pe-Bh
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:13:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cjn1R-0008P5-5Y
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:13:25 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  3 Mar 2017 10:13:17 -0300
Message-Id: <20170303131317.23617-2-ehabkost@redhat.com>
In-Reply-To: <20170303131317.23617-1-ehabkost@redhat.com>
References: <20170303131317.23617-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] qemu-options: Rewrite -numa documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

Rewrite the -numa documentation to clarify what exactly it does.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170123180632.28942-3-ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-options.hx | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index c85f77d1d8..229243831b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -144,16 +144,34 @@ STEXI
 @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
 @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
 @findex -numa
-Simulate a multi node NUMA system. If @samp{mem}, @samp{memdev}
-and @samp{cpus} are omitted, resources are split equally. Also, note
-that the -@option{numa} option doesn't allocate any of the specified
-resources. That is, it just assigns existing resources to NUMA nodes. This
-means that one still has to use the @option{-m}, @option{-smp} options
-to allocate RAM and VCPUs respectively, and possibly @option{-object}
-to specify the memory backend for the @samp{memdev} suboption.
-
-@samp{mem} and @samp{memdev} are mutually exclusive.  Furthermore, if one
-node uses @samp{memdev}, all of them have to use it.
+Define a NUMA node and assign RAM and VCPUs to it.
+
+@var{firstcpu} and @var{lastcpu} are CPU indexes. Each
+@samp{cpus} option represent a contiguous range of CPU indexes
+(or a single VCPU if @var{lastcpu} is omitted). A non-contiguous
+set of VCPUs can be represented by providing multiple @samp{cpus}
+options. If @samp{cpus} is omitted on all nodes, VCPUs are automatically
+split between them.
+
+For example, the following option assigns VCPUs 0, 1, 2 and 5 to
+a NUMA node:
+@example
+-numa node,cpus=0-2,cpus=5
+@end example
+
+@samp{mem} assigns a given RAM amount to a node. @samp{memdev}
+assigns RAM from a given memory backend device to a node. If
+@samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
+split equally between them.
+
+@samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
+if one node uses @samp{memdev}, all of them have to use it.
+
+Note that the -@option{numa} option doesn't allocate any of the
+specified resources, it just assigns existing resources to NUMA
+nodes. This means that one still has to use the @option{-m},
+@option{-smp} options to allocate RAM and VCPUs respectively.
+
 ETEXI
 
 DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
-- 
2.11.0.259.g40922b1
