Received: from eggs.gnu.org ([209.51.188.92]:36772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5H3-00035P-Fb
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gu-0004NN-2O
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:39 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:51901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gp-0004KQ-Lt
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id b11so4697300wmj.1
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:30 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:09 +0100
Message-Id: <1549390526-24246-60-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 59/76] hw/lm32/Makefile.objs: Conditionally
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
Cc: =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_LM32 and CONFIG_MILKYMIST added for lm32 and milkmyst build.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-16-yang.zhong@intel.com>
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
