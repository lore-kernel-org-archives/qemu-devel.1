Received: from eggs.gnu.org ([209.51.188.92]:37485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3tJ-0007fU-GR
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3tI-0001G0-PQ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:05 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3tH-0001D0-SB
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:04 -0500
Received: by mail-wm1-x331.google.com with SMTP id t200so9264328wmt.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:11:01 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:19 +0000
Message-Id: <20190114150129.1013-12-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/21] travis: use homebrew addon for MacOSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Rather than poking homebrew manually we can specify the packages
needed via the homebrew addon. These are only installed on MacOS based
builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

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
