Received: from eggs.gnu.org ([2001:4830:134:3::10]:59287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipsz-0001cr-7B
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipsy-0006yc-E7
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eipsy-0006xU-7y
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:16 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:46 -0200
Message-Id: <20180205230900.11344-8-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/21] qapi: ensure stable sort ordering when
 checking QAPI entities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Some early python 3.x versions will have different default
ordering when calling the 'values()' method on a dict, compared
to python 2.x and later 3.x versions. Explicitly sort the items
to get a stable ordering.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20180116134217.8725-8-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qapi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1fdd189c0d..58f995b07f 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1678,7 +1678,7 @@ class QAPISchema(object):
                 assert False
=20
     def check(self):
-        for ent in self._entity_dict.values():
+        for (name, ent) in sorted(self._entity_dict.items()):
             ent.check(self)
=20
     def visit(self, visitor):
--=20
2.14.3
