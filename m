Received: from eggs.gnu.org ([2001:4830:134:3::10]:37072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOmne-0005qh-KC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOmnd-0003q0-RU
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:10 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:50205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fOmnd-0003pK-LR
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:09 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t11-v6so4085848wmt.0
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 09:21:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Jun 2018 17:21:00 +0100
Message-Id: <20180601162101.895-7-alex.bennee@linaro.org>
In-Reply-To: <20180601162101.895-1-alex.bennee@linaro.org>
References: <20180601162101.895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/7] .travis.yml: make current setup explicit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Add some commentary and make the selection of Container based Trusty
build explicit. We will need to add VM builds later when using docker.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/.travis.yml b/.travis.yml
index f91db3ab1a..7197247a34 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,4 +1,8 @@
+# The current Travis default is a container based 14.04 Trust on EC2
+# Additional builds with specific requirements for a full VM need to
+# be added as additional matrix: entries later on
 sudo: false
+dist: trusty
 language: c
 python:
   - "2.6"
-- 
2.17.0
