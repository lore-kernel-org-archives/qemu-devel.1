Received: from eggs.gnu.org ([209.51.188.92]:46475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sDC-0002Xr-St
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sDA-0005Fb-87
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:14 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sD7-000533-Ed
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:11 -0500
Received: by mail-wr1-x441.google.com with SMTP id w17so6627622wrn.12
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:21:05 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:20:11 +0100
Message-Id: <1551723614-1823-52-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 51/54] unicore32-softmmu.mak: express
 dependencies with Kconfig
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

%-softmmu.mak only keep boards and optional device
definitions in Kconfig mode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/unicore32-softmmu.mak | 5 +++--
 hw/unicore32/Kconfig                  | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/default-configs/unicore32-softmmu.mak b/default-configs/unicore32-softmmu.mak
index 17a7915..0bfce48 100644
--- a/default-configs/unicore32-softmmu.mak
+++ b/default-configs/unicore32-softmmu.mak
@@ -1,4 +1,5 @@
 # Default configuration for unicore32-softmmu
-CONFIG_ISA_BUS=y
+
+# Boards:
+#
 CONFIG_PUV3=y
-CONFIG_PCKBD=y
diff --git a/hw/unicore32/Kconfig b/hw/unicore32/Kconfig
index a03a996..4443a29 100644
--- a/hw/unicore32/Kconfig
+++ b/hw/unicore32/Kconfig
@@ -1,3 +1,5 @@
 config PUV3
     bool
+    select ISA_BUS
+    select PCKBD
     select PTIMER
-- 
1.8.3.1
