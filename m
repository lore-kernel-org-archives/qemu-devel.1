Received: from eggs.gnu.org ([2001:4830:134:3::10]:43419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKg-0006lF-Sm
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKd-0008NL-Tv
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:50 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:52032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faIKd-0008Mj-Mw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:47 -0400
Received: by mail-wm0-x232.google.com with SMTP id s12-v6so1713045wmc.1
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:14:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:25 +0100
Message-Id: <20180703101444.23778-2-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/20] travis: do not waste time cloning unused
 submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
