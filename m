Received: from eggs.gnu.org ([209.51.188.92]:41536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicm-0000bJ-OJ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJici-0005FS-RX
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJicb-000595-9A
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 14:56:57 -0300
Message-Id: <20190425175659.24876-10-ehabkost@redhat.com>
In-Reply-To: <20190425175659.24876-1-ehabkost@redhat.com>
References: <20190425175659.24876-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/11] scripts/update-linux-headers: add
 linux/mman.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

Add linux/mman.h,asm/mman.h,asm/mman-common.h to linux-headers,
So we can use more mmap2 flags.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Message-Id: <f65c78d74859f815aa9c4f97407eb33361a6672c.1549555521.git.yi.z.zhang@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/update-linux-headers.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index a310a9072b..c3819d2b98 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -95,7 +95,7 @@ for arch in $ARCHLIST; do
 
     rm -rf "$output/linux-headers/asm-$arch"
     mkdir -p "$output/linux-headers/asm-$arch"
-    for header in kvm.h unistd.h bitsperlong.h; do
+    for header in kvm.h unistd.h bitsperlong.h mman.h; do
         cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
     done
 
@@ -139,13 +139,13 @@ done
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
2.18.0.rc1.1.g3f1ff2140
