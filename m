Received: from eggs.gnu.org ([2001:4830:134:3::10]:46471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86Lb-0005or-BI
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LT-0002cl-Lc
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:29 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 12:18:50 -0400
Message-Id: <20181004161852.11673-9-crosa@redhat.com>
In-Reply-To: <20181004161852.11673-1-crosa@redhat.com>
References: <20181004161852.11673-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 08/10] scripts/decodetree.py: fix reference to
 attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 457cffea90..37c76b5507 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -298,7 +298,7 @@ class Field:
             s = 's'
         else:
             s = ''
-        return str(pos) + ':' + s + str(len)
+        return str(self.pos) + ':' + s + str(self.len)
 
     def str_extract(self):
         if self.sign:
-- 
2.17.1
