Received: from eggs.gnu.org ([2001:4830:134:3::10]:50850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXpDX-0003zF-5R
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXpDT-0000Bw-5K
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:17:31 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXpDS-00007f-TA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:17:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id f81so6121078wmd.4
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 07:17:26 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 14 Dec 2018 15:17:18 +0000
Message-Id: <20181214151718.5041-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] .shippable.yml: disable the win cross tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The pkg.mxe.cc package repositories have been down for the last two
weeks causing the builds to fail when shippable re-builds the
containers.

This is really just a sticking plaster until we can get our own docker
hub images properly setup so we can avoid having dependencies on
external repos.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .shippable.yml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index f74a3de3ff..f2ffef21d1 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -7,10 +7,11 @@ env:
   matrix:
     - IMAGE=debian-amd64
       TARGET_LIST=x86_64-softmmu,x86_64-linux-user
-    - IMAGE=debian-win32-cross
-      TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
-    - IMAGE=debian-win64-cross
-      TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
+    # currently disabled as the mxe.cc repos are down
+    # - IMAGE=debian-win32-cross
+    #   TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
+    # - IMAGE=debian-win64-cross
+    #   TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
     - IMAGE=debian-armel-cross
       TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
     - IMAGE=debian-armhf-cross
-- 
2.17.1
