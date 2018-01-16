Received: from eggs.gnu.org ([2001:4830:134:3::10]:40133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRWx-0007xT-3y
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRWt-00017Y-UT
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebRWt-00017E-OM
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:43:55 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 16 Jan 2018 13:42:06 +0000
Message-Id: <20180116134217.8725-4-berrange@redhat.com>
In-Reply-To: <20180116134217.8725-1-berrange@redhat.com>
References: <20180116134217.8725-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 03/14] qapi: Use OrderedDict from standard
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
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The OrderedDict class appeared in the 'collections' module
from python 2.7 onwards, so use that in preference to our
local backport if available.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 98d7123d27..514b7bb5a4 100644
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
=20
 builtin_types =3D {
     'null':     'QTYPE_QNULL',
--=20
2.14.3
