Received: from eggs.gnu.org ([2001:4830:134:3::10]:40596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ecDjF-00044G-UK
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ecDjB-0006rA-UQ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:11:53 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:59432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ecDjB-0006mK-OS
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:11:49 -0500
Received: from player791.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 27A14A5E1F
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 18:11:48 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 18 Jan 2018 18:11:37 +0100
Message-ID: <151629549711.18276.15497684562308683805.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] scripts/qemu-gdb/timers.py: define encoding in
 header comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This is required otherwise python complains because of the
accentuated letter in Alex's last name:

Traceback (most recent call last):
  File "scripts/qemu-gdb.py", line 29, in <module>
    from qemugdb import aio, mtree, coroutine, tcg, timers
  File "scripts/qemugdb/timers.py", line 1
SyntaxError: Non-ASCII character '\xc3' in file scripts/qemugdb/timers.py
 on line 1, but no encoding declared;
 see http://www.python.org/peps/pep-0263.html for details

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 scripts/qemugdb/timers.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index be71a001e333..51ea04b5e2ec 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# -*- coding: utf-8 -*-
 # GDB debugging support
 #
 # Copyright 2017 Linaro Ltd
