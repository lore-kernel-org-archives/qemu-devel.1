Received: from eggs.gnu.org ([2001:4830:134:3::10]:45926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evluV-0002gs-C0
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evluP-0004Ae-PK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:32:19 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1evluP-0004AD-Iv
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:32:13 -0400
Received: by mail-wr0-x243.google.com with SMTP id m4so3110wrb.7
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 08:32:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 13 Mar 2018 15:32:07 +0000
Message-Id: <20180313153210.28264-2-alex.bennee@linaro.org>
In-Reply-To: <20180313153210.28264-1-alex.bennee@linaro.org>
References: <20180313153210.28264-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/4] .travis.yml: drop setting default log
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The log backend is the default one, we don't need to explicitly set it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 79377c8de0..92c343a1ef 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -50,7 +50,7 @@ env:
     - MAKEFLAGS="-j3"
   matrix:
     - CONFIG=""
-    - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
+    - CONFIG="--enable-debug --enable-debug-tcg"
     - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb"
     - CONFIG="--enable-modules --disable-linux-user"
     - CONFIG="--with-coroutine=ucontext --disable-linux-user"
-- 
2.16.2
