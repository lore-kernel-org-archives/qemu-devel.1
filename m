Received: from eggs.gnu.org ([2001:4830:134:3::10]:44341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfI0-0004LI-RK
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfI0-0003Zf-1d
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:38:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1emfHz-0003ZW-To
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:38:55 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 16 Feb 2018 13:37:16 +0100
Message-Id: <1518784641-43151-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/9] HMP: disable monitor in preconfig state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

Ban it for now, if someone would need it to work early,
one would have to implement checks if HMP command is valid
at preconfig state.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
---
 monitor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor.c b/monitor.c
index f499250..fcb5386 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3097,6 +3097,10 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 
     trace_handle_hmp_command(mon, cmdline);
 
+    if (runstate_check(RUN_STATE_PRECONFIG)) {
+        monitor_printf(mon, "HMP not available in precofig state\n");
+    }
+
     cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
     if (!cmd) {
         return;
-- 
2.7.4
