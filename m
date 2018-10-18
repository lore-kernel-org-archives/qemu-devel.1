Received: from eggs.gnu.org ([2001:4830:134:3::10]:58751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDCkQ-0003ZY-1D
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDCkL-00024C-QD
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:10:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDCkL-00022N-Hv
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:10:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id r17-v6so2342735wrt.9
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 11:10:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 20:10:03 +0200
Message-Id: <1539886203-33670-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: docker: update test-mingw for GTK+ 2.0
 removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

--with-gtkabi does not exist anymore; remove it from the configure invocation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/test-mingw | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index 7cca7e1..b078f22 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -28,8 +28,7 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
         --enable-vnc \
         --enable-bzip2 \
         --enable-guest-agent \
-        --with-sdlabi=2.0 \
-        --with-gtkabi=3.0
+        --with-sdlabi=2.0
     install_qemu
     make clean
 
-- 
1.8.3.1
