Received: from eggs.gnu.org ([2001:4830:134:3::10]:40210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evn4K-0000yX-Ue
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evn4H-0000Tu-RQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:46:32 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1evn4H-0000Tj-KZ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:46:29 -0400
Received: by mail-wr0-x244.google.com with SMTP id r8so796604wrg.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 09:46:29 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 13 Mar 2018 16:46:24 +0000
Message-Id: <20180313164625.4646-3-alex.bennee@linaro.org>
In-Reply-To: <20180313164625.4646-1-alex.bennee@linaro.org>
References: <20180313164625.4646-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/3] .travis.yml: split default config into
 system and user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

As the build times have risen we keep timing out. Split the default
config into system and user builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index 92c343a1ef..75e5b408d0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -49,7 +49,8 @@ env:
     - TEST_CMD="make check"
     - MAKEFLAGS="-j3"
   matrix:
-    - CONFIG=""
+    - CONFIG="--disable-system"
+    - CONFIG="--disable-user"
     - CONFIG="--enable-debug --enable-debug-tcg"
     - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb"
     - CONFIG="--enable-modules --disable-linux-user"
-- 
2.16.2
