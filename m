Received: from eggs.gnu.org ([2001:4830:134:3::10]:56365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssF-0006D6-Mr
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssE-0005Fy-R2
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:39 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssE-0005Fs-MD
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:38 -0400
Received: by mail-qk0-x244.google.com with SMTP id d14so612520qkb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:27 -0300
Message-Id: <20170622033231.19344-18-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 17/21] travis/osx: don't update Homebrew
 cache
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

installed VMs come already updated, and brew is smart enough to upgrade some
dependencies are missing.

see https://docs.travis-ci.com/user/osx-ci-environment#homebrew

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 4bb288a192..3de3798121 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -83,7 +83,6 @@ git:
   # we want to do this ourselves
   submodules: false
 before_install:
-  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ccache ; fi
   - travis_retry git submodule update --init --recursive
 before_script:
-- 
2.11.0
