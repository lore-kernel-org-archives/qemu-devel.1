Received: from eggs.gnu.org ([209.51.188.92]:53228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gjTJ0-0005EM-05
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gjTIx-0005Do-L3
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:19:16 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:36761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gjTIx-0005Cy-ER
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:19:15 -0500
Received: by mail-wm1-x331.google.com with SMTP id p6so4248970wmc.1
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:19:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 Jan 2019 19:19:07 +0100
Message-Id: <1547576349-13337-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] tests: remove rule for nonexisting
 qdev-monitor-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com

This test was merged into drive_del-test in 2014.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 195af1f..8b88cd5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -737,7 +737,6 @@ tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
 tests/machine-none-test$(EXESUF): tests/machine-none-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
-tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
-- 
1.8.3.1
