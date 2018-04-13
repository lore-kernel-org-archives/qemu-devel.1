Received: from eggs.gnu.org ([2001:4830:134:3::10]:37920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f6zmE-0001iF-4r
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f6zmA-0003IT-VW
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:34:10 -0400
Received: from mail-ve1eur01on0113.outbound.protection.outlook.com
	([104.47.1.113]:61632
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1f6zmA-0003Gn-3g
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:34:06 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 13 Apr 2018 17:33:54 +0300
Message-Id: <20180413143354.17614-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] update-linux-headers: drop hyperv.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>

As of mainline linux commit 5a485803221777013944cbd1a7cd5c62efba3ffa
"x86/hyper-v: move hyperv.h out of uapi" by Vitaly Kuznetsov, no linux
uapi header includes it, so we no longer need to create a stub for it.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 scripts/update-linux-headers.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 5b1d8dcdf4..b65c03f0ae 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -118,9 +118,6 @@ for arch in $ARCHLIST; do
         cp "$tmpdir/include/asm/unistd-common.h" "$output/linux-headers/asm-arm/"
     fi
     if [ $arch = x86 ]; then
-        cat <<-EOF >"$output/include/standard-headers/asm-x86/hyperv.h"
-        /* this is a temporary placeholder until kvm_para.h stops including it */
-EOF
         cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
@@ -144,9 +141,6 @@ else
     cp "$linux/COPYING" "$output/linux-headers"
 fi
 
-cat <<EOF >$output/linux-headers/asm-x86/hyperv.h
-#include "standard-headers/asm-x86/hyperv.h"
-EOF
 cat <<EOF >$output/linux-headers/linux/virtio_config.h
 #include "standard-headers/linux/virtio_config.h"
 EOF
-- 
2.14.3
