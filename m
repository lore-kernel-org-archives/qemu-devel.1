Received: from eggs.gnu.org ([2001:4830:134:3::10]:54758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jH-0008KQ-8i
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jF-0007wL-8j
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:35 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:51004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6jF-0007vj-1x
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:33 -0400
Received: by mail-wm0-x229.google.com with SMTP id v25-v6so12156532wmc.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:03:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:11 +0100
Message-Id: <20180705160329.30386-3-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 02/20] travis: do not waste time cloning
 unused submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Builds only require:
- dtc
- keycodemapdb
- capstone

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: drop wget cache]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index bd66c18fed..134d5331fe 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -66,8 +66,7 @@ git:
 before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
-  - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-  - git submodule update --init --recursive
+  - git submodule update --init --recursive capstone dtc ui/keycodemapdb
 before_script:
   - ./configure ${CONFIG} || { cat config.log && exit 1; }
 script:
-- 
2.17.1
