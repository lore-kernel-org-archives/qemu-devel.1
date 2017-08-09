Received: from eggs.gnu.org ([2001:4830:134:3::10]:48632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXa5-0006Ik-UP
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXa3-0002Un-RW
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:53 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXa3-0002U7-Ny
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:51 -0400
Received: by mail-qt0-x243.google.com with SMTP id d10so6887218qtb.4
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:11 -0300
Message-Id: <20170809202712.6951-16-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for-2.11 v3 15/16] travis/osx: build using
 more Xcode versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

currently default builder is based on Xcode 7.3.1:
    OS X 10.11 (darwin14.5.0)
    Apple LLVM version 7.3.0

add the oldest available Xcode (6.4):
    OS X 10.10 (darwin14.5.0)
    Apple LLVM 6.1.0 (based on LLVM 3.6.0svn)

and the newer available Xcode (8.3.3):
    OS X 10.12 (darwin16.6.0)
    Apple LLVM version 8.1.0

see https://docs.travis-ci.com/user/reference/osx/#OS-X-Version

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 7c93a10c5f..cd59570062 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -117,6 +117,18 @@ matrix:
       compiler: gcc
     - env: CONFIG=""
       os: osx
+      # older available: OS X 10.10
+      osx_image: xcode6.4
+      compiler: clang
+    - env: CONFIG=""
+      os: osx
+      # default: OS X 10.11.6
+      osx_image: xcode7.3
+      compiler: clang
+    - env: CONFIG=""
+      os: osx
+      # newer stable available, OS X 10.12
+      osx_image: xcode8.3
       compiler: clang
     # Plain Trusty System Build
     - env: CONFIG="--disable-linux-user"
-- 
2.13.3
