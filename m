Received: from eggs.gnu.org ([209.51.188.92]:36750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gz-00030m-2x
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gp-0004L5-FF
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:34 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gn-0004Ii-CI
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:30 -0500
Received: by mail-wr1-x430.google.com with SMTP id q15so4662362wro.12
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:06 +0100
Message-Id: <1549390526-24246-57-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 56/76] hw/sh4/Makefile.objs: New CONFIG_*
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
Cc: =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

Make hw/sh4 configurable and add new CONFIG_* to the
default-configs/sh4*-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-13-yang.zhong@intel.com>
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
