Received: from eggs.gnu.org ([209.51.188.92]:46471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sDC-0002Xn-SB
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD9-0005EH-J6
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:13 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sD6-0004qn-2j
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:09 -0500
Received: by mail-wr1-x42e.google.com with SMTP id n2so6634467wrw.8
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:20:05 +0100
Message-Id: <1551723614-1823-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/54] or1k-softmmu.mak: express dependencies
 with Kconfig
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
 default-configs/or1k-softmmu.mak | 5 ++---
 hw/openrisc/Kconfig              | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/default-configs/or1k-softmmu.mak b/default-configs/or1k-softmmu.mak
index 6a0f2ef..168101c 100644
--- a/default-configs/or1k-softmmu.mak
+++ b/default-configs/or1k-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for or1k-softmmu
 
-CONFIG_SERIAL=y
-CONFIG_OPENCORES_ETH=y
-CONFIG_OMPIC=y
+# Boards:
+#
 CONFIG_OR1K_SIM=y
diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
index 7aef98d..6c1e868 100644
--- a/hw/openrisc/Kconfig
+++ b/hw/openrisc/Kconfig
@@ -1,2 +1,5 @@
 config OR1K_SIM
     bool
+    select SERIAL
+    select OPENCORES_ETH
+    select OMPIC
-- 
1.8.3.1
