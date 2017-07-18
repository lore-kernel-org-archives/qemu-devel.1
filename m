Received: from eggs.gnu.org ([2001:4830:134:3::10]:46700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0a-0007kB-Q2
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0a-0003HR-2K
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:40 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0Z-0003H5-LW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:39 -0400
Received: by mail-wr0-x22b.google.com with SMTP id y43so23117550wrd.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:45:00 +0100
Message-Id: <20170718104513.23947-20-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/32] shippable: add x86_64 targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: minor tweak to name]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index 189d193da5..1f92ace8f7 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -5,6 +5,8 @@ env:
   global:
     - LC_ALL=C
   matrix:
+    - IMAGE=debian-amd64
+      TARGET_LIST=x86_64-softmmu,x86_64-linux-user
     - IMAGE=debian-armel-cross
       TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
     - IMAGE=debian-armhf-cross
-- 
2.13.0
