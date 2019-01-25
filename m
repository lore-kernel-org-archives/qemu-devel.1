Received: from eggs.gnu.org ([209.51.188.92]:57689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOK-0007Fj-DB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOJ-0001Rl-Qp
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:16 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOJ-0001Qs-Ky
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:15 -0500
Received: by mail-wr1-x442.google.com with SMTP id 96so9655909wrb.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:20 +0100
Message-Id: <1548410831-19553-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 01/52] arm: disable CONFIG_SERIAL_ISA
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

ARM does not have an ISA bus, this device should not be enabled.  Kconfig
catches the contradiction because ARM does not define CONFIG_ISA_BUS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 2420491..3c9351f 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -6,7 +6,6 @@ CONFIG_VGA=y
 CONFIG_NAND=y
 CONFIG_ECC=y
 CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PTIMER=y
 CONFIG_SD=y
 CONFIG_MAX7310=y
-- 
1.8.3.1
