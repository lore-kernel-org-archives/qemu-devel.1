Received: from eggs.gnu.org ([2001:4830:134:3::10]:44550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS9-0004LM-81
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS7-0004vE-To
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:21 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimS7-0004ur-LV
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:19 -0500
Received: by mail-wm0-x241.google.com with SMTP id 141so27957692wme.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:19 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:25 +0100
Message-Id: <1517858941-5538-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/47] scripts/qemu-gdb/timers.py: define
 encoding in header comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

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
Message-Id: <151629549711.18276.15497684562308683805.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qemugdb/timers.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index be71a00..51ea04b 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# -*- coding: utf-8 -*-
 # GDB debugging support
 #
 # Copyright 2017 Linaro Ltd
-- 
1.8.3.1
