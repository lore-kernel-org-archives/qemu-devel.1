Received: from eggs.gnu.org ([209.51.188.92]:38891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk9gP-0001U8-MH
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk9gL-0006fL-G0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:15 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gk9gH-0006Kd-O4
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:11 -0500
Received: by mail-wm1-x344.google.com with SMTP id m22so1528017wml.3
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 07:34:08 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Jan 2019 15:33:38 +0000
Message-Id: <20190117153338.11820-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] scripts/replay-dump.py: fix utf-8 mangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/replay-dump.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 5ae77c8a92..ee7fda2638 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -3,7 +3,7 @@
 #
 # Dump the contents of a recorded execution stream
 #
-#  Copyright (c) 2017 Alex BennÃ©e <alex.bennee@linaro.org>
+#  Copyright (c) 2017 Alex Bennée <alex.bennee@linaro.org>
 #
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
-- 
2.17.1
