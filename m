Received: from eggs.gnu.org ([2001:4830:134:3::10]:41974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQtw9-00088h-EX
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQtw8-0003qK-H6
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:22:41 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Jun 2018 14:22:31 +0200
Message-Id: <1528374154-14680-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1528374154-14680-1-git-send-email-thuth@redhat.com>
References: <1528374154-14680-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] roms: Update SLOF submodule to current
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

We need the latest version of SLOF's libnet for adding pxelinux.cfg
support in the s390-ccw bios, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I assume that Alexey will send a SLOF update soon, too, which
 supplies the SLOF.bin file for these changes.

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
