Received: from eggs.gnu.org ([2001:4830:134:3::10]:40209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evn4K-0000yW-US
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evn4I-0000UF-UZ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:46:32 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1evn4I-0000Tz-Nx
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:46:30 -0400
Received: by mail-wr0-x242.google.com with SMTP id r8so796753wrg.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 09:46:30 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 13 Mar 2018 16:46:25 +0000
Message-Id: <20180313164625.4646-4-alex.bennee@linaro.org>
In-Reply-To: <20180313164625.4646-1-alex.bennee@linaro.org>
References: <20180313164625.4646-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/3] .travis.yml: add --disable-user with the
 rest of the disables
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

As all the disabled features only affect system emulation we might as
well disable user mode to save compile time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index 75e5b408d0..c1e99237b2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -52,7 +52,7 @@ env:
     - CONFIG="--disable-system"
     - CONFIG="--disable-user"
     - CONFIG="--enable-debug --enable-debug-tcg"
-    - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb"
+    - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb --disable-user"
     - CONFIG="--enable-modules --disable-linux-user"
     - CONFIG="--with-coroutine=ucontext --disable-linux-user"
     - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
-- 
2.16.2
