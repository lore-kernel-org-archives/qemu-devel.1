Received: from eggs.gnu.org ([2001:4830:134:3::10]:41382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt7-00037W-KO
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt6-0001VV-S0
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:13 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAt6-0001Uu-LU
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:12 -0400
Received: by mail-wm0-x236.google.com with SMTP id o78-v6so24238410wmg.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:35 +0200
Message-Id: <1525817687-34620-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/30] qemu-options: Remove remainders of the
 -tdf option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The -tdf options has been removed with d07aa197c5a1556449361a0cbb5108e2,
but apparently I forgot to remove the corresponding two lines from
qemu-options.hx, so this option is still "available" and just silently
ignored. Kill it now for good.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1525453270-23074-2-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 091ded6..50c906c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3921,9 +3921,6 @@ DEF("no-kvm-pit-reinjection", 0, QEMU_OPTION_no_kvm_pit_reinjection,
 HXCOMM Deprecated by -machine kernel_irqchip=on|off property
 DEF("no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip, "", QEMU_ARCH_I386)
 
-HXCOMM Deprecated (ignored)
-DEF("tdf", 0, QEMU_OPTION_tdf,"", QEMU_ARCH_ALL)
-
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
     "-msg timestamp[=on|off]\n"
     "                change the format of messages\n"
-- 
1.8.3.1
