Received: from eggs.gnu.org ([2001:4830:134:3::10]:52679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccCkd-000657-Th
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccCkZ-0002Cf-Rm
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:04:43 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ccCkZ-0002CT-LH
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:04:39 -0500
Received: by mail-wm0-x231.google.com with SMTP id r141so50795663wmg.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 07:04:39 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 10 Feb 2017 15:04:51 +0000
Message-Id: <20170210150452.21550-2-alex.bennee@linaro.org>
In-Reply-To: <20170210150452.21550-1-alex.bennee@linaro.org>
References: <20170210150452.21550-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/2] .travis.yml: don't specify CONFIG twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index d83e2d493b..3dc1e6439d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -104,8 +104,7 @@ matrix:
         - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
         - git submodule update --init --recursive
     # Trusty build with latest stable clang
-    - env: CONFIG=""
-      sudo: required
+    - sudo: required
       addons:
       dist: trusty
       language: generic
-- 
2.11.0
