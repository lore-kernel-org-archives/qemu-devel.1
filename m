Received: from eggs.gnu.org ([2001:4830:134:3::10]:53509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cmHZ4-0002vv-9R
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cmHZ1-0000YS-5Y
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:14:26 -0500
Received: from victor.provo.novell.com ([137.65.250.26]:57104
	helo=prv3-mh.provo.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1cmHZ0-0000Xl-R4
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:14:23 -0500
From: Lin Ma <lma@suse.com>
Date: Fri, 10 Mar 2017 18:14:05 +0800
Message-Id: <20170310101405.26974-1-lma@suse.com>
Subject: [Qemu-devel] [PATCH] configure: add the missing help output for
 optional features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mjt@tls.msk.ru

Signed-off-by: Lin Ma <lma@suse.com>
---
 configure | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configure b/configure
index 6c21975..2603e10 100755
--- a/configure
+++ b/configure
@@ -1335,6 +1335,12 @@ Advanced options (experts only):
   --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
   --with-win-sdk=SDK-path  path to Windows Platform SDK (to build VSS .tlb)
   --tls-priority           default TLS protocol/cipher priority string
+  --enable-gprof           QEMU profiling with gprof
+  --enable-profiler        profiler support
+  --enable-xen-pv-domain-build
+                           xen pv domain builder
+  --enable-debug-stack-usage
+                           track the maximum stack usage of stacks created by qemu_alloc_stack
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -1403,6 +1409,12 @@ disabled with --disable-FEATURE, default is enabled if available:
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
   replication     replication support
+  vhost-vsock     virtio sockets device support
+  opengl          opengl support
+  virglrenderer   virgl rendering support
+  xfsctl          xfsctl support
+  qom-cast-debug  cast debugging support
+  tools           build qemu-io, qemu-nbd and qemu-image tools
 
 NOTE: The object files are built at the place where configure is launched
 EOF
-- 
2.9.2
