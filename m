Received: from eggs.gnu.org ([209.51.188.92]:57653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwA-0002Cf-4I
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnw9-0002Q6-BB
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:10 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnw7-0002Oa-C0
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:09 -0500
Received: by mail-wm1-x341.google.com with SMTP id p6so829243wmc.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:10 +0100
Message-Id: <1549562254-41157-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 27/51] sd: express dependencies with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 -
 hw/sd/Kconfig                   | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 3491403..8283aeb 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -6,7 +6,6 @@ CONFIG_VGA=y
 CONFIG_NAND=y
 CONFIG_ECC=y
 CONFIG_SERIAL=y
-CONFIG_SD=y
 CONFIG_MAX7310=y
 CONFIG_WM8750=y
 CONFIG_TWL92230=y
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 8f12d9c..864f535 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -1,9 +1,11 @@
 config PL181
     bool
+    select SD
 
 config SSI_SD
     bool
     depends on SSI
+    select SD
 
 config SD
     bool
-- 
1.8.3.1
