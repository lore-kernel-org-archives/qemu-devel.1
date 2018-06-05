Received: from eggs.gnu.org ([2001:4830:134:3::10]:42052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQB35-0003pP-Hh
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQB34-0005Hx-Fp
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:26:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fQB34-0005HU-8V
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:26:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9248F859C5
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 12:26:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Jun 2018 13:26:36 +0100
Message-Id: <20180605122636.33654-7-dgilbert@redhat.com>
In-Reply-To: <20180605122636.33654-1-dgilbert@redhat.com>
References: <20180605122636.33654-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] hmp: Allow HMP in preconfig state again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Now we can cope with preconfig in HMP, reenable by reverting
commit 71dc578e116599ea73c8a2a4e693134702ec0e83.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index 9b29787a52..50bcba18db 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3394,12 +3394,6 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 
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
2.17.0
