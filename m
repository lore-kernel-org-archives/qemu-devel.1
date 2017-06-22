Received: from eggs.gnu.org ([2001:4830:134:3::10]:56168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrr-0005gH-9V
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrq-0004tN-6z
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:15 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrq-0004sq-2l
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:14 -0400
Received: by mail-qk0-x242.google.com with SMTP id r62so604018qkf.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:17 -0300
Message-Id: <20170622033231.19344-8-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/21] travis: update sudo-enabled Trusty
 images
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

see https://blog.travis-ci.com/2017-06-19-trusty-updates-2017-Q2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 29c9ef72a4..e60a5cd8e6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -128,6 +128,7 @@ matrix:
     - sudo: required
       addons:
       dist: trusty
+      group: edge
       language: generic
       compiler: none
       env:
@@ -147,6 +148,7 @@ matrix:
     - sudo: required
       addons:
       dist: trusty
+      group: edge
       language: generic
       compiler: none
       env:
@@ -230,6 +232,7 @@ matrix:
     # We run on the trusty Travis hosts so that there's a wider set of
     # dependencies satisfied to improve coverage.
     - dist: trusty
+      group: edge
       env:
         - COVERITY=1
         - COVERITY_BUILD_CMD="make -j3"
-- 
2.11.0
