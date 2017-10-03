Received: from eggs.gnu.org ([2001:4830:134:3::10]:42618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKUt-00032e-AQ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKUr-0001xb-9k
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:19 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzKUr-0001x5-2X
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:17 -0400
Received: by mail-wm0-x244.google.com with SMTP id i124so15831611wmf.3
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 03:32:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 12:28:36 +0200
Message-Id: <1507026521-19230-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
References: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] scsi: Ignore executable for in-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The new qemu-pr-helper (commit b855f8d17) should not be checked in,
even when doing in-tree builds.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170926151421.14557-1-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 40acfcb..3a7e01d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,7 @@
 /qemu-version.h
 /qemu-version.h.tmp
 /module_block.h
+/scsi/qemu-pr-helper
 /vscclient
 /vhost-user-scsi
 /fsdev/virtfs-proxy-helper
-- 
1.8.3.1
