Received: from eggs.gnu.org ([2001:4830:134:3::10]:38431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fvouK-0006Bu-T9
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 15:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fvouG-0003ZD-Lg
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 15:16:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fvouG-0003Z0-GB
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 15:16:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C09D26353
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 19:16:31 +0000 (UTC)
From: Bandan <bsd@redhat.com>
Date: Fri, 31 Aug 2018 15:16:19 -0400
Message-Id: <20180831191619.20275-3-bsd@redhat.com>
In-Reply-To: <20180831191619.20275-1-bsd@redhat.com>
References: <20180831191619.20275-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] doc: replace x-root with rootdir for
 usb-mtp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Signed-off-by: Bandan <bsd@redhat.com>
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
2.11.0
