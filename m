Received: from eggs.gnu.org ([209.51.188.92]:33925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOh-0004lg-8i
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOg-0008Sa-3O
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:39 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOf-0007wm-Qt
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:37 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so12329866wrt.13
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:31 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:15 +0000
Message-Id: <20190110174516.21586-19-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 18/19] tests/docker: update our Travis image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

We are now using Xenial based images on Travis so we should make the
same one available as our qemu:travis docker image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/travis.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index 46cf367488..e72dc85ca7 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -1,4 +1,4 @@
-FROM travisci/ci-garnet:packer-1512502276-986baf0
+FROM travisci/ci-sardonyx:packer-1546978056-2c98a19
 ENV DEBIAN_FRONTEND noninteractive
 ENV LANG en_US.UTF-8
 ENV LC_ALL en_US.UTF-8
-- 
2.17.1
