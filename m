Received: from eggs.gnu.org ([2001:4830:134:3::10]:45722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRGXx-00086a-3X
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRGXw-0005BB-91
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:31:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  8 Jun 2018 09:29:48 -0300
Message-Id: <20180608122952.2009-7-ehabkost@redhat.com>
In-Reply-To: <20180608122952.2009-1-ehabkost@redhat.com>
References: <20180608122952.2009-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/10] python: futurize -f
 lib2to3.fixes.fix_reduce
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Handle the move of reduce() to functools.reduce().

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_reduce $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/image-fuzzer/qcow2/fuzz.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/image-fuzzer/qcow2/fuzz.py b/tests/image-fuzzer/qcow2/fuzz.py
index 20eba6bc1b..abc4f0635d 100644
--- a/tests/image-fuzzer/qcow2/fuzz.py
+++ b/tests/image-fuzzer/qcow2/fuzz.py
@@ -17,6 +17,7 @@
 #
 
 import random
+from functools import reduce
 
 UINT8 = 0xff
 UINT16 = 0xffff
-- 
2.18.0.rc1.1.g3f1ff2140
