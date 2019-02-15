Received: from eggs.gnu.org ([209.51.188.92]:40741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gubGV-0007Vx-9c
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gub3t-0005Hk-DF
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:49:42 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gub3s-00048X-Uf
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:49:41 -0500
Received: by mail-wr1-x442.google.com with SMTP id t18so9867269wrx.2
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 02:49:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 15 Feb 2019 11:49:16 +0100
Message-Id: <1550227757-10869-2-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] build: remove unnecessary assignments from
 Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, eblake@redhat.com

It is only necessary to clear block-obj-y because Makefile.objs
uses "+=" instead of "="; fix that and remove the assignment.
The other variables need not be cleared at all.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs   | 2 +-
 Makefile.target | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index c3a2354..e5cc928 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -22,7 +22,7 @@ slirp-obj-$(CONFIG_SLIRP) = slirp/
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
 
-block-obj-y += nbd/
+block-obj-y = nbd/
 block-obj-y += block.o blockjob.o job.o
 block-obj-y += block/ scsi/
 block-obj-y += qemu-io-cmds.o
diff --git a/Makefile.target b/Makefile.target
index a56a72f..06b44c0 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -174,10 +174,6 @@ endif # CONFIG_SOFTMMU
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
-block-obj-y :=
-common-obj-y :=
-chardev-obj-y :=
-slirp-obj-y :=
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call unnest-vars,.., \
                block-obj-y \
-- 
1.8.3.1
