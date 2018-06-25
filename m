Received: from eggs.gnu.org ([2001:4830:134:3::10]:56755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXPX4-0004wq-JI
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXPX1-0008Bh-2k
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:42 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:40792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXPX0-0008BK-SQ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:39 -0400
Received: by mail-wr0-x230.google.com with SMTP id g18-v6so13254360wro.7
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:19:38 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 25 Jun 2018 12:19:26 +0100
Message-Id: <20180625111935.26108-2-alex.bennee@linaro.org>
In-Reply-To: <20180625111935.26108-1-alex.bennee@linaro.org>
References: <20180625111935.26108-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 01/10] travis: do not waste time cloning
 unused submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Builds only require:
- dtc
- keycodemapdb
- capstone

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: drop wget cache]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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
