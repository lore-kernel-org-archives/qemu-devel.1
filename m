Received: from eggs.gnu.org ([209.51.188.92]:38298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIn-00008U-RR
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIn-0007zA-1y
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:09 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 20:55:48 +0100
Message-Id: <20190206195551.28893-6-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-1-mreitz@redhat.com>
References: <20190206195551.28893-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/8] qapi: Formalize qcow encryption probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

qcow only supports a single encryption (and there is no reason why that
would change in the future), so we can make it the default.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qapi/block-core.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index abf9af0c4d..8e193fe71f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2939,8 +2939,9 @@
 # Since: 2.10
 ##
 { 'union': 'BlockdevQcowEncryption',
-  'base': { 'format': 'BlockdevQcowEncryptionFormat' },
+  'base': { '*format': 'BlockdevQcowEncryptionFormat' },
   'discriminator': 'format',
+  'default-variant': 'aes',
   'data': { 'aes': 'QCryptoBlockOptionsQCow' } }
=20
 ##
--=20
2.20.1
