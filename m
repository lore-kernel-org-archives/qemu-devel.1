Received: from eggs.gnu.org ([2001:4830:134:3::10]:47084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g85Ks-0005xf-DP
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g85Kr-0006F7-OB
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g85Kr-0006Ei-IB
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:41 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 11:14:28 -0400
Message-Id: <20181004151429.7232-7-crosa@redhat.com>
In-Reply-To: <20181004151429.7232-1-crosa@redhat.com>
References: <20181004151429.7232-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] Acceptance Tests: add variants definition
 for architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

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
 tests/acceptance/variants/arch.json | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tests/acceptance/variants/arch.json

diff --git a/tests/acceptance/variants/arch.json b/tests/acceptance/variants/arch.json
new file mode 100644
index 0000000000..a7a2570553
--- /dev/null
+++ b/tests/acceptance/variants/arch.json
@@ -0,0 +1 @@
+[{"paths":["/run/*"],"variant":[["/run/aarch64",[["/run/aarch64", "arch", "aarch64"]]]],"variant_id": "aarch64"},{"paths":["/run/*"],"variant":[["/run/ppc",[["/run/ppc", "arch", "ppc"]]]],"variant_id": "ppc"},{"paths":["/run/*"],"variant":[["/run/ppc64",[["/run/ppc64", "arch", "ppc64"]]]],"variant_id": "ppc64"},{"paths":["/run/*"],"variant":[["/run/s390x",[["/run/s390x", "arch", "s390x"]]]],"variant_id": "s390x"},{"paths":["/run/*"],"variant":[["/run/x86_64",[["/run/x86_64", "arch", "x86_64"]]]],"variant_id": "x86_64"}]
-- 
2.17.1
