Received: from eggs.gnu.org ([2001:4830:134:3::10]:46668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWt-0004mQ-I6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWp-0007j6-Ls
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:19 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWp-0007id-El
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:15 -0400
Received: by mail-wm0-x242.google.com with SMTP id j85so30448035wmj.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:15 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	y35sm22202793wrc.51.2017.07.05.00.15.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jul 2017 00:15:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:24 +0200
Message-Id: <1499238885-26161-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/42] qemu-doc: do not refer to years-old
 version numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 45f67f6..d2986cb 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -386,11 +386,9 @@ CPU registers by prefixing them with @emph{$}.
 @node disk_images
 @section Disk Images
 
-Since version 0.6.1, QEMU supports many disk image formats, including
-growable disk images (their size increase as non empty sectors are
-written), compressed and encrypted disk images. Version 0.8.3 added
-the new qcow2 disk image format which is essential to support VM
-snapshots.
+QEMU supports many disk image formats, including growable disk images
+(their size increase as non empty sectors are written), compressed and
+encrypted disk images.
 
 @menu
 * disk_images_quickstart::    Quick start for disk image creation
-- 
1.8.3.1
