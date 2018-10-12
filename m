Received: from eggs.gnu.org ([2001:4830:134:3::10]:57841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gB0hO-0000hq-6W
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gB0hN-0007xp-5W
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gB0hM-0007wg-VE
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:54:01 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 12 Oct 2018 12:53:47 -0400
Message-Id: <20181012165347.2117-4-crosa@redhat.com>
In-Reply-To: <20181012165347.2117-1-crosa@redhat.com>
References: <20181012165347.2117-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/3] Travis support for the acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This enables the execution of the acceptance tests on Travis.

Because the Travis environment is based on Ubuntu Trusty, it requires
the python3-pip and python3.4-venv packages.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 95be6ec59f..f55f799c52 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -36,6 +36,8 @@ addons:
       - liburcu-dev
       - libusb-1.0-0-dev
       - libvte-2.90-dev
+      - python3-pip
+      - python3.4-venv
       - sparse
       - uuid-dev
       - gcovr
@@ -117,6 +119,9 @@ matrix:
     - env: CONFIG="--target-list=x86_64-softmmu"
       python:
         - "3.6"
+    # Acceptance (Functional) tests
+    - env: CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu"
+           TEST_CMD="make AVOCADO_SHOW=app check-acceptance"
     # Using newer GCC with sanitizers
     - addons:
         apt:
-- 
2.17.1
