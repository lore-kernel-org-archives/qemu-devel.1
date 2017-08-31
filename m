Received: from eggs.gnu.org ([2001:4830:134:3::10]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOo-0007yS-Gt
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOl-0007cz-Br
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnQOl-0007cf-5F
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:47 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 31 Aug 2017 15:24:28 +0100
Message-Id: <20170831142430.16665-4-berrange@redhat.com>
In-Reply-To: <20170831142430.16665-1-berrange@redhat.com>
References: <20170831142430.16665-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] qapi: Use OrderedDict from standard
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>

The OrderedDict class appeared in the 'collections' module
from python 2.7 onwards, so use that in preference to our
local backport if available.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index d89af7d6c6..05cb1ee38c 100644
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
2.13.5
