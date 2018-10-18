Received: from eggs.gnu.org ([2001:4830:134:3::10]:60488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDAH3-0000zX-94
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDAH1-0000ft-UY
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:31:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gDAH1-0000ds-NH
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:31:43 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 18 Oct 2018 11:31:34 -0400
Message-Id: <20181018153134.8493-4-crosa@redhat.com>
In-Reply-To: <20181018153134.8493-1-crosa@redhat.com>
References: <20181018153134.8493-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 3/3] Travis support for the acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

This enables the execution of the acceptance tests on Travis.

Because the Travis environment is based on Ubuntu Trusty, it requires
the python3-pip and python3.4-venv packages.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
---
 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 95be6ec59f..aa49c7b114 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -117,6 +117,14 @@ matrix:
     - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
       python:
         - "3.6"
+    # Acceptance (Functional) tests
+    - env: CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-=
softmmu"
+           TEST_CMD=3D"make AVOCADO_SHOW=3Dapp check-acceptance"
+      addons:
+        apt:
+          packages:
+            - python3-pip
+            - python3.4-venv
     # Using newer GCC with sanitizers
     - addons:
         apt:
--=20
2.17.1
