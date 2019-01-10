Received: from eggs.gnu.org ([209.51.188.92]:34015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOi-0004mV-Ka
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOg-0008Tt-HF
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:40 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOg-0007oz-6n
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:38 -0500
Received: by mail-wm1-x344.google.com with SMTP id a62so12114354wmh.4
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:10 +0000
Message-Id: <20190110174516.21586-14-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 13/19] travis: stop using container based
 envs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

The Travis container based envs are deprecated:

  https://docs.travis-ci.com/user/reference/trusty/

  "Container-based infrastructure is currently being deprecated.
   Please remove any sudo: false keys in your .travis.yml file
   to use the default fully-virtualized Linux infrastructure
   instead."

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 7b18d33e9d..744dc050d6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,8 +1,4 @@
-# The current Travis default is a container based 14.04 Trust on EC2
-# Additional builds with specific requirements for a full VM need to
-# be added as additional matrix: entries later on
 
-sudo: false
 dist: trusty
 language: c
 python:
@@ -255,6 +251,5 @@ matrix:
     - env:
         - CONFIG="--disable-system --disable-docs"
         - TEST_CMD="make -j3 check-tcg"
-      sudo: required
       dist: trusty
       compiler: gcc
-- 
2.17.1
