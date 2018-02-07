Received: from eggs.gnu.org ([2001:4830:134:3::10]:40273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejRVa-0005VP-7e
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejRVW-0007Y5-RU
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:19:38 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejRVW-0007Vd-Ks
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:19:34 -0500
Received: by mail-wr0-x244.google.com with SMTP id t94so1434485wrc.5
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 07:19:34 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  7 Feb 2018 15:19:25 +0000
Message-Id: <20180207151925.26325-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] .travis.yml: add --disable-linux-user for some
 jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The modules and co-routine builds are only really relevant to softmmu
builds and regularly timeout on Travis. Let's disable linux-user
builds here for more headroom.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index f583839755..a6bd01b0a1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -51,9 +51,9 @@ env:
     - CONFIG=""
     - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
     - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb"
-    - CONFIG="--enable-modules"
-    - CONFIG="--with-coroutine=ucontext"
-    - CONFIG="--with-coroutine=sigaltstack"
+    - CONFIG="--enable-modules --disable-linux-user"
+    - CONFIG="--with-coroutine=ucontext --disable-linux-user"
+    - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
 git:
   # we want to do this ourselves
   submodules: false
-- 
2.15.1
