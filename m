Received: from eggs.gnu.org ([209.51.188.92]:58593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP7-0007z5-Lh
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP6-0002H7-82
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:05 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyP5-0002Fn-KA
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:03 -0500
Received: by mail-wm1-x343.google.com with SMTP id f188so5998263wmf.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:08:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:07:08 +0100
Message-Id: <1548410831-19553-50-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 49/52] tpm: express dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

This automatically removes the SCSI subsystem from the
binary altogether if no controllers are selected.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-34-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/tpm/Kconfig | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 8a63597..88890a2 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -1,18 +1,27 @@
 config TPM
     bool
 
+config TPMDEV
+    bool
+
 config TPM_TIS
     bool
     default y if PC
     depends on TPM
+    select TPMDEV
 
 config TPM_CRB
     bool
-    default y
-    depends on TPM && PC
+    default y if PC
+    depends on TPM
+    select TPMDEV
 
 config TPM_PASSTHROUGH
     bool
+    default y
+    depends on TPMDEV
 
 config TPM_EMULATOR
     bool
+    default y
+    depends on TPMDEV
-- 
1.8.3.1
