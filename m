Received: from eggs.gnu.org ([2001:4830:134:3::10]:60602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqK-0001pd-Lk
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqI-0000GY-Lb
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqI-0000GG-EY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:58 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:36 -0300
Message-Id: <20180611174243.31070-7-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 06/13] python: futurize -f
 lib2to3.fixes.fix_reduce
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Handle the move of reduce() to functools.reduce().

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_reduce $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608122952.2009-7-ehabkost@redhat.com>
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
