Received: from eggs.gnu.org ([2001:4830:134:3::10]:37456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AV-0004Wn-5D
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AS-0005K5-0r
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:55 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW2AR-0005Jl-Qe
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:51 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r144so212043383wme.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 06:33:50 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jan 2017 14:33:42 +0000
Message-Id: <20170124143346.22240-4-alex.bennee@linaro.org>
In-Reply-To: <20170124143346.22240-1-alex.bennee@linaro.org>
References: <20170124143346.22240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/7] .travis.yml: DEBUG MacOSX build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:-----------------..." <qemu-devel@nongnu.org>

Currently the MacOSX build is failing. Dump some information to help
with figuring out what has gone wrong.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 9008a796f0..a9ce215f42 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -92,6 +92,7 @@ matrix:
     - env: CONFIG=""
       os: osx
       compiler: clang
+      script: make -j3 || cat qemu-options.texi && false
     # Plain Trusty System Build
     - env: CONFIG="--disable-linux-user"
       sudo: required
-- 
2.11.0
