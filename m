Received: from eggs.gnu.org ([2001:4830:134:3::10]:51998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6p-00040A-TY
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6m-0008Gl-OW
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:35 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6m-0008GI-Hf
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:32 -0500
Received: by mail-wm0-x241.google.com with SMTP id v77so3429546wmv.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:40 +0100
Message-Id: <1487255507-106654-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/23] qemu-doc: Clarify that -vga std is now
 the default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>

From: Alberto Garcia <berto@igalia.com>

The QEMU manual page states that Cirrus Logic is the default video
card if the user doesn't specify any. However this is not true since
QEMU 2.2.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20170127094154.19778-1-berto@igalia.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ac036b4..5633d39 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1194,12 +1194,12 @@ Select type of VGA card to emulate. Valid values for @var{type} are
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
1.8.3.1
