Received: from eggs.gnu.org ([2001:4830:134:3::10]:56163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dWO5j-0003iE-Jz
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 10:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dWO5g-0001QZ-Ce
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 10:30:43 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:33917)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dWO5f-0001Ni-NY
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 10:30:40 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sun, 16 Jul 2017 06:44:01 +0800
Message-Id: <1500158641-23033-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH]  qga-win32: remove a redundancy code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

In the first line of run_agent,it has set ga_state = s,don't need
set ga_state = s again behind.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 qga/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index 405c129..dcd6104 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1314,7 +1314,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
     json_message_parser_init(&s->parser, process_event);
-    ga_state = s;
+
 #ifndef _WIN32
     if (!register_signal_handlers()) {
         g_critical("failed to register signal handlers");
-- 
1.8.3.1
