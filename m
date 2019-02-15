Received: from eggs.gnu.org ([209.51.188.92]:40496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gubGV-0007E3-Ah
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gub3s-0005Ec-Hl
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:49:42 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gub3s-0004BY-2f
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:49:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id l5so8738810wrw.6
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 02:49:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 15 Feb 2019 11:49:17 +0100
Message-Id: <1550227757-10869-3-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] build: clean trace/generated-helpers.c
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.target b/Makefile.target
index 06b44c0..2904910 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -221,6 +221,7 @@ clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
 	rm -f hmp-commands.h gdbstub-xml.c
+	rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
 ifdef CONFIG_TRACE_SYSTEMTAP
 	rm -f *.stp
 endif
-- 
1.8.3.1
