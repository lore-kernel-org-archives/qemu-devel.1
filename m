Received: from eggs.gnu.org ([2001:4830:134:3::10]:48374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZe-0005u0-6x
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZb-00025W-BO
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:26 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZb-00025I-71
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:23 -0400
Received: by mail-qk0-x242.google.com with SMTP id d145so6770266qkc.0
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:26:57 -0300
Message-Id: <20170809202712.6951-2-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11 v3 01/16] travis: update sudo-enabled
 Trusty images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

see https://blog.travis-ci.com/2017-06-19-trusty-updates-2017-Q2
and https://blog.travis-ci.com/2017-06-21-trusty-updates-2017-Q2-launch

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index f583839755..b9cafe3d40 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -98,6 +98,7 @@ matrix:
       sudo: required
       addons:
       dist: trusty
+      group: deprecated-2017Q2
       compiler: gcc
       before_install:
         - sudo apt-get update -qq
@@ -109,6 +110,7 @@ matrix:
       sudo: required
       addons:
       dist: trusty
+      group: deprecated-2017Q2
       compiler: gcc
       before_install:
         - sudo apt-get update -qq
@@ -119,6 +121,7 @@ matrix:
     - sudo: required
       addons:
       dist: trusty
+      group: deprecated-2017Q2
       language: generic
       compiler: none
       env:
@@ -138,6 +141,7 @@ matrix:
     - sudo: required
       addons:
       dist: trusty
+      group: deprecated-2017Q2
       language: generic
       compiler: none
       env:
-- 
2.13.3
