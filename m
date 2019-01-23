Received: from eggs.gnu.org ([209.51.188.92]:45670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmHug-0007EI-DI
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmHf7-0001Z5-Lk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:29:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmHf7-0001Xj-9a
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:29:45 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 12:29:35 +0000
Message-Id: <20190123122935.6431-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] travis: stop requesting libffi & gettext from
 homebrew
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The default package set installed on macOS builders from Travis already
includes libffi and gettext as shown by log messages:

  Skipping install of libffi formula. It is already up-to-date.
  Using libffi
  Skipping install of gettext formula. It is already up-to-date.
  Using gettext

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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
=20
--=20
2.20.1
