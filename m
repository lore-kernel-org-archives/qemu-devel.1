Received: from eggs.gnu.org ([2001:4830:134:3::10]:59744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVwvd-0007E2-GA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVwva-0002cf-Dv
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:30:29 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVwva-0002ai-6F
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:30:26 -0400
Received: by mail-wr0-x243.google.com with SMTP id g46so935584wrd.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:30:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 11:30:16 +0200
Message-Id: <20170714093016.10897-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] travis: add no-TCG build
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

It's fairly easy for --disable-tcg to bitrot.  Test it in our CI.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 6809e25eca..f583839755 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -87,6 +87,9 @@ matrix:
     - env: CONFIG="--enable-trace-backends=ust"
            TEST_CMD=""
       compiler: gcc
+    - env: CONFIG="--disable-tcg"
+           TEST_CMD=""
+      compiler: gcc
     - env: CONFIG=""
       os: osx
       compiler: clang
-- 
2.13.0
