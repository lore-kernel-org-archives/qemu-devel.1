Received: from eggs.gnu.org ([2001:4830:134:3::10]:59265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipsx-0001am-6l
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipsu-0006qm-Of
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eipsu-0006ox-It
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:12 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:44 -0200
Message-Id: <20180205230900.11344-6-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/21] qapi: Adapt to moved location of
 'maketrans' function in py3
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20180116134217.8725-6-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qapi.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 514cca44bf..1fdd189c0d 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1734,7 +1734,10 @@ def c_enum_const(type_name, const_name, prefix=None):
         type_name = prefix
     return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
 
-c_name_trans = string.maketrans('.-', '__')
+if hasattr(str, 'maketrans'):
+    c_name_trans = str.maketrans('.-', '__')
+else:
+    c_name_trans = string.maketrans('.-', '__')
 
 
 # Map @name to a valid C identifier.
-- 
2.14.3
