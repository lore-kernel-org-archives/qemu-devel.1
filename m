Received: from eggs.gnu.org ([2001:4830:134:3::10]:44387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVq-0004hr-GN
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVn-0000l1-Pe
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g6uVn-0000kH-BS
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 318964CEAA
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 09:29:06 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  1 Oct 2018 11:28:45 +0200
Message-Id: <20181001092848.11082-3-kraxel@redhat.com>
In-Reply-To: <20181001092848.11082-1-kraxel@redhat.com>
References: <20181001092848.11082-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] doc: replace x-root with rootdir for usb-mtp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bandan <bsd@redhat.com>

From: Bandan <bsd@redhat.com>

Signed-off-by: Bandan <bsd@redhat.com>
Message-id: 20180907220851.9658-3-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qemu-doc.texi             | 2 +-
 scripts/device-crash-test | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 7bd449f398..f7ad1dfe4b 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -943,7 +943,7 @@ for details
 Bulk-only transport storage device, see
 @url{https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/usb-storage.txt,usb-storage.txt}
 for details here, too
-@item usb-mtp,x-root=@var{dir}
+@item usb-mtp,rootdir=@var{dir}
 Media transfer protocol device, using @var{dir} as root of the file tree
 that is presented to the guest.
 @item usb-host,hostbus=@var{bus},hostaddr=@var{addr}
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e6c233e9bf..7045594bd4 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -125,7 +125,7 @@ ERROR_WHITELIST = [
     {'device':'tpm-tis', 'expected':True},                 # tpm_tis: backend driver with id (null) could not be found
     {'device':'unimplemented-device', 'expected':True},    # property 'size' not specified or zero
     {'device':'usb-braille', 'expected':True},             # Property chardev is required
-    {'device':'usb-mtp', 'expected':True},                 # x-root property must be configured
+    {'device':'usb-mtp', 'expected':True},                 # rootdir property must be configured
     {'device':'usb-redir', 'expected':True},               # Parameter 'chardev' is missing
     {'device':'usb-serial', 'expected':True},              # Property chardev is required
     {'device':'usb-storage', 'expected':True},             # drive property not set
-- 
2.9.3
