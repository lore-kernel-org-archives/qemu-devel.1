Received: from eggs.gnu.org ([2001:4830:134:3::10]:60689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVwzI-0001Hx-HJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVwzH-0005IE-MJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:34:16 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVwzH-0005Hs-Fc
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:34:15 -0400
Received: by mail-wm0-x244.google.com with SMTP id y5so9776119wmh.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:34:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 11:34:07 +0200
Message-Id: <20170714093407.11526-3-pbonzini@redhat.com>
In-Reply-To: <20170714093407.11526-1-pbonzini@redhat.com>
References: <20170714093407.11526-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] travis: move make -j flag out of script
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

Because global environment variables can be overridden when .travis.yml
is processed by the docker-travis target, the effect of this patch is
that docker-travis now obeys the "J=n" option.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 27a2d9cfb3..6809e25eca 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,7 @@ notifications:
 env:
   global:
     - TEST_CMD="make check"
+    - MAKEFLAGS="-j3"
   matrix:
     - CONFIG=""
     - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
@@ -64,7 +65,7 @@ before_install:
 before_script:
   - ./configure ${CONFIG}
 script:
-  - make -j3 && ${TEST_CMD}
+  - make ${MAKEFLAGS} && ${TEST_CMD}
 matrix:
   include:
     # Test with CLang for compile portability
-- 
2.13.0
