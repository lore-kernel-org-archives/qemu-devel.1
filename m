Received: from eggs.gnu.org ([2001:4830:134:3::10]:36673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cX334-0006PD-6O
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cX331-0008Oi-49
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:42:26 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 27 Jan 2017 11:41:54 +0200
Message-Id: <20170127094154.19778-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qemu-doc: Clarify that -vga std is now the
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Alberto Garcia <berto@igalia.com>

The QEMU manual page states that Cirrus Logic is the default video
card if the user doesn't specify any. However this is not true since
QEMU 2.2.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 80df52651a..66ee562821 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1195,12 +1195,12 @@ Select type of VGA card to emulate. Valid values for @var{type} are
 Cirrus Logic GD5446 Video card. All Windows versions starting from
 Windows 95 should recognize and use this graphic card. For optimal
 performances, use 16 bit color depth in the guest and the host OS.
-(This one is the default)
+(This card was the default before QEMU 2.2)
 @item std
 Standard VGA card with Bochs VBE extensions.  If your guest OS
 supports the VESA 2.0 VBE extensions (e.g. Windows XP) and if you want
 to use high resolution modes (>= 1280x1024x16) then you should use
-this option.
+this option. (This card is the default since QEMU 2.2)
 @item vmware
 VMWare SVGA-II compatible adapter. Use it if you have sufficiently
 recent XFree86/XOrg server or Windows guest with a driver for this
-- 
2.11.0
