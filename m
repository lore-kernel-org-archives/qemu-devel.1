Received: from eggs.gnu.org ([2001:4830:134:3::10]:33695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fj1tw-0006gf-7v
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fj1tq-0004r5-Df
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:31:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fj1tq-0004qj-8s
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:31:14 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 27 Jul 2018 13:31:12 +0100
Message-Id: <20180727123112.13707-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] macio/pmu: Fix missing vmsd terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, agraf@suse.de, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fix missing terminator in VMStateDescription

Fixes: d811d61fbc6ca5f2be2185fd7cfa916e7ba613ce
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/misc/macio/pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index e246b0fd41..27dfaf8a74 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -686,6 +686,7 @@ static const VMStateDescription vmstate_pmu_adb = {
         VMSTATE_TIMER_PTR(adb_poll_timer, PMUState),
         VMSTATE_UINT8(adb_reply_size, PMUState),
         VMSTATE_BUFFER(adb_reply, PMUState),
+        VMSTATE_END_OF_LIST()
     }
 };
 
-- 
2.17.1
