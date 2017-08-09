Received: from eggs.gnu.org ([2001:4830:134:3::10]:48543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZw-000693-Sb
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZv-0002Jt-Nf
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:44 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZv-0002Ja-JQ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:43 -0400
Received: by mail-qt0-x243.google.com with SMTP id t37so6894345qtg.2
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:07 -0300
Message-Id: <20170809202712.6951-12-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11 v3 11/16] travis/osx: use readable YAML
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 88ca78c775..4bf69b0116 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -74,8 +74,10 @@ git:
   # we want to do this ourselves
   submodules: false
 before_install:
-  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
-  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
+  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then
+        brew update ;
+        brew install libffi gettext glib pixman ;
+    fi
   - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
   - travis_retry git submodule update --init --recursive
 before_script:
-- 
2.13.3
