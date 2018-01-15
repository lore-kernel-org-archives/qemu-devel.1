Received: from eggs.gnu.org ([2001:4830:134:3::10]:51541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1yd-00019f-8K
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1yc-0007KA-56
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:26:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb1yb-0007Jt-WB
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:26:50 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 Jan 2018 10:26:11 +0000
Message-Id: <20180115102621.9183-4-berrange@redhat.com>
In-Reply-To: <20180115102621.9183-1-berrange@redhat.com>
References: <20180115102621.9183-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/13] qapi: Use OrderedDict from standard
 library if available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The OrderedDict class appeared in the 'collections' module
from python 2.7 onwards, so use that in preference to our
local backport if available.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 5ef50317ca..7ec2e00b2c 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -18,7 +18,10 @@ import os
 import re
 import string
 import sys
-from ordereddict import OrderedDict
+try:
+    from collections import OrderedDict
+except:
+    from ordereddict import OrderedDict
 
 builtin_types = {
     'null':     'QTYPE_QNULL',
-- 
2.14.3
