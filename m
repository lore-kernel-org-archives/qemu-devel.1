Received: from eggs.gnu.org ([2001:4830:134:3::10]:51421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhS-0000n4-SW
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhQ-0001yv-Ve
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:22 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhQ-0001yd-Pg
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:20 -0500
Received: by mail-qk0-x243.google.com with SMTP id d66so3854232qkg.1
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:36:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 18:35:54 -0300
Message-Id: <20171213213557.26561-4-f4bug@amsat.org>
In-Reply-To: <20171213213557.26561-1-f4bug@amsat.org>
References: <20171213213557.26561-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/6] qtest.py: use TMPDIR/TEMP if the TEST_DIR
 env var is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qtest.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index 78db8d02c0..733686a6fe 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -18,12 +18,13 @@ import qemu
 import re
 import unittest
 import logging
+import tempfile
 
 
 qemu_prog = os.environ.get('QEMU_PROG', 'qemu')
 qemu_opts = os.environ.get('QEMU_OPTIONS', '').strip().split(' ')
 
-test_dir = os.environ.get('TEST_DIR')
+test_dir = os.environ.get('TEST_DIR', tempfile.gettempdir())
 output_dir = os.environ.get('OUTPUT_DIR', '.')
 qemu_default_machine = os.environ.get('QEMU_DEFAULT_MACHINE')
 
-- 
2.15.1
