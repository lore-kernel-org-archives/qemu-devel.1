Received: from eggs.gnu.org ([209.51.188.92]:46085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVfL-0004zE-4L
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVfK-0001yt-Ch
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:15 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwVfK-0001y7-5t
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:14 -0500
Received: by mail-wr1-x435.google.com with SMTP id r5so13625439wrg.9
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:28:14 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 20 Feb 2019 17:28:04 +0000
Message-Id: <20190220172811.10588-2-alex.bennee@linaro.org>
In-Reply-To: <20190220172811.10588-1-alex.bennee@linaro.org>
References: <20190220172811.10588-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/8] .travis.yml: the xcode10 image seems to
 be hosed
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

From: Paolo Bonzini <pbonzini@redhat.com>

It fails to install homebrew.  Unfortunately we cannot mark
it as an expected failure because Travis does not match
allow_failures rows against include rows (only against the
main test matrix, which we do not use at all), so just disable
it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190220105131.23479-1-pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index baa06b976a..866a1872b1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -174,13 +174,6 @@ matrix:
       compiler: clang
 
 
-    - env:
-        - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
-      os: osx
-      osx_image: xcode10
-      compiler: clang
-
-
     # Python builds
     - env:
         - CONFIG="--target-list=x86_64-softmmu"
-- 
2.20.1
