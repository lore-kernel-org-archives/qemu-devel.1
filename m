Received: from eggs.gnu.org ([209.51.188.92]:59912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7c-0005mk-Ij
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7Y-00042f-By
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:30 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7Q-0003pw-EW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:21 -0500
Received: by mail-wr1-x42c.google.com with SMTP id f7so994901wrp.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:55 +0100
Message-Id: <1549305379-51117-54-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 53/77] hw/m68k/Makefile.objs: Conditionally
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
