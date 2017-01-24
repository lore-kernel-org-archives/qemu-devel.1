Received: from eggs.gnu.org ([2001:4830:134:3::10]:37453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AV-0004Wi-4a
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AT-0005Kd-Io
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:55 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW2AT-0005KN-Ct
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:53 -0500
Received: by mail-wm0-x235.google.com with SMTP id r144so212045935wme.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 06:33:53 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jan 2017 14:33:40 +0000
Message-Id: <20170124143346.22240-2-alex.bennee@linaro.org>
In-Reply-To: <20170124143346.22240-1-alex.bennee@linaro.org>
References: <20170124143346.22240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/7] .travis.yml: don't specify CONFIG twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:-----------------..." <qemu-devel@nongnu.org>

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
