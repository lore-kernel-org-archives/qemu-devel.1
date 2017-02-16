Received: from eggs.gnu.org ([2001:4830:134:3::10]:51729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6O-0003ZI-Qg
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6M-00082S-LZ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:08 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6M-00082G-FW
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:06 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so3428880wmi.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:06 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56])
	by smtp.gmail.com with ESMTPSA id g5sm9203365wrd.0.2017.02.16.06.32.03
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Feb 2017 06:32:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:28 +0100
Message-Id: <1487255507-106654-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/23] test-vmstate: remove
 yield_until_fd_readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The function is not needed anymore now that migration is built on
top of QIOChannel.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-vmstate.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index d0dd390..39f338a4 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -33,17 +33,6 @@
 static char temp_file[] = "/tmp/vmst.test.XXXXXX";
 static int temp_fd;
 
-/* Fake yield_until_fd_readable() implementation so we don't have to pull the
- * coroutine code as dependency.
- */
-void yield_until_fd_readable(int fd)
-{
-    fd_set fds;
-    FD_ZERO(&fds);
-    FD_SET(fd, &fds);
-    select(fd + 1, &fds, NULL, NULL, NULL);
-}
-
 
 /* Duplicate temp_fd and seek to the beginning of the file */
 static QEMUFile *open_test_file(bool write)
-- 
1.8.3.1
