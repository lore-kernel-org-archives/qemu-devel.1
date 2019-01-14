Received: from eggs.gnu.org ([209.51.188.92]:37553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3tL-0007h5-8T
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3tJ-0001Gj-CS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:07 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:43548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3tJ-0001Fh-69
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:05 -0500
Received: by mail-wr1-x42e.google.com with SMTP id r10so23253392wrs.10
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:11:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:21 +0000
Message-Id: <20190114150129.1013-14-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/21] travis: stop using container based envs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

The Travis container based envs are deprecated:

  https://docs.travis-ci.com/user/reference/trusty/

  "Container-based infrastructure is currently being deprecated.
   Please remove any sudo: false keys in your .travis.yml file
   to use the default fully-virtualized Linux infrastructure
   instead."

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
