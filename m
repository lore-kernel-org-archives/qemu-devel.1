Received: from eggs.gnu.org ([2001:4830:134:3::10]:59766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD5EU-00053z-Ne
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD5EP-0003Lb-9W
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:04:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eD5EP-0003Ka-4R
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:04:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27B20624B3
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:04:08 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 10 Nov 2017 10:03:54 +0100
Message-Id: <20171110090354.29608-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] fix scripts/update-linux-headers.sh here
 document
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 8b847e279b..e2b159aa3d 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -108,7 +108,7 @@ for arch in $ARCHLIST; do
     if [ $arch = x86 ]; then
         cat <<-EOF >"$output/include/standard-headers/asm-x86/hyperv.h"
         /* this is a temporary placeholder until kvm_para.h stops including it */
-        EOF
+EOF
         cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
-- 
2.9.3
