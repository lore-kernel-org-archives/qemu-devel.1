Received: from eggs.gnu.org ([209.51.188.92]:36388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gd-0002bc-9y
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gc-000481-DJ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:19 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:37122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gb-00046N-LP
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:17 -0500
Received: by mail-wr1-x42e.google.com with SMTP id s12so4726430wrt.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:17 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id p5sm8931665wmh.16.2019.02.05.10.16.13
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 10:16:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:55 +0100
Message-Id: <1549390526-24246-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/76] arm: disable CONFIG_SERIAL_ISA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARM should not have an ISA bus, this device should not be enabled.
Kconfig allows to clean up the dependencies and remove CONFIG_ISA_BUS=y
from ARM, and then catches a contradiction between the hardcoded
CONFIG_SERIAL_ISA=y and CONFIG_ISA_BUS=n.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-2-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index be88870..d7b540c 100644
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
