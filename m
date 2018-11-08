Received: from eggs.gnu.org ([2001:4830:134:3::10]:57495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKml3-0007I5-KD
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKmkz-0003AU-PT
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:02:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKmkz-0002vf-JJ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:02:09 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  8 Nov 2018 17:01:15 +0100
Message-Id: <20181108160115.20747-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] travis: Split the OSX job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The current OSX job often reach the 50min Travis-CI time limit.

Split it in two jobs, which as of this commit took:
- system: ~39min
- user:    ~9min

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index aa49c7b114..827f2252b6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -107,7 +107,11 @@ matrix:
     - env: CONFIG=3D"--disable-tcg"
            TEST_CMD=3D""
       compiler: gcc
-    - env: CONFIG=3D""
+    # OSX builds
+    - env: CONFIG=3D"--disable-user"
+      os: osx
+      compiler: clang
+    - env: CONFIG=3D"--disable-system --disable-tools --disable-docs --d=
isable-guest-agent"
       os: osx
       compiler: clang
     # Python builds
--=20
2.17.2
