Received: from eggs.gnu.org ([2001:4830:134:3::10]:51368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etEhD-0004cJ-0p
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etEh8-0007t3-9V
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:40:07 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1etEh8-0007sn-23
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:40:02 -0500
Received: by mail-wm0-x244.google.com with SMTP id e194so4688562wmd.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 07:40:01 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  6 Mar 2018 15:39:51 +0000
Message-Id: <20180306153951.1644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] .shippable.yml: disable powerpc-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, f4bug@amsat.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

Something has happened to the old emdebian setup which means it no
longer builds. Let's disable the shippable builds which are always
failing.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index dd4bbc84b1..60f2ce9218 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -23,8 +23,6 @@ env:
       TARGET_LIST=mips-softmmu,mipsel-linux-user
     - IMAGE=debian-mips64el-cross
       TARGET_LIST=mips64el-softmmu,mips64el-linux-user
-    - IMAGE=debian-powerpc-cross
-      TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
-- 
2.15.1
