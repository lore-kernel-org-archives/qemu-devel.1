Received: from eggs.gnu.org ([209.51.188.92]:36122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqhfw-0006zb-5o
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqhfv-0000f8-8M
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:04:52 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqhfu-0000QC-VH
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:04:51 -0500
Received: by mail-wr1-x443.google.com with SMTP id s12so643897wrt.4
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 09:04:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	x81sm10301914wmg.17.2019.02.04.09.04.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Feb 2019 09:04:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 18:04:23 +0100
Message-Id: <1549299863-42415-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] docker: fix test-mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

--with-sdlabi has been removed.  Drop it from the test-mingw docker test.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/test-mingw | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index b078f22..4b84cfe 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -27,8 +27,7 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
         --enable-curl \
         --enable-vnc \
         --enable-bzip2 \
-        --enable-guest-agent \
-        --with-sdlabi=2.0
+        --enable-guest-agent
     install_qemu
     make clean
 
-- 
1.8.3.1
