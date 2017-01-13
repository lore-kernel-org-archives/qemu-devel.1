Received: from eggs.gnu.org ([2001:4830:134:3::10]:42787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=85m6=Y3=redhat.com=mst@kernel.org>)
	id 1cS4b1-0003NW-KL
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=85m6=Y3=redhat.com=mst@kernel.org>)
	id 1cS4ax-0000jF-Q2
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:20:55 -0500
Received: from mail.kernel.org ([198.145.29.136]:43324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=85m6=Y3=redhat.com=mst@kernel.org>)
	id 1cS4ax-0000iz-KD
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:20:51 -0500
Date: Fri, 13 Jan 2017 18:20:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484324442-3212-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] update-linux-headers.sh: support __bitwise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Tokarev <mjt@tls.msk.ru>, Eric Blake <eblake@redhat.com>

In 4.10, Linux is switching from __bitwise__ to use __bitwise
exclusively. Update our script accordingly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 08c4c4a..72cf1fb 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -51,7 +51,7 @@ cp_portable() {
         -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/"\(input-event-codes\.h\)"/"standard-headers\/linux\/\1"/' \
         -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
-        -e 's/__bitwise__//' \
+        -e 's/__bitwise//' \
         -e 's/__attribute__((packed))/QEMU_PACKED/' \
         -e 's/__inline__/inline/' \
         -e '/sys\/ioctl.h/d' \
-- 
MST
