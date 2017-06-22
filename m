Received: from eggs.gnu.org ([2001:4830:134:3::10]:56383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssI-0006G1-TO
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssH-0005GX-90
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:42 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssH-0005GR-4d
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:41 -0400
Received: by mail-qk0-x242.google.com with SMTP id d14so612585qkb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:28 -0300
Message-Id: <20170622033231.19344-19-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 18/21] travis/osx: silent texinfo warnings
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

  $ make info
    GEN     qemu-doc.html
  qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
    GEN     qemu-doc.txt
  qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 3de3798121..d007fdc9fb 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -84,6 +84,8 @@ git:
   submodules: false
 before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ccache ; fi
+  # silent texinfo warnings (https://github.com/xiaohanyu/oh-my-emacs/blob/c664894e2f1c1cb0f95a9f2da88d41b00f190856/core/ome-basic.org#homebrew)
+  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install texinfo && brew link texinfo --force ; fi
   - travis_retry git submodule update --init --recursive
 before_script:
   # https://docs.travis-ci.com/user/caching#ccache-on-os-x
-- 
2.11.0
