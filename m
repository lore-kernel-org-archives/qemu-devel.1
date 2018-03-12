Received: from eggs.gnu.org ([2001:4830:134:3::10]:56722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evVfW-0000cI-H3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evVfV-0002DP-LF
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evVfV-0002DF-Fs
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:45 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 19:11:32 -0300
Message-Id: <20180312221132.14141-5-ehabkost@redhat.com>
In-Reply-To: <20180312221132.14141-1-ehabkost@redhat.com>
References: <20180312221132.14141-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] device-crash-test: Use 'python' binary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>

Now the script works with Python 3, so we can use the 'python'
binary provided by the system.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180312185503.5746-4-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 7443d0f2c5..f04f34924e 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -1,4 +1,4 @@
-#!/usr/bin/env python2.7
+#!/usr/bin/env python
 #
 #  Copyright (c) 2017 Red Hat Inc
 #
--=20
2.14.3
