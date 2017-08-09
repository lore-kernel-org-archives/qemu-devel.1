Received: from eggs.gnu.org ([2001:4830:134:3::10]:48571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZz-0006Cp-8y
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZx-0002N5-Pf
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:47 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZx-0002Lv-Mh
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:45 -0400
Received: by mail-qk0-x241.google.com with SMTP id a77so6728608qkb.2
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:08 -0300
Message-Id: <20170809202712.6951-13-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11 v3 12/16] travis/osx: silent texinfo
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

  $ make info
    GEN     qemu-doc.html
  qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
    GEN     qemu-doc.txt
  qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 4bf69b0116..24f62fb7cf 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -74,9 +74,11 @@ git:
   # we want to do this ourselves
   submodules: false
 before_install:
+  # silent texinfo warnings (https://github.com/xiaohanyu/oh-my-emacs/blob/c664894e2f1c1cb0f95a9f2da88d41b00f190856/core/ome-basic.org#homebrew)
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then
         brew update ;
-        brew install libffi gettext glib pixman ;
+        brew install libffi gettext glib pixman texinfo ;
+        brew link texinfo --force ;
     fi
   - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
   - travis_retry git submodule update --init --recursive
-- 
2.13.3
