Received: from eggs.gnu.org ([2001:4830:134:3::10]:48657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwM-0000Ws-Vt
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwJ-0005b6-LF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dXKwJ-0005aK-Af
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I5JLfW021972
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:54 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsaghbn32-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:54 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 17 Jul 2017 23:20:53 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 00:20:12 -0500
In-Reply-To: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1500355216-23603-5-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 4/8] qga-win32: remove a redundancy code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Peng Hao <peng.hao2@zte.com.cn>

From: Peng Hao <peng.hao2@zte.com.cn>

In the first line of run_agent,it has set ga_state = s,don't need
set ga_state = s again behind.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
