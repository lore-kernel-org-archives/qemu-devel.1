Received: from eggs.gnu.org ([2001:4830:134:3::10]:34970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8AI-0000TZ-VO
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8AB-0006Vt-E6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb8AB-0006VX-83
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:11 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 Jan 2018 17:02:34 +0000
Message-Id: <20180115170243.24578-5-berrange@redhat.com>
In-Reply-To: <20180115170243.24578-1-berrange@redhat.com>
References: <20180115170243.24578-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/13] qapi: Adapt to moved location of
 'maketrans' function in py3
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

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
