Received: from eggs.gnu.org ([209.51.188.92]:60568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODI-0006lm-H0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODH-0002p9-K1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:38539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODH-0002od-Bw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id a188so5017216wmf.3
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:43 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e12sm6484836wrs.91.2019.03.11.09.55.39 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 Mar 2019 09:55:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:06 +0100
Message-Id: <1552323335-46779-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 02/31] vfio-pci: enable by default
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
