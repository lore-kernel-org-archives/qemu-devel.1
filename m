Received: from eggs.gnu.org ([2001:4830:134:3::10]:34835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHQbf-0006Jn-RB
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHQbc-0002Sw-L5
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:42:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHQbc-0002Se-Ep
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:42:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78CC04E05D
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 08:42:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Nov 2017 09:41:57 +0100
Message-Id: <20171122084157.11480-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH] tcg: Fix complilation with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

This commit started use tb_unlock() and tlb_set_dirty() on non TCG
code.  Add the function as stubs.

commit 27266271977c5a30f2f7d493e042be1897827bdd
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Mon Nov 20 18:08:27 2017 +0000

    exec.c: Factor out before/after actions for notdirty memory writes
    ....

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 accel/stubs/tcg-stub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 5dd480b1a2..ee575a8718 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -20,3 +20,11 @@
 void tb_flush(CPUState *cpu)
 {
 }
+
+void tb_unlock(void)
+{
+}
+
+void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
+{
+}
-- 
2.13.6
