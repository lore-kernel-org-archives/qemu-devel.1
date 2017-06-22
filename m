Received: from eggs.gnu.org ([2001:4830:134:3::10]:56407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssK-0006Hn-Sz
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssJ-0005H9-TU
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:44 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssJ-0005H4-Pc
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:43 -0400
Received: by mail-qk0-x242.google.com with SMTP id p21so616234qke.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:29 -0300
Message-Id: <20170622033231.19344-20-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 19/21] travis/osx: build using more Xcode
 versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

currently default builder is based on Xcode 7.3.1:
    OS X 10.11 (darwin14.5.0)
    Apple LLVM version 7.3.0

add the oldest available Xcode (6.4):
    OS X 10.10 (darwin14.5.0)
    Apple LLVM 6.1.0 (based on LLVM 3.6.0svn)

and the newer available Xcode (8.3.3):
    OS X 10.12 (darwin16.6.0)
    Apple LLVM version 8.1.0

see https://docs.travis-ci.com/user/osx-ci-environment#os-x-version

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index d007fdc9fb..880a057c78 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -126,6 +126,17 @@ matrix:
     - env: CONFIG=""
            CCACHE_SLOPPINESS="file_macro,time_macros,include_file_ctime,include_file_mtime"
       os: osx
+      osx_image: xcode6.4
+      compiler: clang
+    - env: CONFIG=""
+           CCACHE_SLOPPINESS="file_macro,time_macros,include_file_ctime,include_file_mtime"
+      os: osx
+      osx_image: xcode7.3
+      compiler: clang
+    - env: CONFIG=""
+           CCACHE_SLOPPINESS="file_macro,time_macros,include_file_ctime,include_file_mtime"
+      os: osx
+      osx_image: xcode8.3
       compiler: clang
     # Plain Trusty System Build
     - env: CONFIG="--disable-linux-user"
-- 
2.11.0
