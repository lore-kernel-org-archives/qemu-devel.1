Received: from eggs.gnu.org ([2001:4830:134:3::10]:41256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt1-0002zF-2w
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt0-0001Nz-7a
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:07 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAt0-0001Nh-0p
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:06 -0400
Received: by mail-wm0-x242.google.com with SMTP id a67so21143224wmf.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:29 +0200
Message-Id: <1525817687-34620-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/30] update-linux-headers: drop hyperv.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

From: Roman Kagan <rkagan@virtuozzo.com>

As of mainline linux commit 5a485803221777013944cbd1a7cd5c62efba3ffa
"x86/hyper-v: move hyperv.h out of uapi" by Vitaly Kuznetsov, no linux
uapi header includes it, so we no longer need to create a stub for it.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180413143354.17614-1-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 5b1d8dc..b65c03f 100755
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
1.8.3.1
