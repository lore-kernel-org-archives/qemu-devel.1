Received: from eggs.gnu.org ([2001:4830:134:3::10]:36660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9e-0003Sx-Qn
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9d-0006cc-TR
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:34 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9d-0006bp-Ni
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:33 -0400
Received: by mail-wm0-x241.google.com with SMTP id z63so594514wmg.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:10 +0100
Message-Id: <1489508300-48184-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/18] configure: add the missing help output
 for optional features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lin Ma <lma@suse.com>

From: Lin Ma <lma@suse.com>

Signed-off-by: Lin Ma <lma@suse.com>
Message-Id: <20170310101405.26974-1-lma@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configure b/configure
index 75c7c35..99d8bec 100755
--- a/configure
+++ b/configure
@@ -1330,6 +1330,12 @@ Advanced options (experts only):
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
@@ -1397,6 +1403,12 @@ disabled with --disable-FEATURE, default is enabled if available:
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
1.8.3.1
