Received: from eggs.gnu.org ([209.51.188.92]:46440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sDA-0002Vd-3h
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD7-0005CT-H7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:11 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sD5-0004dR-Un
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:09 -0500
Received: by mail-wm1-x344.google.com with SMTP id o10so400428wmc.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:58 +0100
Message-Id: <1551723614-1823-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 38/54] cris-softmmu.mak: express dependencies
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
 default-configs/cris-softmmu.mak | 5 ++---
 hw/cris/Kconfig                  | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/default-configs/cris-softmmu.mak b/default-configs/cris-softmmu.mak
index b3cae59..5932cf4 100644
--- a/default-configs/cris-softmmu.mak
+++ b/default-configs/cris-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for cris-softmmu
 
-CONFIG_ETRAXFS=y
-CONFIG_NAND=y
-CONFIG_PFLASH_CFI02=y
+# Boards:
+#
 CONFIG_AXIS=y
diff --git a/hw/cris/Kconfig b/hw/cris/Kconfig
index b7738ab..884ad2c 100644
--- a/hw/cris/Kconfig
+++ b/hw/cris/Kconfig
@@ -1,5 +1,8 @@
 config AXIS
     bool
+    select ETRAXFS
+    select PFLASH_CFI02
+    select NAND
 
 config ETRAXFS
    bool
-- 
1.8.3.1
