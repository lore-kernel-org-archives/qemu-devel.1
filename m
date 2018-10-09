Received: from eggs.gnu.org ([2001:4830:134:3::10]:56545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g9wGY-0003f6-4I
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g9wGX-0000z2-9c
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g9wGX-0000yh-0S
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:57:53 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  9 Oct 2018 13:57:40 -0400
Message-Id: <20181009175740.13812-4-crosa@redhat.com>
In-Reply-To: <20181009175740.13812-1-crosa@redhat.com>
References: <20181009175740.13812-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/3] Travis support for the acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>

This enables the execution of the acceptance tests on Travis.

Because the Travis environment is based on Ubuntu Trusty, it requires
the python3-pip.

Note: while another supposedely required component on newer versions
(such as on Bionic) split the Python 3 installation further on the
python3-venv package.

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
