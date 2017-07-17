Received: from eggs.gnu.org ([2001:4830:134:3::10]:42600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1p-0000wo-7x
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1o-0004ll-J4
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1o-0004la-Ca
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:49:00 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:25 +0800
Message-Id: <20170717034825.1524-16-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 15/15] travis: add no-TCG build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

It's fairly easy for --disable-tcg to bitrot.  Test it in our CI.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170714093016.10897-1-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 .travis.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 27a2d9c..3c7a5cb 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -86,6 +86,9 @@ matrix:
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
2.9.4
