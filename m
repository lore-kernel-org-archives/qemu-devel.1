Received: from eggs.gnu.org ([209.51.188.92]:33852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOf-0004lO-Lo
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOd-0008J2-Sb
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:37 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOZ-0007oA-PW
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id j2so12425255wrw.1
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:28 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:08 +0000
Message-Id: <20190110174516.21586-12-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 11/19] travis: use homebrew addon for MacOSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Rather than poking homebrew manually we can specify the packages
needed via the homebrew addon. These are only installed on MacOS based
builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index fa70429459..2ef7997d25 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -42,6 +42,12 @@ addons:
       - sparse
       - uuid-dev
       - gcovr
+  homebrew:
+    packages:
+      - libffi
+      - gettext
+      - glib
+      - pixman
 
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
@@ -68,9 +74,6 @@ git:
   submodules: false
 
 
-before_install:
-  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
-  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
 before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
-- 
2.17.1
