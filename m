Received: from eggs.gnu.org ([2001:4830:134:3::10]:58639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5Scl-0007ZD-VZ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5Sci-0000bO-Th
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d5Sci-0000Zn-OY
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C67C1C12A142
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 07:53:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  2 May 2017 09:53:17 +0200
Message-Id: <1493711597-21803-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Print a warning message if the user specified
 a legacy USB option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

'-usb' and '-usbdevice' are considered as deprecated nowadays and
we might want to remove these options in a future version of QEMU.
So print out a warning if they are used and tell the user what to
use instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 vl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/vl.c b/vl.c
index 42d4bce..0023298 100644
--- a/vl.c
+++ b/vl.c
@@ -3748,10 +3748,14 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_usb:
+                error_report("'-usb' is deprecated, please use "
+                             "'-M usb=on' instead");
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "usb=on", false);
                 break;
             case QEMU_OPTION_usbdevice:
+                error_report("'-usbdevice' is deprecated, please use "
+                             "'-device usb-...' instead");
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "usb=on", false);
                 add_device_config(DEV_USB, optarg);
-- 
1.8.3.1
