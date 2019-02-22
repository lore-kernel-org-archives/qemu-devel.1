Received: from eggs.gnu.org ([209.51.188.92]:42006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gx7Xt-0006kX-88
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gx7Xs-0007ku-AN
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:55:05 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gx7Xr-00077g-PR
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:55:04 -0500
Received: by mail-wr1-x432.google.com with SMTP id t18so1677125wrx.2
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 01:54:25 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Feb 2019 09:54:15 +0000
Message-Id: <20190222095421.28938-4-alex.bennee@linaro.org>
In-Reply-To: <20190222095421.28938-1-alex.bennee@linaro.org>
References: <20190222095421.28938-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/9] .travis.yml: Test with disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We've had the build break with replication disabled, so lets
test that case in travis.

Suggsted-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190215094502.32149-1-dgilbert@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 36ed7ec3f9..61b086b8b8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -95,7 +95,7 @@ matrix:
 
 
     - env:
-        - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb --disable-user"
+        - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb --disable-user --disable-replication"
 
 
     - env:
-- 
2.20.1
