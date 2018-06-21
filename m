Received: from eggs.gnu.org ([2001:4830:134:3::10]:53010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt2p-0000su-Cf
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt2m-0000Vc-69
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:11 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt2l-0000Uq-Sk
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:08 -0400
Received: by mail-wm0-x243.google.com with SMTP id o13-v6so3083689wmf.4
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:26:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:09 +0100
Message-Id: <20180621062605.941-2-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 01/57] docker: docker.py wrap StringIO import
 for python3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Although the docker.py is nominally python2 we actually invoke it with
the configured python from the configure script.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 306e14cf69..e4095270eb 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -26,7 +26,10 @@ import tempfile
 import re
 import signal
 from tarfile import TarFile, TarInfo
-from StringIO import StringIO
+try:
+    from StringIO import StringIO
+except ImportError:
+    from io import StringIO
 from shutil import copy, rmtree
 from pwd import getpwuid
 
-- 
2.17.1
