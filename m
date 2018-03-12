Received: from eggs.gnu.org ([2001:4830:134:3::10]:50315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evSbZ-0003X4-Nc
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evSbY-0001iY-Vj
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evSbY-0001i1-QH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F36E380F9E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:55:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 15:55:03 -0300
Message-Id: <20180312185503.5746-4-ehabkost@redhat.com>
In-Reply-To: <20180312185503.5746-1-ehabkost@redhat.com>
References: <20180312185503.5746-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] device-crash-test: Use 'python' binary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>

Now the script works with Python 3, so we can use the 'python'
binary provided by the system.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 36194e4347..7e79a8d885 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -1,4 +1,4 @@
-#!/usr/bin/env python2.7
+#!/usr/bin/env python
 #
 #  Copyright (c) 2017 Red Hat Inc
 #
-- 
2.14.3
