Received: from eggs.gnu.org ([209.51.188.92]:50498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBH9-00074N-BQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBGu-0003od-Ta
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:05:21 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtBGq-0003jm-Q8
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:05:14 -0500
Received: by mail-wm1-x332.google.com with SMTP id b11so17637887wmj.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:05:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Feb 2019 13:04:51 +0000
Message-Id: <20190211130507.8710-3-alex.bennee@linaro.org>
In-Reply-To: <20190211130507.8710-1-alex.bennee@linaro.org>
References: <20190211130507.8710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/18] .travis.yml: stop requesting libffi &
 gettext from homebrew
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The default package set installed on macOS builders from Travis already
includes libffi and gettext as shown by log messages:

  Skipping install of libffi formula. It is already up-to-date.
  Using libffi
  Skipping install of gettext formula. It is already up-to-date.
  Using gettext

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
2.20.1
