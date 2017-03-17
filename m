Received: from eggs.gnu.org ([2001:4830:134:3::10]:60563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cotht-0006cs-PB
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cotho-0005qO-W9
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:22:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cotho-0005qG-QI
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:22:16 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Mar 2017 16:22:14 +0100
Message-Id: <20170317152214.6148-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] oslib-posix: fix compilation on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

si_band is not found in OpenBSD.   It is marked as obsolescent in
POSIX, so we can delete it without any remorse.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-posix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 94d81b9..3fe6089 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -709,8 +709,6 @@ void sigaction_invoke(struct sigaction *action,
         si.si_pid = info->ssi_pid;
         si.si_status = info->ssi_status;
         si.si_uid = info->ssi_uid;
-    } else if (info->ssi_signo == SIGIO) {
-        si.si_band = info->ssi_band;
     }
     action->sa_sigaction(info->ssi_signo, &si, NULL);
 }
-- 
2.9.3
