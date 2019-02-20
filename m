Received: from eggs.gnu.org ([209.51.188.92]:46145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVfO-00052B-46
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVfN-00021m-EW
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:18 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwVfN-00021E-7g
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:17 -0500
Received: by mail-wm1-x331.google.com with SMTP id y15so7244579wma.0
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:28:17 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 20 Feb 2019 17:28:06 +0000
Message-Id: <20190220172811.10588-4-alex.bennee@linaro.org>
In-Reply-To: <20190220172811.10588-1-alex.bennee@linaro.org>
References: <20190220172811.10588-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/8] .travis.yml: Test with
 disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We've had the build break with replication disabled, so lets
test that case in travis.

Suggsted-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190215094502.32149-1-dgilbert@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
