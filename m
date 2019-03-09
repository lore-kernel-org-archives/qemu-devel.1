Received: from eggs.gnu.org ([209.51.188.92]:47238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wic-0003qk-6k
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wia-0000QS-9B
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:30 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2WiX-0000KL-3A
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:26 -0500
Received: by mail-wr1-x42e.google.com with SMTP id l12so7191028wrp.6
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id 11sm5252294wmg.27.2019.03.08.23.48.20
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 08 Mar 2019 23:48:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:47:55 +0100
Message-Id: <1552117698-12355-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/25] vfio-pci: enable by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

CONFIG_VFIO_PCI was not "default y" - and once you do that, it is also
important to disable it if PCI is not there.

Reported-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index ebda9fd..34da2a3 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -4,8 +4,9 @@ config VFIO
 
 config VFIO_PCI
     bool
+    default y
     select VFIO
-    depends on LINUX
+    depends on LINUX && PCI
 
 config VFIO_CCW
     bool
-- 
1.8.3.1
