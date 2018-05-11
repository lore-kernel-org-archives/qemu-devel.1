Received: from eggs.gnu.org ([2001:4830:134:3::10]:41262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHGQJ-0002kM-Un
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHGQJ-0004TX-5W
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:21:59 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 11 May 2018 19:20:48 -0300
Message-Id: <20180511222052.8734-7-ehabkost@redhat.com>
In-Reply-To: <20180511222052.8734-1-ehabkost@redhat.com>
References: <20180511222052.8734-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 06/10] python: futurize -f
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

Handle the move of reduce() to functools.reduce().

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_reduce $py

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
2.14.3
