Received: from eggs.gnu.org ([209.51.188.92]:33987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOi-0004m7-2s
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOg-0008UH-JP
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:39 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOg-0007nH-90
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id d15so12106749wmb.3
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:27 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:07 +0000
Message-Id: <20190110174516.21586-11-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 10/19] travis: don't clone git submodules
 upfront
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

The configure script & Makefile are already capable of figuring out
which git submodules are required for a given build platform, and
cloning them at the right time.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index f539f8b556..fa70429459 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -71,7 +71,6 @@ git:
 before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
-  - git submodule update --init --recursive capstone dtc ui/keycodemapdb
 before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
-- 
2.17.1
