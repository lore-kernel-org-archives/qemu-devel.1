Received: from eggs.gnu.org ([209.51.188.92]:46588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE7W-0005HR-Dm
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE7T-0004W1-Vq
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:18:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkE7Q-00044F-CX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:18:30 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 17 Jan 2019 18:17:43 -0200
Message-Id: <20190117201743.20470-10-ehabkost@redhat.com>
In-Reply-To: <20190117201743.20470-1-ehabkost@redhat.com>
References: <20190117201743.20470-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] scripts/replay-dump.py: fix utf-8 mangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20190117153338.11820-1-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
-#  Copyright (c) 2017 Alex Benn=C3=83=C2=A9e <alex.bennee@linaro.org>
+#  Copyright (c) 2017 Alex Benn=C3=A9e <alex.bennee@linaro.org>
 #
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
--=20
2.18.0.rc1.1.g3f1ff2140
