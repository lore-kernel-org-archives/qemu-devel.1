Received: from eggs.gnu.org ([2001:4830:134:3::10]:44864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3kS-0005YV-Ob
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3kO-0001uV-Eb
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:27 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3kO-0001tP-85
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:24 -0500
Received: by mail-pf0-x243.google.com with SMTP id n6so5653091pfa.4
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:30:24 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:30:06 -0600
Message-Id: <1512682213-4354-2-git-send-email-minyard@acm.org>
In-Reply-To: <1512682213-4354-1-git-send-email-minyard@acm.org>
References: <1512682213-4354-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/8] ipmi: Fix SEL get/set time commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The minimum message size was on the wrong commands, for getting
the time it's zero and for setting the time it's 6.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ipmi/ipmi_bmc_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 277c28c..cc068f2 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -1802,8 +1802,8 @@ static const IPMICmdHandler storage_cmds[] = {
     [IPMI_CMD_GET_SEL_ENTRY] = { get_sel_entry, 8 },
     [IPMI_CMD_ADD_SEL_ENTRY] = { add_sel_entry, 18 },
     [IPMI_CMD_CLEAR_SEL] = { clear_sel, 8 },
-    [IPMI_CMD_GET_SEL_TIME] = { get_sel_time, 6 },
-    [IPMI_CMD_SET_SEL_TIME] = { set_sel_time },
+    [IPMI_CMD_GET_SEL_TIME] = { get_sel_time },
+    [IPMI_CMD_SET_SEL_TIME] = { set_sel_time, 6 },
 };
 
 static const IPMINetfn storage_netfn = {
-- 
2.7.4
