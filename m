Received: from eggs.gnu.org ([209.51.188.92]:52112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn224-0003VO-67
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn221-0000gQ-SW
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:31 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn21x-0000Xb-PQ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:26 -0500
Received: by mail-wm1-x343.google.com with SMTP id f188so6690175wmf.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:21 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:05 +0000
Message-Id: <20190125140017.6092-3-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 02/14] travis: stop requesting libffi &
 gettext from homebrew
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

The default package set installed on macOS builders from Travis already
includes libffi and gettext as shown by log messages:

  Skipping install of libffi formula. It is already up-to-date.
  Using libffi
  Skipping install of gettext formula. It is already up-to-date.
  Using gettext

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 87d9fa971c..beea941408 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -40,8 +40,6 @@ addons:
       - gcovr
   homebrew:
     packages:
-      - libffi
-      - gettext
       - glib
       - pixman
 
-- 
2.17.1
