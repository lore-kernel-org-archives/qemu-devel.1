Received: from eggs.gnu.org ([2001:4830:134:3::10]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTne-0001qg-1u
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnd-0008FZ-8T
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:26 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 22:51:58 +0200
Message-Id: <20180611205203.2624-6-mreitz@redhat.com>
In-Reply-To: <20180611205203.2624-1-mreitz@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/10] qapi: Formalize qcow encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

qcow only supports a single encryption (and there is no reason why that
would change in the future), so we can make it the default.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 295ace42ae..98295ac30e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2647,8 +2647,9 @@
 # Since: 2.10
 ##
 { 'union': 'BlockdevQcowEncryption',
-  'base': { 'format': 'BlockdevQcowEncryptionFormat' },
+  'base': { '*format': 'BlockdevQcowEncryptionFormat' },
   'discriminator': 'format',
+  'default-variant': 'aes',
   'data': { 'aes': 'QCryptoBlockOptionsQCow' } }
 
 ##
-- 
2.17.1
