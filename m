Received: from eggs.gnu.org ([2001:4830:134:3::10]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssA-00068T-Pt
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss9-0005EH-Pb
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:34 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss9-0005ED-Lv
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:33 -0400
Received: by mail-qk0-x242.google.com with SMTP id p21so615910qke.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:25 -0300
Message-Id: <20170622033231.19344-16-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 15/21] travis: retry when git submodules
 initialization fails
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

example of failure: https://travis-ci.org/philmd/qemu/jobs/245612939

  $ git submodule update --init --recursive
  [...]
  Submodule 'pixman' (git://anongit.freedesktop.org/pixman) registered for path 'pixman'
  Cloning into 'pixman'...
  fatal: unable to connect to anongit.freedesktop.org:
  anongit.freedesktop.org[0: 131.252.210.161]: errno=Connection timed out
  anongit.freedesktop.org[1: 2610:10:20:722:a800:ff:fe24:61cf]: errno=Network is unreachable
  Clone of 'git://anongit.freedesktop.org/pixman' into submodule path 'pixman' failed
  The command "git submodule update --init --recursive" failed and exited with 1 during .
  Your build has been stopped.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index bac5bea744..34391722a2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -85,7 +85,7 @@ git:
 before_install:
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ccache ; fi
-  - git submodule update --init --recursive
+  - travis_retry git submodule update --init --recursive
 before_script:
   # https://docs.travis-ci.com/user/caching#ccache-on-os-x
   - if [ "$TRAVIS_OS_NAME" == "osx" ]; then export PATH=/usr/local/opt/ccache/libexec:$PATH ; fi
-- 
2.11.0
