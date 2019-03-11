Received: from eggs.gnu.org ([209.51.188.92]:60767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODZ-000757-DO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODY-000359-7X
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODW-00031z-8x
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id p8so4334262wrq.6
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:57 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e12sm6484836wrs.91.2019.03.11.09.55.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 Mar 2019 09:55:55 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:20 +0100
Message-Id: <1552323335-46779-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 16/31] build: remove unnecessary assignments
 from Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It is only necessary to clear block-obj-y because Makefile.objs
uses "+=" instead of "="; fix that and remove the assignment.
The other variables need not be cleared at all.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs   | 2 +-
 Makefile.target | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index acc53aa..31a84b7 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -13,7 +13,7 @@ authz-obj-y = authz/
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
 
-block-obj-y += nbd/
+block-obj-y = nbd/
 block-obj-y += block.o blockjob.o job.o
 block-obj-y += block/ scsi/
 block-obj-y += qemu-io-cmds.o
diff --git a/Makefile.target b/Makefile.target
index a458506..441ace6 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -175,9 +175,6 @@ endif # CONFIG_SOFTMMU
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
-block-obj-y :=
-common-obj-y :=
-chardev-obj-y :=
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call unnest-vars,.., \
                authz-obj-y \
-- 
1.8.3.1
