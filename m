Received: from eggs.gnu.org ([2001:4830:134:3::10]:51947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRIPV-0007gs-6i
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRIPQ-0004W5-Na
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:30:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fRIPQ-0004VE-DX
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:30:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  8 Jun 2018 11:30:26 -0300
Message-Id: <20180608143026.20167-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] configure: Require Python 2.7 or newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>

All of the supported build platforms documented in qemu-doc.texi
should already support Python 2.7.

Removing support for Python 2.6 will allow us to remove some
compatibility modules we carry in the QEMU tree:

* scripts/argparse.py
* scripts/ordereddict.py

Python 2.6 is also not receiving bug fixes upstream and is not
supported by pylint, which makes it harder to keep the code
compatible with both Python 2 and Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 14b11130a7..a8c4094c87 100755
--- a/configure
+++ b/configure
@@ -1651,8 +1651,8 @@ fi
 
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6))'; then
-  error_exit "Cannot use '$python', Python 2 >= 2.6 or Python 3 is required." \
+if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
+  error_exit "Cannot use '$python', Python 2 >= 2.7 or Python 3 is required." \
       "Use --python=/path/to/python to specify a supported Python."
 fi
 
-- 
2.18.0.rc1.1.g3f1ff2140
