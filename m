Received: from eggs.gnu.org ([209.51.188.92]:39260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1grJ3n-0007BY-J2
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1grJ0m-0004J9-Gu
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 03:56:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:63226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1grJ0k-000481-Bs
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 03:56:50 -0500
From: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Date: Thu,  7 Feb 2019 01:27:01 +0800
Message-Id: <f6bd986c4b3205f8fe3610dc3680766c3ad624f0.1549473586.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1549473586.git.yi.z.zhang@linux.intel.com>
References: <cover.1549473586.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH V12 2/5] scripts/update-linux-headers: add
 linux/mman.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

Add linux/mman.h,asm/mman.h,asm/mman-common.h to linux-headers,
So we can use more mmap2 flags.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 scripts/update-linux-headers.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 0a964fe..57db5d9 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -95,7 +95,7 @@ for arch in $ARCHLIST; do
 
     rm -rf "$output/linux-headers/asm-$arch"
     mkdir -p "$output/linux-headers/asm-$arch"
-    for header in kvm.h unistd.h bitsperlong.h; do
+    for header in kvm.h unistd.h bitsperlong.h mman.h; do
         cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
     done
 
@@ -126,13 +126,13 @@ done
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in kvm.h vfio.h vfio_ccw.h vhost.h \
-              psci.h psp-sev.h userfaultfd.h; do
+              psci.h psp-sev.h userfaultfd.h mman.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
 rm -rf "$output/linux-headers/asm-generic"
 mkdir -p "$output/linux-headers/asm-generic"
-for header in unistd.h bitsperlong.h; do
+for header in unistd.h bitsperlong.h mman-common.h mman.h hugetlb_encode.h; do
     cp "$tmpdir/include/asm-generic/$header" "$output/linux-headers/asm-generic"
 done
 
-- 
2.7.4
