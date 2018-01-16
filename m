Received: from eggs.gnu.org ([2001:4830:134:3::10]:40335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRXM-0008Jg-Qs
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRXM-0001Lf-3U
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebRXL-0001L3-T8
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:24 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 16 Jan 2018 13:42:13 +0000
Message-Id: <20180116134217.8725-11-berrange@redhat.com>
In-Reply-To: <20180116134217.8725-1-berrange@redhat.com>
References: <20180116134217.8725-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 10/14] configure: allow use of python 3
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

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 configure | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index b272a0336b..60b99f45f6 100755
--- a/configure
+++ b/configure
@@ -1598,9 +1598,8 @@ fi
 
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6) or sys.version_info >= (3,))'; then
-  error_exit "Cannot use '$python', Python 2.6 or later is required." \
-      "Note that Python 3 or later is not yet supported." \
+if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6))'; then
+  error_exit "Cannot use '$python', Python 2 >= 2.6 or Python 3 is required." \
       "Use --python=/path/to/python to specify a supported Python."
 fi
 
-- 
2.14.3
