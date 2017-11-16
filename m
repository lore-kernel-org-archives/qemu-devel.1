Received: from eggs.gnu.org ([2001:4830:134:3::10]:34046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIps-00020W-J0
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpp-0000Te-GT
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:00:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eFIpp-0000TC-Ak
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E6F1356C4
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 11:59:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Nov 2017 12:59:26 +0100
Message-Id: <20171116115926.16627-12-pbonzini@redhat.com>
In-Reply-To: <20171116115926.16627-1-pbonzini@redhat.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] fix scripts/update-linux-headers.sh here
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

From: Gerd Hoffmann <kraxel@redhat.com>

The minus sign after << causes the shell to strip only
preceding tabs, not spaces.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20171110090354.29608-1-kraxel@redhat.com>
Fixes: 40bf8e9aede0f9105a9e1e4aaf17b20aaa55f9a0
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index ad80fe3fca..76fd894a77 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -106,7 +106,7 @@ for arch in $ARCHLIST; do
     if [ $arch = x86 ]; then
         cat <<-EOF >"$output/include/standard-headers/asm-x86/hyperv.h"
         /* this is a temporary placeholder until kvm_para.h stops including it */
-        EOF
+EOF
         cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
-- 
2.14.3
