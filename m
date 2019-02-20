Received: from eggs.gnu.org ([209.51.188.92]:46102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVfL-000502-Vy
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVfL-0001zN-4u
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:15 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwVfK-0001yl-Ty
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id t15so7136936wmi.5
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:28:14 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 20 Feb 2019 17:28:05 +0000
Message-Id: <20190220172811.10588-3-alex.bennee@linaro.org>
In-Reply-To: <20190220172811.10588-1-alex.bennee@linaro.org>
References: <20190220172811.10588-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 2/8] .travis.yml: split debug builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The builds are reaching the magic 50 minute limit with regularity so
lets split them up. Rather than doing a full debug build on both just
enable debug tcg for linux-user.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 866a1872b1..36ed7ec3f9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -86,7 +86,12 @@ matrix:
 
 
     - env:
-        - CONFIG="--enable-debug --enable-debug-tcg"
+        - CONFIG="--enable-debug --enable-debug-tcg --disable-user"
+
+
+    # TCG debug can be run just on it's own and is mostly agnostic to user/softmmu distinctions
+    - env:
+        - CONFIG="--enable-debug-tcg --disable-system"
 
 
     - env:
-- 
2.20.1
