Received: from eggs.gnu.org ([209.51.188.92]:58071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOn-0007cb-Ar
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOl-0001ph-5s
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOk-0001dK-UZ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:43 -0500
Received: by mail-wm1-x342.google.com with SMTP id y8so6008620wmi.4
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:30 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:34 +0100
Message-Id: <1548410831-19553-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 15/52] hw/lm32/Makefile.objs: Conditionally
 build lm32 and milkmyst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_LM32 and CONFIG_MILKYMIST added for lm32 and milkmyst build.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-12-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/lm32/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/lm32/Makefile.objs b/hw/lm32/Makefile.objs
index ea6418a..c394186 100644
--- a/hw/lm32/Makefile.objs
+++ b/hw/lm32/Makefile.objs
@@ -1,3 +1,3 @@
 # LM32 boards
-obj-y += lm32_boards.o
-obj-y += milkymist.o
+obj-$(CONFIG_LM32) += lm32_boards.o
+obj-$(CONFIG_MILKYMIST) += milkymist.o
-- 
1.8.3.1
