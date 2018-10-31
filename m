Received: from eggs.gnu.org ([2001:4830:134:3::10]:43298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQp-0002XD-5X
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQo-0004M8-5u
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:32:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:31:18 -0300
Message-Id: <20181031003120.26771-14-ehabkost@redhat.com>
In-Reply-To: <20181031003120.26771-1-ehabkost@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/15] Travis support for the acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Cleber Rosa <crosa@redhat.com>

This enables the execution of the acceptance tests on Travis.

Because the Travis environment is based on Ubuntu Trusty, it requires
the python3-pip and python3.4-venv packages.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Message-Id: <20181018153134.8493-4-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.18.0.rc1.1.g3f1ff2140
