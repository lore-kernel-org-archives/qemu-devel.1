Received: from eggs.gnu.org ([209.51.188.92]:60803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODa-00076h-VE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODa-0003EP-6n
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODY-00032q-Ru
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id y15so5068401wma.0
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:58 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e12sm6484836wrs.91.2019.03.11.09.55.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 Mar 2019 09:55:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:21 +0100
Message-Id: <1552323335-46779-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 17/31] build: clean trace/generated-helpers.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.target b/Makefile.target
index 441ace6..d8048aa 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -222,6 +222,7 @@ clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
 	rm -f hmp-commands.h gdbstub-xml.c
+	rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
 ifdef CONFIG_TRACE_SYSTEMTAP
 	rm -f *.stp
 endif
-- 
1.8.3.1
