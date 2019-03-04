Received: from eggs.gnu.org ([209.51.188.92]:46076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCr-0002Ec-Qj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCn-0004Yo-Ra
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:51 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCl-0004PD-TA
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:48 -0500
Received: by mail-wr1-x432.google.com with SMTP id d17so6637582wre.10
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:45 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:49 +0100
Message-Id: <1551723614-1823-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/54] sd: express dependencies with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 -
 hw/sd/Kconfig                   | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 8bb4fd1..2a7efc1 100644
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
