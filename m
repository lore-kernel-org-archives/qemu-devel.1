Received: from eggs.gnu.org ([2001:4830:134:3::10]:59615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCoLH-00006v-TO
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCoLD-0004RR-SS
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCoL9-00045P-PZ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:06:34 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 17 Oct 2018 12:05:39 -0400
Message-Id: <20181017160539.12316-4-crosa@redhat.com>
In-Reply-To: <20181017160539.12316-1-crosa@redhat.com>
References: <20181017160539.12316-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 3/3] Travis support for the acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This enables the execution of the acceptance tests on Travis.

Because the Travis environment is based on Ubuntu Trusty, it requires
the python3-pip and python3.4-venv packages.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
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
