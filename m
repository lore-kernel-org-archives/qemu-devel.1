Received: from eggs.gnu.org ([2001:4830:134:3::10]:39234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNh04-0003wd-Ad
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgzy-0007oP-Mb
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:56 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgzy-0007nz-Fl
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:50 -0400
Received: by mail-wr0-x22c.google.com with SMTP id r103so138306023wrb.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:52:50 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:48:07 +0100
Message-Id: <20170621144814.15324-15-alex.bennee@linaro.org>
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/21] shippable: use C locale to simplify
 console output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

remove this noise:

perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LANGUAGE = (unset),
    LC_ALL = "en_US.UTF-8",
    LC_CTYPE = "en_US.UTF-8",
    LANG = "en_US.UTF-8"
    are supported and installed on your system.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index 653bd750fe..231c29b620 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -1,5 +1,7 @@
 language: c
 env:
+  global:
+    - LC_ALL=C
   matrix:
     - IMAGE=debian-armhf-cross
       TARGET_LIST=arm-softmmu,arm-linux-user
-- 
2.13.0
