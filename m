Received: from eggs.gnu.org ([2001:4830:134:3::10]:35991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OX-0003N7-GK
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OW-0000ok-7x
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gA1OV-0000mf-QD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:28 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  9 Oct 2018 19:26:06 -0400
Message-Id: <20181009232607.15521-7-crosa@redhat.com>
In-Reply-To: <20181009232607.15521-1-crosa@redhat.com>
References: <20181009232607.15521-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/7] Acceptance Tests: add variants
 definition for architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

One of the Avocado features relevant to virtualization testing is the
ability to reuse tests in different scenarios, known as variants.
This adds a JSON based variants file, that can be used to run most
tests in a number of different architectures.  It can be run with:

   $ avocado run \
     --json-variants-load=tests/acceptance/variants/arch.json \
     --filter-by-tags='-x86_64' -- tests/acceptance/

Currently this covers 5 architectures, resulting in the execution
of 25 different combinations.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/variants/arch.json | 92 +++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 tests/acceptance/variants/arch.json

diff --git a/tests/acceptance/variants/arch.json b/tests/acceptance/variants/arch.json
new file mode 100644
index 0000000000..64ff6ad278
--- /dev/null
+++ b/tests/acceptance/variants/arch.json
@@ -0,0 +1,92 @@
+[
+    {
+        "paths": [
+            "/run/*"
+        ],
+        "variant": [
+            [
+                "/run/aarch64",
+                [
+                    [
+                        "/run/aarch64",
+                        "arch",
+                        "aarch64"
+                    ]
+                ]
+            ]
+        ],
+        "variant_id": "aarch64"
+    },
+    {
+        "paths": [
+            "/run/*"
+        ],
+        "variant": [
+            [
+                "/run/ppc",
+                [
+                    [
+                        "/run/ppc",
+                        "arch",
+                        "ppc"
+                    ]
+                ]
+            ]
+        ],
+        "variant_id": "ppc"
+    },
+    {
+        "paths": [
+            "/run/*"
+        ],
+        "variant": [
+            [
+                "/run/ppc64",
+                [
+                    [
+                        "/run/ppc64",
+                        "arch",
+                        "ppc64"
+                    ]
+                ]
+            ]
+        ],
+        "variant_id": "ppc64"
+    },
+    {
+        "paths": [
+            "/run/*"
+        ],
+        "variant": [
+            [
+                "/run/s390x",
+                [
+                    [
+                        "/run/s390x",
+                        "arch",
+                        "s390x"
+                    ]
+                ]
+            ]
+        ],
+        "variant_id": "s390x"
+    },
+    {
+        "paths": [
+            "/run/*"
+        ],
+        "variant": [
+            [
+                "/run/x86_64",
+                [
+                    [
+                        "/run/x86_64",
+                        "arch",
+                        "x86_64"
+                    ]
+                ]
+            ]
+        ],
+        "variant_id": "x86_64"
+    }
+]
-- 
2.17.1
