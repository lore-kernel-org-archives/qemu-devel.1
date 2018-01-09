Received: from eggs.gnu.org ([2001:4830:134:3::10]:41396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1eYzja-00059a-My
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1eYzjW-0003Nc-Jv
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:38:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1eYzjW-0003Ju-DR
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:38:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40F07272C8
	for <qemu-devel@nongnu.org>; Tue,  9 Jan 2018 19:38:48 +0000 (UTC)
Date: Tue, 9 Jan 2018 17:37:46 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20180109193745.GA18506@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] qemu: improve hugepage allocation failure
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>


Improve hugepage allocation failure message, indicating
whats happening to the user.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/exec.c b/exec.c
index 4722e521d4..439abedb98 100644
--- a/exec.c
+++ b/exec.c
@@ -1643,7 +1643,8 @@ static void *file_ram_alloc(RAMBlock *block,
                          block->flags & RAM_SHARED);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
-                         "unable to map backing store for guest RAM");
+                         "unable to map backing store for guest RAM, "
+                         "falling back to malloc based RAM allocation");
         return NULL;
     }
 
