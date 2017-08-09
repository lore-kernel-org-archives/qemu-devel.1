Received: from eggs.gnu.org ([2001:4830:134:3::10]:48648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXa7-0006Kn-A9
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXa6-0002W3-6x
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:55 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXa6-0002Vp-2Y
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:54 -0400
Received: by mail-qt0-x244.google.com with SMTP id u19so6908057qtc.0
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:12 -0300
Message-Id: <20170809202712.6951-17-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [NOTFORMERGE PATCH for-2.11 v3 16/16] travis/osx:
 build using bleeding Xcode
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

test 'unstable' Xcode (9beta4) ...
    OS X 10.13 (darwin16.7.0)
    Apple LLVM version 9.0.0 (clang-900.0.31)

see https://docs.travis-ci.com/user/reference/osx/#OS-X-Version

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index cd59570062..16c1dee150 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -130,6 +130,11 @@ matrix:
       # newer stable available, OS X 10.12
       osx_image: xcode8.3
       compiler: clang
+    - env: CONFIG=""
+      os: osx
+      # unstable
+      osx_image: xcode9
+      compiler: clang
     # Plain Trusty System Build
     - env: CONFIG="--disable-linux-user"
       sudo: required
-- 
2.13.3
