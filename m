Received: from eggs.gnu.org ([209.51.188.92]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOs-0007hw-2P
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOl-0001qx-LL
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOl-0001bT-5f
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:43 -0500
Received: by mail-wm1-x341.google.com with SMTP id n190so6175820wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:31 +0100
Message-Id: <1548410831-19553-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/52] hw/sh4/Makefile.objs: New CONFIG_*
 varibales created for sh4 boards and device
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

Make hw/sh4 configurable and add new CONFIG_* to the default-configs/sh4*-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Message-Id: <20190123065618.3520-10-yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/sh4-softmmu.mak   | 2 ++
 default-configs/sh4eb-softmmu.mak | 2 ++
 hw/sh4/Makefile.objs              | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index caeccd5..1fdb009 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -19,3 +19,5 @@ CONFIG_PCSPK=y
 CONFIG_I82374=y
 CONFIG_I8257=y
 CONFIG_MC146818RTC=y
+CONFIG_R2D=y
+CONFIG_SHIX=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 53b9cd7..3b550a5 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -19,3 +19,5 @@ CONFIG_PCSPK=y
 CONFIG_I82374=y
 CONFIG_I8257=y
 CONFIG_MC146818RTC=y
+CONFIG_R2D=y
+CONFIG_SHIX=y
diff --git a/hw/sh4/Makefile.objs b/hw/sh4/Makefile.objs
index 2393702..2a707f9 100644
--- a/hw/sh4/Makefile.objs
+++ b/hw/sh4/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += shix.o r2d.o
-
 obj-y += sh7750.o sh7750_regnames.o
 obj-y += sh_pci.o
+obj-$(CONFIG_R2D) +=  r2d.o
+obj-$(CONFIG_SHIX) += shix.o
-- 
1.8.3.1
