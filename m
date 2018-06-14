Received: from eggs.gnu.org ([2001:4830:134:3::10]:39909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTTcy-0006xL-Nd
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTTcy-0006RN-52
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:53:32 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 14 Jun 2018 16:53:18 +0200
Message-Id: <1528988003-21855-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1528988003-21855-1-git-send-email-thuth@redhat.com>
References: <1528988003-21855-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 2/7] roms: Update SLOF submodule
 to current status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

We need the latest version of SLOF's libnet for adding pxelinux.cfg
support in the s390-ccw bios, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 roms/SLOF | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/SLOF b/roms/SLOF
index fa98132..2317427 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit fa981320a1e0968d6fc1b8de319723ff8212b337
+Subproject commit 2317427ce76006723f7ae103a6998ab41dd79c68
-- 
1.8.3.1
