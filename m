Received: from eggs.gnu.org ([2001:4830:134:3::10]:60147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfT3-00081Z-QT
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfT3-00016l-1L
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43774 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSfT2-00016O-Tf
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C0387D84D
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:19:56 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 12 Jun 2018 10:19:48 +0100
Message-Id: <20180612091948.14367-8-dgilbert@redhat.com>
In-Reply-To: <20180612091948.14367-1-dgilbert@redhat.com>
References: <20180612091948.14367-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 7/7] hmp: Allow HMP in preconfig state again
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 monitor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index 9ea23828ef..66fc5fe3b3 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3395,12 +3395,6 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 
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
