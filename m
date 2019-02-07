Received: from eggs.gnu.org ([209.51.188.92]:55004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grpT5-0002Oe-Qf
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grpT4-0007Wv-V8
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:36:15 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  7 Feb 2019 14:36:03 -0500
Message-Id: <20190207193605.25676-3-crosa@redhat.com>
In-Reply-To: <20190207193605.25676-1-crosa@redhat.com>
References: <20190207193605.25676-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] configure: fix qemu-img name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index ff55e2273e..c8fc1647fe 100755
--- a/configure
+++ b/configure
@@ -1768,7 +1768,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   virglrenderer   virgl rendering support
   xfsctl          xfsctl support
   qom-cast-debug  cast debugging support
-  tools           build qemu-io, qemu-nbd and qemu-image tools
+  tools           build qemu-io, qemu-nbd and qemu-img tools
   vxhs            Veritas HyperScale vDisk backend support
   bochs           bochs image format support
   cloop           cloop image format support
--=20
2.20.1
