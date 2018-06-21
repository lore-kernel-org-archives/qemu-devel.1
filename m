Received: from eggs.gnu.org ([2001:4830:134:3::10]:45051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2kH-00045b-9D
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2kG-0003l4-Ar
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fW2kG-0003ku-67
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:40 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 21 Jun 2018 17:47:27 +0100
Message-Id: <20180621164727.36626-10-dgilbert@redhat.com>
In-Reply-To: <20180621164727.36626-1-dgilbert@redhat.com>
References: <20180621164727.36626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] hmp: Allow HMP in preconfig state again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com, sjitindarsingh@gmail.com, walling@linux.ibm.com
Cc: armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Now we can cope with preconfig in HMP, reenable by reverting
commit 71dc578e116599ea73c8a2a4e693134702ec0e83.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20180620153947.30834-8-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index 068c094a9a..0730a27172 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3461,12 +3461,6 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 
     trace_handle_hmp_command(mon, cmdline);
 
-    if (runstate_check(RUN_STATE_PRECONFIG)) {
-        monitor_printf(mon, "HMP not available in preconfig state, "
-                            "use QMP instead\n");
-        return;
-    }
-
     cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
     if (!cmd) {
         return;
-- 
2.17.1
