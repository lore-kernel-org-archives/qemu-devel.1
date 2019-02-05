Received: from eggs.gnu.org ([209.51.188.92]:36658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gk-0002jk-EU
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gi-0004G9-PA
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gi-0004FG-HN
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:24 -0500
Received: by mail-wm1-x32d.google.com with SMTP id z5so4669880wmf.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:02 +0100
Message-Id: <1549390526-24246-53-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 52/76] hw/m68k/Makefile.objs: Conditionally
 build boards
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

CONFIG_AN5206, CONFIG_MCF5206 and CONFIG_MCF5208 make
variables created for m68k boards, and added to
default-configs/m86k-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-9-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/m68k-softmmu.mak | 2 ++
 hw/m68k/Makefile.objs            | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index 60f7cdf..27f5274 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -2,3 +2,5 @@
 
 CONFIG_COLDFIRE=y
 CONFIG_PTIMER=y
+CONFIG_AN5206=y
+CONFIG_MCF5208=y
diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
index d1f089c..482f847 100644
--- a/hw/m68k/Makefile.objs
+++ b/hw/m68k/Makefile.objs
@@ -1,2 +1,2 @@
-obj-y += an5206.o mcf5208.o
-obj-y += mcf5206.o mcf_intc.o
+obj-$(CONFIG_AN5206) += an5206.o mcf5206.o
+obj-$(CONFIG_MCF5208) += mcf5208.o mcf_intc.o
-- 
1.8.3.1
