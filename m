Received: from eggs.gnu.org ([2001:4830:134:3::10]:49118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWBcF-000144-5K
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWBcB-0002ti-51
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:15:59 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWBcB-0002ta-0o
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:15:55 -0400
Received: by mail-qt0-x244.google.com with SMTP id z6-v6so4765559qti.2
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 19:15:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 23:15:46 -0300
Message-Id: <20180622021546.18178-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] travis: Do not waste time cloning unused
 submodules
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

Builds only require:
- dtc
- keycodemapdb
- capstone

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Some tests might require ROMs. Can they clone submodules only when required?
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index fabfe9ec34..415d703c91 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -67,7 +67,7 @@ before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
   - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
-  - git submodule update --init --recursive
+  - git submodule update --init --recursive capstone dtc ui/keycodemapdb
 before_script:
   - ./configure ${CONFIG} || { cat config.log && exit 1; }
 script:
-- 
2.18.0.rc2
