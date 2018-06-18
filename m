Received: from eggs.gnu.org ([2001:4830:134:3::10]:57269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV2zx-0005vu-4V
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV2zw-0005dX-En
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fV2zw-0005dF-8v
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 18 Jun 2018 19:51:29 -0300
Message-Id: <20180618225131.13113-2-ehabkost@redhat.com>
In-Reply-To: <20180618225131.13113-1-ehabkost@redhat.com>
References: <20180618225131.13113-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] device-crash-test: No need for sys.path
 hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The device-crash-test script is already inside the 'scripts'
directory, there's no need to add the directory manually to
sys.path.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e6c233e9bf..52a2a613d4 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -35,7 +35,6 @@ import random
 import argparse
 from itertools import chain
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'scripts'))
 from qemu import QEMUMachine
 
 logger = logging.getLogger('device-crash-test')
-- 
2.18.0.rc1.1.g3f1ff2140
